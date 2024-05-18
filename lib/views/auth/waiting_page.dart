import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vendors/common/app_style.dart';
import 'package:vendors/common/background_container.dart';
import 'package:vendors/common/reusable_text.dart';
import 'package:vendors/constant/constants.dart';

import 'package:vendors/controllers/restaurant_controller.dart';
import 'package:vendors/views/auth/login_page.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantController = Get.put(RestaurantController());
    restaurantController.restaurant = restaurantController.getRestaurantData();

    return Scaffold(
      body: BackGroundContainer(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 180.h, 24.w, 0),
            child: ListView(
              children: [
                Lottie.asset('assets/anime/delivery.json'),
                SizedBox(
                  height: 22.h,
                ),
                ResuableText(
                    text: restaurantController.restaurant!.title,
                    style: const TextStyle(
                        fontSize: 21,
                        color: kTertiary,
                        fontWeight: FontWeight.w800)),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ResuableText(
                        text:
                            "Status: ${restaurantController.restaurant!.verification == "Pending" ? "Pendiente" : ""}",
                        style: const TextStyle(
                            fontSize: 14,
                            color: kPrimary,
                            fontWeight: FontWeight.w700)),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const Login(),
                        );
                      },
                      child: const ResuableText(
                          text: "Intente Loguearse",
                          style: TextStyle(
                              fontSize: 15,
                              color: kTertiary,
                              fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  width: width * 0.8,
                  child: Text(
                    restaurantController.restaurant!.verificationMessage,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: kGray,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          )),
    );
  }
}
