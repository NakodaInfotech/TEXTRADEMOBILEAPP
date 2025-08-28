import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/DateSelectionScreen/DateSelectionListResponseModel.dart';
import 'package:textrade/Filter/FilterModel/ItemDetailsRequestModel.dart';
import 'package:textrade/Filter/FilterModel/ItemDetailsResponseModel.dart';
import 'package:textrade/Items/StockResponseModel.dart';

class ItemDetailScreenController extends GetxController {
  var itemDetail = ItemDetailsResponseModel().obs;
  var selectedDate = "".obs;
  ItemTable? itemTable;
  var isApiLoading = false.obs;

  @override
  void onInit() {
    itemTable = Get.arguments;
   
    selectedDate.value =
        "${AppController.shared.selectedDate!.text} to ${AppController.shared.selectedDate!.text1}";
    var selectedYear = AppController.shared.selectedDate;

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady

    AppController.shared.selectedDateItem =
        AppController.shared.selectedMainDate;

    var dates = AppController.shared.selectedDateItem;
    ItemDetailsRequestModel itemDetailsRequestModel = ItemDetailsRequestModel(
        itemID: (itemTable?.iTEMID ?? 0).toString(),
        designID: (itemTable?.dESIGNID ?? 0).toString(),
        colorID: (itemTable?.cOLORID ?? 0).toString(),
        yearID: dates?.value ?? "",
        fromDate: Utility.convertDateFormate(dates?.text ?? ""),
        toDate: Utility.convertDateFormate(dates?.text1 ?? ""));

    getItemDetails(itemDetailsRequestModel);

    super.onReady();
  }

  void getItemDetails(ItemDetailsRequestModel itemDetailsRequestModel) async {
    isApiLoading.value = true;
    Utility.showLoader(title: "Loading...");

    itemDetail.value =
        await ApiUtility.shared.fetchItemDetails(itemDetailsRequestModel);
    isApiLoading.value = false;
    Utility.hideLoader();
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
      var selectedYear = AppController.shared.selectedDateItem;

      var startDateStr = Utility.dateTimeToString(result.start, "dd-MM-yyyy");
      var endDateStr = Utility.dateTimeToString(result.end, "dd-MM-yyyy");
      var values = selectedYear?.value ?? "";

      selectedDate.value = "${startDateStr} to ${endDateStr}";
      Year tempYear =
          Year(text: startDateStr, text1: endDateStr, value: values);
      AppController.shared.selectedDateItem = tempYear;

      var dates = AppController.shared.selectedDateItem;
      isApiLoading.value = true;
      ItemDetailsRequestModel itemDetailsRequestModel = ItemDetailsRequestModel(
          itemID: (itemTable?.iTEMID ?? 0).toString(),
          designID: (itemTable?.dESIGNID ?? 0).toString(),
          colorID: (itemTable?.cOLORID ?? 0).toString(),
          yearID: dates?.value ?? "",
          fromDate: Utility.convertDateFormate(dates?.text ?? ""),
          toDate: Utility.convertDateFormate(dates?.text1 ?? ""));
      getItemDetails(itemDetailsRequestModel);
      isApiLoading.value = false;
    }
  }
}
