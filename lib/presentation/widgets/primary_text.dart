
import 'package:flutter/material.dart';
import 'package:employee/core/constants/constants.dart';

class PrimaryText extends StatelessWidget {
  String text ="";
  FontWeight? weight;
  double? size;
  double? spacing;
  Color? color;
  TextAlign? align;
  TextDecoration? decoration;
  Color? decorationColor;
  TextOverflow? overflow;
  bool? softWrap;
  int? maxLines;
  PrimaryText(this.text,{this.weight,this.size,this.color,this.align,this.decoration,this.decorationColor,this.overflow,this.spacing,this.softWrap,this.maxLines,key});

  @override
  Widget build(BuildContext context) {
    return Text(text,textAlign: align ?? TextAlign.left,textScaler: TextScaler.linear(1),softWrap: softWrap ?? true,maxLines: maxLines,style:TextStyle(fontWeight: weight ?? FontWeight.w400,fontSize: size ?? Sizes.s12.sp,color: color ?? Colors.black,decoration: decoration,decorationColor: decorationColor,overflow: overflow,letterSpacing:spacing ),);
  }
}
