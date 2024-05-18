import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendors/constant/constants.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final double? btnWidth;
  final double? btnHeight;
  final Color? btnColor;
  final double? btnRadius;
  final String text;
  const CustomButton(
      {super.key,
      this.onTap,
      this.btnWidth,
      this.btnHeight,
      this.btnColor,
      this.btnRadius,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: btnWidth ?? width,
        height: btnHeight ?? 32.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(btnRadius ?? 12.r),
            color: btnColor ?? kPrimary),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 14, color: kLightWhite, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
