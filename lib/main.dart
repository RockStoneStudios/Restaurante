import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vendors/firebase_options.dart';
import 'package:vendors/views/auth/login_page.dart';
import 'package:vendors/views/auth/verification_page.dart';
import 'package:vendors/views/auth/waiting_page.dart';
import 'package:vendors/views/home/home_page.dart';

Widget defaultHome = const Login();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    String? accessToken = box.read('accessToken');
    String? restaurantId = box.read('restaurantId');
    String verification = box.read('verification') ?? 'default_value';
    bool? everification = box.read('e-verification') ?? false;

    if (accessToken == null) {
      defaultHome = const Login();
    } else if (accessToken != null && everification == false) {
      defaultHome = const VerificationPage();
    } else if (accessToken != null &&
        restaurantId != null &&
        verification == "Verified") {
      defaultHome = const HomePage();
    } else if (accessToken != null &&
        restaurantId != null &&
        verification != "Verified") {
      defaultHome = const WaitingPage();
    }

    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(420, 926),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: defaultHome);
      },
    );
  }
}
