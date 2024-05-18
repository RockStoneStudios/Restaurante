import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendors/common/reusable_text.dart';
import 'package:vendors/constant/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vendors/controllers/restaurant_controller.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RestaurantController());
    controller.getRestaurantData();
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.fromLTRB(15.w, 45.h, 12.w, 1.h),
      color: kSecondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundColor: kWhite,
                backgroundImage: NetworkImage(controller.restaurant!.logoUrl),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResuableText(
                      style: const TextStyle(
                          fontSize: 17,
                          color: kWhite,
                          fontWeight: FontWeight.w800),
                      text: controller.restaurant!.title,
                    ),
                    SizedBox(
                      child: Text(
                        controller.restaurant!.coords.address,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SvgPicture.asset('assets/icons/open_sign.svg',
              height: 50.h, width: 50.w)
        ],
      ),
    );
  }
}
