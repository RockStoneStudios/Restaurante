import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabWidget extends StatelessWidget {
  final String text;
  const TabWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        height: 26.h,
        width: 100.w,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
