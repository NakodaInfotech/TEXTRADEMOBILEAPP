import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/SalePurchaseOrder/SaleOrderListDetailController.dart';
import 'package:textrade/TopSalePurchaseReport/TopSalePurchaseReportDetailController.dart';

class TopSalePurchaseReportDetail extends StatelessWidget {
  TopSalePurchaseReportDetail({super.key});
  final TopSalePurchaseReportDetailController
      topSalePurchaseReportDetailController =
      Get.put(TopSalePurchaseReportDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            "${topSalePurchaseReportDetailController.isPuchase.value ? "Top Purchase" : "Top Sale"} ${topSalePurchaseReportDetailController.selectedtype == "PARTYWISE" ? "Party Wise" : topSalePurchaseReportDetailController.selectedtype == "AGENTWISE" ? "Agent Wise" : "Item Wise"}")),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                topSalePurchaseReportDetailController.getGeneratedPdfLink();
              },
              child: const Icon(Icons.share),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () async {
                topSalePurchaseReportDetailController.openFilter();
              },
              child: const Icon(
                Icons.filter_alt_outlined,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              topSalePurchaseReportDetailController.selectDateTimeRage(context);
            },
            child: monthView(context),
          ),
          Expanded(child: SafeArea(child: listItems())),
        ],
      ),
    );
  }

  Widget listItems() {
    return Obx(() {
      return !topSalePurchaseReportDetailController.isApiLoading.value
          ? PlutoGrid(
              // columns: topSalePurchaseReportDetailController.selectedtype ==
              //         "PARTYWISE"
              //     ? topSalePurchaseReportDetailController.columnsParty
              //     : topSalePurchaseReportDetailController.selectedtype ==
              //             "AGENTWISE"
              //         ? topSalePurchaseReportDetailController.columnsAgent
              //         : topSalePurchaseReportDetailController.columnsItem,
              columns: topSalePurchaseReportDetailController.columns,
              rows: topSalePurchaseReportDetailController.rows.value,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                topSalePurchaseReportDetailController.stateManager =
                    event.stateManager;
                topSalePurchaseReportDetailController.stateManager
                    ?.setShowColumnFilter(false);
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                print(event);
              },
              onSelected: (event) {
                if (topSalePurchaseReportDetailController
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

  Widget monthView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 60,
      color: appColor,
      child: Row(
        children: [
          const Icon(
            Icons.calendar_month_outlined,
            color: Colors.black,
            size: 40,
          ),
          const SizedBox(
            width: 8,
          ),
          GetX<TopSalePurchaseReportDetailController>(builder: (controller) {
            return Text(controller.selectedDate.value);
          })
        ],
      ),
    );
  }
}
