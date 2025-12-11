import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:share_plus/share_plus.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/DateSelectionScreen/DateSelectionListResponseModel.dart';
import 'package:textrade/Parties/Models/LedgerMainResponseModel.dart';
import 'package:textrade/Parties/party_controller/PartyController.dart';
import 'package:textrade/PartyDetail/PartyDetailRequestModel.dart';
import 'package:textrade/PartyDetail/PartyResponseModel.dart';
import 'package:textrade/Common/ShareHelper.dart';
import 'package:share_plus/share_plus.dart'; // already present but keep it
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


class PartyDetailController extends GetxController {
  var partyDetailResponse = PartyResponseModel().obs;
  PlutoGridStateManager? stateManager;
  var ledger = TableLedger();
  var isApiLoading = false.obs;
  var selectedDate = "".obs;
  static const platform = MethodChannel("com.textrade.android/helper");

  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Date',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Date',
      width: 110,
      applyFormatterInEditing: false,
      enableSorting: false,
      enableRowChecked: false,
      enableSetColumnsMenuItem: false,
      enableRowDrag: false,
      enableContextMenu: false,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'ACCTYPE',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'ACCTYPE',
      width: 100,
      applyFormatterInEditing: false,
      enableSorting: false,
      enableRowChecked: false,
      enableSetColumnsMenuItem: false,
      enableRowDrag: false,
      enableContextMenu: false,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'BILLNO',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'BILLNO',
      width: 90,
      applyFormatterInEditing: false,
      enableSorting: false,
      enableRowChecked: false,
      enableSetColumnsMenuItem: false,
      enableRowDrag: false,
      enableContextMenu: false,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      width: 120,
      title: 'DESC',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'DESC',
      applyFormatterInEditing: false,
      enableSorting: false,
      enableRowChecked: false,
      enableSetColumnsMenuItem: false,
      enableRowDrag: false,
      enableContextMenu: false,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
        title: 'AMT',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: 'AMT',
        applyFormatterInEditing: false,
        enableSorting: false,
        enableRowChecked: false,
        enableSetColumnsMenuItem: false,
        enableRowDrag: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        width: 110),
    PlutoColumn(
        title: 'DRCR',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: 'DRCR',
        applyFormatterInEditing: false,
        enableSorting: false,
        enableRowChecked: false,
        enableSetColumnsMenuItem: false,
        enableRowDrag: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        width: 70)
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    ledger = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    final PartyController partyController = Get.find<PartyController>();
    partyController.isDateChangedFromDetailScreen = false;
    selectedDate.value =
        "${AppController.shared.selectedItemDetailParty!.text} to ${AppController.shared.selectedItemDetailParty!.text1}";
    getpartyDetails();
    super.onReady();
  }

  void getpartyDetails() async {
    Utility.showLoader(title: "Fetching Details...");
    isApiLoading.value = true;
    String? yearId = AppController.shared.selectedMainDate?.value;

    PartyDetailRequestModel partyDetailRequestModel = PartyDetailRequestModel(
        name: ledger.lEDGERID.toString(),
        fromDate: Utility.convertDateFormate(
            AppController.shared.selectedItemDetailParty!.text ?? ""),
        toDate: Utility.convertDateFormate(
            AppController.shared.selectedItemDetailParty!.text1 ?? ""),
        yearID: yearId);
    partyDetailResponse.value =
        await ApiUtility.shared.fetchPartyDetail(partyDetailRequestModel);
    isApiLoading.value = false;
    Utility.hideLoader();
  }

  List<PlutoRow> buildRows() {
    isApiLoading.value = true;
    List<PlutoRow> rows = <PlutoRow>[];
    partyDetailResponse.value.table1?.forEach((e) {
      var row = PlutoRow(cells: {
        'Date':
            PlutoCell(value: Utility.convertDateFormateDDMMYYYY(e.dATE ?? "")),
        'ACCTYPE': PlutoCell(value: e.aCCTYPE),
        'BILLNO': PlutoCell(value: e.bILLNO),
        'DESC': PlutoCell(value: e.dESC),
        'AMT': PlutoCell(value: e.aMT),
        'DRCR': PlutoCell(value: e.dRCR),
      });
      rows.add(row);
    });

    isApiLoading.value = false;
    isApiLoading.refresh();
    rows.first.setChecked(true);
    rows.last.setChecked(true);
    return rows;
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
      AppController.shared.selectedItemDetailParty = tempYear;
      final PartyController partyController = Get.find<PartyController>();
      partyController.isDateChangedFromDetailScreen = true;

      getpartyDetails();
    }
  }

Future<void> getGeneratedPdfLink() async {
  Utility.showLoader(title: "Please Wait...");
  try {
    // 1) Try native generation (Android) — keep this for Android clients that rely on native method
    String? nativeFilePath;
    try {
      // build data same as you did earlier
      var companyDetails = AppController.shared.selectedCompany;
      var data = {
        "pdf_data": jsonEncode(partyDetailResponse.value),
        "company_detail": jsonEncode(companyDetails?.toJson()),
        "party_name": ledger.nAME ?? "",
        "pdf_date": selectedDate.value.replaceAll('to', '-'),
      };

      // attempt call (may throw on iOS if native iOS method not implemented)
      final result =
          await platform.invokeMethod<String>("getGeneratedLedgerPdfLocation", data);

      if (result != null && result.isNotEmpty) {
        nativeFilePath = result;
      }
    } catch (e) {
      // native call failed / not implemented — we'll fallback to server below
      debugPrint('Native method failed or not available: $e');
      nativeFilePath = null;
    }

    // 2) If native gave us a file path, use it; otherwise fallback to server generation
    if (nativeFilePath != null && nativeFilePath.isNotEmpty) {
      final file = File(nativeFilePath);
      if (await file.exists()) {
        await ShareHelper.shareFilesUniversal([XFile(file.path)]);
        return;
      } else {
        debugPrint('Native file path returned but file not found: $nativeFilePath');
        // fallthrough to server generation
      }
    }

    // 3) Server-side fallback: prepare a request similar to other controllers
    // Build a simple table representation from partyDetailResponse (server expects 'table' JSON)
    // We will reuse PDFGenetarionRequest model and map PartyResponseModel rows into generic OutTable-like entries.
    List<Map<String, dynamic>> tableForServer = [];
    for (var r in partyDetailResponse.value.table1 ?? []) {
      tableForServer.add({
        "DATE": r.dATE ?? "",
        "TYPE": r.aCCTYPE ?? "",
        "BILLINITIALS": r.bILLNO ?? "",
        "AGENT": r.dESC ?? "",
        "BILLAMT": 0,
        "RECDAMT": r.aMT ?? 0,
        "BALANCE": 0,
        "DAYS": 0
      });
    }

    final companyName = AppController.shared.selectedCompany?.cmpname ?? "";
    // If your backend expects PDFGenetarionRequest structure, use that JSON shape:
    final payload = {
      "Date": selectedDate.value,
      "partyName": ledger.nAME ?? "",
      "companyName": companyName,
      "companyAddress":
          "${AppController.shared.selectedCompany?.add1}\n${AppController.shared.selectedCompany?.add2}",
      "bank": AppController.shared.selectedCompany?.bank ?? "",
      "account": AppController.shared.selectedCompany?.account ?? "",
      "ifsc": AppController.shared.selectedCompany?.ifsc ?? "",
      "upi": AppController.shared.selectedCompany?.upi ?? "",
      "table": tableForServer,
      "table1": [], // if you need totals, push them here
      "titles": [
        "Date",
        "AccType",
        "Bill No",
        "Desc",
        "Bill Amt",
        "Recd Amt",
        "Balance",
        "Days"
      ]
    };

    // call server generate PDF (adjust to your ApiUtility method if different)
    final data = await ApiUtility.shared.generatePDF(payload);

    if (data.success == true) {
      final pdfUrl = data.requirementQuotation ?? "";
      if (pdfUrl.isEmpty) {
        Utility.showErrorView("Alert!", "PDF URL is empty.");
        return;
      }

      final response = await http.get(Uri.parse(pdfUrl));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final safeName = 'Ledger_${ledger.nAME ?? "party"}.pdf'
            .replaceAll(RegExp(r'[\\/:\*\?"<>\|]'), '_');
        final file = File('${tempDir.path}/$safeName');
        await file.writeAsBytes(response.bodyBytes);

        if (!await file.exists()) {
          Utility.showErrorView("Alert!", "Failed to save PDF.");
          return;
        }

        await ShareHelper.shareFilesUniversal([XFile(file.path)]);
      } else {
        debugPrint('Failed to download PDF. Status: ${response.statusCode}');
        Utility.showErrorView("Alert!", "Failed to download PDF.");
      }
    } else {
      Utility.showErrorView("Alert!", data.message ?? "Failed to generate PDF.");
    }
  } catch (e, st) {
    debugPrint('Exception in getGeneratedPdfLink: $e\n$st');
    Utility.showErrorView("Alert!", "Something went wrong while sharing.");
  } finally {
    Utility.hideLoader();
  }
}

}

class CustomToolTip extends StatelessWidget {
  final String? msg;
  final Color? color;
  CustomToolTip({Key? key, this.msg, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: false,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 20, right: 20),
      message: msg,
      triggerMode: TooltipTriggerMode.tap,
    );
  }
}
