import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/two_dimensional_tables/table.dart';

import '../Common/Constants.dart';

class ChallanScreen extends StatefulWidget {
  const ChallanScreen({super.key});

  @override
  State<ChallanScreen> createState() => _ChallanScreenState();
}

class _ChallanScreenState extends State<ChallanScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('GDN Challan'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
               // gatePassController.openQrScanner();
              },
              child: const Icon(
                Icons.filter,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildUI(),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: appColor,
            ),
            onPressed: () {
              //gatePassController.submitGatePassForm();
              Get.toNamed(Utility.screenName(Screens.gdnChallanDetailsScreen));
            },
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUI() {
    return ListView.builder(
      itemCount: 10,//gatePassController.getPassListModel.value.table?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return const Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          "GatePass No:"), //${gatePassController.getPassListModel.value.table?[index].tEMPENTRYNO ?? ""}"),
                      Text(
                          "Name: "), //${gatePassController.getPassListModel.value.table?[index].nAME ?? ""}"),
                      Text(
                          "Date: "), //${gatePassController.getPassListModel.value.table?[index].dATE ?? ""}"),
                      Text(
                          "Agent: "), //${gatePassController.getPassListModel.value.table?[index].aGENT ?? ""}"),
                      Text(
                          "Transport: "), //${gatePassController.getPassListModel.value.table?[index].tRANSPORT ?? ""}"),
                      Text(
                          "Delivery: "), //${gatePassController.getPassListModel.value.table?[index].dELIVERY ?? ""}"),
                      Text(
                          "Vehicle No: "), //${gatePassController.getPassListModel.value.table?[index].vEHICLENO ?? ""}"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
