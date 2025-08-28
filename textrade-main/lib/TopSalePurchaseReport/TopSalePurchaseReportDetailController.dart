import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:share_plus/share_plus.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Items/ItemsController.dart';
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
import 'package:textrade/Parties/Models/FilterLedgerRequest.dart';
import 'package:textrade/Parties/Models/LedgerMainRequestModel.dart';
import 'package:textrade/Parties/Models/LedgerMainResponseModel.dart';
import 'package:textrade/SalesForm/model/searchModel.dart';
import 'package:textrade/TopSalePurchaseReport/TopSalePurchaseModel.dart';
import '../Common/Utilies.dart';

class TopSalePurchaseReportDetailController extends GetxController {
  PlutoGridStateManager? stateManager;

  var listOfGDN = TopSalePurchaseModel().obs;
  var isApiLoading = true.obs;
  var rows = <PlutoRow>[].obs;
  var isPuchase = false.obs;

  var selectedtype = "";
  var selecteditemName = "";
  var selectedDate = "".obs;
  var selectedName = "";
  var selectedAgent = "";
  var selectedCity = "";

  List<PlutoColumn> columns = <PlutoColumn>[];

  @override
  void onReady() {
    isPuchase.value = Get.arguments?[0] ?? false;
    selectedtype = Get.arguments?[1] ?? "";
    selectedtype = selectedtype.toUpperCase();

    if (selectedtype == "PARTYWISE") {
      columns = columnsParty;
    } else if (selectedtype == "AGENTWISE") {
      columns = columnsAgent;
    } else if (selectedtype == "ITEMWISE") {
      columns = columnsItem;
    }
    selectedDate.value =
        "${AppController.shared.selectedDate!.text} to ${AppController.shared.selectedDate!.text1}";
    selecteditemName = "";
    selectedName = "";
    selectedAgent = "";
    selectedCity = "";

    // isApiLoading.value = false;
    isApiLoading.refresh();
    getChallanList();
    super.onReady();
  }

  getChallanList() async {
    Utility.showLoader(title: "Loading");
    if (isPuchase.value == true) {
      listOfGDN.value = await ApiUtility.shared.getTopPuchases(
          selectedtype,
          selecteditemName,
          selectedName,
          selectedAgent,
          selectedCity,
          Utility.convertDateFormate(
              AppController.shared.selectedDate!.text ?? ""),
          Utility.convertDateFormate(
              AppController.shared.selectedDate!.text1 ?? ""));
    } else {
      listOfGDN.value = await ApiUtility.shared.getTopSales(
          selectedtype,
          selecteditemName,
          selectedName,
          selectedAgent,
          selectedCity,
          Utility.convertDateFormate(
              AppController.shared.selectedDate!.text ?? ""),
          Utility.convertDateFormate(
              AppController.shared.selectedDate!.text1 ?? ""));
    }
    Utility.hideLoader();
    buildRows();
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
      if (isPuchase.value == true) {
        listOfGDN.value = await ApiUtility.shared.getTopPuchases(
            selectedtype,
            selecteditemName,
            selectedName,
            selectedAgent,
            selectedCity,
            startDateStr,
            endDateStr);
      } else {
        listOfGDN.value = await ApiUtility.shared.getTopSales(
            selectedtype,
            selecteditemName,
            selectedName,
            selectedAgent,
            selectedCity,
            startDateStr,
            endDateStr);
      }
      Utility.hideLoader();
    }
  }

  final List<PlutoColumn> columnsParty = <PlutoColumn>[
    PlutoColumn(
      title: 'Sr No',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Sr No',
      width: 60,
      applyFormatterInEditing: false,
      enableSorting: false,
      enableRowChecked: false,
      enableSetColumnsMenuItem: false,
      enableRowDrag: false,
      enableContextMenu: false,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Party Name',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Party Name',
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
      title: 'City',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'City',
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
      title: 'Total MTRS',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Total MTRS',
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
      title: 'Taxable Amount',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Taxable Amount',
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
        title: 'Grand Total',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: 'Grand Total',
        applyFormatterInEditing: false,
        enableSorting: false,
        enableRowChecked: false,
        enableSetColumnsMenuItem: false,
        enableRowDrag: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        width: 110),
    PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
        title: '%',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: '%',
        applyFormatterInEditing: false,
        enableSorting: false,
        enableRowChecked: false,
        enableSetColumnsMenuItem: false,
        enableRowDrag: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        width: 110)
  ];

  final List<PlutoColumn> columnsAgent = <PlutoColumn>[
    PlutoColumn(
      title: 'Sr No',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Sr No',
      width: 60,
      applyFormatterInEditing: false,
      enableSorting: false,
      enableRowChecked: false,
      enableSetColumnsMenuItem: false,
      enableRowDrag: false,
      enableContextMenu: false,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Agent Name',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Agent Name',
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
      title: 'City',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'City',
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
      title: 'Total MTRS',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Total MTRS',
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
      title: 'Taxable Amount',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Taxable Amount',
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
        title: 'Grand Total',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: 'Grand Total',
        applyFormatterInEditing: false,
        enableSorting: false,
        enableRowChecked: false,
        enableSetColumnsMenuItem: false,
        enableRowDrag: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        width: 110),
    PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
        title: '%',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: '%',
        applyFormatterInEditing: false,
        enableSorting: false,
        enableRowChecked: false,
        enableSetColumnsMenuItem: false,
        enableRowDrag: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        width: 110)
  ];

  final List<PlutoColumn> columnsItem = <PlutoColumn>[
    PlutoColumn(
      title: 'Sr No',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Sr No',
      width: 60,
      applyFormatterInEditing: false,
      enableSorting: false,
      enableRowChecked: false,
      enableSetColumnsMenuItem: false,
      enableRowDrag: false,
      enableContextMenu: false,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Item Name',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Item Name',
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
      title: 'Total Qty',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Total Qty',
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
      title: 'Total MTRS',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Total MTRS',
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
      title: 'Amount',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Amount',
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
        title: 'Avg Rate',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: 'Avg Rate',
        applyFormatterInEditing: false,
        enableSorting: false,
        enableRowChecked: false,
        enableSetColumnsMenuItem: false,
        enableRowDrag: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        width: 110),
    PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
        title: '%',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: '%',
        applyFormatterInEditing: false,
        enableSorting: false,
        enableRowChecked: false,
        enableSetColumnsMenuItem: false,
        enableRowDrag: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        width: 110)
  ];

  List<PlutoRow> buildRows() {
    isApiLoading.value = true;
    var i = 1;
    listOfGDN.value.table?.forEach((element) {
      // element.iTEMDETAILS?.forEach((e) {
      if (selectedtype == "PARTYWISE") {
        var row = PlutoRow(cells: {
          'Sr No': PlutoCell(value: i),
          'Party Name': PlutoCell(value: element.pARTYNAME),
          'City': PlutoCell(value: element.cITY),
          'Total MTRS': PlutoCell(value: element.tOTALMTRS),
          'Taxable Amount': PlutoCell(value: element.tAXABLEAMT),
          'Grand Total': PlutoCell(value: element.gRANDTOTAL),
          '%': PlutoCell(value: element.pERCENTAGE),
        });
        rows.add(row);
        rows.refresh();
      } else if (selectedtype == "AGENTWISE") {
        var row = PlutoRow(cells: {
          'Sr No': PlutoCell(value: i),
          'Agent Name': PlutoCell(value: element.aGENTNAME),
          'City': PlutoCell(value: element.cITY),
          'Total MTRS': PlutoCell(value: element.tOTALMTRS),
          'Taxable Amount': PlutoCell(value: element.tAXABLEAMT),
          'Grand Total': PlutoCell(value: element.gRANDTOTAL),
          '%': PlutoCell(value: element.pERCENTAGE),
        });

        rows.add(row);
        rows.refresh();
      } else {
        var row = PlutoRow(cells: {
          'Sr No': PlutoCell(value: i),
          'Item Name': PlutoCell(value: element.iTEMNAME),
          'Total Qty': PlutoCell(value: element.tOTALQTY),
          'Total MTRS': PlutoCell(value: element.tOTALMTRS),
          'Amount': PlutoCell(value: element.tOTALAMT),
          'Avg Rate': PlutoCell(value: element.aVGRATE),
          '%': PlutoCell(value: element.pERCENTAGE),
        });

        rows.add(row);
        rows.refresh();
      }

      isApiLoading.value = false;
      isApiLoading.refresh();
      i += 1;
      // });
    });

    if (rows.isNotEmpty) {
      rows.last.setChecked(true);
    }
    return rows;
  }

  void openFilter() async {
    var cats = [
      Categories("Name", true),
      Categories("Agent", false),
      Categories("City", false)
    ];
    Utility.showLoader(title: "Loading");

    var yearId = AppController.shared.selectedDate?.value;
    final FilterPartiesRequest filterLedgerRequest =
        FilterPartiesRequest(yearID: yearId);
    var ledgerArr =
        await ApiUtility.shared.fetchLedgerDetails(filterLedgerRequest);

    var agentArr =
        await ApiUtility.shared.fetchAgentDetails(filterLedgerRequest);

    var regArr = await ApiUtility.shared.fetchCityDetails(filterLedgerRequest);

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
    if (regArr.city != null) {
      for (var element in regArr.city ?? []) {
        regSearchArr.add(SearchGenericModel(element.text, element.value));
      }
    }
    var data = [ledgerSearchArr.obs, agentSearchArr.obs, regSearchArr.obs];
    var data1 = [ledgerSearchArr.obs, agentSearchArr.obs, regSearchArr.obs];
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
      selectedCity = (value[2] as List<SearchGenericModel>)
          .map((e) => e.name)
          .toList()
          .join(",");
      selecteditemName = (value[3] as List<SearchGenericModel>)
              .map((e) => e.name)
              .toList()
              .first ??
          "";
      getChallanList();
    });
  }

  void getGeneratedPdfLink() async {
    // Create a deep copy instead of referencing listOfGDN
    num totalMTRS = 0;
    num totalAMT = 0;
    num totalGND = 0;
    List<List<String>> dataListvalue = [];
    if (selectedtype == "PARTYWISE") {
      dataListvalue.add([
        'Party Name',
        'City',
        'Total MTRS',
        'Taxable Amount',
        'Grand Total',
        '%',
      ]);
      listOfGDN.value.table?.forEach((element) {
        dataListvalue.add([
          element.pARTYNAME ?? "",
          element.cITY ?? "",
          "${element.tOTALMTRS ?? 0}",
          "${element.tAXABLEAMT ?? 0}",
          "${element.gRANDTOTAL ?? 0}",
          "${element.pERCENTAGE ?? 0}",
        ]);
        totalMTRS += element.tOTALMTRS ?? 0;
        totalAMT += element.tOTALAMT ?? 0;
        totalGND += element.gRANDTOTAL ?? 0;
      });
      dataListvalue.add([
        '',
        'Grand Total',
        "$totalMTRS",
        "$totalAMT",
        "$totalGND",
        '',
      ]);
    } else if (selectedtype == "AGENTWISE") {
      dataListvalue.add([
        'Agent Name',
        'City',
        'Total MTRS',
        'Taxable Amount',
        'Grand Total',
        '%',
      ]);

      listOfGDN.value.table?.forEach((element) {
        dataListvalue.add([
          element.aGENTNAME ?? "",
          element.cITY ?? "",
          "${element.tOTALMTRS ?? 0}",
          "${element.tAXABLEAMT ?? 0}",
          "${element.gRANDTOTAL ?? 0}",
          "${element.pERCENTAGE ?? 0}",
        ]);
        totalMTRS += element.tOTALMTRS ?? 0;
        totalAMT += element.tOTALAMT ?? 0;
        totalGND += element.gRANDTOTAL ?? 0;
      });
      dataListvalue.add([
        '',
        'Grand Total',
        "$totalMTRS",
        "$totalAMT",
        "$totalGND",
        '',
      ]);
    } else if (selectedtype == "ITEMWISE") {
      dataListvalue.add([
        'Item Name',
        'Total Qty',
        'Total MTRS',
        'Amount',
        'Avg Rate',
        '%',
      ]);

      listOfGDN.value.table?.forEach((element) {
        dataListvalue.add([
          element.iTEMNAME ?? "",
          "${element.tOTALQTY ?? 0}",
          "${element.tOTALMTRS ?? 0}",
          "${element.tOTALAMT ?? 0}",
          "${element.aVGRATE ?? 0}",
          "${element.pERCENTAGE ?? 0}",
        ]);
        totalMTRS += element.tOTALMTRS ?? 0;
        totalAMT += element.tOTALAMT ?? 0;
        totalGND += element.aVGRATE ?? 0;
      });
      dataListvalue.add([
        '',
        'Grand Total',
        "$totalMTRS",
        "$totalAMT",
        "$totalGND",
        '',
      ]);
    }

    PDFTopSalesGenetarionRequest pdfGenetarionRequest =
        PDFTopSalesGenetarionRequest(
            dataList: dataListvalue,
            mainCompany: MainCompany(
                panno: AppController.shared.selectedCompany?.pANNO,
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
                    AppController.shared.selectedCompany?.sTATEREMARK,
                date:
                    "${AppController.shared.selectedDate!.text} - ${AppController.shared.selectedDate!.text1}",
                reportName:
                    "${isPuchase.value ? "Purchase" : "Sale"} Invoice ${selectedtype == "PARTYWISE" ? "Party Wise" : selectedtype == "AGENTWISE" ? "Agent Wise" : "Item Wise"} Details (%)"));

    var data =
        await ApiUtility.shared.generateTopPDF(pdfGenetarionRequest.toJson());

    if (data.success == true) {
      final response =
          await http.get(Uri.parse(data.requirementQuotation ?? ""));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File(
            '${tempDir.path}/${isPuchase.value ? "Purchase" : "Sale"} Report.pdf');
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
