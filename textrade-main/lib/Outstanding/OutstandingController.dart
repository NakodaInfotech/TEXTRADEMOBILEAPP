import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/DateSelectionScreen/DateSelectionListResponseModel.dart';
import 'package:textrade/Items/ItemsController.dart';
import 'package:textrade/Parties/Models/FilterAgentRequest.dart';
import 'package:textrade/Parties/Models/FilterAreaResponse.dart';
import 'package:textrade/Parties/Models/FilterCityResponse.dart';
import 'package:textrade/Parties/Models/FilterGroupResponse.dart';
import 'package:textrade/Parties/Models/FilterLedgerRequest.dart';
import 'package:textrade/Parties/Models/FilterLedgerResponse.dart';
import 'package:textrade/Parties/Models/LedgerMainRequestModel.dart';
import 'package:textrade/Parties/Models/LedgerMainResponseModel.dart';

class OutstandingController extends GetxController {
  var isRecSelected = true.obs;
  var filterLedgerResponse = FilterLedgerResponse().obs;
  var filterAgentResponse = FilterAgentResponse().obs;
  var filterCityResponse = FilterCityResponse().obs;
  var filterAreaResponse = FilterAreaResponse().obs;
  var filterGroupResponse = FilterGroupResponse().obs;

  //
  var filterLedgerArray = <Ledger>[].obs;
  var filterAgentArray = <Agent>[].obs;
  var filterCityArray = <City>[].obs;
  var filterAreaArray = <AREA>[].obs;
  var filterGroupArray = <Group>[].obs;

  //

  var mainRecLedgerResponse = LedgerMainResponseModel().obs;
  var mainPayLedgerResponse = LedgerMainResponseModel().obs;
  var isDateChangedFromDetailScreen = false;
  var searchTextController = TextEditingController();
  var selectedDate = "".obs;

  var startDateStr = "";
  var endDateStr = "";
  var catArry = [
    Categories("Ledger", true),
    Categories("Agent", false),
    Categories("City", false),
    Categories("Area", false),
    Categories("Group", false)
  ].obs;
  var isCategoryChanged = false;
  var selectedCategory = "Ledger".obs;

  var ledger = "";
  var agent = "";
  var city = "";
  var area = "";
  var group = "";

  LedgerMainRequest ledgerMainRequest = LedgerMainRequest();

  @override
  void onReady() {
    AppController.shared.selectedItemDetailParty =
        AppController.shared.selectedMainDate;
    selectedDate.value =
        "${AppController.shared.selectedDate!.text} to ${AppController.shared.selectedDate!.text1}";
    getRecBalance();
    super.onReady();
  }

  void getRecBalance() async {
    Utility.showLoader(title: "Fetching Data");

    String? yearId = AppController.shared.selectedMainDate?.value;
    ledgerMainRequest = LedgerMainRequest(
        name: ledger,
        agentName: agent,
        city: city,
        area: area,
        group: group,
        yearID: yearId,
        fromDate: Utility.convertDateFormate(
            AppController.shared.selectedItemDetailParty!.text ?? ""),
        toDate: Utility.convertDateFormate(
            AppController.shared.selectedItemDetailParty!.text1 ?? ""));
    if (selectedCategory.value == "Ledger") {
      mainRecLedgerResponse.value =
          await ApiUtility.shared.getRecBalance(ledgerMainRequest);
    } else {
      mainRecLedgerResponse.value =
          await ApiUtility.shared.getAgentRecBalance(ledgerMainRequest);
    }
    Utility.hideLoader();
    getPayBalance();
  }

  void getPayBalance() async {
    Utility.showLoader(title: "Fetching Data");

    String? yearId = AppController.shared.selectedMainDate?.value;
    ledgerMainRequest = LedgerMainRequest(
        name: ledger,
        agentName: agent,
        city: city,
        area: area,
        group: group,
        yearID: yearId,
        fromDate: Utility.convertDateFormate(
            AppController.shared.selectedItemDetailParty!.text ?? ""),
        toDate: Utility.convertDateFormate(
            AppController.shared.selectedItemDetailParty!.text1 ?? ""));

    if (selectedCategory.value == "Ledger") {
      mainPayLedgerResponse.value =
          await ApiUtility.shared.getPayBalance(ledgerMainRequest);
    } else {
      mainPayLedgerResponse.value =
          await ApiUtility.shared.getAgentPayBalance(ledgerMainRequest);
    }

    Utility.hideLoader();
    if (isCategoryChanged == false) {
      getLedgerFilter();
    }
  }

  void getLedgerFilter() async {
    Utility.showLoader(title: "Fetching Data");
    String? yearId = AppController.shared.selectedMainDate?.value;
    final FilterPartiesRequest filterLedgerRequest =
        FilterPartiesRequest(yearID: yearId);
    filterLedgerResponse.value =
        await ApiUtility.shared.fetchLedgerDetails(filterLedgerRequest);
    if (filterLedgerResponse.value.ledger != null) {
      filterLedgerArray.value = filterLedgerResponse.value.ledger!;
    }

    Utility.hideLoader();
    getAgentFilter();
  }

  void getAgentFilter() async {
    Utility.showLoader(title: "Fetching Data");
    String? yearId = AppController.shared.selectedMainDate?.value;
    final FilterPartiesRequest filterLedgerRequest =
        FilterPartiesRequest(yearID: yearId);
    filterAgentResponse.value =
        await ApiUtility.shared.fetchAgentDetails(filterLedgerRequest);
    if (filterAgentResponse.value.agent != null) {
      filterAgentArray.value = filterAgentResponse.value.agent!;
    }
    Utility.hideLoader();
    getCityFilter();
  }

  void getCityFilter() async {
    Utility.showLoader(title: "Fetching Data");
    String? yearId = AppController.shared.selectedMainDate?.value;
    final FilterPartiesRequest filterLedgerRequest =
        FilterPartiesRequest(yearID: yearId);
    filterCityResponse.value =
        await ApiUtility.shared.fetchCityDetails(filterLedgerRequest);
    if (filterCityResponse.value.city != null) {
      filterCityArray.value = filterCityResponse.value.city!;
    }
    Utility.hideLoader();
    getAreaFilter();
  }

  void getAreaFilter() async {
    Utility.showLoader(title: "Fetching Data");
    String? yearId = AppController.shared.selectedMainDate?.value;
    final FilterPartiesRequest filterLedgerRequest =
        FilterPartiesRequest(yearID: yearId);
    filterAreaResponse.value =
        await ApiUtility.shared.fetchAreaDetails(filterLedgerRequest);
    if (filterAreaResponse.value.aREA != null) {
      filterAreaArray.value = filterAreaResponse.value.aREA!;
    }
    Utility.hideLoader();
    getGroupFilter();
  }

  void getGroupFilter() async {
    Utility.showLoader(title: "Fetching Data");
    String? yearId = AppController.shared.selectedMainDate?.value;
    final FilterPartiesRequest filterLedgerRequest =
        FilterPartiesRequest(yearID: yearId);
    filterGroupResponse.value =
        await ApiUtility.shared.fetchGroupDetails(filterLedgerRequest);
    if (filterGroupResponse.value.group != null) {
      filterGroupArray.value = filterGroupResponse.value.group!;
    }
    Utility.hideLoader();
  }

  void searchResult(String searchStr) {
    var selectedCategoryIndex =
        catArry.indexWhere((element) => element.isSelected == true);
    switch (selectedCategoryIndex) {
      case 0:
        if (searchStr != "") {
          filterLedgerArray.value = filterLedgerResponse.value.ledger!
              .where((element) =>
                  element.text!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList();
        } else {
          filterLedgerArray.value = filterLedgerResponse.value.ledger!;
        }
        filterLedgerArray.refresh();
        break;
      case 1:
        if (searchStr != "") {
          filterAgentArray.value = filterAgentResponse.value.agent!
              .where((element) =>
                  element.text!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList();
        } else {
          filterAgentArray.value = filterAgentResponse.value.agent!;
        }
        filterAgentArray.refresh();
        break;
      case 2:
        if (searchStr != "") {
          filterCityArray.value = filterCityResponse.value.city!
              .where((element) =>
                  element.text!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList();
        } else {
          filterCityArray.value = filterCityResponse.value.city!;
        }
        filterCityArray.refresh();
        break;
      case 3:
        if (searchStr != "") {
          filterAreaArray.value = filterAreaResponse.value.aREA!
              .where((element) =>
                  element.text!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList();
        } else {
          filterAreaArray.value = filterAreaResponse.value.aREA!;
        }
        filterAreaArray.refresh();
        break;
      case 4:
        if (searchStr != "") {
          filterGroupArray.value = filterGroupResponse.value.group!
              .where((element) =>
                  element.text!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList();
        } else {
          filterGroupArray.value = filterGroupResponse.value.group!;
        }
        filterGroupArray.refresh();
        break;
      default:
    }
  }

  void applyFilter() async {
    Get.back();

    ledger = (filterLedgerResponse.value.ledger ?? [])
        .where((p0) => p0.isSelected == true)
        .map((e) => e.value)
        .join(",");
    agent = (filterAgentResponse.value.agent ?? [])
        .where((p0) => p0.isSelected == true)
        .map((e) => e.value)
        .join(",");
    city = (filterCityResponse.value.city ?? [])
        .where((p0) => p0.isSelected == true)
        .map((e) => e.value)
        .join(",");
    area = (filterAreaResponse.value.aREA ?? [])
        .where((p0) => p0.isSelected == true)
        .map((e) => e.value)
        .join(",");
    group = (filterGroupResponse.value.group ?? [])
        .where((p0) => p0.isSelected == true)
        .map((e) => e.value)
        .join(",");

    Utility.showLoader(title: "Fetching Data...");
    String? yearId = AppController.shared.selectedMainDate?.value;
    ledgerMainRequest = LedgerMainRequest(
        name: ledger,
        agentName: agent,
        city: city,
        area: area,
        group: group,
        yearID: yearId,
        fromDate: Utility.convertDateFormate(
            AppController.shared.selectedDate!.text ?? ""),
        toDate: Utility.convertDateFormate(
            AppController.shared.selectedDate!.text1 ?? ""));

    if (selectedCategory.value == "Ledger") {
      mainRecLedgerResponse.value =
          await ApiUtility.shared.getRecBalance(ledgerMainRequest);
    } else {
      mainRecLedgerResponse.value =
          await ApiUtility.shared.getAgentRecBalance(ledgerMainRequest);
    }
    if (selectedCategory.value == "Ledger") {
      mainPayLedgerResponse.value =
          await ApiUtility.shared.getPayBalance(ledgerMainRequest);
    } else {
      mainPayLedgerResponse.value =
          await ApiUtility.shared.getAgentPayBalance(ledgerMainRequest);
    }
    // mainRecLedgerResponse.value =
    //     await ApiUtility.shared.getRecBalance(ledgerMainRequest);
    // mainPayLedgerResponse.value =
    //     await ApiUtility.shared.getPayBalance(ledgerMainRequest);
    Utility.hideLoader();
  }

  void resetFilter() {
    (filterLedgerResponse.value.ledger ?? []).forEach((element) {
      element.isSelected = false;
    });
    filterLedgerArray.forEach((element) {
      element.isSelected = false;
    });
    filterLedgerArray.refresh();

    (filterAgentResponse.value.agent ?? []).forEach((element) {
      element.isSelected = false;
    });
    filterAgentArray.forEach((element) {
      element.isSelected = false;
    });
    filterAgentArray.refresh();

    (filterCityResponse.value.city ?? []).forEach((element) {
      element.isSelected = false;
    });
    filterCityArray.forEach((element) {
      element.isSelected = false;
    });
    filterCityArray.refresh();

    (filterAreaResponse.value.aREA ?? []).forEach((element) {
      element.isSelected = false;
    });
    filterAreaArray.forEach((element) {
      element.isSelected = false;
    });
    filterAreaArray.refresh();

    (filterGroupResponse.value.group ?? []).forEach((element) {
      element.isSelected = false;
    });
    filterGroupArray.forEach((element) {
      element.isSelected = false;
    });
    filterGroupArray.refresh();
  }

  void selectDateTimeRage(BuildContext context) async {
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1990, 1, 1),
      // the earliest allowable
      lastDate: DateTime(2030, 12, 31),
      // the latest allowable
      currentDate: DateTime.now(),
      // fieldStartHintText: "dd/mm/yyyy",

      // fieldEndHintText: "dd/mm/yyyy",
      saveText: 'Done',
    );
    if (result != null) {
      var selectedYear = AppController.shared.selectedDateItem;

      startDateStr = Utility.dateTimeToString(result.start, "dd-MM-yyyy");
      endDateStr = Utility.dateTimeToString(result.end, "dd-MM-yyyy");
      var values = selectedYear?.value ?? "";

      selectedDate.value = "${startDateStr} to ${endDateStr}";
      Year tempYear =
          Year(text: startDateStr, text1: endDateStr, value: values);
      AppController.shared.selectedItemDetailParty = tempYear;

      var dates = AppController.shared.selectedItemDetailParty;
      final String ledger = filterLedgerArray
          .where((p0) => p0.isSelected == true)
          .map((e) => e.value)
          .join(",");
      final String agent = filterAgentArray
          .where((p0) => p0.isSelected == true)
          .map((e) => e.value)
          .join(",");
      final String city = filterCityArray
          .where((p0) => p0.isSelected == true)
          .map((e) => e.value)
          .join(",");
      final String area = filterAreaArray
          .where((p0) => p0.isSelected == true)
          .map((e) => e.value)
          .join(",");
      final String group = filterGroupArray
          .where((p0) => p0.isSelected == true)
          .map((e) => e.value)
          .join(",");

      Utility.showLoader(title: "Fetching Data...");
      String? yearId = AppController.shared.selectedMainDate?.value;
      ledgerMainRequest = LedgerMainRequest(
          name: ledger,
          agentName: agent,
          city: city,
          area: area,
          group: group,
          yearID: yearId,
          fromDate: Utility.convertDateFormate(dates!.text ?? ""),
          toDate: Utility.convertDateFormate(dates.text1 ?? ""));

      mainRecLedgerResponse.value =
          await ApiUtility.shared.fetchMainLedgerDetails(ledgerMainRequest);
      Utility.hideLoader();
    }
  }

  updateSelectedCategory(String newValue) {
    selectedCategory.value = newValue;
    isCategoryChanged = true;
    getRecBalance();
  }
}
