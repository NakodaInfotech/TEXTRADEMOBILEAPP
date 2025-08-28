import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:textrade/CompanyList/CompanyListModal.dart';

import '../Common/Constants.dart';
import 'CompanyListController.dart';

class CompanyListScreen extends StatelessWidget {
  var companyListController = Get.put(CompanyListController());
  CompanyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
          child:
              Padding(padding: const EdgeInsets.all(20), child: listItems())),
    );
  }

  Widget listItems() {
    return GetX<CompanyListController>(builder: (controller) {
      return ListView.builder(
        itemCount: controller.companyListObs.value.table?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (() {}),
            child: Column(
              children: [
                radioView(controller.companyListObs.value.table[index])
              ],
            ),
          );
        },
      );
    });
  }

  Widget radioView(Company table) {
    return GestureDetector(
      onTap: () {
        companyListController.selectedCompany(table);
      },
      child: Column(
        children: [
          Container(
            child: Container(
              constraints: const BoxConstraints(minHeight: 50),
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      table.cmpname,
                      style: TextStyle(fontSize: 17, color: Colors.black),
                      // overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: appColor,
      title: const Text("Select Company"),
    );
  }
}
