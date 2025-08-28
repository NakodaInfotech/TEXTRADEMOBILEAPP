import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:textrade/GDNChallanDetails/GDNChallanDetailsController.dart';
import 'package:textrade/two_dimensional_tables/table.dart';

import '../Common/Constants.dart';

class GDNChallanDetails extends StatelessWidget {
  GDNChallanDetails({super.key});
  final GDNChallanDetailsController gDNChallanDetailsController =
      Get.put(GDNChallanDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GDN Challan Details'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                gDNChallanDetailsController.getGeneratedPdfLink();
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
                        "Challan No: ${gDNChallanDetailsController.listOfGDN.value.gDNNO}",
                        textAlign: TextAlign.left),
                    Text(
                        "Party Name: ${gDNChallanDetailsController.listOfGDN.value.nAME}",
                        textAlign: TextAlign.left),
                    Text(
                        "Agent Name: ${gDNChallanDetailsController.listOfGDN.value.aGENT}",
                        textAlign: TextAlign.left),
                    Text(
                        "Dispatch To: ${gDNChallanDetailsController.listOfGDN.value.dISPATCHTO}",
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
      return !gDNChallanDetailsController.isApiLoading.value
          ? PlutoGrid(
              columns: gDNChallanDetailsController.columns,
              rows: gDNChallanDetailsController.rows.value,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                gDNChallanDetailsController.stateManager = event.stateManager;
                gDNChallanDetailsController.stateManager
                    ?.setShowColumnFilter(false);
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                print(event);
              },
              onSelected: (event) {
                if (gDNChallanDetailsController.stateManager!.currentRow ==
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
