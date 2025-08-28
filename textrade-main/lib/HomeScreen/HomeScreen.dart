import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/StorageManager.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/DateSelectionScreen/DateSelectionListResponseModel.dart';
import 'package:textrade/HomeScreen/HomeScreenController.dart';
import 'package:textrade/HomeScreen/HomeScreenResponseModel.dart';
import 'package:textrade/two_dimensional_tables/table.dart';

import '../Widgets/CustomLoader.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Column(
          children: [
            // lastSync(),
            const SizedBox(
              height: 10,
            ),
            tabs(),
            const SizedBox(
              height: 10,
            ),
            monthView(context),
            const SizedBox(
              height: 8,
            ),
            listItems()
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    var startDateStr = homeScreenController.startDateStr;
    var endDateStr = homeScreenController.startDateStr;
    var selectedYear = AppController.shared.selectedDate;
    var values = selectedYear?.value ?? "";
    Year tempYear = Year(text: startDateStr, text1: endDateStr, value: values);
    homeScreenController.getDashboardListing(selectedYear: tempYear);
  }

  Widget listItems() {
    return Expanded(
      child: GetX<HomeScreenController>(builder: (controller) {
        return controller.isApiLoading.value
            ? CustomLoader(loadingMessage: "Fetching Data...")
            : RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  itemCount:
                      controller.homeScreenResponse.value.table?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            var selectedYear =
                                AppController.shared.selectedDate;
                            Get.toNamed(
                                Utility.screenName(
                                    Screens.itemTransactionsScreen),
                                arguments: [
                                  controller
                                      .homeScreenResponse.value.table?[index],
                                  controller.startDateStr == ""
                                      ? selectedYear?.text
                                      : controller.startDateStr,
                                  controller.endDateStr == ""
                                      ? selectedYear?.text1
                                      : controller.endDateStr,
                                ]);
                          },
                          child: salesViewItems(homeScreenController
                              .homeScreenResponse.value.table![index]),
                        ),
                        const Divider()
                      ],
                    );
                  },
                ));
      }),
    );
  }

  Widget salesViewItems(TableResponse table) {
    return Row(children: [
      const SizedBox(
        width: 14,
      ),
      // Icon(
      //   Icons.shopping_cart,
      //   color: appColor,
      // ),

      Image.asset(
        "assets/${table.tRADETYPE}.png",
        height: 24,
        width: 24,
      ),
      const SizedBox(
        width: 10,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            table.aMT?.toStringAsFixed(2) ?? "0.00",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            table.tRADETYPE ?? "Unknown",
            style: const TextStyle(
                fontSize: 14, color: Color.fromARGB(117, 117, 117, 1)),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    ]);
  }

  Widget monthView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 40,
      color: appColor.withOpacity(0.2),
      child: Row(
        children: [
          Icon(
            Icons.calendar_month_outlined,
            color: appColor,
          ),
          const SizedBox(
            width: 8,
          ),
          GetX<HomeScreenController>(builder: (controllers) {
            return GestureDetector(
                onTap: () {
                  controllers.selectDateTimeRage(context);
                },
                child: Text(controllers.selectedDate.value));
          }) //Text(controller.selectedDate.value);
        ],
      ),
    );
  }

  Widget tabs() {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child: GestureDetector(
                onTap: () {
                  Get.toNamed(Utility.screenName(Screens.itemScreen));
                },
                child: tabItems("assets/Box.png", "Items", false))),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: GestureDetector(
                onTap: () {
                  Get.toNamed(Utility.screenName(Screens.partyScreen));
                },
                child: tabItems("assets/Users.png", "Party", false))),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }

  Widget tabItems(String icon, String title, bool isSelected) {
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
                Image.asset(icon),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          )),
    );
  }

  // Widget lastSync() {
  //   return Container(
  //     padding: const EdgeInsets.only(left: 10, right: 10),
  //     height: 30,
  //     color: appColor.withOpacity(0.6),
  //     child: Row(
  //       children: const [
  //         Text("Last Sync on: 22nd June 22, @12:45PM"),
  //         Spacer(),
  //         Icon(
  //           Icons.sync,
  //           color: Color.fromARGB(255, 190, 1, 1),
  //         ),
  //         SizedBox(
  //           width: 14,
  //         )
  //       ],
  //     ),
  //   );
  // }

  PreferredSizeWidget appBar() {
    return AppBar(
        backgroundColor: appColor,
        foregroundColor: Colors.black,
        title: const Text("TexTrade"),
        actions: [
          GestureDetector(
              onTap: () {
                StorageManager.clearAllData();
                Get.offAllNamed(Utility.screenName(Screens.loginScreen));
              },
              child: Row(children: [
                Image.asset(
                  "assets/logout.png",
                  height: 40,
                  width: 40,
                ),
                const SizedBox(
                  width: 10,
                )
              ]))
        ]);
    // title: ,
    // actions: [
    //   IconButton(
    //     icon: Image.asset(
    //       "assets/questionMark.png",
    //       height: 40,
    //       width: 40,
    //     ),
    //     onPressed: () {
    //       Get.toNamed(Utility.screenName(Screens.tableScreen));
    //     },
    //   ),
    //   const SizedBox(
    //     width: 18,
    //   )
    // ],
  }
}
