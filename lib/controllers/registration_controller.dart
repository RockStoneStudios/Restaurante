import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendors/constant/constants.dart';
import 'package:http/http.dart' as http;
import 'package:vendors/models/success_model.dart';
import 'package:vendors/views/auth/login_page.dart';

class RegistrationController extends GetxController {
  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  void registration(String data) async {
    isLoading = true;
    var url = Uri.parse('${appBaseUrl}/register');

    Map<String, String> headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(url, body: data, headers: headers);
      if (response.statusCode == 201) {
        var data = successResponseFromJson(response.body);
        Get.snackbar("Registro Exitoso", data.message,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        isLoading = false;
        Get.to(() => const Login(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 850));
      } else {
        var data = successResponseFromJson(response.body);
        Get.snackbar("Registro Exitoso", data.message,
            snackPosition: SnackPosition.TOP,
            backgroundColor: kPrimary,
            colorText: Colors.white);
        isLoading = false;
      }
    } catch (error) {
      print(error.toString());
      Get.snackbar("Error", error.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: kPrimary,
          colorText: Colors.white);
      isLoading = false;
    }
  }
}
