import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/SalesForm/controller/salesFormController.dart';

class SalesFormScreen extends StatelessWidget {
  var controller = Get.put(SalesFormController());

  SalesFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Sale Order'), actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                Get.toNamed(Utility.screenName(Screens.qrScanner),
                    arguments: [true])?.then((value) {
                  if (value != null) {
                    Utility.showLoader(title: "Fetching Details");
                    for (var item in value) {
                      if (!controller.scannedQrCodes
                          .map((element) => element.barcode)
                          .contains(item)) {
                        controller.getBarCodeDetails(item);
                      } else {
                        Utility.showErrorView("Alert", "Qr was already added");
                      }
                    }
                    Utility.hideLoader();
                  }
                });
              },
              child: const Icon(Icons.qr_code),
            ),
          )
        ]),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Obx(() => Column(
                children: [
                  _buildUI(SalesFormType.party),
                  _buildUI(SalesFormType.ship),
                  _buildUI(SalesFormType.transport),
                  _buildUI(SalesFormType.agent),
                  _buildUI(SalesFormType.city),
                  _scannedQrViews(),
                ],
              )),
        )),
        bottomNavigationBar: _bottomButton());
  }

  Widget _scannedQrViews() {
    return Visibility(
      visible: controller.scannedQrCodes.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.scannedQrCodes.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          controller.scannedQrCodes[index].barcode ?? "Unknown",
                          style: const TextStyle(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.start,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            controller.scannedQrCodes.removeAt(index);
                          },
                          child: const CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Icon(Icons.close,
                                color: Colors.white, size: 20),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.qr_code,
                          size: 70,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _richText(
                                  "Item Name",
                                  controller.scannedQrCodes[index].iTEMNAME ??
                                      "Unknown"),
                              _richText(
                                  "Color",
                                  controller.scannedQrCodes[index].cOLOR ??
                                      "Unknown"),
                              _richText(
                                  "Design",
                                  controller.scannedQrCodes[index].dESIGNNO ??
                                      "Unknown")
                            ],
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      controller: controller.scannedQrCodes[index].desc,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Description',
                      ),
                    ),
                    TextField(
                      controller: controller.scannedQrCodes[index].qty,
                      keyboardType:
                          const TextInputType.numberWithOptions(signed: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+$'))
                      ],
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Qty',
                      ),
                    ),
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      controller: controller.scannedQrCodes[index].mtrs,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,4}'))
                      ],
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Mtrs',
                      ),
                    ),
                    TextField(
                      controller: controller.scannedQrCodes[index].rate,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,4}'))
                      ],
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Rate',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _richText(String key, String value) {
    return RichText(
      maxLines: 2,
      text: TextSpan(
        children: [
          TextSpan(
            text: "$key: ",
            style: const TextStyle(
                fontWeight: FontWeight.w700, color: Colors.black),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _bottomButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: InkWell(
          onTap: () async {
            controller.updateSalesOrder();
          },
          child: Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            height: 40,
            decoration: BoxDecoration(
              color: appColor,
              border: Border.all(color: Colors.transparent),
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            ),
            child: const Center(
              child: Text(
                "Submit",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUI(SalesFormType salesFormType) {
    return Visibility(
      visible: _getStatus(salesFormType),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(_getTitle(salesFormType)),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: InkWell(
                onTap: () {
                  controller.openSearch(salesFormType);
                },
                child: ListTile(
                  title: Text(_getText(salesFormType)),
                  trailing: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTitle(SalesFormType salesFormType) {
    switch (salesFormType) {
      case SalesFormType.party:
        return "Party Name";
      case SalesFormType.ship:
        return "Ship to";
      case SalesFormType.agent:
        return "Agent";
      case SalesFormType.transport:
        return "Transport";
      case SalesFormType.city:
        return "City";
      default:
        return "Unknown";
    }
  }

  String _getText(SalesFormType salesFormType) {
    switch (salesFormType) {
      case SalesFormType.party:
        return controller.partyName.value;
      case SalesFormType.ship:
        return controller.shipToo.value;
      case SalesFormType.agent:
        return controller.agent.value;
      case SalesFormType.transport:
        return controller.transport.value;
      case SalesFormType.city:
        return controller.city.value;
      default:
        return "Unknown";
    }
  }

  bool _getStatus(SalesFormType salesFormType) {
    switch (salesFormType) {
      case SalesFormType.party:
        return true;
      case SalesFormType.ship:
        return controller.partyName.value != 'Party Name';
      case SalesFormType.agent:
        return controller.partyName.value != 'Party Name';
      case SalesFormType.transport:
        return controller.partyName.value != 'Party Name';
      case SalesFormType.city:
        return controller.partyName.value != 'Party Name';
      default:
        return true;
    }
  }
}
