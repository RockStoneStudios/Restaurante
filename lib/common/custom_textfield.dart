import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendors/constant/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget prefixIcon;
  final int? maxLines;
  final void Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      this.maxLines,
      this.onEditingComplete,
      this.keyboardType,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kDark,
      maxLines: maxLines ?? 1,
      onEditingComplete: onEditingComplete,
      keyboardType: keyboardType,
      controller: controller,
      style: const TextStyle(
          fontSize: 13, color: kGray, fontWeight: FontWeight.w500),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese texto';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          isDense: true,
          contentPadding: maxLines == 1
              ? EdgeInsets.symmetric(vertical: 5.h)
              : EdgeInsets.all(8.r),
          hintStyle: const TextStyle(
              fontSize: 12, color: kGray, fontWeight: FontWeight.w600),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kRed, width: 0.5.w),
            borderRadius: BorderRadius.circular(12.r),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 0.5.w),
              borderRadius: BorderRadius.circular(12.r)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kPrimary, width: 0.5.w),
              borderRadius: BorderRadius.circular(12.r)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kGray, width: 0.5.w),
              borderRadius: BorderRadius.circular(12.r)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kPrimary, width: 0.5.w),
              borderRadius: BorderRadius.circular(12.r)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: kGray, width: 0.5.w),
              borderRadius: BorderRadius.circular(12.r))),
    );
  }
}
