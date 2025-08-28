import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:torch_controller/torch_controller.dart';

class QRScannerTexTrade extends StatefulWidget {
  const QRScannerTexTrade({super.key});

  @override
  State<QRScannerTexTrade> createState() => _QRScannerTexTradeState();
}

class _QRScannerTexTradeState extends State<QRScannerTexTrade> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  final TorchController _torchController = TorchController();
  var allowMultiCapture = false;
  bool _isTorchOn = false;
  var scannedQrs = [].obs;
  List<String?>? barcodesToCheck;

  @override
  void initState() {
    // TODO: implement initState
    allowMultiCapture = Get.arguments?[0] ?? false;
    if (Get.arguments.length > 1) {
      barcodesToCheck = Get.arguments?[1] ?? [];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (allowMultiCapture) {
          Get.back(result: scannedQrs);
        }
        return true;
      },
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            actions: [
              Obx(() => Text(
                    "Scanned:" + scannedQrs.value.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  )),
              const SizedBox(
                width: 10,
              ),
              Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: Switch(
                    activeColor: appColor,
                    value: _isTorchOn,
                    onChanged: (value) async {
                      if (controller != null) {
                        await controller!.toggleFlash(); // Toggle flash
                        final isFlashOn = await controller!.getFlashStatus();
                        setState(() {
                          _isTorchOn = isFlashOn ?? false;
                        });
                      }
                    },
                  )),
            ],
          ),
          body: Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                ),
                Expanded(
                    // flex: 1,
                    child: Obx(() => ListView.builder(
                          itemCount: scannedQrs.value.reversed.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              scannedQrs.value.reversed.toList()[index] ?? "",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            );
                          },
                        )))
              ],
            ),
          )),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    var isbacked = false;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        if (allowMultiCapture == false && isbacked == false) {
          isbacked = true;
          print(scanData.code);
          Get.back(result: scanData.code);
        } else {
          //to check barcode
          if (barcodesToCheck != null) {
            if (barcodesToCheck?.contains(scanData.code) ?? false) {
              if (!scannedQrs.contains(scanData.code)) {
                // Utility.showErrorView("Alert!", "Qr scanned...",
                //     alertType: AlertType.success);
                scannedQrs.add(scanData.code ?? '');
              }
            }
          } else {
            if (!scannedQrs.contains(scanData.code)) {
              // print("adding data ${scannedQrs.map((e) => e)}");
              scannedQrs.add(scanData.code ?? '');
              // Utility.showErrorView("Alert!", "Qr scanned...",
              //     alertType: AlertType.success);
            }
          }
        }
      }
    });
  }
}
