import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendors/common/custom_button.dart';
import 'package:vendors/common/custom_textfield.dart';
import 'package:vendors/constant/constants.dart';
import 'package:vendors/controllers/food_controller.dart';
import 'package:vendors/models/add_foods_model.dart';
import 'package:vendors/models/additive_model.dart';

class AdditivesInfo extends StatelessWidget {
  const AdditivesInfo({
    super.key,
    required this.additiveTitle,
    required this.additivePrice,
    required this.foodTags,
    required this.back,
    required this.submit,
  });

  final TextEditingController additiveTitle;
  final TextEditingController additivePrice;
  final TextEditingController foodTags;
  final Function back;
  final Function submit;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 12.h, bottom: 12.h),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Agregar Informacion Aditivos",
                  style: TextStyle(
                      fontSize: 19, color: kGray, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Debe agregar aditivos a su producto si tiene alguno",
                  style: TextStyle(
                      fontSize: 13, color: kGray, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: height * 0.36,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  CustomTextField(
                      controller: additiveTitle,
                      hintText: "Nombre de Aditivo",
                      prefixIcon: const Icon(Icons.add)),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                      controller: additivePrice,
                      hintText: "Precio de Aditivo",
                      prefixIcon: const Icon(Icons.monetization_on)),
                  SizedBox(
                    height: 15.h,
                  ),
                  Obx(
                    () => controller.additivesList.isNotEmpty
                        ? Column(
                            children: List.generate(
                                controller.additivesList.length, (index) {
                              final additive = controller.additivesList[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                  margin: EdgeInsets.only(right: 5.1.w),
                                  decoration: BoxDecoration(
                                    color: kPrimary,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Center(
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w, vertical: 3.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              additive.title,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: kWhite,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "\$ ${additive.price}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: kWhite,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              );
                            }),
                          )
                        : const SizedBox.shrink(),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomButton(
                    text: "A G R E G A R   A D I C T I V O S",
                    btnHeight: 36.h,
                    btnColor: kSecondary,
                    btnRadius: 8,
                    onTap: () {
                      if (additivePrice.text.isNotEmpty &&
                          additiveTitle.text.isNotEmpty) {
                        Additive additive = Additive(
                            id: controller.generateId(),
                            title: additiveTitle.text,
                            price: additivePrice.text);
                        controller.addAdditivesList = additive;
                        additivePrice.clear();
                        additiveTitle.clear();
                      } else {
                        Get.snackbar(
                            colorText: kLightWhite,
                            backgroundColor: kPrimary,
                            "Necesitas agregar adictivos",
                            "Por favor llene los campos");
                      }
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 16.w, top: 12.h, bottom: 12.h, right: 2.w),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Agregar Tags de Comidas",
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600, color: kGray),
                ),
                Text(
                    "debe agregar etiquetas de alimentos para su producto si tiene alguna",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: kGray))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.h),
            child: Column(
              children: [
                CustomTextField(
                    controller: foodTags,
                    hintText: "Agregar Tags de Comidas",
                    prefixIcon: const Icon(Icons.keyboard_capslock))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
            child: Obx(
              () => controller.tags.isNotEmpty
                  ? Row(
                      children: List.generate(controller.tags.length, (index) {
                        return Container(
                          margin: EdgeInsets.only(right: 5.1.w),
                          decoration: BoxDecoration(
                            color: kPrimary,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 3.h),
                              child: Text(
                                controller.tags[index],
                                style: const TextStyle(
                                    fontSize: 11, color: kWhite),
                              ),
                            ),
                          ),
                        );
                      }),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomButton(
              text: "A G R E G A R     T A G",
              btnColor: kSecondary,
              onTap: () {
                controller.setTags = foodTags.text;
                foodTags.clear();
              },
              btnRadius: 6,
              btnHeight: 30,
            ),
          ),
          SizedBox(
            height: 38.h,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  text: "Atras",
                  btnWidth: width / 2.8,
                  onTap: () {
                    back();
                  },
                ),
                CustomButton(
                  btnWidth: width / 2.8,
                  text: "Enviar",
                  onTap: () {
                    submit();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
