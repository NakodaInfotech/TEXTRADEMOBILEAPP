import 'dart:convert';

import 'package:get/get.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/CompanyList/CompanyListModal.dart';
import 'package:textrade/DateSelectionScreen/DateSelectionListResponseModel.dart';

import '../Common/DefaultStorageKeys.dart';
import '../Common/Routes.dart';
import '../Common/StorageManager.dart';

class DateListController extends GetxController {
  var dateListObs = DateListResponseModel().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getDateList();
    super.onInit();
  }

  void getDateList() async {
    var companyList = await ApiUtility.shared.dateListApiCall();
    if (companyList == null) {
      Utility.showErrorView("Error", "Failed to fetch company List");
      return;
    }

    dateListObs.value = companyList;
  }

  void dateSelected(Year value) {
    AppController.shared.selectedDate = value;
    AppController.shared.selectedMainDate = value;
    AppController.shared.selectedDateItem = value;
    AppController.shared.selectedItemDetailParty = value;
    Get.offAllNamed(Utility.screenName(Screens.tabBar));
  }
}
