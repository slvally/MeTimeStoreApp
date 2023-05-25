import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFE1E2DB),
        body: Center(
          child: Container(
            width: Get.width * 0.4,
            height: Get.height * 0.6,
            child: Image.asset("assets/SplashLogo.png"),
          ),
        ),
      ),
    );
  }
}
