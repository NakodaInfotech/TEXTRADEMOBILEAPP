import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/SalePurchaseOrder/SaleOrderVerificationModel.dart';
import 'package:flutter/scheduler.dart';

class SaleOrderVerificationController extends GetxController {
  var pendingVerificationModel =
      SaleOrderVerificationModel(table: <SaleOrderVerificationData>[].obs).obs;

  var enteredVerificationModel =
      SaleOrderVerificationModel(table: <SaleOrderVerificationData>[].obs).obs;

  var isLoading = false.obs;
  var selectedTab = "Pending".obs;
  var selectedDate = "".obs;

  var selectedName = "";
  var selectedAgent = "";

  var fromTextController = TextEditingController();
  var toTextController = TextEditingController();

  @override
  void onReady() {
    selectedDate.value =
        "${AppController.shared.selectedDate?.text ?? ''} to ${AppController.shared.selectedDate?.text1 ?? ''}";
    selectedTab.value = "Pending";
    getPendingSaleOrders();
    super.onReady();
  }

  Future<void> selectDateTimeRange(BuildContext context) async {
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1990, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      var startDateStr = Utility.dateTimeToString(result.start, "yyyy-MM-dd");
      var endDateStr = Utility.dateTimeToString(result.end, "yyyy-MM-dd");
      var startDateDisplay = Utility.dateTimeToString(result.start, "dd-MM-yyyy");
      var endDateDisplay = Utility.dateTimeToString(result.end, "dd-MM-yyyy");

      selectedDate.value = "$startDateDisplay to $endDateDisplay";

      fromTextController.text = startDateStr;
      toTextController.text = endDateStr;

      if (selectedTab.value == "Pending") {
        await getPendingSaleOrders();
      } else {
        await getEnteredSaleOrders();
      }
    }
  }

  Future<void> getPendingSaleOrders() async {
    selectedTab.value = "Pending";
    await _fetchData();
  }

  Future<void> getEnteredSaleOrders() async {
    selectedTab.value = "Entered";
    await _fetchData();
  }

  Future<void> _fetchData() async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Utility.showLoader(title: "Loading");
    });

    try {
      isLoading.value = true;
      var result = await ApiUtility.shared.getPendingSaleOrder(
        selectedName,
        selectedAgent,
        "",
        "",
        "",
        Utility.convertDateFormate(
            fromTextController.text.isNotEmpty
                ? fromTextController.text
                : AppController.shared.selectedDate?.text ?? ""),
        Utility.convertDateFormate(
            toTextController.text.isNotEmpty
                ? toTextController.text
                : AppController.shared.selectedDate?.text1 ?? ""),
        selectedTab.value, // "Pending" or "Entered"
      );

      if (selectedTab.value == "Pending") {
        pendingVerificationModel.value = result;
      } else {
        enteredVerificationModel.value = result;
      }
    } catch (e) {
      print("Error fetching ${selectedTab.value} sale orders: $e");
    } finally {
      isLoading.value = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Utility.hideLoader();
      });
    }
  }
void verifySelectedOrders() async {
  var selectedList = (selectedTab.value == "Pending"
          ? pendingVerificationModel.value.table
          : enteredVerificationModel.value.table)
      .where((item) => item.isSelected.value)
      .toList();

  if (selectedList.isEmpty) {
    Utility.showErrorView("Alert!", "Please select at least one Sale Order to verify");
    return;
  }

  // Convert list of ints to string like "2|3"
  String sonoString = selectedList.map((e) => e.sono.toString()).join('|');

  // Prepare parameters with correct field names
  Map<String, dynamic> params = {
    "SONO": sonoString,
    "Type": selectedTab.value,
    "YearID": "15"
  };
Utility.showLoader(title: "Loading");
try {
  print('Start verify API: ${DateTime.now()}');
  var response = await ApiUtility.shared.verifySaleOrders(sonoString, selectedTab.value);
  print('Verify API response: ${DateTime.now()}');
  if (selectedTab.value == "Pending") {
    await getPendingSaleOrders();
  } else {
    await getEnteredSaleOrders();
  }
  print('List refreshed: ${DateTime.now()}');
  Utility.hideLoader();
  Utility.showErrorView("Success", "Entries refreshed!");
} catch (e) {
  Utility.hideLoader();
  Utility.showErrorView("Exception", "Something went wrong: $e");
}

}


  void openFilter(BuildContext context) {
    print("Filter button pressed");
    // Yahan filter dialog ya screen open karne ka logic dalein
  }
}
