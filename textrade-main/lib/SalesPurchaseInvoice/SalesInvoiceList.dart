import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/Items/ItemsController.dart';
import 'package:textrade/SalesPurchaseInvoice/salesInvoiceListController.dart';
import 'package:textrade/two_dimensional_tables/table.dart';

import '../Common/Constants.dart';

class SalesInvoiceList extends StatelessWidget {
  SalesInvoiceList({super.key});
  final SalesInvoiceListController salesInvoiceListController =
      Get.put(SalesInvoiceListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale Invoices'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () async {
                salesInvoiceListController.openFilter();
              },
              child: const Icon(
                Icons.filter_alt_outlined,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(child: Obx(() {
        return _buildUI();
      })),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: appColor,
            ),
            onPressed: () {
              salesInvoiceListController.getGeneratedPdfLink();
            },
            child: const Text(
              "Share",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUI() {
    return ListView.builder(
      itemCount:
          (salesInvoiceListController.challanGDNModel.value.table?.length ??
                  0) +
              2,
      itemBuilder: (BuildContext context, int index) {
        return index == 0
            ? Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.only(
                          left: 10, right: 2, top: 1, bottom: 1),
                      padding: const EdgeInsets.only(
                          left: 10, right: 2, top: 15, bottom: 1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(color: Colors.black),
                      ),
                      child: TextField(
                        keyboardType:
                            const TextInputType.numberWithOptions(signed: true),
                        controller:
                            salesInvoiceListController.fromTextController,
                        style: const TextStyle(color: Colors.black),
                        maxLines: 1,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          hintText: "From Invoice No",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.only(
                          left: 10, right: 5, top: 1, bottom: 1),
                      padding: const EdgeInsets.only(
                          left: 12, right: 2, top: 15, bottom: 1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(color: Colors.black),
                      ),
                      child: TextField(
                        keyboardType:
                            const TextInputType.numberWithOptions(signed: true),
                        controller: salesInvoiceListController.toTextController,
                        style: const TextStyle(color: Colors.black),
                        maxLines: 1,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          hintText: "To Invoice No",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColor,
                      ),
                      onPressed: () {
                        salesInvoiceListController.getChallanList();
                      },
                      child: const Text(
                        "Search",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              )
            : index == 1
                ? InkWell(
                    onTap: () {
                      salesInvoiceListController.selectDateTimeRage(context);
                    },
                    child: monthView(context))
                : Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Card(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            Utility.screenName(Screens
                                                .salesInvoiceListDetailScreen),
                                            arguments: [
                                              (salesInvoiceListController
                                                  .challanGDNModel
                                                  .value
                                                  .table?[index - 2])
                                            ]);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              "INV No: ${salesInvoiceListController.challanGDNModel.value.table?[index - 2].iNVNO ?? ""}"),
                                          Text(
                                              "Name: ${salesInvoiceListController.challanGDNModel.value.table?[index - 2].nAME ?? ""}"),
                                          Text(
                                              "Date: ${salesInvoiceListController.challanGDNModel.value.table?[index - 2].iNVDATE ?? ""}"),
                                          Text(
                                              "Agent: ${salesInvoiceListController.challanGDNModel.value.table?[index - 2].aGENTNAME ?? ""}"),
                                          Text(
                                              "Total Pcs: ${salesInvoiceListController.challanGDNModel.value.table?[index - 2].tOTALPCS ?? 0.0}"),
                                          Text(
                                              "Total Mtrs: ${salesInvoiceListController.challanGDNModel.value.table?[index - 2].tOTALMTRS ?? 0.0}"),
                                          Text(
                                              "Dispatch To: ${salesInvoiceListController.challanGDNModel.value.table?[index - 2].dISPATCHTO ?? ""}"),
                                        ],
                                      ))),
                              InkWell(
                                onTap: () async {
                                  salesInvoiceListController
                                      .selectOrDeselectChallan(
                                          salesInvoiceListController
                                              .challanGDNModel
                                              .value
                                              .table?[index - 2]);
                                },
                                child: salesInvoiceListController
                                            .challanGDNModel
                                            .value
                                            .table?[index - 2]
                                            .isSelected ==
                                        false
                                    ? const Icon(
                                        Icons.radio_button_unchecked_rounded)
                                    : const Icon(Icons.radio_button_checked),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                  );
      },
    );
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
          GetX<SalesInvoiceListController>(builder: (controller) {
            return Text(controller.selectedDate.value);
          })
        ],
      ),
    );
  }
}
