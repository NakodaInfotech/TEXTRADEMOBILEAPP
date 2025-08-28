import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:textrade/DateSelectionScreen/DateSelectionController.dart';

import '../Common/Constants.dart';
import '../Common/Routes.dart';
import '../Common/Utilies.dart';

class DateListScreen extends StatelessWidget {
  var companyListController = Get.put(DateListController());
  DateListScreen({Key? key}) : super(key: key);

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
    return GetX<DateListController>(builder: (controller) {
      return ListView.builder(
        itemCount: controller.dateListObs.value.year?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (() {
              var year = controller.dateListObs.value.year?[index];
              if (year == null) {
                return;
              }
              controller.dateSelected(year);
            }),
            child: Column(
              children: [
                radioView(
                    "${controller.dateListObs.value.year?[index].text ?? ""} to ${controller.dateListObs.value.year?[index].text1 ?? ""}")
              ],
            ),
          );
        },
      );
    });
  }

  Widget radioView(String title) {
    return Column(
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
                    title,
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
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: appColor,
      title: const Text("Select Year"),
    );
  }
}
