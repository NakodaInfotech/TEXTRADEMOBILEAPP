import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:share_plus/share_plus.dart';
import 'package:textrade/Challan/ChallanGDNModel.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
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

import '../Common/Utilies.dart';

class GDNChallanDetailsController extends GetxController {
  PlutoGridStateManager? stateManager;

  var listOfGDN = ChallanTableList().obs;
  var isApiLoading = false.obs;
  var rows = <PlutoRow>[].obs;

  @override
  void onReady() {
    listOfGDN.value = Get.arguments?[0] ?? "";
    buildRows();
    super.onReady();
  }

  final List<PlutoColumn> columns = <PlutoColumn>[
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
      title: 'Width',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Width',
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
      title: 'HSN',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'HSN',
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
      title: 'Design No',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Design No',
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
      title: 'Shade',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Shade',
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
        title: 'Pcs',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: 'Pcs',
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
        title: 'Mtrs',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: 'Mtrs',
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
        title: 'Rate',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: 'Rate',
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
        title: 'Barcode',
        enableDropToResize: false,
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableHideColumnMenuItem: false,
        enableFilterMenuItem: false,
        field: 'Barcode',
        applyFormatterInEditing: false,
        enableSorting: false,
        enableRowChecked: false,
        enableSetColumnsMenuItem: false,
        enableRowDrag: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        width: 110),
  ];

  List<PlutoRow> buildRows() {
    isApiLoading.value = true;
    listOfGDN.value.gDNDETAILS?.forEach((element) {
      element.iTEMDETAILS?.forEach((e) {
        var row = PlutoRow(cells: {
          'Item Name': PlutoCell(value: element.iTEMNAME),
          'Width': PlutoCell(value: element.wIDTH),
          'HSN': PlutoCell(value: element.hSN),
          'Design No': PlutoCell(value: e.dESIGN),
          'Shade': PlutoCell(value: e.sHADE),
          'Pcs': PlutoCell(value: e.pCS),
          'Mtrs': PlutoCell(value: e.mTRS),
          'Rate': PlutoCell(value: e.rATE),
          'Barcode': PlutoCell(value: e.bARCODE),
        });
        rows.add(row);
        rows.refresh();
        isApiLoading.value = false;
        isApiLoading.refresh();
      });
    });

    if (rows.isNotEmpty) {
      rows.last.setChecked(true);
    }
    return rows;
  }

  void getGeneratedPdfLink() async {
    // Create a deep copy instead of referencing listOfGDN
    var mainGDN = ChallanTableList();
    if (listOfGDN.value.gDNDETAILS != null) {
      mainGDN =
          ChallanTableList.fromJson(jsonDecode(jsonEncode(listOfGDN.value)));
    }

    List<ITEMDETAILS> iTEMDETAILSTemp = [];
    mainGDN.gDNDETAILS?.forEach((element) {
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
              cuts = "$cuts&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
            } else {
              cuts = "$cuts&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
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

    PDFChallanGenetarionRequest pdfGenetarionRequest = PDFChallanGenetarionRequest(
        dataList: [mainGDN],
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
      final response =
          await http.get(Uri.parse(data.requirementQuotation ?? ""));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/Challan.pdf');
        await file.writeAsBytes(response.bodyBytes);

        // Share the PDF file
        await Share.shareXFiles([XFile(file.path)],
            text: '');
      } else {
        print('Failed to download PDF');
      }
    } else {
      Utility.showErrorView("Alert!", "Failed to share...");
    }
  }
}
