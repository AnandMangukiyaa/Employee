
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:employee/core/constants/constants.dart';

class PrimaryTextField extends StatelessWidget {
  final IconData? icon;
  final String labelText;
  final Color? labelColor;
  final Color? backgroundColor;
  final Color? textColor;
  final String? hintText;
  final String? endedText;
  final bool readOnly;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final Widget? suffix;
  final Widget? suffixWidget;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final int maxLine;
  final EdgeInsetsGeometry? padding;
  final LayerLink? link;
  final Key? fieldKey;
  final FocusNode? focusNode;
  final bool? isRequired;
  final double? radius;
  final double? labelSize;
  final double? textSize;
  final int? maxLength;
  final Color? borderColor;
  final FontWeight? textWeight;
  final bool? isDense;
  final bool? capitalize;

  const PrimaryTextField({
    Key? key,
    this.icon,
    required this.labelText,
    this.hintText,
    this.labelColor,
    this.backgroundColor,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffix,
    this.prefix,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.validator,
    this.maxLine = 1,
    this.readOnly = false,
    this.enabled = true,
    this.endedText,
    this.padding,
    this.link,
    this.fieldKey,
    this.focusNode, this.isRequired,
    this.radius,
    this.textSize,
    this.labelSize,
    this.suffixWidget,
    this.textColor,
    this.onSubmitted,
    this.maxLength,
    this.borderColor,
    this.textWeight,
    this.isDense,
    this.capitalize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText.isNotEmpty) ...[
          Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if(labelText.isNotEmpty)...{
              Text(
                labelText,
                // maxLines: 1,
                // softWrap: false,
                style: TextStyle(
                    color: labelColor ?? AppColors.darkGrey,
                    fontSize: labelSize ?? Sizes.s12.sp,
                    fontWeight: FontWeight.w600,),
              ),

              if(isRequired??false) ...[SizedBox(width: Sizes.s8.w,),Text(
                (isRequired ?? false) ? "*" : "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.s20.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              )] ,
            },
            const Spacer(),
            endedText != null
                ? Align(
              alignment: Alignment.topRight,
              child: Text(
                endedText!,
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                    color: labelColor ?? AppColors.darkGrey,
                    fontSize: Sizes.s12.sp,
                    fontWeight: FontWeight.w300,),
              ),
            )
                : const SizedBox(),
          ],
        ),SizedBox(height: Sizes.s6.h,) ]else SizedBox.shrink(),
        CompositedTransformTarget(
          link: link ?? LayerLink(),
          child: TextFormField(
            key: fieldKey,
            focusNode: focusNode,
            textCapitalization: (capitalize??false) ? TextCapitalization.characters:TextCapitalization.none,
            autocorrect: false,
            autofocus: false,
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: (textSize ?? Sizes.s16.sp) / MediaQuery.of(context).textScaleFactor,
              fontWeight: textWeight ?? FontWeight.w400,
            ),
            maxLines: maxLine,
            enabled: enabled,
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            validator: validator,
            readOnly: readOnly,
            obscuringCharacter: '*',
            cursorColor: AppColors.darkGrey,
            obscureText: obscureText,
            inputFormatters: inputFormatters,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTap: onTap,
            maxLength: maxLength,
            onFieldSubmitted: onSubmitted,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIconConstraints: BoxConstraints(maxWidth: Sizes.s40.w,maxHeight: Sizes.s40.w),
              prefixIcon: icon != null ? Icon(icon,color: AppColors.darkGrey,) : prefix,
              filled: true,
              isDense:isDense ??true,
              hintStyle: TextStyle(color: AppColors.darkGrey),
              enabledBorder: _border(borderColor ?? AppColors.border),
              fillColor: backgroundColor ??Colors.white,
              border: _border(borderColor ?? AppColors.border),
              contentPadding: padding,
              counterText: "",
              suffixIconConstraints: BoxConstraints(maxHeight: Sizes.s32.h),
              focusedBorder: _border(borderColor ?? AppColors.primary),
              errorBorder: _border(borderColor ?? Colors.red),
              focusedErrorBorder: _border(borderColor ?? Colors.red),
              suffixIcon: suffix,
              suffix: suffixWidget,
              errorMaxLines: 2,
              errorStyle: TextStyle(
                    color: Colors.red,
                    fontSize:  Sizes.s14.sp,
                    fontWeight: FontWeight.w400,
                  )
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: Sizes.s1.w),
      borderRadius: BorderRadius.circular(radius ?? Sizes.s8.radius),
    );
  }
}