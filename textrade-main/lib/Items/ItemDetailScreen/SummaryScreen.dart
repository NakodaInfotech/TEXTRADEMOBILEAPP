import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/Items/ItemDetailScreen/ItemDetailController.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const TotalViewScreen(),
          const SalesHistory(),
          Divider(
            color: appColorNM,
          ),
          const PurchaseHistory(),
          Divider(
            color: appColorNM,
          ),
          const PendingSaleOrderSummary(),
          Divider(
            color: appColorNM,
          )
        ],
      ),
    );
  }
}

class PurchaseHistory extends StatelessWidget {
  const PurchaseHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ItemDetailScreenController>(builder: (controller) {
      return controller.itemDetail.value.table2 == null
          ? Container()
          : ExpansionTile(
              title: const Text('Purchase'),
              children: controller.itemDetail.value.table2!
                  .map((e) => Container(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                e.pURMONTH ?? "",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              e.pURMTRS.toString() ?? "",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ))
                  .toList(),
            );
    });
  }
}

class SalesHistory extends StatelessWidget {
  const SalesHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ItemDetailScreenController>(builder: (controller) {
      return controller.itemDetail.value.table1 == null
          ? Container()
          : ExpansionTile(
              title: const Text('Sales'),
              children: controller.itemDetail.value.table1!
                  .map((e) => Container(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                e.sALEMONTH ?? "",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              e.sALEMTRS.toString() ?? "",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ))
                  .toList(),
            );
    });
  }
}

class PendingSaleOrderSummary extends StatelessWidget {
  const PendingSaleOrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ItemDetailScreenController>(builder: (controller) {
      return controller.itemDetail.value.table3 == null
          ? Container()
          : ExpansionTile(
              title: const Text('Pending Order'),
              children: controller.itemDetail.value.table3!
                  .map((e) => Container(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                e.oRDERNAME ?? "",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              e.oRDERMTRS.toString() ?? "",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ))
                  .toList(),
            );
    });
  }
}

class TotalViewScreen extends StatelessWidget {
  const TotalViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ItemDetailScreenController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 8, top: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "PCS",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  controller.itemDetail.value.table?.first.pCS.toString() ?? "",
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "MTRS",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  controller.itemDetail.value.table?.first.mTRS.toString() ??
                      "",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Divider(
              color: appColorNM,
            )
          ],
        ),
      );
    });
  }
}

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ItemDetailScreenController>(builder: (controller) {
      return ListView.builder(
        itemCount: controller.itemDetail.value.table4?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              InkWell(
                onTap: () {},
                child: salesViewItems(controller, index),
              ),
              const Divider()
            ],
          );
        },
      );
    });
  }

  Widget salesViewItems(
      ItemDetailScreenController itemDetailScreenController, int index) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(children: [
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: Text(
            itemDetailScreenController
                    .itemDetail.value.table4?[index].cUSNAME ??
                "",
            style: const TextStyle(fontSize: 17),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          itemDetailScreenController.itemDetail.value.table4?[index].cUSMTRS!
                  .toStringAsFixed(2) ??
              "",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 14,
        ),
      ]),
    );
  }
}

class SupplierView extends StatelessWidget {
  const SupplierView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ItemDetailScreenController>(builder: (controller) {
      return ListView.builder(
        itemCount: controller.itemDetail.value.table5?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              InkWell(
                onTap: () {},
                child: salesViewItems(controller, index),
              ),
              const Divider()
            ],
          );
        },
      );
    });
  }

  Widget salesViewItems(
      ItemDetailScreenController itemDetailScreenController, int index) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(children: [
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: Text(
            itemDetailScreenController
                    .itemDetail.value.table5?[index].sUPPNAME ??
                "",
            style: const TextStyle(fontSize: 17),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          itemDetailScreenController.itemDetail.value.table5?[index].sUPPMTRS!
                  .toStringAsFixed(2) ??
              "",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 14,
        ),
      ]),
    );
  }
}
