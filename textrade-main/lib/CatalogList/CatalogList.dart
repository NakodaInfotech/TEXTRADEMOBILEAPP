import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:textrade/CatalogList/CatalogListController.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/Items/ItemsController.dart';
import 'package:textrade/two_dimensional_tables/table.dart';

import '../Common/Constants.dart';

class CatalogList extends StatelessWidget {
  CatalogList({super.key});
  final CatalogListController catalogListController =
      Get.put(CatalogListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog List'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () async {
                catalogListController.openFilter();
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
              catalogListController.getGeneratedPdfLink();
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
          (catalogListController.challanGDNModel.value.table?.length ?? 0) + 1,
      itemBuilder: (BuildContext context, int index) {
        return index == 0
            ? Column(
                children: [
                  Obx(() => GestureDetector(
                      onTap: () {
                        catalogListController.isIncludeSelected.value =
                            !catalogListController.isIncludeSelected.value;
                        catalogListController.apiCall();
                        // changeSelectionStatus(index);
                      },
                      child: Row(
                        children: [
                          Spacer(),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      6.0) //                 <--- border radius here
                                  ),
                            ),
                            child: Container(
                              child: Center(
                                child: Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: catalogListController
                                              .isIncludeSelected.value
                                          ? appColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: catalogListController
                                                  .isIncludeSelected.value
                                              ? appColor
                                              : Colors.white),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                              5.0) //                 <--- border radius here
                                          ),
                                    )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Flexible(
                            child: Text(
                              "Include Stock",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Spacer(),
                        ],
                      ))),
                  Row(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appColor,
                          ),
                          onPressed: () {
                            catalogListController.selectUnselectAllList(true);
                          },
                          child: const Text(
                            "Select All",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appColor,
                          ),
                          onPressed: () {
                            catalogListController.selectUnselectAllList(false);
                          },
                          child: const Text(
                            "Unselect All",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  )
                ],
              )
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
                                    catalogListController
                                        .selectOrDeselectCatalog(
                                            catalogListController
                                                .challanGDNModel
                                                .value
                                                .table?[index - 1]);
                                  },
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            child: Image.network(
                                              width: 100,
                                              height: 100,
                                              // "http://122.179.159.186:8142/TEXTRADE/IMAGES/B_104_115.jpg"
                                              catalogListController
                                                      .challanGDNModel
                                                      .value
                                                      .table?[index - 1]
                                                      .fILENAME ??
                                                  "",
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "Catalog No: ${catalogListController.challanGDNModel.value.table?[index - 1].cATALOGNO ?? ""}"),
                                            Text(
                                                "Item Name: ${catalogListController.challanGDNModel.value.table?[index - 1].iTEMNAME ?? ""}"),
                                            Text(
                                                "Design No: ${catalogListController.challanGDNModel.value.table?[index - 1].dESIGNNO ?? ""}"),
                                          ],
                                        ),
                                      )
                                    ],
                                  ))),
                          InkWell(
                            onTap: () async {
                              catalogListController.selectOrDeselectCatalog(
                                  catalogListController
                                      .challanGDNModel.value.table?[index - 1]);
                            },
                            child: catalogListController.challanGDNModel.value
                                        .table?[index - 1].isSelected ==
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
}
