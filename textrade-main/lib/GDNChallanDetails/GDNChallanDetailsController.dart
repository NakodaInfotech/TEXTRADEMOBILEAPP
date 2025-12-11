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
import 'package:textrade/Common/ShareHelper.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart'; // XFile (share_plus exports it too)

import 'package:flutter/rendering.dart';
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

  Future<void> getGeneratedPdfLink() async {
  // deep copy as before...
  var mainGDN = ChallanTableList();
  if (listOfGDN.value.gDNDETAILS != null) {
    mainGDN = ChallanTableList.fromJson(jsonDecode(jsonEncode(listOfGDN.value)));
  }

  // your aggregation code unchanged...
  PDFChallanGenetarionRequest pdfGenetarionRequest = PDFChallanGenetarionRequest(
    dataList: [mainGDN],
    mainCompany: MainCompany(
      companyAddress:
          "${AppController.shared.selectedCompany?.add1}\n${AppController.shared.selectedCompany?.add2}",
      companyName: AppController.shared.selectedCompany?.cmpname ?? "",
      GSTNO: AppController.shared.selectedCompany?.gSTIN,
      State: AppController.shared.selectedCompany?.sTATENAME,
      StateBenchMark: AppController.shared.selectedCompany?.sTATEREMARK,
    ),
  );

  var data = await ApiUtility.shared.generateChallanPDF(pdfGenetarionRequest.toJson());
  if (data.success != true) {
    Utility.showErrorView("Alert!", "Failed to generate PDF on server.");
    return;
  }

  final pdfUrlString = data.requirementQuotation ?? "";
  if (pdfUrlString.isEmpty) {
    Utility.showErrorView("Alert!", "PDF URL is empty.");
    return;
  }

  // --- Parse pdfUrlString robustly ---
  List<String> pdfUrls = [];
  try {
    final parsed = jsonDecode(pdfUrlString);
    if (parsed is List) {
      pdfUrls = parsed.map((e) => e.toString()).toList();
    } else if (parsed is String) {
      // single URL string
      pdfUrls = [parsed];
    }
  } catch (_) {
    // fallback: maybe comma-separated or single url
    pdfUrls = pdfUrlString.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
  }

  debugPrint('Final pdfUrls list length: ${pdfUrls.length}');
  for (var u in pdfUrls) debugPrint('URL -> $u');

  final tempDir = await getTemporaryDirectory();
  final List<XFile> xfiles = [];

  for (var i = 0; i < pdfUrls.length; i++) {
    final url = pdfUrls[i];
    if (url.isEmpty) continue;

    try {
      final resp = await http.get(Uri.parse(url));
      debugPrint('Downloading [$i] ${url} => ${resp.statusCode}');
      if (resp.statusCode == 200) {
        final fileName = 'Challan_${DateTime.now().millisecondsSinceEpoch}_$i.pdf';
        final file = File('${tempDir.path}/$fileName');
        await file.writeAsBytes(resp.bodyBytes);

        final exists = await file.exists();
        final length = exists ? await file.length() : 0;
        debugPrint('Saved [$i]: path=${file.path}, exists=$exists, size=$length');

        if (exists && length > 0) {
          // include mimeType explicitly (helps some iOS targets)
          xfiles.add(XFile(file.path, name: fileName)); // you can add mimeType param if supported in current cross_file
        }
      } else {
        debugPrint('Skipping [$i] due to status ${resp.statusCode}');
      }
    } catch (e, st) {
      debugPrint('Exception downloading [$i]: $e\n$st');
    }
  }

  debugPrint('Prepared XFiles count: ${xfiles.length}');
  if (xfiles.isEmpty) {
    Utility.showErrorView("Alert!", "No PDF files available to share.");
    return;
  }

  // Try direct share (bypass helper) for diagnosing
  try {
    await Share.shareXFiles(
      xfiles,
      text: 'Please find the challan PDF(s) attached.',
    );
  } catch (e) {
    debugPrint('Direct Share.shareXFiles failed: $e');
    // fallback to your helper which handles origin
    try {
      await ShareHelper.shareFilesUniversal(xfiles, text: 'Please find the challan PDF(s) attached.');
    } catch (e2) {
      debugPrint('ShareHelper fallback also failed: $e2');
      Utility.showErrorView('Alert!', 'Sharing failed.');
    }
  }
}

}
