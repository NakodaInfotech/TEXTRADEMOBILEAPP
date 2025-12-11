import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/SplashScreen/SplashScreen.dart';

import 'Common/Routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'Common/Utilies.dart';
  // adjust import as per project

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TexTrade',
      debugShowCheckedModeBanner: false,

      // ✅ GetX routing use kar rahe ho to sirf ye do chiz:
      initialRoute: Utility.screenName(Screens.splash),
      getPages: Routes.shared.pages,

      theme: ThemeData(
        primarySwatch: appColor,
      ),

      // ❌ yahan `home:` mat do, warna route / overlay kabhi-kabhi gadbad karta hai
      // home: SplashScreen(),
    );
  }
}

