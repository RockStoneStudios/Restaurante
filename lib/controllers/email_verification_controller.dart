import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vendors/constant/constants.dart';
import 'package:http/http.dart' as http;
import 'package:vendors/models/login_response.dart';
import 'package:vendors/models/success_model.dart';
import 'package:vendors/views/auth/login_page.dart';
import 'package:vendors/views/auth/restaurant_registration.dart';

class EmailVerificationController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  void loginFunc(String data) async {}

  RxString _code = ''.obs;

  String get code => _code.value;

  void setCode(String value) => _code.value = value;

  void verifyEmail(String code) async {
    isLoading = true;
    String accessToken = box.read('accessToken');
    print('--------++++++++-------- $accessToken');
    var url = Uri.parse('$appBaseUrl/api/users/verify/$code');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      var response = await http.get(url, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        LoginResponse data = loginResponseFromJson(response.body);

        box.write(data.id, json.encode(data));
        box.write('accessToken', data.userToken);
        box.write('e-verification', data.verification);

        Get.snackbar(
          "Verificacion Exitosa",
          "Disfruta de SopeFoods y encuentra las mejores comidas!!",
          backgroundColor: kSecondary,
          colorText: kLightWhite,
        );

        if (data.userType == 'Client') {
          Get.offAll(() => const RestauranteRegistration(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 859));
        } else {
          Get.offAll(() => const Login(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 859));
        }
        isLoading = false;
      } else {
        var data = successResponseFromJson(response.body);

        Get.snackbar("Error al verificar cuenta", "Oops!! Ocurrido un Error",
            backgroundColor: kPrimary, colorText: kLightWhite);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error al verificar cuenta", "Oops!! Ocurrido un Error!",
          backgroundColor: kPrimary, colorText: kLightWhite);
    }
  }
}
