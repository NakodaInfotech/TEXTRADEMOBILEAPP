// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/DateSelectionScreen/DateSelectionListResponseModel.dart';
import 'package:textrade/HomeScreen/HomeScreenResponseModel.dart';

import '../Common/ApiHandler/ApiUtility.dart';
import '../Common/Utilies.dart';

class HomeScreenController extends GetxController {
  var homeScreenResponse = HomeScreenResponseModel().obs;
  var selectedDate = "".obs;
  var startDateStr = "";
  var endDateStr = "";
  var isApiLoading = false.obs;
  @override
  void onInit() {
    selectedDate.value =
        "${AppController.shared.selectedDate!.text} to ${AppController.shared.selectedDate!.text1}";

    var selectedYear = AppController.shared.selectedDate;

    getDashboardListing(selectedYear: selectedYear);
    super.onInit();
  }

  void getDashboardListing({Year? selectedYear}) async {
    isApiLoading.value = true;
    var homeScreenList =
        await ApiUtility.shared.dashboardistApiCall(selectedYear: selectedYear);
    isApiLoading.value = false;
    if (homeScreenList == null) {
      Utility.showErrorView("Error", "Failed to fetch company List");
      return;
    }
    homeScreenResponse.value = homeScreenList;
  }

  void selectDateTimeRage(BuildContext context) async {
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1990, 1, 1), // the earliest allowable
      lastDate: DateTime(2030, 12, 31), // the latest allowable
      currentDate: DateTime.now(),
      // fieldStartHintText: "dd/mm/yyyy",

      // fieldEndHintText: "dd/mm/yyyy",
      saveText: 'Done',
    );
    if (result != null) {
      var selectedYear = AppController.shared.selectedDate;

      startDateStr = Utility.dateTimeToString(result.start, "dd-MM-yyyy");
      endDateStr = Utility.dateTimeToString(result.end, "dd-MM-yyyy");
      var values = selectedYear?.value ?? "";

      selectedDate.value = "${startDateStr} to ${endDateStr}";
      Year tempYear =
          Year(text: startDateStr, text1: endDateStr, value: values);
      // AppController.shared.selectedDate = tempYear;
      getDashboardListing(selectedYear: tempYear);
    }
  }
}
