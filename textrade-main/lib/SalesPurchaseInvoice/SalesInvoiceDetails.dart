import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:textrade/SalesPurchaseInvoice/SalesInvoiceDetailsController.dart';
import 'package:textrade/two_dimensional_tables/table.dart';

import '../Common/Constants.dart';

class SalesInvoiceDetails extends StatelessWidget {
  SalesInvoiceDetails({super.key});
  final SalesInvoiceDetailsController salesInvoiceDetailsController =
      Get.put(SalesInvoiceDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale Invoice'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                salesInvoiceDetailsController.getGeneratedPdfLink();
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
                        "INV No: ${salesInvoiceDetailsController.listOfGDN.value.iNVNO}",
                        textAlign: TextAlign.left),
                    Text(
                        "Party Name: ${salesInvoiceDetailsController.listOfGDN.value.nAME}",
                        textAlign: TextAlign.left),
                    Text(
                        "Agent Name: ${salesInvoiceDetailsController.listOfGDN.value.aGENTNAME}",
                        textAlign: TextAlign.left),
                    Text(
                        "Dispatch To: ${salesInvoiceDetailsController.listOfGDN.value.dISPATCHTO}",
                        textAlign: TextAlign.left),
                    Text(
                        "Total Amount: ${salesInvoiceDetailsController.listOfGDN.value.tOTALWITHMATVALUE}",
                        textAlign: TextAlign.left),
                    // Text(
                    //     "Charges: ${salesInvoiceDetailsController.listOfGDN.value.cHARGES}",
                    //     textAlign: TextAlign.left),
                    Text(
                        "Taxable Amount: ${salesInvoiceDetailsController.listOfGDN.value.tOTALTAXAMT}",
                        textAlign: TextAlign.left),
                    Text(
                        "CGST: ${salesInvoiceDetailsController.listOfGDN.value.tOTALCGSTAMT}",
                        textAlign: TextAlign.left),
                    Text(
                        "SGST: ${salesInvoiceDetailsController.listOfGDN.value.tOTALSGSTAMT}",
                        textAlign: TextAlign.left),
                    Text(
                        "IGST: ${salesInvoiceDetailsController.listOfGDN.value.tOTALIGSTAMT}",
                        textAlign: TextAlign.left),
                    Text(
                        "Grand Total: ${salesInvoiceDetailsController.listOfGDN.value.gRANDTOTAL}",
                        textAlign: TextAlign.left),
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
      return !salesInvoiceDetailsController.isApiLoading.value
          ? PlutoGrid(
              columns: salesInvoiceDetailsController.columns,
              rows: salesInvoiceDetailsController.rows.value,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                salesInvoiceDetailsController.stateManager = event.stateManager;
                salesInvoiceDetailsController.stateManager
                    ?.setShowColumnFilter(false);
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                print(event);
              },
              onSelected: (event) {
                if (salesInvoiceDetailsController.stateManager!.currentRow ==
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
