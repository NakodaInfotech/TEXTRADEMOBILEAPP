import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:textrade/CatalogList/CatalogModel.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/DefaultStorageKeys.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/StorageManager.dart';
import 'package:textrade/Items/ItemsController.dart';
import 'package:textrade/Outstanding/PDFGenerationReq.dart';
import 'package:textrade/Parties/Models/FilterLedgerRequest.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:path_provider/path_provider.dart';
import 'package:textrade/SalesForm/model/searchModel.dart';

import '../Common/Utilies.dart';

class CatalogListController extends GetxController {
  var fromTextController = TextEditingController();
  var toTextController = TextEditingController();

  var challanGDNModel = CatalogModel().obs;
  var isIncludeSelected = false.obs;

  var isPurchaseOrder = false.obs;

  var selectedName = "";
  var selectedAgent = "";
  var selectedReg = "Purchase REGISTER";

  @override
  Future<void> onReady() async {
    apiCall();
    super.onReady();
  }

  selectUnselectAllList(bool? selectedBool) async {
    challanGDNModel.value.table?.forEach((element) {
      element.isSelected = selectedBool;
    });
    challanGDNModel.refresh();
  }

  selectOrDeselectCatalog(CatalogTable? table) {
    if (table != null) {
      table.isSelected = !table.isSelected!;
      challanGDNModel.refresh();
    }
  }

  void openFilter() async {
    var cats = [
      Categories("Item", true),
      Categories("Design", false),
    ];
    Utility.showLoader(title: "Loading");

    var yearId = AppController.shared.selectedDate?.value;
    final FilterPartiesRequest filterLedgerRequest =
        FilterPartiesRequest(yearID: yearId);
    var ledgerArr = await ApiUtility.shared.fetchItem(filterLedgerRequest);

    var agentArr = await ApiUtility.shared.fetchDesign(filterLedgerRequest);

    var ledgerSearchArr = <SearchGenericModel>[];
    var agentSearchArr = <SearchGenericModel>[];

    if (ledgerArr.item != null) {
      for (var element in ledgerArr.item ?? []) {
        ledgerSearchArr.add(SearchGenericModel(element.text, element.value));
      }
    }

    if (agentArr.design != null) {
      for (var element in agentArr.design ?? []) {
        agentSearchArr.add(SearchGenericModel(element.text, element.value));
      }
    }

    var data = [ledgerSearchArr.obs, agentSearchArr.obs];
    var data1 = [ledgerSearchArr.obs, agentSearchArr.obs];

    Utility.hideLoader();
    Get.toNamed(Utility.screenName(Screens.commonFilter),
        arguments: [cats, data, data1])?.then((value) async {
      selectedName = (value[0] as List<SearchGenericModel>)
          .map((e) => e.name)
          .toList()
          .join(",");
      selectedAgent = (value[1] as List<SearchGenericModel>)
          .map((e) => e.name)
          .toList()
          .join(",");
      apiCall();
    });
  }

  Future<void> apiCall() async {
    Utility.showLoader(title: "Loading");
    challanGDNModel.value = await ApiUtility.shared
        .getCatalogList(selectedAgent, selectedName, isIncludeSelected.value);
    Utility.hideLoader();
  }

  void getGeneratedPdfLink() async {
    Utility.showLoader(title: "Loading");
    var fileList = <XFile>[];
    challanGDNModel.value.table
        ?.where((element) => element.isSelected == true)
        .forEach((element) async {
      final response = await http.get(Uri.parse(element.fILENAME ?? ""));

      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File(
            '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
        await file.writeAsBytes(response.bodyBytes);
        fileList.add(XFile(file.path));
        sharefile(fileList);
        // Share the PDF file
      } else {
        print('Failed to download images');
      }
    });
  }

  Future<void> sharefile(List<XFile> fileList) async {
    if (challanGDNModel.value.table
            ?.where((element) => element.isSelected == true)
            .length ==
        fileList.length) {
      Utility.hideLoader();
      await Share.shareXFiles(fileList);
    }
  }
}
