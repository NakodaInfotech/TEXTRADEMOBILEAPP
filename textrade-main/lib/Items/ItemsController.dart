import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Filter/FilterModel/CategoryListModel.dart';
import 'package:textrade/Filter/FilterModel/DesignListModel.dart';
import 'package:textrade/Filter/FilterModel/FilterItemModel.dart';
import 'package:textrade/Filter/FilterModel/PieceTypeListModel.dart';
import 'package:textrade/Filter/FilterModel/QualityListModel.dart';
import 'package:textrade/Filter/FilterModel/ShadeListModel.dart';
import 'package:textrade/Filter/FilterModel/UnitListModel.dart';
import 'package:textrade/Items/StockRequestModel.dart';
import 'package:textrade/Items/StockResponseModel.dart';
import 'package:textrade/Outstanding/PDFGenerationReq.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:textrade/Common/Utilies.dart';

import 'package:textrade/Outstanding/OutstandingDetaisResModel.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:textrade/Common/ShareHelper.dart';

import '../Common/Utilies.dart';
import '../Filter/FilterModel/GoDownListModel.dart';

class Categories {
  String? title;
  bool? isSelected;

  Categories(String title, bool isSelected) {
    this.title = title;
    this.isSelected = isSelected;
  }
}

class ItemsController extends GetxController {
  static const platform = MethodChannel("com.textrade.android/helper");

  var items = StockResponseModel().obs;
  PlutoGridStateManager? stateManager;

  var itemList = ItemListModel().obs;
  var categoryListModel = CategoryListModel().obs;
  var designListModel = DesignListModel().obs;
  var goDownListModel = GoDownListModel().obs;
  var pieceTypeListModel = PieceTypeListModel().obs;
  var unitListModel = UnitListModel().obs;
  var shadeListModel = ShadeListModel().obs;
  var qualityListModel = QualityListModel().obs;
  var isloadingDone = true.obs;

  //
  var searchitemList = <Item>[].obs;
  var searchcategoryListModel = <Category>[].obs;
  var searchdesignListModel = <Design>[].obs;
  var searchgoDownListModel = <Godown>[].obs;
  var searchpieceTypeListModel = <PieceType>[].obs;
  var searchunitListModel = <Unit>[].obs;
  var searchshadeListModel = <Shade>[].obs;
  var searchqualityListModel = <Quality>[].obs;

  //
  var searchTextController = TextEditingController();
  var catArry = [
    Categories("Item Name", true),
    Categories("Quality Name", false),
    Categories("Design No", false),
    Categories("Color", false),
    Categories("Godown", false),
    Categories("Unit", false),
    Categories("Piece Type", false),
    Categories("Category", false)
  ].obs;

  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'ITEMNAME',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'ITEMNAME',
      applyFormatterInEditing: false,
      enableSorting: false,
      enableRowChecked: false,
      enableSetColumnsMenuItem: false,
      enableRowDrag: false,
      enableContextMenu: false,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'DESIGNNO',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'DESIGNNO',
      applyFormatterInEditing: false,
      enableSorting: false,
      enableRowChecked: false,
      enableSetColumnsMenuItem: false,
      enableRowDrag: false,
      enableContextMenu: false,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'COLOR',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'COLOR',
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
      title: 'UNIT',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'UNIT',
      applyFormatterInEditing: false,
      enableSorting: false,
      enableRowChecked: false,
      enableSetColumnsMenuItem: false,
      enableRowDrag: false,
      enableContextMenu: false,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'PCS',
      enableDropToResize: false,
      enableEditingMode: false,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableHideColumnMenuItem: false,
      enableFilterMenuItem: false,
      field: 'PCS',
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
  ];

  List<PlutoRow> rows = <PlutoRow>[];

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady

    getItemsList();
    super.onReady();
  }

  void getItemsList() async {
    isloadingDone.value = false;
    Utility.showLoader(title: "Fetching Data...");
    final StockRequestModel stockRequestModel = StockRequestModel();
    stockRequestModel.yearID = AppController.shared.selectedDate!.value ?? "";
    var res = await ApiUtility.shared.fetchStocks(stockRequestModel);
    Utility.hideLoader();

    if (res != null) {
      items.value = res;
      var itemSize = items.value.table?.length ?? 0;
      for (int i = 0; i < itemSize; i++) {
        var e = items.value.table![i];
        items.value.table![i].id = i;
        var row = PlutoRow(cells: {
          'ITEMNAME': PlutoCell(value: e.iTEMNAME, key: Key(i.toString())),
          'DESIGNNO': PlutoCell(value: e.dESIGNNO, key: Key(i.toString())),
          'COLOR': PlutoCell(value: e.cOLOR, key: Key(i.toString())),
          'UNIT': PlutoCell(value: e.uNIT, key: Key(i.toString())),
          'PCS': PlutoCell(
              value: e.pCS?.toStringAsFixed(2) ?? "0.00",
              key: Key(i.toString())),
          'MTRS': PlutoCell(
              value: e.mTRS?.toStringAsFixed(2) ?? "0.00",
              key: Key(i.toString())),
        });
        rows.add(row);
      }

      var otherItemSize = items.value.table1?.length ?? 0;
      for (int i = 0; i < otherItemSize; i++) {
        var e = items.value.table1![i];
        var row = PlutoRow(cells: {
          'ITEMNAME': PlutoCell(value: "", key: Key(i.toString())),
          'DESIGNNO': PlutoCell(value: "", key: Key(i.toString())),
          'COLOR': PlutoCell(value: "", key: Key(i.toString())),
          'UNIT': PlutoCell(value: "", key: Key(i.toString())),
          'PCS': PlutoCell(value: "Total: ${e.pCS}", key: Key(i.toString())),
          'MTRS': PlutoCell(value: "Total: ${e.mTRS}", key: Key(i.toString())),
        });
        rows.add(row);
      }
      buildRows();
    }

    isloadingDone.value = true;
    getFilterItems();
  }

  List<PlutoRow> buildRows({List<PlutoRow>? rowss}) {
    if (rowss == null) {
      rows.last.setChecked(true);
      return rows;
    }
    rowss.last.setChecked(true);
    return rowss;
  }

  void getFilterItems() async {
    Utility.showLoader(title: "Fetching Data...");
    var items = await ApiUtility.shared.filterFetchItemList();
    if (items != null) {
      itemList.value = items;
      searchitemList.value = itemList.value.item!;
    }

    var categoryList = await ApiUtility.shared.filterFetchCATEGORYList();
    if (categoryList != null) {
      categoryListModel.value = categoryList;
      searchcategoryListModel.value = categoryListModel.value.category!;
    }

    var designList = await ApiUtility.shared.filterFetchDesignList();
    if (designList != null) {
      designListModel.value = designList;
      searchdesignListModel.value = designListModel.value.design!;
    }

    var goDownList = await ApiUtility.shared.filterFetchGODOWNList();
    if (goDownList != null) {
      goDownListModel.value = goDownList;
      searchgoDownListModel.value = goDownListModel.value.godown!;
    }

    var pieceTypeList = await ApiUtility.shared.filterFetchPieceTypeList();
    if (pieceTypeList != null) {
      pieceTypeListModel.value = pieceTypeList;
      searchpieceTypeListModel.value = pieceTypeListModel.value.pieceType!;
    }

    var unitList = await ApiUtility.shared.filterFetchUnitList();
    if (unitList != null) {
      unitListModel.value = unitList;
      searchunitListModel.value = unitListModel.value.unit!;
    }

    var shadeList = await ApiUtility.shared.filterFetchShadeList();
    if (shadeList != null) {
      shadeListModel.value = shadeList;
      searchshadeListModel.value = shadeListModel.value.shade!;
    }

    var qualityList = await ApiUtility.shared.filterFetchQualityList();
    if (qualityList != null) {
      qualityListModel.value = qualityList;
      searchqualityListModel.value = qualityListModel.value.quality!;
    }

    Utility.hideLoader();
  }

  void searchResult(String searchStr) {
    var selectedCategoryIndex =
        catArry.indexWhere((element) => element.isSelected == true);
    switch (selectedCategoryIndex) {
      case 0:
        if (searchStr != "") {
          searchitemList.value = itemList.value.item!
              .where((element) =>
                  element.text!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList();
        } else {
          searchitemList.value = itemList.value.item!;
        }
        searchitemList.refresh();
        break;
      case 1:
        if (searchStr != "") {
          searchqualityListModel.value = qualityListModel.value.quality!
              .where((element) =>
                  element.text!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList();
        } else {
          searchqualityListModel.value = qualityListModel.value.quality!;
        }
        searchqualityListModel.refresh();
        break;
      case 2:
        if (searchStr != "") {
          searchdesignListModel.value = designListModel.value.design!
              .where((element) =>
                  element.text!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList();
        } else {
          searchdesignListModel.value = designListModel.value.design!;
        }
        searchdesignListModel.refresh();
        break;
      case 3:
        if (searchStr != "") {
          searchshadeListModel.value = shadeListModel.value.shade!
              .where((element) =>
                  element.text!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList();
        } else {
          searchshadeListModel.value = shadeListModel.value.shade!;
        }
        searchshadeListModel.refresh();
        break;
      case 4:
        if (searchStr != "") {
          searchgoDownListModel.value = goDownListModel.value.godown!
              .where((element) =>
                  element.text!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList();
        } else {
          searchgoDownListModel.value = goDownListModel.value.godown!;
        }
        searchgoDownListModel.refresh();
        break;

      case 5:
        if (searchStr != "") {
          searchunitListModel.value = unitListModel.value.unit!
              .where((element) =>
                  element.text!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList();
        } else {
          searchunitListModel.value = unitListModel.value.unit!;
        }
        searchunitListModel.refresh();
        break;

      case 6:
        if (searchStr != "") {
          searchpieceTypeListModel.value = pieceTypeListModel.value.pieceType!
              .where((element) =>
                  element.text!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList();
        } else {
          searchpieceTypeListModel.value = pieceTypeListModel.value.pieceType!;
        }
        searchpieceTypeListModel.refresh();
        break;
      case 7:
        if (searchStr != "") {
          searchcategoryListModel.value = categoryListModel.value.category!
              .where((element) =>
                  element.text!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList();
        } else {
          searchcategoryListModel.value = categoryListModel.value.category!;
        }
        searchcategoryListModel.refresh();
        break;
      default:
    }
  }

  void applyFilter() async {
    Get.back();
    //  stateManager?.resetCurrentState(notify: true);
    // stateManager?.resetPage(resetCurrentState: true, notify: true);
    //  stateManager?.removeAllRows(notify: true);
    final String itemName = itemList.value.item!
        .where((p0) => p0.isSelected == true)
        .map((e) => e.value)
        .join(",");
    final String category = categoryListModel.value.category!
        .where((p0) => p0.isSelected == true)
        .map((e) => e.value)
        .join(",");
    final String designListModel1 = designListModel.value.design!
        .where((p0) => p0.isSelected == true)
        .map((e) => e.value)
        .join(",");
    final String piece = pieceTypeListModel.value.pieceType!
        .where((p0) => p0.isSelected == true)
        .map((e) => e.value)
        .join(",");
    final String units = unitListModel.value.unit!
        .where((p0) => p0.isSelected == true)
        .map((e) => e.value)
        .join(",");
    final String shades = shadeListModel.value.shade!
        .where((p0) => p0.isSelected == true)
        .map((e) => e.value)
        .join(",");
    final String quality = qualityListModel.value.quality!
        .where((p0) => p0.isSelected == true)
        .map((e) => e.value)
        .join(",");

    final String godown = goDownListModel.value.godown!
        .where((p0) => p0.isSelected == true)
        .map((e) => e.value)
        .join(",");
    Utility.showLoader(title: "Fetching Data...");
    final StockRequestModel stockRequestModel = StockRequestModel();
    stockRequestModel.itemName = itemName;
    stockRequestModel.designName = designListModel1;
    stockRequestModel.color = shades;
    stockRequestModel.category = category;
    stockRequestModel.godown = godown;
    stockRequestModel.quality = quality;
    stockRequestModel.pieceType = piece;

    stockRequestModel.unit = units;

    stockRequestModel.yearID = AppController.shared.selectedDate!.value ?? "";
    var res = await ApiUtility.shared.fetchStocks(stockRequestModel);
    Utility.hideLoader();
    isloadingDone.value = false;
    int i = 0;
    if (res != null) {
      rows.clear();
      rows = [];
      items.value = res;
      var itemSize = items.value.table?.length ?? 0;
      for (int i = 0; i < itemSize; i++) {
        var e = items.value.table![i];
        items.value.table![i].id = i;
        var row = PlutoRow(cells: {
          'ITEMNAME': PlutoCell(value: e.iTEMNAME, key: Key(i.toString())),
          'DESIGNNO': PlutoCell(value: e.dESIGNNO, key: Key(i.toString())),
          'COLOR': PlutoCell(value: e.cOLOR, key: Key(i.toString())),
          'UNIT': PlutoCell(value: e.uNIT, key: Key(i.toString())),
          'PCS': PlutoCell(
              value: e.pCS?.toStringAsFixed(2) ?? "0.00",
              key: Key(i.toString())),
          'MTRS': PlutoCell(
              value: e.mTRS?.toStringAsFixed(2) ?? "0.00",
              key: Key(i.toString())),
        });
        rows.add(row);
      }

      var otherItemSize = items.value.table1?.length ?? 0;
      for (int i = 0; i < otherItemSize; i++) {
        var e = items.value.table1![i];
        var row = PlutoRow(cells: {
          'ITEMNAME': PlutoCell(value: "", key: Key(i.toString())),
          'DESIGNNO': PlutoCell(value: "", key: Key(i.toString())),
          'COLOR': PlutoCell(value: "", key: Key(i.toString())),
          'UNIT': PlutoCell(value: "", key: Key(i.toString())),
          'PCS': PlutoCell(value: "Total: ${e.pCS}", key: Key(i.toString())),
          'MTRS': PlutoCell(value: "Total: ${e.mTRS}", key: Key(i.toString())),
        });
        rows.add(row);
      }
      stateManager!.removeRows(stateManager!.rows);
      // stateManager!.appendRows(rows);
      refreshTableData();
      isloadingDone.value = true;
    }
  }

  refreshTableData() {
    stateManager!.removeAllRows();
    stateManager!.resetCurrentState();
    stateManager!.insertRows(0, buildRows());
  }

  void resetFilter() {
    (itemList.value.item ?? []).forEach((element) {
      element.isSelected = false;
    });
    searchitemList.forEach((element) {
      element.isSelected = false;
    });
    searchitemList.refresh();

    (categoryListModel.value.category ?? []).forEach((element) {
      element.isSelected = false;
    });
    searchcategoryListModel.forEach((element) {
      element.isSelected = false;
    });
    searchcategoryListModel.refresh();

    (designListModel.value.design ?? []).forEach((element) {
      element.isSelected = false;
    });
    searchdesignListModel.forEach((element) {
      element.isSelected = false;
    });
    searchdesignListModel.refresh();

    (pieceTypeListModel.value.pieceType ?? []).forEach((element) {
      element.isSelected = false;
    });
    searchpieceTypeListModel.forEach((element) {
      element.isSelected = false;
    });
    searchpieceTypeListModel.refresh();

    (unitListModel.value.unit ?? []).forEach((element) {
      element.isSelected = false;
    });
    searchunitListModel.forEach((element) {
      element.isSelected = false;
    });
    searchunitListModel.refresh();

    (shadeListModel.value.shade ?? []).forEach((element) {
      element.isSelected = false;
    });
    searchshadeListModel.forEach((element) {
      element.isSelected = false;
    });
    searchshadeListModel.refresh();

    (qualityListModel.value.quality ?? []).forEach((element) {
      element.isSelected = false;
    });
    searchqualityListModel.forEach((element) {
      element.isSelected = false;
    });
    searchqualityListModel.refresh();

    (goDownListModel.value.godown ?? []).forEach((element) {
      element.isSelected = false;
    });
    searchgoDownListModel.forEach((element) {
      element.isSelected = false;
    });
    searchgoDownListModel.refresh();
  }

  Future<void> getGeneratedPdfLink() async {
  Utility.showLoader(title: "Loading");
  try {
    List<OutTable> tableToForm = [];
    var itemSize = items.value.table?.length ?? 0;
    for (int i = 0; i < itemSize; i++) {
      var e = items.value.table![i];
      var row = OutTable(
        dATE: e.uNIT,
        tYPE: e.iTEMNAME,
        bILLINITIALS: e.dESIGNNO,
        aGENT: e.cOLOR,
        bILLAMT: 0,
        rECDAMT: e.pCS,
        bALANCE: e.mTRS,
        dAYS: 0,
      );
      tableToForm.add(row);
    }

    var companyName = AppController.shared.selectedCompany?.cmpname ?? "";
    PDFGenetarionRequest pdfGenetarionRequest = PDFGenetarionRequest(
      bank: AppController.shared.selectedCompany?.bank,
      account: AppController.shared.selectedCompany?.account,
      ifsc: AppController.shared.selectedCompany?.ifsc,
      upi: AppController.shared.selectedCompany?.upi,
      partyName: "STOCK",
      date:
          "${AppController.shared.selectedDate!.text} to ${AppController.shared.selectedDate!.text1}",
      pdfTable: tableToForm,
      pdfTable1: [],
      companyName: companyName,
      companyAddress:
          "${AppController.shared.selectedCompany?.add1}\n${AppController.shared.selectedCompany?.add2}",
      titles: [
        "",
        "ITEM NAME",
        "DESIGN NO",
        "COLOR",
        "UNIT",
        "PCS",
        "MTRS",
        ""
      ],
    );

    var data =
        await ApiUtility.shared.generatePDF(pdfGenetarionRequest.toJson());

    if (data.success == true) {
      final pdfUrl = data.requirementQuotation ?? "";
      if (pdfUrl.isEmpty) {
        Utility.showErrorView("Alert!", "PDF URL is empty.");
        return;
      }

      final response = await http.get(Uri.parse(pdfUrl));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();

        final fileName = 'Stock_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final file = File('${tempDir.path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);

        if (!await file.exists()) {
          Utility.showErrorView("Alert!", "Failed to save PDF.");
          return;
        }

        // Use centralized helper that handles iOS popover origin and fallbacks
        await ShareHelper.shareFilesUniversal([XFile(file.path)]);
      } else {
        debugPrint('Failed to download PDF. Status: ${response.statusCode}');
        Utility.showErrorView("Alert!", "Failed to download PDF.");
      }
    } else {
      Utility.showErrorView("Alert!", "Failed to share...");
    }
  } catch (e, st) {
    debugPrint('Exception in getGeneratedPdfLink: $e\n$st');
    Utility.showErrorView("Alert!", "Something went wrong while sharing.");
  } finally {
    Utility.hideLoader();
  }
}

}
