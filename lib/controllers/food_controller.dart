import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vendors/constant/constants.dart';
import 'package:vendors/models/add_foods_model.dart';
import 'package:vendors/models/additive_model.dart';
import 'package:http/http.dart' as http;
import 'package:vendors/models/api_error.dart';
import 'package:vendors/models/success_model.dart';
import 'package:vendors/views/home/home_page.dart';

class FoodController extends GetxController {
  String _category = '';
  final box = GetStorage();
  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;
  String get category => _category;
  set setCategory(String newValue) {
    _category = newValue;
  }

  RxList<String> _types = <String>[].obs;

  RxList<String> get types => _types;

  set setTypes(String newValue) {
    _types.add(newValue);
  }

  int generateId() {
    int min = 0;
    int max = 10000;
    final _random = Random();
    return min + Random().nextInt(max - min);
  }

  RxList<Additive> _additivesList = <Additive>[].obs;

  List<Additive> get additivesList => _additivesList;

  set addAdditivesList(Additive newValue) {
    _additivesList.add(newValue);
  }

  void clearAdditives() {
    _additivesList.clear();
  }

  RxList<String> _tags = <String>[].obs;

  RxList<String> get tags => _tags;

  set setTags(String newValue) {
    _tags.add(newValue);
  }

  void addFoodsFunction(String data) async {
    String accessToken = box.read('accessToken');
    isLoading = true;

    Uri url = Uri.parse('$appBaseUrl/api/foods');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    try {
      var response = await http.post(url, headers: headers, body: data);

      if (response.statusCode == 201) {
        var data = successResponseFromJson(response.body);
        isLoading = false;
        Get.snackbar(
            colorText: kLightWhite,
            backgroundColor: Colors.green,
            'Comida Cargada con Exito',
            data.message);
        Get.to(() => const HomePage(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 856));
      } else {
        isLoading = false;
        var data = apiErrorFromJson(response.body);
        Get.snackbar(
            colorText: kLightWhite,
            backgroundColor: kPrimary,
            'Fallo Subida',
            data.message);
      }
    } catch (e) {
      isLoading = false;
      var data = apiErrorFromJson(e.toString());
      Get.snackbar(
          colorText: kLightWhite,
          backgroundColor: kPrimary,
          'Faillo Subida',
          data.message);
    }
  }
}
