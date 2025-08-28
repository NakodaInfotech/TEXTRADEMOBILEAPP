import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:textrade/SalePurchaseOrder/SaleOrderListDetailController.dart';

class SaleOrderListDetail extends StatelessWidget {
  SaleOrderListDetail({super.key});
  final SaleOrderListDetailController saleOrderListDetailController =
      Get.put(SaleOrderListDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale Order'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                saleOrderListDetailController.getGeneratedPdfLink();
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
                        "SO No: ${saleOrderListDetailController.listOfGDN.value.sONO}",
                        textAlign: TextAlign.left),
                    Text(
                        "Party Name: ${saleOrderListDetailController.listOfGDN.value.pARTYNAME}",
                        textAlign: TextAlign.left),
                    Text(
                        "Agent Name: ${saleOrderListDetailController.listOfGDN.value.aGENTNAME}",
                        textAlign: TextAlign.left),
                    Text(
                        "Dispatch To: ${saleOrderListDetailController.listOfGDN.value.sHIPTO}",
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
      return !saleOrderListDetailController.isApiLoading.value
          ? PlutoGrid(
              columns: saleOrderListDetailController.columns,
              rows: saleOrderListDetailController.rows.value,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                saleOrderListDetailController.stateManager = event.stateManager;
                saleOrderListDetailController.stateManager
                    ?.setShowColumnFilter(false);
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                print(event);
              },
              onSelected: (event) {
                if (saleOrderListDetailController.stateManager!.currentRow ==
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
