import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/Reports/ReportController.dart';

import '../Common/Constants.dart';

class ReportScreen extends StatelessWidget {
  var reportController = Get.put(ReportController());

  ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            listItems()
          ],
        ),
      ),
    );
  }

  Widget listItems() {
    return Expanded(
      child: ListView.builder(
        itemCount: reportController.listItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      Get.toNamed(Utility.screenName(Screens.dateListScreen));
                    } else if (index == 1) {
                      Get.toNamed(Utility.screenName(Screens.challanScreen));
                    } else if (index == 2) {
                      Get.toNamed(
                          Utility.screenName(Screens.salesInvoiceListScreen));
                    } else if (index == 3) {
                      Get.toNamed(Utility.screenName(
                          Screens.purchaseInvoiceListScreen));
                    } else if (index == 4) {
                      Get.toNamed(Utility.screenName(Screens.topReportsFilter));
                    } else if (index == 5) {
                      Get.toNamed(Utility.screenName(Screens.saleOrderScreen));
                    } else if (index == 6) {
                      Get.toNamed(
                          Utility.screenName(Screens.saleOrderVerificationScreen));
                    }else if (index == 7) {
                      Get.toNamed(
                          Utility.screenName(Screens.purchaseOrderScreen));
                    } else if (index == 8) {
                      Get.toNamed(
                          Utility.screenName(Screens.catalogListScreen));
                    } else if (index == 9) {
                      Get.toNamed(Utility.screenName(Screens.rackScreen),
                          arguments: [true]);
                    } else if (index == 10) {
                      Get.toNamed(Utility.screenName(Screens.rackScreen),
                          arguments: [false]);
                    } else if (index == 11) {
                      Get.toNamed(Utility.screenName(Screens.salesForm));
                    } else if (index == 12 &&
                        AppController.shared.selectedCompany?.GATEPASSENABLED ==
                            true) {
                      Get.toNamed(Utility.screenName(Screens.gatePassScreen));
                    }
                  },
                  child: salesViewItems(reportController.listItems[index])),
              const Divider()
            ],
          );
        },
      ),
    );
  }

  // Get.toNamed(Utility.screenName(Screens.salesForm));

  Widget salesViewItems(String itemName) {
    return SizedBox(
      height: 50,
      child: Row(children: [
        const SizedBox(
          width: 14,
        ),
        Image.asset(
          "assets/$itemName.png",
          height: 20,
          width: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          itemName,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ]),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: appColor,
      title: const Text(
        "Reports",
        style: TextStyle(color: Colors.black),
      ),
      actions: [],
    );
  }
}
