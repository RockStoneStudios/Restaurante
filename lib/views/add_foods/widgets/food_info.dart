import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendors/common/custom_button.dart';
import 'package:vendors/common/custom_textfield.dart';

import 'package:vendors/constant/constants.dart';
import 'package:vendors/controllers/food_controller.dart';
import 'package:vendors/controllers/uploader_controller.dart';

class FoodInfo extends StatelessWidget {
  const FoodInfo(
      {super.key,
      required this.back,
      required this.next,
      required this.title,
      required this.description,
      required this.price,
      required this.preparation,
      required this.types});

  final TextEditingController title;
  final TextEditingController description;
  final TextEditingController price;
  final TextEditingController preparation;
  final TextEditingController types;

  final Function back;
  final Function next;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodController());
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 12.h, bottom: 12.h),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Agregar Detalles",
                    style: TextStyle(
                        fontSize: 19,
                        color: kGray,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "La informacion del plato es requerida",
                    style: TextStyle(
                        fontSize: 13,
                        color: kGray,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: "Titulo",
                    prefixIcon: const Icon(
                      Icons.title,
                      size: 22,
                    ),
                    controller: title,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextField(
                    hintText: "Agrega una descripcion tu plato",
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    prefixIcon: const Icon(
                      Icons.description,
                      size: 25,
                    ),
                    controller: description,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextField(
                    hintText: "Precio",
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(
                      Icons.attach_money,
                      size: 22,
                    ),
                    controller: price,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextField(
                    hintText: "Tiempo de Preparacion e.j 15 min",
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(
                      Icons.lock_clock,
                      size: 22,
                    ),
                    controller: preparation,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 12.h, bottom: 12.h),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Agregar Tipos Platos',
                    style: TextStyle(
                        fontSize: 16,
                        color: kGray,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Debes escribir etiquetas que ayudaran con la búsqueda de alimentos.',
                    style: TextStyle(
                        fontSize: 12,
                        color: kGray,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Obx(
                () => Column(
                  children: [
                    CustomTextField(
                      hintText:
                          "Desayuno / Almuerzo / Comida / Rapida / Bebida",
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(
                        Icons.label_important,
                        size: 22,
                      ),
                      controller: types,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    controller.types.isNotEmpty
                        ? Row(
                            children:
                                List.generate(controller.types.length, (index) {
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
                                      controller.types[index],
                                      style: const TextStyle(
                                          fontSize: 11, color: kWhite),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )
                        : const SizedBox.shrink(),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomButton(
                      onTap: () {
                        controller.setTypes = types!.text;
                        types.clear();
                      },
                      text: "Agregar Etiqueta",
                      btnColor: kSecondary,
                      btnHeight: 32,
                      btnWidth: 200,
                      btnRadius: 10,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    text: "Atras",
                    btnWidth: width / 2.6,
                    btnRadius: 9.r,
                    onTap: () {
                      back();
                    },
                  ),
                  CustomButton(
                    text: "Siguiente",
                    btnWidth: width / 2.6,
                    btnRadius: 9.r,
                    onTap: () {
                      next();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
