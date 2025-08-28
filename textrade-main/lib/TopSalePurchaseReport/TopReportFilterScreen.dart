import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/Utilies.dart';

class TopReportFilterScreen extends StatelessWidget {
  TopReportFilterScreen({Key? key}) : super(key: key);
  var selectedITEM = "Sales".obs;
  var typeList = ["Party Wise", "Agent Wise", "Item Wise"];
  var selectedWise = "".obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Top Reports")),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(children: [
                  Text("Select Report:",
                      style: TextStyle(fontSize: 17, color: Colors.black)),
                  SizedBox(
                    width: 10,
                  ),
                  Obx(
                    () => DropdownButton<String>(
                      value: selectedITEM.value,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (String? newValue) {
                        selectedITEM.value = newValue ?? "";
                      },
                      items: ["Sales", "Purchase"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black)),
                        );
                      }).toList(),
                    ),
                  )
                ]),
                Expanded(
                  child: ListView.builder(
                    itemCount: typeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (() {
                          selectedWise.value = typeList[index];
                        }),
                        child: Obx(() => radioView(typeList[index],
                            typeList[index] == selectedWise.value)),
                      );
                    },
                  ),
                ),
                TextButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appColor,
                  ),
                  onPressed: () {
                    //gatePassController.submitGatePassForm();
                    Get.toNamed(
                        Utility.screenName(Screens.topSalePurchaseDetailScreen),
                        arguments: [
                          selectedITEM == "Purchase",
                          selectedWise.value.replaceAll(' ', '')
                        ]);
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget radioView(String title, bool isSelected) {
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
              color: isSelected ? appColor : Colors.white,
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
}
