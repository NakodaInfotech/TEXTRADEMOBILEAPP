import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
//import 'package:pluto_grid_export/pluto_grid_export.dart' as pluto_grid_export;
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/Items/ItemsController.dart';
import 'package:textrade/Items/StockResponseModel.dart';

class ItemsScreen extends StatelessWidget {
  ItemsScreen({Key? key}) : super(key: key);
  var controller = Get.put(ItemsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(child: listItems()),
    );
  }

  void gridHandler() {}

  Widget listItems() {
    return GetX<ItemsController>(builder: (controllers) {
      return controllers.isloadingDone.value &&
              (controllers.items.value.table?.length ?? 0) > 0
          ? PlutoGrid(
              columns: controller.columns,
              rows: controller.buildRows(),
              onLoaded: (PlutoGridOnLoadedEvent event) {
                controller.stateManager = event.stateManager;
                controller.stateManager?.setShowColumnFilter(false);
                // event.stateManager.addListener(gridHandler);
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                print(event);
              },
              onSelected: (event) {
                if (controller.stateManager!.currentRow == null) {
                  return;
                }

                int index = controller.stateManager!.currentRow?.sortIdx ?? 0;
                final ItemTable? itemTable =
                    controller.items.value.table?[index];
                Get.toNamed(Utility.screenName(Screens.itemDetailScreen),
                    arguments: itemTable);

                controller.stateManager?.unCheckedRows;
              },
              onRowSecondaryTap: (event) {
                print("object");
              },
              configuration: const PlutoGridConfiguration(),
              mode: PlutoGridMode.selectWithOneTap,
            )
          : const Center(
              child: Text(
                "No Data",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            );
    });
  }

  Widget normalDivider() {
    return const SizedBox(
      height: 6,
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: appColor,
      title: const Text("Items"),
      actions: [
        GestureDetector(
          onTap: () {
            controller.getGeneratedPdfLink();
          },
          child: const Icon(
            Icons.share,
            size: 30,
          ),
        ),
        const SizedBox(
          width: 18,
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Utility.screenName(Screens.filterScreen));
          },
          child: const Icon(
            Icons.filter_list,
            size: 30,
          ),
        ),
        const SizedBox(
          width: 18,
        )
      ],
    );
  }

  /*void exportToPdf() async {
    var plutoGridPdfExport = pluto_grid_export.PlutoGridDefaultPdfExport(
      title: "Pluto Grid Sample pdf print",
      creator: "Pluto Grid Rocks!",
      format: pluto_grid_export.PdfPageFormat.a4.landscape,
      // themeData: themeData,
    );

    await pluto_grid_export.Printing.sharePdf(
      bytes: await plutoGridPdfExport.export(controller.stateManager!),
      filename: plutoGridPdfExport.getFilename(),
    );
  }*/
}
