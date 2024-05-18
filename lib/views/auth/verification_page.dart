import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_text_field_v2/otp_text_field_v2.dart';
import 'package:vendors/common/custom_button.dart';
import 'package:vendors/constant/constants.dart';
import 'package:vendors/controllers/email_verification_controller.dart';
import 'package:vendors/controllers/login_controller.dart';
import 'package:vendors/models/login_response.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmailVerificationController());
    final userController = Get.put(LoginController());
    LoginResponse? user = userController.getUserData();

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          SizedBox(
            height: 80.h,
          ),
          Lottie.asset('assets/anime/delivery.json'),
          SizedBox(
            height: 30.h,
          ),
          const Text(
            "Verifica tu Cuenta",
            style: TextStyle(
                fontSize: 20, color: kDark, fontWeight: FontWeight.w700),
          ),
          const Text(
              "Ingresa el código enviado a tu correo electrónico, si no lo recibiste haz click en reenviar",
              style: TextStyle(
                  fontSize: 17, color: kDark, fontWeight: FontWeight.w600)),
          SizedBox(
            height: 20.h,
          ),
          OTPTextFieldV2(
              controller: otpController,
              length: 6,
              autoFocus: true,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 45,
              outlineBorderRadius: 15,
              style: const TextStyle(fontSize: 17),
              onCompleted: (pin) {
                controller.setCode(pin);
                controller.verifyEmail(pin);
              }),
          SizedBox(
            height: 20.h,
          ),
          CustomButton(
            onTap: () {
              controller.verifyEmail(controller.code);
            },
            btnColor: kPrimary,
            text: "Verificar Cuenta",
            btnHeight: 40.h,
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
              "El correo electrónico ha sido enviado a ${user!.email}. Si el correo electrónico no es correcto, elimine esta cuenta y cree una nueva con el correo electrónico correcto. Alternativamente, puedes cerrar sesión y navegar por la aplicación sin una cuenta",
              textAlign: TextAlign.justify,
              style: const TextStyle(
                  fontSize: 11, color: kDark, fontWeight: FontWeight.w700)),
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    userController.logout();
                  },
                  child: const Text("Salir",
                      style: TextStyle(
                          fontSize: 15,
                          color: kSecondary,
                          fontWeight: FontWeight.w500))),
              GestureDetector(
                onTap: () {
                  // userController.deleteAccount();
                },
                child: const Text("Borrar Cuenta",
                    style: TextStyle(
                        color: kPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
