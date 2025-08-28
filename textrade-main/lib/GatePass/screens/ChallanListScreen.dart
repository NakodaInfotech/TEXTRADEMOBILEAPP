import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/GatePass/Controller/GetPassController.dart';

class ChallanList extends StatelessWidget {
  final GatePassController gatePassController = Get.find();

  ChallanList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challans'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () async {
                await gatePassController.getSearchList();
                Get.toNamed(Utility.screenName(Screens.challanFiler))
                    ?.then((value) {
                  if (value != null) {
                    gatePassController.getChallanList(
                        value[0], value[1], value[2], "");
                  }
                });
              },
              child: const Icon(
                Icons.filter_alt_outlined,
                size: 30,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: appColor,
            ),
            onPressed: () {
              gatePassController.loadGatePassForm();
            },
            child: const Text(
              "Next",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          return _buildListUI();
        }),
      ),
    );
  }

  Widget _buildListUI() {
    return ListView.builder(
      itemCount: gatePassController.challanList.value.table?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Card(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          gatePassController.selectOrDeselectChallan(
                              gatePassController
                                  .challanList.value.table?[index]);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                "Challan No: ${gatePassController.challanList.value.table?[index].gDNNO ?? ""}"),
                            Text(
                                "Name: ${gatePassController.challanList.value.table?[index].nAME ?? ""}"),
                            Text(
                                "MTRS: ${gatePassController.challanList.value.table?[index].mTRS ?? ""}"),
                            Text(
                                "PCS: ${gatePassController.challanList.value.table?[index].pCS ?? ""}"),
                            Text(
                                "Date: ${Utility.convertDateFormateDDMMYYYY(gatePassController.challanList.value.table?[index].gDNDATE ?? "")}"),
                          ],
                        ),
                      ),
                    ),
                    gatePassController
                                .challanList.value.table?[index].isSelected ==
                            true
                        ? const Icon(Icons.check)
                        : const SizedBox(),
                  ],
                )),
          ),
        );
      },
    );
  }
}
