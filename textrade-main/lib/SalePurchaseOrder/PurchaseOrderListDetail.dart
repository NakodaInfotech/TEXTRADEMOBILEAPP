import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:textrade/SalePurchaseOrder/PurchaseOrderListDetailController.dart';

class PurchaseOrderListDetail extends StatelessWidget {
  PurchaseOrderListDetail({super.key});
  final PurchaseOrderListDetailController purchaseOrderListDetailController =
      Get.put(PurchaseOrderListDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Order'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                purchaseOrderListDetailController.getGeneratedPdfLink();
              },
              child: const Icon(Icons.share),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          InkWell(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "SO No: ${purchaseOrderListDetailController.listOfGDN.value.pONO}",
                        textAlign: TextAlign.left),
                    Text(
                        "Party Name: ${purchaseOrderListDetailController.listOfGDN.value.pARTYNAME}",
                        textAlign: TextAlign.left),
                    Text(
                        "Agent Name: ${purchaseOrderListDetailController.listOfGDN.value.aGENTNAME}",
                        textAlign: TextAlign.left),
                    Text(
                        "Transport Name: ${purchaseOrderListDetailController.listOfGDN.value.tRANSNAME}",
                        textAlign: TextAlign.left)
                  ],
                )),
          )),
          Expanded(child: SafeArea(child: listItems())),
        ],
      ),
    );
  }

  Widget listItems() {
    return Obx(() {
      return !purchaseOrderListDetailController.isApiLoading.value
          ? PlutoGrid(
              columns: purchaseOrderListDetailController.columns,
              rows: purchaseOrderListDetailController.rows.value,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                purchaseOrderListDetailController.stateManager =
                    event.stateManager;
                purchaseOrderListDetailController.stateManager
                    ?.setShowColumnFilter(false);
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                print(event);
              },
              onSelected: (event) {
                if (purchaseOrderListDetailController
                        .stateManager!.currentRow ==
                    null) {
                  return;
                }
              },
              onRowSecondaryTap: (event) {
                print("object");
              },
              configuration: const PlutoGridConfiguration(),
              mode: PlutoGridMode.normal,
            )
          : Container();
    });
  }
}
