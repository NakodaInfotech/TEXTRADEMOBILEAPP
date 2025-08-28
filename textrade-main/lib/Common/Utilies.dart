import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../Widgets/CustomLoader.dart';
import 'Routes.dart';

enum AlertType { success, error }

class Utility {
  static String screenName(Screens screenName) {
    return "/$screenName";
  }

  static showErrorView(String title, String message, {AlertType? alertType}) {
    Color? backgroundColor;
    switch (alertType) {
      case AlertType.success:
        backgroundColor = Colors.orange;
        break;

      case AlertType.error:
        backgroundColor = Colors.red;
        break;
      default:
        backgroundColor = Colors.orange;
        break;
    }
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
    );
  }

  static showLoader({String? title}) {
    Get.dialog(CustomLoader(loadingMessage: title), barrierDismissible: false);
  }

  static String convertDateFormate(String dateString) {
    var date = DateFormat("dd-MM-yyyy").parse("$dateString 00:00:00.00");
    var formatedDate = DateFormat("yyyy-MM-dd").format(date);
    return formatedDate;
  }

  static String convertDateFormateDDMMYYYY(String dateString) {
    var date = DateFormat("yyy-MM-dd").parse("$dateString 00:00:00.00");
    var formatedDate = DateFormat("dd-MM-yyyy").format(date);
    return formatedDate;
  }

  static String dateTimeToString(DateTime dateTime, String formate) {
    return DateFormat(formate).format(dateTime);
  }

  static hideLoader() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  Future<XFile?> imagePicker() async {}
}
