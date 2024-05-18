import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendors/common/custom_button.dart';
import 'package:vendors/constant/constants.dart';
import 'package:vendors/controllers/uploader_controller.dart';

class ImageUploads extends StatelessWidget {
  const ImageUploads({super.key, required this.back, required this.next});

  final Function back;
  final Function next;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploaderController());
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
                  "Subir Imagenes",
                  style: TextStyle(
                      fontSize: 19, color: kGray, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Debes elegir por lo menos 1 imagen",
                  style: TextStyle(
                      fontSize: 13, color: kGray, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: height * .8,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Image One
                      GestureDetector(
                          onTap: () {
                            controller.pickImage('one');
                          },
                          child: Obx(
                            () => Container(
                                height: 120.h,
                                width: width / 2.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: kGrayLight)),
                                child: controller.imageOneUrl == ''
                                    ? Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.camera_alt,
                                              color: kGray,
                                              size: 26,
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            const Text(
                                              "Subir Imagen",
                                              style: TextStyle(
                                                  color: kGray, fontSize: 14),
                                            )
                                          ],
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Image.network(
                                          controller.imageOneUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                          )),
                      GestureDetector(
                          onTap: () {
                            controller.pickImage('two');
                          },
                          child: Obx(
                            () => Container(
                                height: 120.h,
                                width: width / 2.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: kGrayLight)),
                                child: controller.imageTwoUrl == ''
                                    ? Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.camera_alt,
                                              color: kGray,
                                              size: 26,
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            const Text(
                                              "Subir Imagen",
                                              style: TextStyle(
                                                  color: kGray, fontSize: 14),
                                            )
                                          ],
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Image.network(
                                          controller.imageTwoUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            controller.pickImage('three');
                          },
                          child: Obx(
                            () => Container(
                                height: 120.h,
                                width: width / 2.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: kGrayLight)),
                                child: controller.imageThreeUrl == ''
                                    ? Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.camera_alt,
                                              color: kGray,
                                              size: 26,
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            const Text(
                                              "Subir Imagen",
                                              style: TextStyle(
                                                  color: kGray, fontSize: 14),
                                            )
                                          ],
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Image.network(
                                          controller.imageThreeUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                          )),
                      GestureDetector(
                          onTap: () {
                            controller.pickImage('four');
                          },
                          child: Obx(
                            () => Container(
                                height: 120.h,
                                width: width / 2.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: kGrayLight)),
                                child: controller.imageFourUrl == ''
                                    ? Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.camera_alt,
                                              color: kGray,
                                              size: 26,
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            const Text(
                                              "Subir Imagen",
                                              style: TextStyle(
                                                  color: kGray, fontSize: 14),
                                            )
                                          ],
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Image.network(
                                          controller.imageFourUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  Row(
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
                          if (controller.images.length >= 1) {
                            next();
                          } else {
                            Get.snackbar(
                                colorText: kLightWhite,
                                backgroundColor: kPrimary,
                                snackPosition: SnackPosition.TOP,
                                "Error",
                                "Por favor suba como minimo 1 imagen");
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
