import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/rack/controller/rack_controller.dart';
import 'package:textrade/rack/model/rack_model.dart';
import 'package:textrade/rack/model/update_rack_res.dart';

class RackScreen extends StatelessWidget {
  final controller = Get.put(RackController());

  RackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<RackTable>(
                          isExpanded: true,
                          value: controller.selectedRack.value,
                          hint: const Text(
                            'Select Rack',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          items: (controller.racks.value.table ?? [])
                              .map((RackTable value) {
                            return DropdownMenuItem<RackTable>(
                              value: value,
                              child: Text(
                                value.rACKNAME ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (RackTable? newValue) {
                            print(newValue);
                            if (newValue != null) {
                              controller.selectedRack.value = newValue;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(() => Visibility(
                    visible: !controller.isRackManagement.value,
                    child: Container(
                        margin: EdgeInsets.all(16),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          controller: controller.textController,
                          style: const TextStyle(color: Colors.black),
                          maxLines: 1,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            hintText: "Remark",
                          ),
                        )))),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Number of columns
                        childAspectRatio: 2 / 2, // Width/Height ratio
                      ),
                      itemCount: controller.scannedQrCodes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Icon(Icons.qr_code),
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        controller.scannedQrCodes[index],
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 6,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.scannedQrCodes.removeAt(index);
                                  },
                                  child: const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close,
                                        color: Colors.white, size: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: InkWell(
            onTap: () async {
              if (controller.scannedQrCodes.isNotEmpty) {
                Utility.showLoader(title: "updating...");
                String result = controller.scannedQrCodes.join('|');
                var rackUpdateModel = UpadateRackModel(
                    rACKID:
                        (controller.selectedRack.value.rACKId ?? 0).toString(),
                    cMPID: (AppController.shared.selectedCompany?.cmpid ?? 0)
                        .toString(),
                    uSERID: (AppController.shared.userId ?? 0).toString(),
                    yEARID: (AppController.shared.selectedDate?.value ?? ""),
                    bARCODE: result);
                var stockUpdateModel = UpdateStockTacking(
                    rACKID:
                        (controller.selectedRack.value.rACKId ?? 0).toString(),
                    cMPID: (AppController.shared.selectedCompany?.cmpid ?? 0)
                        .toString(),
                    uSERID: (AppController.shared.userId ?? 0).toString(),
                    yEARID: (AppController.shared.selectedDate?.value ?? ""),
                    bARCODE: result,
                    remark: controller.textController.text);
                if (controller.isRackManagement == true) {
                  var data = await ApiUtility().updateRack(rackUpdateModel);
                  Utility.hideLoader();
                  if ((data.table?[0].column1 ?? false) == true) {
                    Get.back();
                    Utility.showErrorView(
                        "Alert!", (data.table?[0].column2 ?? ""));
                  } else {
                    Utility.showErrorView(
                        "Alert!", (data.table?[0].column2 ?? ""),
                        alertType: AlertType.error);
                  }
                } else {
                  var data = await ApiUtility().updateStock(stockUpdateModel);
                  Utility.hideLoader();
                  if ((data.table?[0].column1 ?? false) == true) {
                    Get.back();
                    Utility.showErrorView(
                        "Alert!", (data.table?[0].column2 ?? ""));
                  } else {
                    Utility.showErrorView(
                        "Alert!", (data.table?[0].column2 ?? ""),
                        alertType: AlertType.error);
                  }
                }
              } else {
                Utility.showErrorView("Error", "Please scan some qr codes",
                    alertType: AlertType.error);
              }
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
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: appColor,
      title: Obx(() => Text(controller.isRackManagement.value
          ? "Rack Management"
          : "Stock Taking")),
      elevation: 0,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 12),
          child: InkWell(
            onTap: () {
              Get.toNamed(Utility.screenName(Screens.qrScanner),
                  arguments: [true])?.then((value) {
                if (value != null) {
                  Utility.showLoader(title: "Fetching details...");
                  for (var item in value) {
                    if (!controller.scannedQrCodes.contains(item)) {
                      controller.scannedQrCodes.add(item);
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
      ],
    );
  }
}
