import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:textrade/Challan/ChallanGDNModel.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Items/ItemsController.dart';
import 'package:textrade/Outstanding/PDFGenerationReq.dart';
import 'package:textrade/Parties/Models/FilterLedgerRequest.dart';
import 'package:http/http.dart' as http;
import 'package:textrade/SalesForm/model/searchModel.dart';
import 'package:share_plus/share_plus.dart';
import 'package:textrade/Common/Utilies.dart';

import 'package:textrade/Outstanding/OutstandingDetaisResModel.dart';
import 'package:textrade/Outstanding/PDFGenerationReq.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:share_plus/share_plus.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/Outstanding/OutstandingController.dart';
import 'package:textrade/Outstanding/OutstandingDetaisResModel.dart';
import 'package:textrade/Outstanding/PDFGenerationReq.dart';
import 'package:textrade/Parties/Models/LedgerMainRequestModel.dart';
import 'package:textrade/Parties/Models/LedgerMainResponseModel.dart';
import 'package:textrade/Common/ShareHelper.dart';

import '../Common/Utilies.dart';

class ChallanGDNController extends GetxController {
  var fromTextController = TextEditingController();
  var toTextController = TextEditingController();
  var challanGDNModel = ChallanGDNModel().obs;

  var selectedDate = "".obs;

  var selectedName = "";
  var selectedAgent = "";

  @override
  void onReady() {
    selectedDate.value =
        "${AppController.shared.selectedDate!.text} to ${AppController.shared.selectedDate!.text1}";
    getChallanList();
    super.onReady();
  }

  getChallanList() async {
    Utility.showLoader(title: "Loading");
    challanGDNModel.value = await ApiUtility.shared.getGDNChallanList(
        fromTextController.text,
        toTextController.text,
        selectedName,
        selectedAgent,
        Utility.convertDateFormate(
            AppController.shared.selectedDate!.text ?? ""),
        Utility.convertDateFormate(
            AppController.shared.selectedDate!.text1 ?? ""));
    Utility.hideLoader();
  }

  selectOrDeselectChallan(ChallanTableList? table) {
    if (table != null) {
      table.isSelected = !table.isSelected!;
      challanGDNModel.refresh();
    }
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
      var startDateStr = Utility.dateTimeToString(result.start, "yyyy-MM-dd");
      var endDateStr = Utility.dateTimeToString(result.end, "yyyy-MM-dd");
      var startDateStrdis =
          Utility.dateTimeToString(result.start, "dd-MM-yyyy");
      var endDateStrdis = Utility.dateTimeToString(result.end, "dd-MM-yyyy");
      selectedDate.value = "$startDateStrdis to $endDateStrdis";

      Utility.showLoader(title: "Loading");
      challanGDNModel.value = await ApiUtility.shared.getGDNChallanList(
          fromTextController.text,
          toTextController.text,
          selectedName,
          selectedAgent,
          startDateStr,
          endDateStr);
      Utility.hideLoader();
    }
  }

  void openFilter() async {
    var cats = [Categories("Name", true), Categories("Agent", false)];
    Utility.showLoader(title: "Loading");

    var yearId = AppController.shared.selectedDate?.value;
    final FilterPartiesRequest filterLedgerRequest =
        FilterPartiesRequest(yearID: yearId);
    var ledgerArr =
        await ApiUtility.shared.fetchLedgerDetails(filterLedgerRequest);

    var agentArr =
        await ApiUtility.shared.fetchAgentDetails(filterLedgerRequest);

    var ledgerSearchArr = <SearchGenericModel>[];
    var agentSearchArr = <SearchGenericModel>[];

    if (ledgerArr.ledger != null) {
      for (var element in ledgerArr.ledger ?? []) {
        ledgerSearchArr.add(SearchGenericModel(element.text, element.value));
      }
    }

    if (agentArr.agent != null) {
      for (var element in agentArr.agent ?? []) {
        agentSearchArr.add(SearchGenericModel(element.text, element.value));
      }
    }

    var data = [ledgerSearchArr.obs, agentSearchArr.obs];
    var data1 = [ledgerSearchArr.obs, agentSearchArr.obs];

    Utility.hideLoader();
    Get.toNamed(Utility.screenName(Screens.commonFilter),
        arguments: [cats, data, data1])?.then((value) async {
      selectedName = (value[0] as List<SearchGenericModel>)
          .map((e) => e.id)
          .toList()
          .join(",");
      selectedAgent = (value[1] as List<SearchGenericModel>)
          .map((e) => e.id)
          .toList()
          .join(",");
      getChallanList();
    });
  }

  void getGeneratedPdfLink() async {
    var mainGDN = ChallanGDNModel();
    if (challanGDNModel.value != null) {
      mainGDN = ChallanGDNModel.fromJson(
          jsonDecode(jsonEncode(challanGDNModel.value)));
    }

    var selectedGDN = challanGDNModel.value.table
        ?.where((mainElement) => (mainElement.isSelected ?? false) == true)
        .map((e) => e.gDNNO);

    List<ChallanTableList>? tablevalue = [];
    mainGDN.table?.forEach((elementTable) {
      if (selectedGDN!.contains(elementTable.gDNNO ?? 0)) {
        elementTable.gDNDETAILS?.forEach((element) {
          var listItemsDesign = [];
          List<ITEMDETAILS> iTEMDETAILSTemp = [];
          element.iTEMDETAILS?.forEach((itemelement) {
            var listtemp = listItemsDesign.where((elementdetails) =>
                itemelement.dESIGN == elementdetails.dESIGN &&
                itemelement.sHADE == elementdetails.sHADE);
            if (listtemp.isEmpty) {
              var list = element.iTEMDETAILS?.where((elementdetails) =>
                  itemelement.dESIGN == elementdetails.dESIGN &&
                  itemelement.sHADE == elementdetails.sHADE);
              var cuts = "";
              var countMTRS = 0.00;
              var countPCS = 0.00;
              var i = 0;
              list?.forEach((element) {
                cuts = "$cuts${element.cUTS}";
                if ((i % 7 == 0) && (i != 0)) {
                  cuts =
                      "$cuts&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
                } else {
                  cuts =
                      "$cuts&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                }
                countPCS += element.pCS ?? 0.0;
                countMTRS += element.mTRS ?? 0.0;
                i++;
              });
              listItemsDesign.add(itemelement);
              iTEMDETAILSTemp.add(ITEMDETAILS(
                  dESIGN: itemelement.dESIGN,
                  sHADE: itemelement.sHADE,
                  pCS: countPCS,
                  cUTSTEMP: cuts,
                  cUTS: 0.0,
                  mTRS: countMTRS,
                  rATE: itemelement.rATE,
                  bARCODE: itemelement.bARCODE));
            }
          });
          element.iTEMDETAILS = iTEMDETAILSTemp;
        });
        tablevalue.add(elementTable);
      }
    });
    var temp = mainGDN.table
        ?.where((mainElement) => (mainElement.isSelected ?? false) == true);
    PDFChallanGenetarionRequest pdfGenetarionRequest = PDFChallanGenetarionRequest(
        dataList: tablevalue,
        mainCompany: MainCompany(
            companyAddress:
                "${AppController.shared.selectedCompany?.add1}\n${AppController.shared.selectedCompany?.add2}",
            companyName: AppController.shared.selectedCompany?.cmpname ?? "",
            GSTNO: AppController.shared.selectedCompany?.gSTIN,
            State: AppController.shared.selectedCompany?.sTATENAME,
            StateBenchMark: AppController.shared.selectedCompany?.sTATEREMARK));

    var data = await ApiUtility.shared
        .generateChallanPDF(pdfGenetarionRequest.toJson());

    if (data.success == true) {
  try {
    final pdfUrl = data.requirementQuotation ?? "";
    if (pdfUrl.isEmpty) {
      Utility.showErrorView("Alert!", "PDF URL is empty.");
      return;
    }

    final response = await http.get(Uri.parse(pdfUrl));
    if (response.statusCode == 200) {
      final tempDir = await getTemporaryDirectory();

      // make filename safe
      final fileName = 'Challan_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${tempDir.path}/$fileName');

      await file.writeAsBytes(response.bodyBytes);

      if (!await file.exists()) {
        Utility.showErrorView("Alert!", "Failed to save PDF.");
        return;
      }

      // Use shared helper which handles iOS popover origin and fallbacks
      await ShareHelper.shareFilesUniversal([XFile(file.path)]);

    } else {
      debugPrint('Failed to download PDF. Status: ${response.statusCode}');
      Utility.showErrorView("Alert!", "Failed to download PDF.");
    }
  } catch (e, st) {
    debugPrint('Exception while downloading/sharing PDF: $e\n$st');
    Utility.showErrorView("Alert!", "Something went wrong while sharing.");
  }
} else {
  Utility.showErrorView("Alert!", "Failed to share...");
}

  }
}
