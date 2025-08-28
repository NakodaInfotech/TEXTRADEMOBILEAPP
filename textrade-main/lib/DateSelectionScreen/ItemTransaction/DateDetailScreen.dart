import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/DateSelectionScreen/ItemTransaction/DateDetailScreenController.dart';
import 'package:textrade/DateSelectionScreen/ItemTransaction/Model/ItemTransactionResponse.dart';

class ItemTransactionsScreen extends StatelessWidget {
  var controller = Get.put(ItemTransactionController());
  ItemTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: listItems(),
      ),
    );
  }

  Widget listItems() {
    return GetX<ItemTransactionController>(builder: (controller) {
      return ListView.builder(
        itemCount: controller.itemTransactionResponse.value.table?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              salesViewItems(controller.itemTransactionResponse.value, index),
              const Divider()
            ],
          );
        },
      );
    });
  }

  Widget salesViewItems(
      ItemTransactionResponse itemTransactionResponse, int index) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(children: [
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: Text(
            itemTransactionResponse.table?[index].nAME ?? "",
            style: const TextStyle(fontSize: 17),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          itemTransactionResponse.table?[index].aMT.toStringAsFixed(2) ?? "",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 14,
        ),
      ]),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: appColor,
      title: const Text("Detail"),
    );
  }
}
