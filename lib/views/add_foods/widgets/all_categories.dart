import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendors/common/shimmers/foodlist_shimmer.dart';
import 'package:vendors/constant/constants.dart';
import 'package:vendors/constant/uidata.dart';
import 'package:vendors/controllers/food_controller.dart';
import 'package:vendors/hooks/category_list.hook.dart';

class ChooseCategory extends HookWidget {
  final Function() next;
  const ChooseCategory({super.key, required this.next});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodController());
    final hookResults = fetchCategories();
    final categories = hookResults.data;
    final isLoading = hookResults.isLoading;
    final error = hookResults.error;

    if (isLoading) {
      return const FoodsListShimmer();
    }
    if (error != null) {
      return Center(
        child: Text(error.toString()),
      );
    }

    return SizedBox(
      height: height,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 12.h, bottom: 12.h),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Escoge Categoria",
                  style: TextStyle(
                      fontSize: 18, color: kGray, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Debes elegir una categoría para continuar agregando tu producto",
                  style: TextStyle(
                      fontSize: 12, color: kGray, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: height * .8,
            child: ListView.builder(
                itemCount: categories!.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return ListTile(
                    onTap: () {
                      controller.setCategory = category.id.toString();
                      next();
                    },
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: kPrimary,
                      child: Image.network(
                        category.imageUrl.toString(),
                        fit: BoxFit.contain,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kGray,
                      size: 20.sp,
                    ),
                    title: Text(
                      category.title.toString(),
                      style: const TextStyle(
                          fontSize: 14,
                          color: kGray,
                          fontWeight: FontWeight.w700),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
