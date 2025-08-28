import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/Parties/Models/LedgerMainRequestModel.dart';
import 'package:textrade/rack/model/rack_model.dart';

class RackController extends GetxController {
  var textController = TextEditingController();
  var selectedRack = RackTable().obs;
  var racks = RackModel().obs;
  var scannedQrCodes = <String>[].obs;
  final showDropdown = false.obs;
  var isRackManagement = false.obs;

  @override
  void onReady() {
    fetchRackList();
    super.onReady();
  }

  void onInit() {
    isRackManagement.value = Get.arguments[0];
    super.onInit();
  }

  fetchRackList() async {
    Utility.showLoader(title: "Loading...");
    LedgerMainRequest ledgerMainRequest = LedgerMainRequest();
    ledgerMainRequest.yearID = AppController.shared.selectedDate!.value ?? "";
    racks.value = await ApiUtility().fetchRackList(ledgerMainRequest);
    racks.value.table = racks.value.table?.reversed.toList();
    racks.value.table?.add(RackTable(rACKId: 0, rACKNAME: ""));
    racks.value.table = racks.value.table?.reversed.toList();
    racks.value.table = racks.value.table?.toSet().toList();
    if (isRackManagement.value) {
      racks.value.table?.removeAt(0);
    }
    selectedRack.value = racks.value.table!.first;
    racks.refresh();
    scannedQrCodes.value = [];
    Utility.hideLoader();
    if (racks.value.table?.isEmpty ?? true) {
      Utility.showErrorView("Error", "Something went wrong");
    }
  }
}
