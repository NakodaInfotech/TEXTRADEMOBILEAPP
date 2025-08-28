import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Items/ItemsController.dart';
import 'package:textrade/Outstanding/PDFGenerationReq.dart';
import 'package:textrade/Parties/Models/FilterLedgerRequest.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:path_provider/path_provider.dart';
import 'package:textrade/SalePurchaseOrder/PurchaseOrderListModel.dart';
import 'package:textrade/SalesForm/model/searchModel.dart';

import '../Common/Utilies.dart';

class PurchaseOrderListController extends GetxController {
  var fromTextController = TextEditingController();
  var toTextController = TextEditingController();

  var challanGDNModel = PurchaseOrderListModel().obs;

  var isPurchaseOrder = false.obs;

  var selectedDate = "".obs;

  var selectedName = "";
  var selectedAgent = "";
  var selectedReg = "Purchase REGISTER";

  @override
  void onReady() {
    selectedDate.value =
        "${AppController.shared.selectedDate!.text} to ${AppController.shared.selectedDate!.text1}";
    getChallanList();
    super.onReady();
  }

  getChallanList() async {
    Utility.showLoader(title: "Loading");
    challanGDNModel.value = await ApiUtility.shared.getPurchaseOrderList(
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

  selectOrDeselectChallan(PurchaseOrderListTable? table) {
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
      challanGDNModel.value = await ApiUtility.shared.getPurchaseOrderList(
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
    var cats = [
      Categories("Name", true),
      Categories("Agent", false),
    ];
    Utility.showLoader(title: "Loading");

    var yearId = AppController.shared.selectedDate?.value;
    final FilterPartiesRequest filterLedgerRequest =
        FilterPartiesRequest(yearID: yearId);
    var ledgerArr =
        await ApiUtility.shared.fetchLedgerDetails(filterLedgerRequest);

    var agentArr =
        await ApiUtility.shared.fetchAgentDetails(filterLedgerRequest);

    var regArr =
        await ApiUtility.shared.fetchRegNameDetails(filterLedgerRequest);

    var ledgerSearchArr = <SearchGenericModel>[];
    var agentSearchArr = <SearchGenericModel>[];
    var regSearchArr = <SearchGenericModel>[];

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
    if (regArr.register != null) {
      for (var element in regArr.register ?? []) {
        regSearchArr.add(SearchGenericModel(element.text, element.value));
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
    PDFPurchaseOrderGenetarionRequest pdfGenetarionRequest =
        PDFPurchaseOrderGenetarionRequest(
            dataList: challanGDNModel.value.table
                ?.where(
                    (mainElement) => (mainElement.isSelected ?? false) == true)
                .toList(),
            mainCompany: MainCompany(
                panno: AppController.shared.selectedCompany?.bank,
                msme: AppController.shared.selectedCompany?.mSME,
                bank: AppController.shared.selectedCompany?.bank,
                account: AppController.shared.selectedCompany?.account,
                ifsc: AppController.shared.selectedCompany?.ifsc,
                upi: AppController.shared.selectedCompany?.upi,
                companyAddress:
                    "${AppController.shared.selectedCompany?.add1}\n${AppController.shared.selectedCompany?.add2}",
                companyName:
                    AppController.shared.selectedCompany?.cmpname ?? "",
                GSTNO: AppController.shared.selectedCompany?.gSTIN,
                State: AppController.shared.selectedCompany?.sTATENAME,
                StateBenchMark:
                    AppController.shared.selectedCompany?.sTATEREMARK));

    var data = await ApiUtility.shared
        .generatePurchaseOrderPDF(pdfGenetarionRequest.toJson());

    if (data.success == true) {
      final response =
          await http.get(Uri.parse(data.requirementQuotation ?? ""));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/Purchase Order.pdf');
        await file.writeAsBytes(response.bodyBytes);

        // Share the PDF file
        await Share.shareXFiles([XFile(file.path)], text: '');
      } else {
        print('Failed to download PDF');
      }
    } else {
      Utility.showErrorView("Alert!", "Failed to share...");
    }
  }
}
