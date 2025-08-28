import 'dart:io';

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

class OutStandingDetailController extends GetxController {
  var partyDetailResponse = OutstandingDetailResModel().obs;
  PlutoGridStateManager? stateManager;
  var ledger = TableLedger();
  var isRec = true;
  var isApiLoading = false.obs;
  var selectedDate = "".obs;
  static const platform = MethodChannel("com.textrade.android/helper");
  var isLedger = false;
  LedgerMainRequest ledgerMainRequest = LedgerMainRequest();

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
      title: 'Type',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Type',
      width: 120,
      applyFormatterInEditing: false,
      enableSorting: false,
      enableRowChecked: false,
      enableSetColumnsMenuItem: false,
      enableRowDrag: false,
      enableContextMenu: false,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Bill NO',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'BillNO',
      width: 130,
      applyFormatterInEditing: false,
      enableSorting: false,
      enableRowChecked: false,
      enableSetColumnsMenuItem: false,
      enableRowDrag: false,
      enableContextMenu: false,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      width: 140,
      title: 'Agent',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Agent',
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
        title: 'Bill Amt',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: 'BillAmt',
        applyFormatterInEditing: false,
        enableSorting: false,
        enableRowChecked: false,
        enableSetColumnsMenuItem: false,
        enableRowDrag: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        width: 110),
    PlutoColumn(
        title: 'Recd Amt',
        textAlign: PlutoColumnTextAlign.right,
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: 'RecdAmt',
        applyFormatterInEditing: false,
        enableSorting: false,
        enableRowChecked: false,
        enableSetColumnsMenuItem: false,
        enableRowDrag: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        width: 120),
    PlutoColumn(
        title: 'Balance',
        textAlign: PlutoColumnTextAlign.right,
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: 'Balance',
        applyFormatterInEditing: false,
        enableSorting: false,
        enableRowChecked: false,
        enableSetColumnsMenuItem: false,
        enableRowDrag: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        width: 120),
    PlutoColumn(
        title: 'Days',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: 'Days',
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
    ledger = Get.arguments[0];
    isRec = Get.arguments[1];
    isLedger = Get.arguments[2];
    ledgerMainRequest = Get.arguments[3];
    super.onInit();
  }

  @override
  void onReady() {
    final OutstandingController partyController =
        Get.find<OutstandingController>();
    partyController.isDateChangedFromDetailScreen = false;
    selectedDate.value =
        "${AppController.shared.selectedItemDetailParty!.text} to ${AppController.shared.selectedItemDetailParty!.text1}";
    getpartyDetails(
      Utility.convertDateFormate(
          AppController.shared.selectedItemDetailParty!.text ?? ""),
      Utility.convertDateFormate(
          AppController.shared.selectedItemDetailParty!.text1 ?? ""),
    );
    super.onReady();
  }

  void getpartyDetails(String fromDate, String toDate) async {
    Utility.showLoader(title: "Fetching Details...");
    isApiLoading.value = true;
    String? yearId = AppController.shared.selectedMainDate?.value;
    if (isLedger) {
      columns[3] = PlutoColumn(
        width: 140,
        title: 'Agent',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: 'Agent',
        applyFormatterInEditing: false,
        enableSorting: false,
        enableRowChecked: false,
        enableSetColumnsMenuItem: false,
        enableRowDrag: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
      );
    } else {
      columns[3] = PlutoColumn(
        width: 140,
        title: 'Party',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: 'Party',
        applyFormatterInEditing: false,
        enableSorting: false,
        enableRowChecked: false,
        enableSetColumnsMenuItem: false,
        enableRowDrag: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
      );
    }

    // PartyDetailRequestModel partyDetailRequestModel = PartyDetailRequestModel(
    //     name: ledger.lEDGERID.toString(),
    //     fromDate: fromDate,
    //     toDate: toDate,
    //     yearID: yearId);

    if (isRec == true) {
      if (isLedger) {
        LedgerMainRequest ledgerMainRequest1 = LedgerMainRequest(
            name: (ledgerMainRequest.name ?? "") == ""
                ? (ledger.lEDGERID ?? 0).toString()
                : "${ledgerMainRequest.name},${ledger.lEDGERID}",
            agentName: ledgerMainRequest.agentName ?? "",
            yearID: ledgerMainRequest.yearID ?? "",
            fromDate: fromDate,
            toDate: toDate,
            area: ledgerMainRequest.area ?? "",
            city: ledgerMainRequest.city ?? "",
            group: ledgerMainRequest.group ?? "");
        partyDetailResponse.value =
            await ApiUtility.shared.fetchRecOutStanding(ledgerMainRequest1);
      } else {
        LedgerMainRequest ledgerMainRequest1 = LedgerMainRequest(
            name: ledgerMainRequest.name ?? "",
            agentName: (ledgerMainRequest.agentName ?? "") == ""
                ? (ledger.lEDGERID ?? 0).toString()
                : "${ledgerMainRequest.agentName},${ledger.lEDGERID}",
            yearID: ledgerMainRequest.yearID ?? "",
            fromDate: fromDate,
            toDate: toDate,
            area: ledgerMainRequest.area ?? "",
            city: ledgerMainRequest.city ?? "",
            group: ledgerMainRequest.group ?? "");
        partyDetailResponse.value = await ApiUtility.shared
            .fetchAgentRecOutStanding(ledgerMainRequest1);
      }
    } else {
      if (isLedger) {
        LedgerMainRequest ledgerMainRequest1 = LedgerMainRequest(
            name: (ledgerMainRequest.name ?? "") == ""
                ? (ledger.lEDGERID ?? 0).toString()
                : "${ledgerMainRequest.name},${ledger.lEDGERID}",
            agentName: ledgerMainRequest.agentName ?? "",
            yearID: ledgerMainRequest.yearID ?? "",
            fromDate: fromDate,
            toDate: toDate,
            area: ledgerMainRequest.area ?? "",
            city: ledgerMainRequest.city ?? "",
            group: ledgerMainRequest.group ?? "");
        partyDetailResponse.value =
            await ApiUtility.shared.fetchPayOutstanding(ledgerMainRequest1);
      } else {
        LedgerMainRequest ledgerMainRequest1 = LedgerMainRequest(
            name: ledgerMainRequest.name ?? "",
            agentName: (ledgerMainRequest.agentName ?? "") == ""
                ? (ledger.lEDGERID ?? 0).toString()
                : "${ledgerMainRequest.agentName},${ledger.lEDGERID}",
            yearID: ledgerMainRequest.yearID ?? "",
            fromDate: fromDate,
            toDate: toDate,
            area: ledgerMainRequest.area ?? "",
            city: ledgerMainRequest.city ?? "",
            group: ledgerMainRequest.group ?? "");
        partyDetailResponse.value = await ApiUtility.shared
            .fetchAgentPayOutstanding(ledgerMainRequest1);
      }
    }

    isApiLoading.value = false;
    Utility.hideLoader();
  }

  List<PlutoRow> buildRows() {
    isApiLoading.value = true;
    List<PlutoRow> rows = <PlutoRow>[];
    var titles = isLedger ? 'Agent' : 'Party';

    partyDetailResponse.value.table?.forEach((e) {
      var row = PlutoRow(cells: {
        'Date':
            PlutoCell(value: Utility.convertDateFormateDDMMYYYY(e.dATE ?? "")),
        'Type': PlutoCell(value: e.tYPE),
        'BillNO': PlutoCell(value: e.bILLINITIALS),
        titles: PlutoCell(value: isLedger ? e.aGENT : e.nAME),
        'BillAmt': PlutoCell(value: e.bILLAMT),
        'RecdAmt': PlutoCell(value: e.rECDAMT),
        'Balance': PlutoCell(value: e.bALANCE),
        'Days': PlutoCell(value: e.dAYS),
      });
      rows.add(row);
    });

    partyDetailResponse.value.table1?.forEach((e) {
      var row = PlutoRow(cells: {
        'Date': PlutoCell(value: "TOTAL"),
        'Type': PlutoCell(value: ""),
        'BillNO': PlutoCell(value: ""),
        titles: PlutoCell(value: ""),
        'BillAmt': PlutoCell(value: e.TOTALBILLAMT ?? ""),
        'RecdAmt': PlutoCell(value: e.TOTALRECDAMT ?? ""),
        'Balance': PlutoCell(value: e.TOTALBALANCE ?? ""),
        'Days': PlutoCell(value: ""),
      });
      rows.add(row);
    });

    isApiLoading.value = false;
    isApiLoading.refresh();
    if (rows.isNotEmpty) {
      rows.last.setChecked(true);
    }
    return rows;
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
      var startDateStr = Utility.dateTimeToString(result.start, "yyyy-MM-dd");
      var endDateStr = Utility.dateTimeToString(result.end, "yyyy-MM-dd");
      var values = selectedYear?.value ?? "";
      selectedDate.value = "${startDateStr} to ${endDateStr}";
      // Year tempYear =
      //     Year(text: startDateStr, text1: endDateStr, value: values);
      // AppController.shared.selectedItemDetailParty = tempYear;
      final OutstandingController partyController =
          Get.find<OutstandingController>();
      partyController.isDateChangedFromDetailScreen = true;

      getpartyDetails(startDateStr, endDateStr);
    }
  }

  void getGeneratedPdfLink() async {
    List<OutTable> tableToForm = [];
    for (var e in partyDetailResponse.value.table ?? []) {
      tableToForm.add(
        OutTable(
            dATE: Utility.convertDateFormateDDMMYYYY(e.dATE ?? ""),
            tYPE: e.tYPE,
            bILLINITIALS: e.bILLINITIALS,
            aGENT: isLedger ? e.aGENT : e.nAME,
            bILLAMT: e.bILLAMT,
            rECDAMT: e.rECDAMT,
            bALANCE: e.bALANCE,
            dAYS: e.dAYS),
      );
    }
    var companyName = AppController.shared.selectedCompany?.cmpname ?? "";
    PDFGenetarionRequest pdfGenetarionRequest = PDFGenetarionRequest(
        bank: AppController.shared.selectedCompany?.bank,
        account: AppController.shared.selectedCompany?.account,
        ifsc: AppController.shared.selectedCompany?.ifsc,
        upi: AppController.shared.selectedCompany?.upi,
        partyName: ledger.nAME ?? "",
        date: selectedDate.value,
        pdfTable: tableToForm,
        pdfTable1: partyDetailResponse.value.table1,
        companyName: companyName,
        companyAddress:
            "${AppController.shared.selectedCompany?.add1}\n${AppController.shared.selectedCompany?.add2}",
        titles: isLedger
            ? [
                "Date",
                "Type",
                "Bill No",
                "Agent",
                "Bill Amt",
                "Recd Amt",
                "Balance",
                "Days"
              ]
            : [
                "Date",
                "Type",
                "Bill No",
                "Party",
                "Bill Amt",
                "Recd Amt",
                "Balance",
                "Days"
              ]);

    var data =
        await ApiUtility.shared.generatePDF(pdfGenetarionRequest.toJson());
    if (data.success == true) {
      final response =
          await http.get(Uri.parse(data.requirementQuotation ?? ""));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/${ledger.nAME}.pdf');
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
