import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String googleApiKey = 'AIzaSyBI66AmMWjQ68bqowmtFLzr2tht-nMiQng';

const kPrimary = Color(0xFF881004);
const kPrimaryLight = Color(0xFFA10F3A);
const kSecondary = Color(0xffffa44f);
const kSecondaryLight = Color(0xFFffe5db);
const kTertiary = Color(0xff0078a6);
const kGray = Color(0xff83829A);
const kGrayLight = Color(0xffC1C0C8);
const kLightWhite = Color(0xffFAFAFC);
const kWhite = Color(0xfffFFFFF);
const kDark = Color(0xff000000);
const kRed = Color(0xffe81e4d);
const kOffWhite = Color(0xffF3F4F8);

double height = 926.h;
double width = 428.w;

List<String> orderList = [
  "Nueva Orden",
  "Preparando",
  "Listo",
  "Recogido",
  "Entregado",
  "Autoentrega",
  "Cancelado"
];

const String appBaseUrl = "http://192.168.101.71:3000";
