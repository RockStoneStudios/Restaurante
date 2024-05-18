import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendors/common/reusable_text.dart';
import 'package:vendors/constant/constants.dart';

class MapBtn extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const MapBtn({
    super.key,
    this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 25,
        width: 70,
        decoration: BoxDecoration(
            border: Border.all(color: kLightWhite, width: 0.5),
            borderRadius: BorderRadius.circular(8.r)),
        child: Center(
          child: ResuableText(
              text: text,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: kLightWhite)),
        ),
      ),
    );
  }
}
