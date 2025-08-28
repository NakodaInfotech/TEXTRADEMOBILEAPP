import 'package:get/get.dart';
import 'package:textrade/Common/Utilies.dart';

import '../Common/Routes.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    _startTimer();
    super.onInit();
  }

  _startTimer() async {
    Future.delayed(const Duration(seconds: 2), () {
      _goToLoginScreenOrHomeScreen();
    });
  }

  _goToLoginScreenOrHomeScreen() async {
    Get.offAllNamed(Utility.screenName(Screens.loginScreen));
  }
}
