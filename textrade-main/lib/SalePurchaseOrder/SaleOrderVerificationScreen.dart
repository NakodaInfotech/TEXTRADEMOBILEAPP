import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/SalePurchaseOrder/SaleOrderVerificationController.dart';

class SaleOrderVerificationScreen extends StatelessWidget {
  final SaleOrderVerificationController controller =
      Get.put(SaleOrderVerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sale Order Verification"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Filter ka function yahan call karo
              controller.openFilter(context);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              // Date Filter Box (Yellow)
              InkWell(
                onTap: () => controller.selectDateTimeRange(context),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffF8D67D),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month, color: Colors.brown),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          controller.selectedDate.value,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Tab Toggle Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.selectedTab.value == "Pending"
                          ? const Color.fromARGB(255, 245, 200, 104)
                          : Colors.white,
                      foregroundColor: controller.selectedTab.value == "Pending"
                          ? Colors.black
                          : Colors.grey,
                    ),
                    onPressed: () => controller.getPendingSaleOrders(),
                    child: const Text("Pending"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.selectedTab.value == "Entered"
                          ? const Color.fromARGB(255, 249, 183, 91)
                          : Colors.white,
                      foregroundColor: controller.selectedTab.value == "Entered"
                          ? Colors.black
                          : Colors.grey,
                    ),
                    onPressed: () => controller.getEnteredSaleOrders(),
                    child: const Text("Entered"),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // List & Circular Radio Selection
              Expanded(
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Builder(builder: (_) {
                        var table = controller.selectedTab.value == "Pending"
                            ? controller.pendingVerificationModel.value.table ?? []
                            : controller.enteredVerificationModel.value.table ?? [];

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
                               
                                title: Text("SO No: ${item.sono ?? ''}"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name: ${item.name ?? ''}"),
                                    Text("Agent: ${item.agentName ?? ''}"),
                                    Text("Item: ${item.itemName ?? ''}"),
                                    Text("Design: ${item.designName ?? ''}"),
                                    Text("Color: ${item.color ?? ''}"),
                                    Text("Type: ${item.type ?? ''}"),
                                  ],
                                ),
                                 trailing: Obx(() => Checkbox(
                                    value: item.isSelected.value, 
                                    onChanged: (val) {
                                      item.isSelected.value = val ?? false;
                                      if (controller.selectedTab.value == "Pending") {
                                        controller.pendingVerificationModel.refresh();
                                      } else {
                                        controller.enteredVerificationModel.refresh();
                                      }
                                    },
                                  ),
                                 ),
                              ),
                            );
                          },
                        );
                      }),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: SizedBox(
            width: 300.0,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor,
              ),
              onPressed: () {
                controller.verifySelectedOrders();
              },
              child: const Text(
                "Verify",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
