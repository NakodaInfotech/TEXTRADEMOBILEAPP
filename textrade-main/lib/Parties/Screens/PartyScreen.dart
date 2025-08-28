import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/Parties/Models/LedgerMainResponseModel.dart';
import 'package:textrade/Parties/party_controller/PartyController.dart';

class PartyScreen extends StatelessWidget {
  PartyController partyController = Get.put(PartyController());
  PartyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          InkWell(
              onTap: () {
                partyController.selectDateTimeRage(context);
              },
              child: monthView(context)),
          Expanded(child: listItems()),
        ],
      ),
    );
  }

  Widget monthView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 80,
      color: appColor,
      child: Row(
        children: [
          const Icon(
            Icons.calendar_month_outlined,
            color: Colors.black,
            size: 40,
          ),
          const SizedBox(
            width: 8,
          ),
          GetX<PartyController>(builder: (controller) {
            return Text(controller.selectedDate.value);
          })
        ],
      ),
    );
  }

  Widget listItems() {
    return GetX<PartyController>(builder: (partyController) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListView.builder(
          itemCount:
              partyController.mainLedgerResponse.value.table?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                InkWell(
                    onTap: () {
                      Get.toNamed(Utility.screenName(Screens.partyDetailScreen),
                              arguments: partyController
                                  .mainLedgerResponse.value.table?[index])!
                          .then((value) {
                        if (partyController.isDateChangedFromDetailScreen) {
                          print(
                              "values is changed ${AppController.shared.selectedItemDetailParty?.text} to ${AppController.shared.selectedItemDetailParty?.text1}");
                          partyController.selectedDate.value =
                              "${AppController.shared.selectedItemDetailParty!.text} to ${AppController.shared.selectedItemDetailParty!.text1}";
                          partyController.getLedgerBalance();
                        }
                      });
                    },
                    child: salesViewItems(
                        partyController.mainLedgerResponse.value, index)),
                const Divider()
              ],
            );
          },
        ),
      );
    });
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

  Widget tabs() {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child: GestureDetector(
                onTap: () {}, child: tabItems("Receivable", true))),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: GestureDetector(
                onTap: () {}, child: tabItems("Payable", false))),
        const SizedBox(
          width: 20,
        ),
      ],
    );
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
      elevation: 0,
      backgroundColor: appColor,
      title: const Text(
        "Party",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.toNamed(Utility.screenName(Screens.partiesFilterScreen));
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
