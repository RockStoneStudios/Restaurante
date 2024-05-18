import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendors/constant/constants.dart';

class BackGroundContainer extends StatelessWidget {
  final Widget child;
  final Color? color;

  const BackGroundContainer({super.key, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(top: 16.h),
        decoration: BoxDecoration(
            color: color ?? kLightWhite,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            image: const DecorationImage(
                image: AssetImage("assets/images/restaurant_bk.png"),
                fit: BoxFit.cover,
                opacity: .8)),
        child: child,
      ),
    );
  }
}
