import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendors/common/home_tile.dart';
import 'package:vendors/constant/constants.dart';
import 'package:vendors/views/add_foods/add_foods.dart';
import 'package:vendors/views/food/food_list.dart';

class HomeTiles extends StatelessWidget {
  const HomeTiles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomeTile(
                onTap: () {
                  Get.to(() => const AddFoods(),
                      transition: Transition.circularReveal,
                      duration: const Duration(milliseconds: 850));
                },
                text: "Agregar Comida",
                iconPath: "assets/icons/taco.svg"),
            HomeTile(
                onTap: () {},
                text: "Billetera",
                iconPath: "assets/icons/wallet.svg"),
            HomeTile(
                onTap: () {
                  Get.to(() => const FoodList(),
                      transition: Transition.circularReveal,
                      duration: const Duration(milliseconds: 680));
                },
                text: "Comidas",
                iconPath: "assets/icons/french_fries.svg"),
            HomeTile(
                onTap: () {},
                text: "AutoEntregas",
                iconPath: "assets/icons/deliver_food.svg"),
          ],
        ),
      ),
    );
  }
}
