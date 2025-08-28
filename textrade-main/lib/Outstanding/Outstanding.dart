import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/Outstanding/OutstandingController.dart';
import 'package:textrade/Parties/Models/LedgerMainRequestModel.dart';
import 'package:textrade/Parties/Models/LedgerMainResponseModel.dart';

import '../Common/Constants.dart';

class OutstandingScreen extends StatelessWidget {
  var outstandingController = Get.put(OutstandingController());

  OutstandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            tabs(),
            const SizedBox(
              height: 8,
            ),
            // monthView(),
            const Divider(),

            listItems()
          ],
        ),
      ),
    );
  }

  Widget listItems() {
    return Expanded(
      child: GetX<OutstandingController>(builder: (partyController) {
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ListView.builder(
            itemCount: partyController.isRecSelected.value
                ? partyController.mainRecLedgerResponse.value.table?.length ?? 0
                : partyController.mainPayLedgerResponse.value.table?.length ??
                    0,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  InkWell(
                      onTap: () {
                        TableLedger? selectedRec = TableLedger();
                        TableLedger? selectedPay = TableLedger();
                        if (partyController.isRecSelected.value) {
                          selectedRec = partyController
                              .mainRecLedgerResponse.value.table?[index];
                        } else {
                          selectedPay = partyController
                              .mainPayLedgerResponse.value.table?[index];
                        }

                        var ledgerMainRequest = LedgerMainRequest(
                            name: (partyController.isRecSelected.value)
                                ? selectedRec?.lEDGERID.toString()
                                : selectedPay?.lEDGERID.toString(),
                            agentName: "",
                            city: "",
                            area: "",
                            group: "",
                            yearID:
                                AppController.shared.selectedMainDate?.value,
                            fromDate: Utility.convertDateFormate(AppController
                                    .shared.selectedItemDetailParty!.text ??
                                ""),
                            toDate: Utility.convertDateFormate(AppController
                                    .shared.selectedItemDetailParty!.text1 ??
                                ""));
                        Get.toNamed(
                                Utility.screenName(
                                    Screens.OutstandingDetailScreen),
                                arguments: [
                              (partyController.isRecSelected.value
                                  ? selectedRec
                                  : selectedPay),
                              partyController.isRecSelected.value,
                              partyController.selectedCategory.value == "Ledger"
                              //ledger or agent
                              ,
                              ledgerMainRequest
                            ])!
                            .then((value) {
                          if (partyController.isDateChangedFromDetailScreen) {
                            print(
                                "values is changed ${AppController.shared.selectedItemDetailParty?.text} to ${AppController.shared.selectedItemDetailParty?.text1}");
                            partyController.selectedDate.value =
                                "${AppController.shared.selectedItemDetailParty!.text} to ${AppController.shared.selectedItemDetailParty!.text1}";
                            if (partyController.isRecSelected.value) {
                              partyController.getRecBalance();
                            } else {
                              partyController.getPayBalance();
                            }
                          }
                        });
                      },
                      child: salesViewItems(
                          partyController.isRecSelected.value
                              ? partyController.mainRecLedgerResponse.value
                              : partyController.mainPayLedgerResponse.value,
                          index)),
                  const Divider()
                ],
              );
            },
          ),
        );
      }),
    );
  }

  Widget salesViewItems(LedgerMainResponseModel responseModel, int index) {
    return Row(children: [
      const SizedBox(
        width: 14,
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              responseModel.table?[index].nAME ?? "Unknown",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
      const SizedBox(
        width: 8,
      ),
      Text(
        "${responseModel.table?[index].bALANCE.toStringAsFixed(2) ?? "0"} ${responseModel.table?[index].dRCR.toString() ?? "0"}",
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
      const SizedBox(
        width: 10,
      ),
    ]);
  }

  Widget mainCategoryViewItems() {
    return Card(
      child: Row(children: [
        const SizedBox(
          width: 14,
        ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              "₹ 2,50,000",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "As of 29 Jan 21 | All",
              style: TextStyle(
                  fontSize: 16, color: Color.fromARGB(117, 117, 117, 1)),
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
        Spacer(),
        Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.transparent, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
              height: 40,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 14,
                    ),
                    Icon(Icons.menu,
                        color: const Color.fromARGB(255, 190, 1, 1)),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Apply Filter",
                      style: const TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 190, 1, 1)),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                  ],
                ),
              )),
        ),
        const SizedBox(
          width: 10,
        ),
      ]),
    );
  }

  Widget monthView() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 40,
      color: appColor.withOpacity(0.2),
      child: Row(
        children: const [
          Text("Want Faster Payment?"),
          Spacer(),
          Text("SETUP AUTO REMINDERS",
              style: TextStyle(color: Color.fromARGB(255, 190, 1, 1))),
        ],
      ),
    );
  }

  Widget tabs() {
    return Obx(() => Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      // outstandingController.resetFilter();
                      outstandingController.isRecSelected.value = true;
                    },
                    child: tabItems("Receivable",
                        outstandingController.isRecSelected.value))),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      // outstandingController.resetFilter();
                      outstandingController.isRecSelected.value = false;
                    },
                    child: tabItems("Payable",
                        !outstandingController.isRecSelected.value))),
            const SizedBox(
              width: 20,
            ),
          ],
        ));
  }

  Widget tabItems(String title, bool isSelected) {
    return Card(
      color: isSelected ? appColor : Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.transparent, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
          height: 40,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          )),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: appColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Outstanding",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          //create a dropdown with ledger and agent
          Obx(() => DropdownButton<String>(
                value: outstandingController.selectedCategory.value,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String? newValue) {
                  outstandingController.updateSelectedCategory(newValue ?? "");
                },
                items: ["Ledger", "Agent"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ))
        ],
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.toNamed(Utility.screenName(Screens.outStandingFilterScreen));
          },
          child: const Icon(
            Icons.filter_list,
            size: 30,
          ),
        ),
        const SizedBox(
          width: 18,
        )
      ],
    );
  }
}
