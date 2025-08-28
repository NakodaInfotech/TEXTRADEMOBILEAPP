import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_imei/flutter_device_imei.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/DefaultStorageKeys.dart';
import 'package:textrade/Common/StorageManager.dart';

import '../Common/Routes.dart';
import '../Common/Utilies.dart';

class LoginScreenControler extends GetxController {
  var companyCodeTextFieldController = TextEditingController();
  var userIdTextFieldController = TextEditingController();
  var passWordTextFieldController = TextEditingController();
  var _identifier = 'Unknown'.obs;
  var baseUrlvalue = ''.obs;

  void loginPressed() {
    if (userIdTextFieldController.text.isEmpty) {
      Utility.showErrorView("Alert", "Please Enter UserId",
          alertType: AlertType.error);
    } else if (passWordTextFieldController.text.isEmpty) {
      Utility.showErrorView("Alert", "Please Enter Password",
          alertType: AlertType.error);
    } else {
      loginApi();
    }
  }

  void loginApi() async {
    String imei = _identifier.value; //"5e88b20bb5773bdf";
    var loginResponse = await ApiUtility.shared.loginApiCall(
        userIdTextFieldController.text, passWordTextFieldController.text, imei);
    if ((loginResponse?.table[0].statusMsg ?? "") == "Login Successful") {
      StorageManager.saveData(
          userId, loginResponse?.table[0].userId.toString() ?? "");
      AppController.shared.userId =
          loginResponse?.table[0].userId.toString() ?? "";
      Get.toNamed(Utility.screenName(Screens.companyListScreen));
    } else {
      Utility.showErrorView("Alert", "Invalid Details",
          alertType: AlertType.error);
    }
  }

  void verifyCompany() async {
    if (companyCodeTextFieldController.text == "") {
      Utility.showErrorView("Alert", "Please Enter Company Code",
          alertType: AlertType.error);
      return;
    }
    var loginResponse = await ApiUtility.shared.getCompanyDetails();
    if (loginResponse.response != null) {
      var arrayObject = loginResponse.response?.where(
          (element) => element.code == companyCodeTextFieldController.text);
      if (arrayObject!.length == 0) {
        Utility.showErrorView("Alert", "Invalid Company Details",
            alertType: AlertType.error);
        return;
      }
      baseUrlvalue.value = arrayObject.first.ipAddress!;
      StorageManager.saveData(baseUrlVal, arrayObject.first.ipAddress);
    } else {
      Utility.showErrorView("Alert", "Invalid Details",
          alertType: AlertType.error);
    }
  }

  Future<String?> getDeviceIMEI() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      // Request permission for Android
      var status = await Permission.phone.request();
      if (status.isGranted) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return androidInfo
            .id; // IMEI is no longer accessible directly on Android 10+
      } else {
        return "Permission denied";
      }
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor; // Unique ID for iOS devices
    }
    return null;
  }

  @override
  void onReady() async {
    baseUrlvalue.value = await StorageManager.readData(baseUrlVal) ?? "";
    getData();
    super.onReady();
  }

  getData() async {
    // _identifier.value = await getDeviceIMEI() ?? "Unknown";

    _identifier.value = (await FlutterDeviceImei.instance.getIMEI())!;
    print("agsejqwgejqhwge ${_identifier.value}");
    //kkgehjqwge
  }
}
