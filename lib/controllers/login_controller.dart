import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vendors/constant/constants.dart';
import 'package:vendors/controllers/restaurant_controller.dart';
import 'package:vendors/models/api_error.dart';
import 'package:vendors/models/login_response.dart';
import 'package:vendors/models/restaurant_response.dart';
import 'package:vendors/models/success_model.dart';
import 'package:vendors/views/auth/login_page.dart';
import 'package:vendors/main.dart';
import 'package:http/http.dart' as http;
import 'package:vendors/views/auth/restaurant_registration.dart';
import 'package:vendors/views/auth/verification_page.dart';
import 'package:vendors/views/auth/waiting_page.dart';
import 'package:vendors/views/home/home_page.dart';

class LoginController extends GetxController {
  final controller = Get.put(RestaurantController());
  final box = GetStorage();
  RestaurantResponse? restaurant;
  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  void loginFunc(String data) async {
    isLoading = true;
    var url = Uri.parse('${appBaseUrl}/login');

    Map<String, String> headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(url, body: data, headers: headers);
      if (response.statusCode == 200) {
        var data = loginResponseFromJson(response.body);
        box.write(data.id, json.encode(data));
        box.write('userId', data.id);
        box.write('accessToken', data.userToken);
        box.write('e-verification', data.verification);

        if (data.verification == false) {
          Get.snackbar('Verificacion', "Por favor Revise su Email",
              backgroundColor: Colors.green, colorText: kLightWhite);

          Get.offAll(() => const VerificationPage(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 892));
        } else if (data.verification == true && data.userType == "Client") {
          defaultHome = const Login();
          Get.offAll(() => const RestauranteRegistration(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 592));
        } else if (data.verification == true && data.userType == 'Vendor') {
          getVendorInfo(data.userToken);
        }

        isLoading = false;
      } else {
        var data = successResponseFromJson(response.body);
        Get.snackbar("No se Pudo Loguear. Vuelve a intentar", data.message,
            snackPosition: SnackPosition.TOP,
            backgroundColor: kPrimary,
            colorText: Colors.white);
        isLoading = false;
      }
    } catch (error) {
      Get.snackbar("Error no se pudo Loguer", error.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: kPrimary,
          colorText: Colors.white);
      isLoading = false;
    }
  }

  void logout() {
    box.erase();
    defaultHome = const Login();
    Get.offAll(() => defaultHome,
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 760));
  }

  LoginResponse? getUserData() {
    String id = box.read('userId');

    if (id != null) {
      return loginResponseFromJson(box.read(id));
    } else {
      return null;
    }
  }

  void getVendorInfo(String accessToken) async {
    isLoading = true;
    var url = Uri.parse('$appBaseUrl/api/restaurants/owner/profile');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        RestaurantResponse restaurantData =
            restaurantResponseFromJson(response.body);
        restaurant = restaurantData;
        controller.restaurant = restaurantData;

        box.write("restaurantId", restaurantData.id);
        box.write("verification", restaurantData.verification);

        String data = restaurantResponseToJson(restaurantData);

        box.write(restaurantData.id, data);

        if (restaurantData.verification != "Verified") {
          Get.offAll(() => const WaitingPage(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 489));
        } else {
          Get.offAll(() => const HomePage(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 499));
        }
        isLoading = false;
      } else {
        var data = apiErrorFromJson(response.body);
        Get.snackbar('Opps Fallo!', data.message,
            backgroundColor: kPrimary, colorText: kLightWhite);
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      Get.snackbar('Fallo Login', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
