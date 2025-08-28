import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/ApiHandler/ApiHandler.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/SplashScreen/SplashScreenController.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  var controller = Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover)),
        child: Center(
            child: Image.asset(
          appIcon,
        )),
      ),
    );
  }
}
