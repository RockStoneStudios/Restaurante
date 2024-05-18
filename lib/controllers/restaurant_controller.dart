import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vendors/constant/constants.dart';
import 'package:http/http.dart' as http;
import 'package:vendors/models/api_error.dart';
import 'package:vendors/models/restaurant_response.dart';
import 'package:vendors/models/success_model.dart';
import 'package:vendors/views/auth/login_page.dart';

class RestaurantController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  RestaurantResponse? restaurant;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  void restaurantRegistration(String data) async {
    String accessToken = box.read('accessToken');
    isLoading = true;
    Uri url = Uri.parse('$appBaseUrl/api/restaurants');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      var response = await http.post(url, body: data, headers: headers);
      print(response.statusCode);
      if (response.statusCode == 201) {
        var data = successResponseFromJson(response.body);
        isLoading = false;
        Get.snackbar(data.message, 'Registro de Restaurante Exitoso',
            colorText: kLightWhite, backgroundColor: Colors.green);
        Get.offAll(() => const Login(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 482));
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar(error.message, 'Fallo el Registro intenta de Nuevo !! ',
            colorText: kLightWhite, backgroundColor: kPrimary);
        isLoading = false;
      }
    } catch (error) {
      isLoading = false;
      debugPrint(error.toString());
      Get.snackbar(error.toString(), 'Fallo',
          colorText: kLightWhite, backgroundColor: kPrimary);
    }
  }

  int generateId() {
    int min = 0;
    int max = 10000;
    final _random = Random();
    return min + Random().nextInt(max - min);
  }

  RestaurantResponse getRestaurantData() {
    String id = box.read('restaurantId');

    if (id != null) {
      String data = box.read(id);
      restaurant = restaurantResponseFromJson(data);
    }
    return restaurant!;
  }
}
