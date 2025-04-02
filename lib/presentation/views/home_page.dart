import 'package:employee/core/constants/constants.dart';
import 'package:employee/core/routes/app_routes.dart';
import 'package:employee/core/utils/utils.dart';
import 'package:employee/presentation/bloc/employee_bloc.dart';
import 'package:employee/presentation/bloc/employee_event.dart';
import 'package:employee/presentation/bloc/employee_state.dart';
import 'package:employee/presentation/widgets/primary_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import '../../data/models/employee.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EmployeeBloc _employeeBloc = GetIt.I<EmployeeBloc>();

  @override
  void initState() {
    _employeeBloc.add(LoadEmployees());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: PrimaryText(
          "Employee List",
          size: Sizes.s18.sp,
          weight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        bloc: _employeeBloc,
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmployeeLoaded) {
            if (state.employees.isEmpty) {
              return Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppAssets.noRecords),
                  PrimaryText(
                    "No employee records found",
                    size: Sizes.s18.sp,
                    color: Colors.black,
                    weight: FontWeight.w500,
                  )
                ],
              ));
            }
            List<Employee> currentEmployees = state.employees.where((e) => e.endDate == null).toList();
            List<Employee> previousEmployees = state.employees.where((e) => e.endDate != null).toList();
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Color(0xfff5f5f5)),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: Sizes.s16.h, horizontal: Sizes.s16.w),
                    child: PrimaryText(
                      "Current Employees",
                      size: Sizes.s16.sp,
                      weight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                  ...List.generate(currentEmployees.length, (index) {
                    return SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, Routes.addEmployee, arguments: currentEmployees[index]);
                        },
                        child: Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          background: ColoredBox(
                            color: Colors.red,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: SvgPicture.asset(AppAssets.delete),
                              ),
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            Employee employee = currentEmployees[index];
                            GetIt.I<EmployeeBloc>().add(DeleteEmployee(currentEmployees[index]));
                            var snackBar = SnackBar(
                              content: Text("Employee data has been deleted"),
                              backgroundColor: Colors.black,
                              behavior: SnackBarBehavior.floating,
                              elevation: 2,
                              duration: const Duration(milliseconds: 2000),
                              action: SnackBarAction(
                                label: "UNDO",
                                textColor: AppColors.primary,
                                onPressed: () {
                                  GetIt.I<EmployeeBloc>().add(AddEmployee(employee));
                                },
                              ),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                          child: Container(
                            padding: EdgeInsets.all(kIsWeb ? Sizes.s16.h:Sizes.s16.w),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PrimaryText(
                                      currentEmployees[index].name!,
                                      size: Sizes.s16.sp,
                                      weight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: Sizes.s8.h,
                                    ),
                                    PrimaryText(
                                      currentEmployees[index].designation!,
                                      size: Sizes.s14.sp,
                                      weight: FontWeight.w400,
                                      color: AppColors.darkGrey,
                                    ),
                                    SizedBox(
                                      height: Sizes.s8.h,
                                    ),
                                    PrimaryText(
                                      "From ${currentEmployees[index].startDate!}",
                                      size: Sizes.s12.sp,
                                      weight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  if (previousEmployees.isNotEmpty) ...[
                    Container(
                      decoration: BoxDecoration(color: Color(0xfff5f5f5)),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: Sizes.s16.h, horizontal: Sizes.s16.w),
                      child: PrimaryText(
                        "Previous Employees",
                        size: Sizes.s16.sp,
                        weight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                    ...List.generate(previousEmployees.length, (index) {
                      return Container(
                        width: ScreenUtil().screenWidth,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, Routes.addEmployee, arguments: previousEmployees[index]);
                          },
                          child: Dismissible(
                            direction: DismissDirection.endToStart,
                            background: ColoredBox(
                              color: Colors.red,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: SvgPicture.asset(AppAssets.delete),
                                ),
                              ),
                            ),
                            confirmDismiss: (direction) async {
                              Employee employee = previousEmployees[index];
                              GetIt.I<EmployeeBloc>().add(DeleteEmployee(previousEmployees[index]));
                              var snackBar = SnackBar(
                                content: Text("Employee data has been deleted"),
                                backgroundColor: Colors.black,
                                behavior: SnackBarBehavior.floating,
                                elevation: 2,
                                duration: const Duration(milliseconds: 2000),
                                action: SnackBarAction(
                                  label: "UNDO",
                                  textColor: AppColors.primary,
                                  onPressed: () {
                                    GetIt.I<EmployeeBloc>().add(AddEmployee(employee));
                                  },
                                ),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: Container(
                              padding: EdgeInsets.all(kIsWeb ? Sizes.s16.h:Sizes.s16.w),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      PrimaryText(
                                        previousEmployees[index].name!,
                                        size: Sizes.s16.sp,
                                        weight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        height: Sizes.s8.h,
                                      ),
                                      PrimaryText(
                                        previousEmployees[index].designation!,
                                        size: Sizes.s14.sp,
                                        weight: FontWeight.w400,
                                        color: AppColors.darkGrey,
                                      ),
                                      SizedBox(
                                        height: Sizes.s8.h,
                                      ),
                                      PrimaryText(
                                        "${previousEmployees[index].startDate!} - ${previousEmployees[index].endDate!}",
                                        size: Sizes.s12.sp,
                                        weight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            key: UniqueKey(),
                          ),
                        ),
                      );
                    }),

                  ],
                  Container(
                    decoration: BoxDecoration(color: Color(0xfff5f5f5)),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: Sizes.s16.h, horizontal: Sizes.s16.w),
                    child: PrimaryText(
                      "Swipe left to delete",
                      size: Sizes.s16.sp,
                      weight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is EmployeeError) {
            return Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppAssets.noRecords),
                PrimaryText(
                  "No employee records found",
                  size: Sizes.s18.sp,
                  color: Colors.black,
                  weight: FontWeight.w500,
                )
              ],
            ));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(Sizes.s8.radius)),
        height: kIsWeb ? Sizes.s50.h:Sizes.s50.w,
        width: kIsWeb ? Sizes.s50.h:Sizes.s50.w,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.addEmployee);
            },
            splashColor: AppColors.secondary,
            borderRadius: BorderRadius.circular(Sizes.s8.radius),
            child: SizedBox(
              height: kIsWeb ? Sizes.s50.h:Sizes.s50.w,
              width: kIsWeb ? Sizes.s50.h:Sizes.s50.w,
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: kIsWeb ? Sizes.s20.h:Sizes.s20.w,
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
