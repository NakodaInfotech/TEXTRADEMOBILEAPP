import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/GatePass/Controller/GetPassController.dart';

class GatePassList extends StatelessWidget {
  final GatePassController gatePassController = Get.put(GatePassController());

  GatePassList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gate Pass'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                gatePassController.isForEditing = false;
                gatePassController.loadChalanScreen();
              },
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          )
        ],
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
      itemCount: gatePassController.getPassListModel.value.table?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          "GatePass No: ${gatePassController.getPassListModel.value.table?[index].tEMPENTRYNO ?? ""}"),
                      Text(
                          "Name: ${gatePassController.getPassListModel.value.table?[index].nAME ?? ""}"),
                      Text(
                          "Date: ${gatePassController.getPassListModel.value.table?[index].dATE ?? ""}"),
                      Text(
                          "Agent: ${gatePassController.getPassListModel.value.table?[index].aGENT ?? ""}"),
                      Text(
                          "Transport: ${gatePassController.getPassListModel.value.table?[index].tRANSPORT ?? ""}"),
                      Text(
                          "Delivery: ${gatePassController.getPassListModel.value.table?[index].dELIVERY ?? ""}"),
                      Text(
                          "Vehicle No: ${gatePassController.getPassListModel.value.table?[index].vEHICLENO ?? ""}"),
                      if (gatePassController.getPassListModel.value
                              .table?[index].pPARTIALSAVE ==
                          true)
                        const Text(
                          "Partially saved",
                          style: TextStyle(color: Colors.red),
                        )
                    ],
                  ),
                  if (gatePassController.getPassListModel.value
                              .table?[index].pPARTIALSAVE ==
                          true)
                    Positioned(
                        right: 0,
                        child: IconButton(
                            onPressed: () {
                              gatePassController.isForEditing = true;
                              gatePassController.loadChalanScreen(
                                  gpNo: (gatePassController
                                              .getPassListModel
                                              .value
                                              .table?[index]
                                              .tEMPENTRYNO ??
                                          0)
                                      .toString());
                            },
                            icon: const Icon(Icons.edit)))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
