import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SaleOrderVerificationController.dart';

class SaleOrderVerificationScreen extends StatelessWidget {
  final SaleOrderVerificationController controller =
      Get.put(SaleOrderVerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sale Order Verification"),
      ),
      body: Column(
        children: [
          // Toggle Buttons
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.selectedTab.value == "Pending"
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    onPressed: () => controller.getPendingSaleOrders(),
                    child: const Text("Pending"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.selectedTab.value == "Entered"
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    onPressed: () => controller.getEnteredSaleOrders(),
                    child: const Text("Entered"),
                  ),
                ],
              )),
          const SizedBox(height: 10),

          // List Data
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              var table = controller.verificationModel.value.table ?? [];
              if (table.isEmpty) {
                return const Center(child: Text("No Records Found"));
              }

              return ListView.builder(
                itemCount: table.length,
                itemBuilder: (context, index) {
                  var item = table[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    child: ListTile(
                      title: Text("SO No: ${item.sONO ?? ""}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Party: ${item.pARTYNAME ?? ""}"),
                          Text("Agent: ${item.aGENTNAME ?? ""}"),
                          Text("Total Pcs: ${item.tOTALQTY ?? 0}"),
                          Text("Total Mtrs: ${item.tOTALMTRS ?? 0}"),
                          Text("Dispatch To: ${item.sHIPTO ?? ""}"),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
