import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:textrade/SalesPurchaseInvoice/PurchaseInvoiceDetailsController.dart';
import 'package:textrade/two_dimensional_tables/table.dart';

import '../Common/Constants.dart';

class PurchaseInvoiceDetails extends StatelessWidget {
  PurchaseInvoiceDetails({super.key});
  final PurchaseInvoiceDetailsController purchaseInvoiceDetailsController =
      Get.put(PurchaseInvoiceDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Invoice'),
        actions: [
          // Container(
          //   margin: const EdgeInsets.only(right: 12),
          //   child: InkWell(
          //     onTap: () {
          //       purchaseInvoiceDetailsController.getGeneratedPdfLink();
          //     },
          //     child: const Icon(Icons.share),
          //   ),
          // )
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
                        "PI No: ${purchaseInvoiceDetailsController.listOfGDN.value.pINO}",
                        textAlign: TextAlign.left),
                    Text(
                        "Party Name: ${purchaseInvoiceDetailsController.listOfGDN.value.pARTYNAME}",
                        textAlign: TextAlign.left),
                    Text(
                        "Agent Name: ${purchaseInvoiceDetailsController.listOfGDN.value.aGENTNAME}",
                        textAlign: TextAlign.left),
                    Text(
                        "Grand Total: ${purchaseInvoiceDetailsController.listOfGDN.value.gRANDTOTAL}",
                        textAlign: TextAlign.left),
                    // Text(
                    //     "Charges: ${purchaseInvoiceDetailsController.listOfGDN.value.cHARGES}",
                    //     textAlign: TextAlign.left),
                    // Text(
                    //     "Taxable Amount: ${purchaseInvoiceDetailsController.listOfGDN.value.tOTALTAXAMT}",
                    //     textAlign: TextAlign.left),
                    // Text(
                    //     "CGST: ${purchaseInvoiceDetailsController.listOfGDN.value.tOTALCGSTAMT}",
                    //     textAlign: TextAlign.left),
                    // Text(
                    //     "SGST: ${purchaseInvoiceDetailsController.listOfGDN.value.tOTALSGSTAMT}",
                    //     textAlign: TextAlign.left),
                    // Text(
                    //     "IGST: ${purchaseInvoiceDetailsController.listOfGDN.value.tOTALIGSTAMT}",
                    //     textAlign: TextAlign.left),
                    // Text(
                    //     "Grand Total: ${purchaseInvoiceDetailsController.listOfGDN.value.gRANDTOTAL}",
                    //     textAlign: TextAlign.left),
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
      return !purchaseInvoiceDetailsController.isApiLoading.value
          ? PlutoGrid(
              columns: purchaseInvoiceDetailsController.columns,
              rows: purchaseInvoiceDetailsController.rows.value,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                purchaseInvoiceDetailsController.stateManager =
                    event.stateManager;
                purchaseInvoiceDetailsController.stateManager
                    ?.setShowColumnFilter(false);
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                print(event);
              },
              onSelected: (event) {
                if (purchaseInvoiceDetailsController.stateManager!.currentRow ==
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
