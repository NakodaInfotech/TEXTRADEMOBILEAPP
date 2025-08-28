import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/GatePass/Controller/GetPassController.dart';

class GatePassFormScreen extends StatelessWidget {
  final GatePassController gatePassController = Get.put(GatePassController());

  GatePassFormScreen({super.key});

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
                gatePassController.openQrScanner();
              },
              child: const Icon(
                Icons.qr_code,
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
              gatePassController.submitGatePassForm();
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

  Widget _buildTransportUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "LOCAL TRANSPORT",
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: InkWell(
              onTap: () {
                gatePassController.openSearch();
              },
              child: Obx(() => ListTile(
                    title: Text(
                        gatePassController.selectedTransport.value.name ?? ""),
                    trailing: const Icon(Icons.arrow_forward),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUI() {
    var gridHeight = gatePassController.selectedChallanBarcodes.length / 3 * 50;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTransportUI(),
        Obx(
          () => _vehicalTextField(),
        ),
        const SizedBox(
          height: 10,
        ),
        _vehicalImage(),
        const SizedBox(
          height: 10,
        ),
        // Obx(() => _scannerGrid()),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: gatePassController.selectedChallans.length,
          physics: const ClampingScrollPhysics(),
          // Changed from NeverScrollableScrollPhysics
          itemBuilder: (BuildContext context, int index) {
            var i = gatePassController.selectedChallans[index];
            return Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Name: ${i.nAME} \nChallan No: ${i.gDNNO}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Obx(() => GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 1,
                          ),
                          itemCount: gatePassController.selectedChallanBarcodes
                              .where((p0) => p0.gDNNO == i.gDNNO)
                              .toList()
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if ((gatePassController
                                            .selectedChallanBarcodes
                                            .where((p0) => p0.gDNNO == i.gDNNO)
                                            .toList()[index]
                                            .isScanned ??
                                        false) || (gatePassController
                                            .selectedChallanBarcodes
                                            .where((p0) => p0.gDNNO == i.gDNNO)
                                            .toList()[index]
                                            .cHK ??
                                        0) == 1)
                                      const Icon(Icons.check_circle,
                                          color: Colors.green),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Text(
                                        gatePassController
                                                .selectedChallanBarcodes
                                                .where(
                                                    (p0) => p0.gDNNO == i.gDNNO)
                                                .toList()[index]
                                                .bARCODE ??
                                            '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                  ],
                ));
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _vehicalTextField() {
    return TextField(
      controller: gatePassController.vehicalNoFieldController.value,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Vehicle No',
      ),
    );
  }

  Widget _vehicalImage() {
    return Obx(() => Column(
          children: [
            gatePassController.xfile.value.path == ""
                ? Container()
                : Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(gatePassController.xfile.value.path),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            gatePassController.xfile.value.path == ""
                ? Container()
                : const SizedBox(
                    height: 10,
                  ),
            ElevatedButton(
              onPressed: () {
                gatePassController.selectImageClicked();
              },
              child: Text(gatePassController.xfile.value.path == ""
                  ? "Select Image"
                  : "Change Image"),
            ),
          ],
        ));
  }
}
