import 'package:employee/core/constants/constants.dart';
import 'package:employee/core/utils/utils.dart';
import 'package:employee/data/models/employee.dart';
import 'package:employee/presentation/bloc/employee_bloc.dart';
import 'package:employee/presentation/bloc/employee_event.dart';
import 'package:employee/presentation/dialogs/calender_dialog.dart';
import 'package:employee/presentation/widgets/primary_drop_down.dart';
import 'package:employee/presentation/widgets/primary_text.dart';
import 'package:employee/presentation/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

class AddEmployeePage extends StatefulWidget {
  Employee? employee;
  AddEmployeePage(this.employee, {super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  List<String> posts = ["Product Designer", "Flutter Developer", "QA Tester", "Product Owner"];
  TextEditingController _name = TextEditingController();
  TextEditingController _role = TextEditingController();
  TextEditingController _startDate = TextEditingController();
  TextEditingController _endDate = TextEditingController();

  @override
  void initState() {
    if (widget.employee != null) {
      _name.text = widget.employee!.name ?? "";
      _role.text = widget.employee!.designation ?? "";
      _startDate.text = widget.employee!.startDate ?? "";
      _endDate.text = widget.employee!.endDate ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: PrimaryText(
          "Add Employee Details",
          size: Sizes.s18.sp,
          weight: FontWeight.w500,
          color: Colors.white,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Sizes.s16.w),
              child: Column(
                children: [
                  PrimaryTextField(
                    labelText: "",
                    controller: _name,
                    hintText: "Employee Name",
                    prefix: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.s12.w),
                      child: SvgPicture.asset(
                        AppAssets.employee,
                        height: Sizes.s15.w,
                        width: Sizes.s15.w,
                      ),
                    ),
                    radius: Sizes.s4.radius,
                    padding: EdgeInsets.all(Sizes.s8.w),
                  ),
                  SizedBox(
                    height: Sizes.s24.h,
                  ),
                  PrimaryTextField(
                    labelText: "",
                    controller: _role,
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    hintText: "Select Role",
                    readOnly: true,
                    prefix: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.s12.w),
                      child: SvgPicture.asset(
                        AppAssets.designation,
                        height: Sizes.s15.w,
                        width: Sizes.s15.w,
                      ),
                    ),
                    radius: Sizes.s4.radius,
                    padding: EdgeInsets.all(Sizes.s8.w),
                    suffix: Padding(
                      padding: EdgeInsets.all(Sizes.s12.w),
                      child: SvgPicture.asset(AppAssets.down, height: Sizes.s15.w, width: Sizes.s15.w),
                    ),
                  ),
                  SizedBox(
                    height: Sizes.s24.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryTextField(
                          labelText: "",
                          controller: _startDate,
                          onTap: () async {
                            String? date = await CalenderDialog.show(context,date: widget.employee?.startDate);
                            if (date != null && date.isNotEmpty) {
                              setState(() {
                                _startDate.text = date;
                              });
                            }
                          },
                          readOnly: true,
                          hintText: "No Date",
                          prefix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Sizes.s12.w),
                            child: SvgPicture.asset(
                              AppAssets.calender,
                              height: Sizes.s15.w,
                              width: Sizes.s15.w,
                            ),
                          ),
                          radius: Sizes.s4.radius,
                          padding: EdgeInsets.all(Sizes.s8.w),
                        ),
                      ),
                      SizedBox(
                        width: Sizes.s52.w,
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.arrow,
                            height: Sizes.s20.w,
                            width: Sizes.s20.w,
                          ),
                        ),
                      ),
                      Expanded(
                        child: PrimaryTextField(
                          labelText: "",
                          controller: _endDate,
                          onTap: () async {
                            String? date = await CalenderDialog.show(context,end: true,date: widget.employee?.endDate);
                            if (date != null && date.isNotEmpty) {
                              setState(() {
                                _endDate.text = date;
                              });
                            }else{
                              setState(() {
                                _endDate.text = "";
                              });
                            }
                          },
                          readOnly: true,
                          hintText: "No Date",
                          prefix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Sizes.s12.w),
                            child: SvgPicture.asset(
                              AppAssets.calender,
                              height: Sizes.s15.w,
                              width: Sizes.s15.w,
                            ),
                          ),
                          radius: Sizes.s4.radius,
                          padding: EdgeInsets.all(Sizes.s8.w),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(Sizes.s16.w),
            width: double.infinity,
            decoration: BoxDecoration(border: Border(top: BorderSide(width: Sizes.s1.w, color: AppColors.border))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(color: AppColors.secondaryButton, borderRadius: BorderRadius.circular(Sizes.s4.radius)),
                  width: Sizes.s72.w,
                  height: Sizes.s40.h,
                  child: SizedBox(
                    width: Sizes.s72.w,
                    height: Sizes.s40.h,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: AppColors.secondary,
                        borderRadius: BorderRadius.circular(Sizes.s4.radius),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                            child: PrimaryText(
                          "Cancel",
                          size: Sizes.s14.sp,
                          weight: FontWeight.w500,
                          color: AppColors.primary,
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Sizes.s16.w,
                ),
                Container(
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(Sizes.s4.radius)),
                  width: Sizes.s72.w,
                  height: Sizes.s40.h,
                  child: SizedBox(
                    width: Sizes.s72.w,
                    height: Sizes.s40.h,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: AppColors.secondary,
                        borderRadius: BorderRadius.circular(Sizes.s4.radius),
                        onTap: () {
                          if (_name.text.isEmpty) {
                            SnackUtils.showSnak("Please Enter Your Name!");
                          } else if (_role.text.isEmpty) {
                            SnackUtils.showSnak("Please Select Your Role!");
                          } else if (_startDate.text.isEmpty) {
                            SnackUtils.showSnak("Please Select Starting Date!");
                          } else {

                            if (widget.employee != null) {
                              widget.employee!.name = _name.text;
                              widget.employee!.designation = _role.text;
                              widget.employee!.startDate = _startDate.text;
                              widget.employee!.endDate = _endDate.text.isEmpty ? null : _endDate.text;
                              GetIt.I<EmployeeBloc>().add(UpdateEmployee(widget.employee!));
                              SnackUtils.showSnak("Employee Updated Successfully!");
                            } else {
                              Employee employee = Employee(
                                name: _name.text,
                                designation: _role.text,
                                startDate: _startDate.text,
                                endDate: _endDate.text.isEmpty ? null : _endDate.text,
                              );
                              GetIt.I<EmployeeBloc>().add(AddEmployee(employee));
                              SnackUtils.showSnak("Employee Added Successfully!");
                            }
                            Navigator.pop(context);
                          }
                        },
                        child: Center(
                            child: PrimaryText(
                          "Save",
                          size: Sizes.s14.sp,
                          weight: FontWeight.w500,
                          color: Colors.white,
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (BuildContext context) {
        return Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(posts.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _role.text = posts[index];
                });
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(Sizes.s16.w),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border, width: Sizes.s1.w))),
                child: Center(
                  child: PrimaryText(
                    posts[index],
                    size: Sizes.s16.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }),
        ));
      },
    );
  }
}
