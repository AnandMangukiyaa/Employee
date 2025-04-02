import 'dart:io';

import 'package:employee/core/constants/constants.dart';
import 'package:employee/core/utils/utils.dart';
import 'package:employee/presentation/widgets/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalenderDialog extends StatefulWidget {
  final bool end;
  final String? date;
  const CalenderDialog({this.end = false,this.date,super.key});
  static Future<String?> show(BuildContext context, {bool end = false,String? date}) async {
    return await showDialog<String>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) {
        return Dialog(
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.s16.radius),
          ),
          backgroundColor:  Colors.white,
          child:  CalenderDialog(end:end,date: date,),
        );
      },
    );
  }
  @override
  State<CalenderDialog> createState() => _CalenderDialogState();
}

class _CalenderDialogState extends State<CalenderDialog> {
  DateTime? date ;
  DateRangePickerController _controller = DateRangePickerController();
  int selectedIndex = 0;

  @override
  void initState() {
    if(widget.date != null) {
      date = DateFormat("d MMM yyyy").parse(widget.date!);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _controller.selectedDate = date;
      });
    }else {
      date = DateFormat("dd/MM/yyyy").parse(DateFormat("dd/MM/yyyy").format(DateTime.now()));
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _controller.selectedDate = date;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb?Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.7 ,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(widget.end)  ...[Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Container(
                  decoration: BoxDecoration(
                      color: selectedIndex == 0 ?AppColors.primary:AppColors.secondaryButton,
                      borderRadius: BorderRadius.circular(Sizes.s4.radius)
                  ),
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
                          setState(() {
                            date = null;
                            _controller.selectedDate = null;
                            selectedIndex = 0;
                          });
                        },
                        child: Center(child: PrimaryText("No Date",size: Sizes.s14.sp,weight: FontWeight.w500,color: selectedIndex == 0 ? Colors.white:AppColors.primary,)),

                      ),
                    ),
                  ),
                ),),
                SizedBox(width: Sizes.s16.w,),
                Expanded(child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.secondaryButton,
                      borderRadius: BorderRadius.circular(Sizes.s4.radius)
                  ),
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
                          setState(() {
                            date = DateFormat("dd/MM/yyyy").parse(DateFormat("dd/MM/yyyy").format(DateTime.now()));
                            _controller.selectedDate = date;
                            selectedIndex = 1;
                          });
                        },
                        child: Center(child: PrimaryText("Today",size: Sizes.s14.sp,weight: FontWeight.w500,color: AppColors.primary,)),

                      ),
                    ),
                  ),
                ),),
              ],
            ),]else...[Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Container(
                  decoration: BoxDecoration(
                      color: selectedIndex == 0 ?AppColors.primary:AppColors.secondaryButton,
                      borderRadius: BorderRadius.circular(Sizes.s4.radius)
                  ),
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
                          setState(() {
                            date = DateFormat("dd/MM/yyyy").parse(DateFormat("dd/MM/yyyy").format(DateTime.now()));
                            _controller.selectedDate = date;
                            selectedIndex = 0;
                          });
                        },
                        child: Center(child: PrimaryText("Today",size: Sizes.s14.sp,weight: FontWeight.w500,color: selectedIndex == 0 ?Colors.white:AppColors.primary,)),

                      ),
                    ),
                  ),
                ),),
                SizedBox(width: Sizes.s16.w,),
                Expanded(child: Container(
                  decoration: BoxDecoration(
                      color: selectedIndex == 1 ?AppColors.primary:AppColors.secondaryButton,
                      borderRadius: BorderRadius.circular(Sizes.s4.radius)
                  ),
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
                          setState(() {
                            date = getNext(DateTime.monday);
                            _controller.selectedDate = date;
                            selectedIndex = 1;
                          });
                        },
                        child: Center(child: PrimaryText("Next Monday",size: Sizes.s14.sp,weight: FontWeight.w500,color: selectedIndex == 1 ?Colors.white:AppColors.primary,)),

                      ),
                    ),
                  ),
                ),),
              ],
            ),
              SizedBox(height: Sizes.s16.w,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container(
                    decoration: BoxDecoration(
                        color: selectedIndex == 2 ?AppColors.primary:AppColors.secondaryButton,
                        borderRadius: BorderRadius.circular(Sizes.s4.radius)
                    ),
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
                            setState(() {
                              date = getNext(DateTime.tuesday);
                              _controller.selectedDate = date;
                              selectedIndex = 2;
                            });
                          },
                          child: Center(child: PrimaryText("Next Tuesday",size: Sizes.s14.sp,weight: FontWeight.w500,color: selectedIndex == 2 ?Colors.white:AppColors.primary,)),

                        ),
                      ),
                    ),
                  ),),
                  SizedBox(width: Sizes.s16.w,),
                  Expanded(child: Container(
                    decoration: BoxDecoration(
                        color: selectedIndex == 3 ?AppColors.primary:AppColors.secondaryButton,
                        borderRadius: BorderRadius.circular(Sizes.s4.radius)
                    ),
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
                            setState(() {
                              date = DateFormat("dd/MM/yyyy").parse(DateFormat("dd/MM/yyyy").format(DateTime.now())).add(const Duration(days: 7));
                              _controller.selectedDate = date;
                              selectedIndex = 3;
                            });
                          },
                          child: Center(child: PrimaryText("After 1 Week",size: Sizes.s14.sp,weight: FontWeight.w500,color: selectedIndex == 3 ?Colors.white:AppColors.primary,)),

                        ),
                      ),
                    ),
                  ),),
                ],
              ),],
            SizedBox(height: Sizes.s24.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      date = DateTime(date!.year, date!.month - 1, date!.day);
                      _controller.backward!();
                    });
                  },
                  child: SvgPicture.asset(AppAssets.leftArrow),
                ),
                SizedBox(width: Sizes.s8.w,),
                PrimaryText(
                    date != null ?  DateFormat('MMMM yyyy').format(date!): "No Date",
                    size: Sizes.s18.sp, weight: FontWeight.bold),
                SizedBox(width: Sizes.s8.w,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      setState(() {
                        date = DateTime(date!.year, date!.month + 1, date!.day);
                        _controller.forward!();
                      });
                    });
                  },
                  child: SvgPicture.asset(AppAssets.rightArrow),
                ),
              ],
            ),
            SizedBox(height: Sizes.s24.h,),
            getDateRangePicker(),
            SizedBox(height: Sizes.s24.h),
            Container(
              padding: EdgeInsets.all(Sizes.s16.w),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(top:BorderSide(width: Sizes.s1.w,color: AppColors.border))
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: Row(
                    children: [
                      SvgPicture.asset(AppAssets.calender,height: Sizes.s20.w,width: Sizes.s20.w,),
                      SizedBox(width: Sizes.s8.w,),
                      PrimaryText("${date != null ? DateFormat("d MMM yyyy").format(date!):"No Date"}",size: Sizes.s16.sp,)
                    ],
                  )),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.secondaryButton,
                        borderRadius: BorderRadius.circular(Sizes.s4.radius)
                    ),
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
                          child: Center(child: PrimaryText("Cancel",size: Sizes.s14.sp,weight: FontWeight.w500,color: AppColors.primary,)),

                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Sizes.s16.w,),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(Sizes.s4.radius)
                    ),
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
                            Navigator.pop(context,date != null ?DateFormat("d MMM yyyy").format(date!):null);
                          },
                          child: Center(child: PrimaryText("Save",size: Sizes.s14.sp,weight: FontWeight.w500,color: Colors.white,)),

                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    ):Container(
        width: ScreenUtil().screenWidth *0.93,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(widget.end)  ...[Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container(
                    decoration: BoxDecoration(
                        color: selectedIndex == 0 ?AppColors.primary:AppColors.secondaryButton,
                        borderRadius: BorderRadius.circular(Sizes.s4.radius)
                    ),
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
                            setState(() {
                              date = null;
                              _controller.selectedDate = null;
                              selectedIndex = 0;
                            });
                          },
                          child: Center(child: PrimaryText("No Date",size: Sizes.s14.sp,weight: FontWeight.w500,color: selectedIndex == 0 ? Colors.white:AppColors.primary,)),

                        ),
                      ),
                    ),
                  ),),
                  SizedBox(width: Sizes.s16.w,),
                  Expanded(child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.secondaryButton,
                        borderRadius: BorderRadius.circular(Sizes.s4.radius)
                    ),
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
                            setState(() {
                              date = DateFormat("dd/MM/yyyy").parse(DateFormat("dd/MM/yyyy").format(DateTime.now()));
                              _controller.selectedDate = date;
                              selectedIndex = 1;
                            });
                          },
                          child: Center(child: PrimaryText("Today",size: Sizes.s14.sp,weight: FontWeight.w500,color: AppColors.primary,)),

                        ),
                      ),
                    ),
                  ),),
                ],
              ),]else...[Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container(
                    decoration: BoxDecoration(
                        color: selectedIndex == 0 ?AppColors.primary:AppColors.secondaryButton,
                        borderRadius: BorderRadius.circular(Sizes.s4.radius)
                    ),
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
                            setState(() {
                              date = DateFormat("dd/MM/yyyy").parse(DateFormat("dd/MM/yyyy").format(DateTime.now()));
                              _controller.selectedDate = date;
                              selectedIndex = 0;
                            });
                          },
                          child: Center(child: PrimaryText("Today",size: Sizes.s14.sp,weight: FontWeight.w500,color: selectedIndex == 0 ?Colors.white:AppColors.primary,)),

                        ),
                      ),
                    ),
                  ),),
                  SizedBox(width: Sizes.s16.w,),
                  Expanded(child: Container(
                    decoration: BoxDecoration(
                        color: selectedIndex == 1 ?AppColors.primary:AppColors.secondaryButton,
                        borderRadius: BorderRadius.circular(Sizes.s4.radius)
                    ),
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
                            setState(() {
                              date = getNext(DateTime.monday);
                              _controller.selectedDate = date;
                              selectedIndex = 1;
                            });
                          },
                          child: Center(child: PrimaryText("Next Monday",size: Sizes.s14.sp,weight: FontWeight.w500,color: selectedIndex == 1 ?Colors.white:AppColors.primary,)),

                        ),
                      ),
                    ),
                  ),),
                ],
              ),
              SizedBox(height: Sizes.s16.w,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container(
                    decoration: BoxDecoration(
                        color: selectedIndex == 2 ?AppColors.primary:AppColors.secondaryButton,
                        borderRadius: BorderRadius.circular(Sizes.s4.radius)
                    ),
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
                            setState(() {
                              date = getNext(DateTime.tuesday);
                              _controller.selectedDate = date;
                              selectedIndex = 2;
                            });
                          },
                          child: Center(child: PrimaryText("Next Tuesday",size: Sizes.s14.sp,weight: FontWeight.w500,color: selectedIndex == 2 ?Colors.white:AppColors.primary,)),

                        ),
                      ),
                    ),
                  ),),
                  SizedBox(width: Sizes.s16.w,),
                  Expanded(child: Container(
                    decoration: BoxDecoration(
                        color: selectedIndex == 3 ?AppColors.primary:AppColors.secondaryButton,
                        borderRadius: BorderRadius.circular(Sizes.s4.radius)
                    ),
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
                            setState(() {
                              date = DateFormat("dd/MM/yyyy").parse(DateFormat("dd/MM/yyyy").format(DateTime.now())).add(const Duration(days: 7));
                              _controller.selectedDate = date;
                              selectedIndex = 3;
                            });
                          },
                          child: Center(child: PrimaryText("After 1 Week",size: Sizes.s14.sp,weight: FontWeight.w500,color: selectedIndex == 3 ?Colors.white:AppColors.primary,)),

                        ),
                      ),
                    ),
                  ),),
                ],
              ),],
              SizedBox(height: Sizes.s24.h),
              Row(
          mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        date = DateTime(date!.year, date!.month - 1, date!.day);
                        _controller.backward!();
                      });
                    },
                    child: SvgPicture.asset(AppAssets.leftArrow),
                  ),
                  SizedBox(width: Sizes.s8.w,),
                  PrimaryText(
                     date != null ?  DateFormat('MMMM yyyy').format(date!): "No Date",
                      size: Sizes.s18.sp, weight: FontWeight.bold),
                  SizedBox(width: Sizes.s8.w,),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        setState(() {
                          date = DateTime(date!.year, date!.month + 1, date!.day);
                          _controller.forward!();
                        });
                      });
                    },
                    child: SvgPicture.asset(AppAssets.rightArrow),
                  ),
                ],
              ),
              SizedBox(height: Sizes.s24.h,),
              getDateRangePicker(),
              SizedBox(height: Sizes.s24.h),
              Container(
                padding: EdgeInsets.all(Sizes.s16.w),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(top:BorderSide(width: Sizes.s1.w,color: AppColors.border))
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(child: Row(
                      children: [
                        SvgPicture.asset(AppAssets.calender,height: Sizes.s20.w,width: Sizes.s20.w,),
                        SizedBox(width: Sizes.s8.w,),
                        PrimaryText("${date != null ? DateFormat("d MMM yyyy").format(date!):"No Date"}",size: Sizes.s16.sp,)
                      ],
                    )),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.secondaryButton,
                          borderRadius: BorderRadius.circular(Sizes.s4.radius)
                      ),
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
                            child: Center(child: PrimaryText("Cancel",size: Sizes.s14.sp,weight: FontWeight.w500,color: AppColors.primary,)),

                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Sizes.s16.w,),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(Sizes.s4.radius)
                      ),
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
                              Navigator.pop(context,date != null ?DateFormat("d MMM yyyy").format(date!):null);
                            },
                            child: Center(child: PrimaryText("Save",size: Sizes.s14.sp,weight: FontWeight.w500,color: Colors.white,)),

                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

    );
  }

  DateTime getNext(int day) {
    DateTime now = DateFormat("dd/MM/yyyy").parse(DateFormat("dd/MM/yyyy").format(DateTime.now()));
    int daysUntilMonday = (day - now.weekday) % 7;
    if (daysUntilMonday == 0) {
      daysUntilMonday = 7; // If today is Monday, get next Monday
    }
    return now.add(Duration(days: daysUntilMonday));
  }



  Widget getDateRangePicker() {
    return SizedBox(
        width: ScreenUtil().screenWidth - 100,
        height: Sizes.s300.h,
        child: SfDateRangePicker(
          controller: _controller,
          rangeSelectionColor: AppColors.primary,
          initialSelectedRange:  PickerDateRange(date,
              date),
          view: DateRangePickerView.month,
          todayHighlightColor: AppColors.primary,
          selectionColor: AppColors.primary,
          selectionMode: DateRangePickerSelectionMode.single,
          onSelectionChanged: selectionChanged,
          navigationMode: DateRangePickerNavigationMode.snap,
          showNavigationArrow: true,
          headerHeight: 0,
          monthViewSettings: DateRangePickerMonthViewSettings(
            firstDayOfWeek: 1,
            showTrailingAndLeadingDates: true,
            dayFormat: 'EEE',
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: TextStyle(fontSize: Sizes.s15.sp)
            )
          ),
          headerStyle: DateRangePickerHeaderStyle(
            textAlign: TextAlign.center
          ),
        ));
  }


  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    if(args.value is DateTime) {
      setState(() {
      date = args.value;
      if(date == getNext(DateTime.monday) && !widget.end){
        selectedIndex = 1;
      }else if(!widget.end && date == DateFormat("dd/MM/yyyy").parse(DateFormat("dd/MM/yyyy").format(DateTime.now()))){
      selectedIndex = 0;
      }else if(widget.end && date == null){
        selectedIndex = 0;
      }else if(widget.end && date == DateFormat("dd/MM/yyyy").parse(DateFormat("dd/MM/yyyy").format(DateTime.now()))) {
        selectedIndex = 1;
      }else if(!widget.end && date == getNext(DateTime.tuesday)){
        selectedIndex = 2;
      }else if(!widget.end && date == DateFormat("dd/MM/yyyy").parse(DateFormat("dd/MM/yyyy").format(DateTime.now())).add(const Duration(days: 7))){
        selectedIndex = 3;
      }else{
        selectedIndex = -1;
      }
    });
    }
  }
}
