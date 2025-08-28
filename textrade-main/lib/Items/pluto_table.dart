// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mgc_management/common/constants.dart';
// import 'package:mgc_management/common/shared_ui.dart';
// import 'package:mgc_management/common/widgets/cutom_appbar.dart';
// import 'package:mgc_management/controller/detail_controller.dart';
// import 'package:pluto_grid/pluto_grid.dart';

// class PlutoTable extends StatelessWidget {
//   ReportDetailController reportDetailController =
//       Get.put(ReportDetailController());

//   PlutoGridStateManager? stateManager;
//   Key? currentRowKey;
//   bool isLoading = true;

//   PlutoTable({Key? key}) : super(key: key);
//   List<PlutoColumn> _buildColumns() {
//     Map<String, dynamic> configs = reportDetailController.reportData.first;
//     List<PlutoColumn> pColumns = [];
//     configs.forEach((key, value) {
//       pColumns.add(_buildPlutoColumn(key));
//     });
//     pColumns.removeWhere((element) => element.field == "\$t");
//     // if (widget.showCheckboxColumn) {
//     pColumns.add(
//       PlutoColumn(
//         enableColumnDrag: false,
//         enableRowDrag: false,
//         width: responsiveController.count(Get.context!,
//             mobilePotrait: 70,
//             mobileLandscape: 70,
//             tabPotrait: 110,
//             tabLandscape: 110),
//         // enableRowChecked: true,
//         enableFilterMenuItem: false,
//         enableSorting: false,
//         enableEditingMode: false,
//         enableContextMenu: false,
//         title: "srNo".tr,
//         field: "srNo",
//         titleSpan: TextSpan(
//           children: [
//             TextSpan(
//               text: "srNo".tr,
//               style: TextStyles.columnTitleStyle,
//             ),
//           ],
//         ),
//         type: PlutoColumnType.text(),
//         frozen: PlutoColumnFrozen.start,
//         renderer: (rendererContext) {
//           Widget? child;
//           if (child == null) {
//             String value = rendererContext
//                 .row.cells[rendererContext.column.field]!.value
//                 .toString();
//             child = Text(
//               value,
//               style: TextStyles.inventoryCardBlue16SubTitle,
//             );
//           } else {
//             child = Align(alignment: Alignment.centerLeft, child: child);
//           }
//           return child;
//         },
//       ),
//     );
//     // }

//     return pColumns;
//   }

//   List<PlutoRow> _buildRows() {
//     RxList<PlutoRow> pRows = <PlutoRow>[].obs;
//     int count = 0;
//     List<PlutoColumn> pCols = _buildColumns();
//     for (var json in reportDetailController.reportData) {
//       RxMap<String, PlutoCell> cells = <String, PlutoCell>{}.obs;
//       count++;

//       for (var element in pCols) {
//         cells[element.field] = PlutoCell(
//             value: (json.containsKey(element.field))
//                 ? (json[element.field].runtimeType == String)
//                     ? json[element.field]
//                     : (json[element.field] as Map<String, dynamic>)
//                             .containsKey("\$t")
//                         ? json[element.field]['\$t'] ?? ""
//                         : ""
//                 : "");
//       }
//       cells["srNo"] = PlutoCell(value: count.toString());
//       pRows.add(PlutoRow(cells: cells));
//     }
//     return pRows;
//   }

//   refreshTableData() {
//     stateManager!.removeRows(stateManager!.rows);
//     stateManager!.resetCurrentState();
//     stateManager!.appendRows(_buildRows());
//   }

  // void gridHandler() {
    // if (stateManager!.currentRow == null) {
    //   return;
    // }
    // if (stateManager!.currentRow!.key != currentRowKey) {
    //   print("Row press");
    //   currentRowKey = stateManager!.currentRow!.key;
    // }
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () {
//         return Scaffold(
//           appBar: CustomAppbar(
//             showLanguageIcon: false,
//             title: Get.arguments != null ? Get.arguments[0] : "",
//             hideapprovals: true,
//           ),
//           body: reportDetailController.isLoading.isTrue
//               ? SharedUi().loadingWidget()
//               : reportDetailController.reportData.isEmpty
//                   ? Center(child: SharedUi().noRecordWidget(context))
//                   : SizedBox(
//                       child: Column(
//                         children: [
//                           Get.arguments[0] == "Inventory Detail"
//                               ? Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 20),
//                                   child: Text(
//                                     "${Get.arguments[1]} - ${Get.arguments[2]}",
//                                     style: TextStyles.inventoryTitle,
//                                   ),
//                                 )
//                               : SizedBox(),
//                           Expanded(
//                             child: PlutoGrid(
//                               rows: _buildRows(),
//                               columns: _buildColumns(),
//                               onLoaded: (event) {
//                                 stateManager = event.stateManager;
//                                 event.stateManager.addListener(gridHandler);
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//         );
//       },
//     );
//   }

  
// }
