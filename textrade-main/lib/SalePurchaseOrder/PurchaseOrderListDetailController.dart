import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:share_plus/share_plus.dart';
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
import 'package:textrade/SalePurchaseOrder/PurchaseOrderListModel.dart';
import '../Common/Utilies.dart';

class PurchaseOrderListDetailController extends GetxController {
  PlutoGridStateManager? stateManager;

  var listOfGDN = PurchaseOrderListTable().obs;
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
      title: 'Design',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Design',
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
      title: 'Shade',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'Shade',
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
      title: 'MTRS',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'MTRS',
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
    ),
    PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
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
        width: 110),
  ];

  List<PlutoRow> buildRows() {
    isApiLoading.value = true;
    var i = 1;
    listOfGDN.value.pODETAILS?.forEach((element) {
      element.iTEMDETAILS?.forEach((e) {
        var row = PlutoRow(cells: {
          'Sr No': PlutoCell(value: i),
          'Item Name': PlutoCell(value: element.iTEMNAME),
          'Design': PlutoCell(value: e.dESIGN),
          'Shade': PlutoCell(value: e.cOLOR),
          'MTRS': PlutoCell(value: e.mTRS),
          'Rate': PlutoCell(value: e.rATE),
          'Amount': PlutoCell(value: e.aMOUNT),
        });
        rows.add(row);
        rows.refresh();
        isApiLoading.value = false;
        isApiLoading.refresh();
        i += 1;
      });
    });

    if (rows.isNotEmpty) {
      rows.last.setChecked(true);
    }
    return rows;
  }

  void getGeneratedPdfLink() async {
    // Create a deep copy instead of referencing listOfGDN
    PDFPurchaseOrderGenetarionRequest pdfGenetarionRequest =
        PDFPurchaseOrderGenetarionRequest(
            dataList: [listOfGDN.value],
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
