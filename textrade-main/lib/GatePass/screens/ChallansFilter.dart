import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/GatePass/Controller/GetPassController.dart';
import 'package:textrade/Items/ItemsController.dart';

class ChallansFilter extends StatelessWidget {
  final GatePassController controller = Get.find();

  ChallansFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [filterMainView(), applyFilterButton()],
        ),
      ),
    );
  }

  Widget applyFilterButton() {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(8),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            // If the button is pressed, return green, otherwise blue
            if (states.contains(MaterialState.pressed)) {
              return Colors.white;
            }
            return appColor;
          }),
        ),
        onPressed: () {
          controller.applyFilter();
        },
        child: const Text(
          "Apply Filter",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget filterMainView() {
    return Expanded(
      // height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: ListView.builder(
                  itemCount: controller.catArry.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return filterMainCat(controller.catArry.value[index],
                        index: index);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: GetX<GatePassController>(builder: (controller) {
                return Container(
                  child: Column(
                    children: [
                      searchBar(),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(child: selectableWidget()),
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: appColor,
      title: const Text("Filter Items"),
      actions: [
        GestureDetector(
          onTap: () {
            controller.resetFilter();
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Center(
              child: Text("Reset"),
            ),
          ),
        ),
        const SizedBox(
          width: 18,
        )
      ],
    );
  }

  Widget filterMainCat(Categories categories, {int? index}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.searchTextController.text = "";
            controller.searchResult("");
            controller.catArry.value.forEach((element) {
              element.isSelected = false;
            });
            controller.catArry.value[index!].isSelected =
                !(controller.catArry.value[index].isSelected!);
            controller.catArry.refresh();
          },
          child: GetX<GatePassController>(builder: (controller) {
            return Container(
                decoration: BoxDecoration(
                  color: (controller.catArry.value[index!].isSelected ?? false)
                      ? appColor.withOpacity(0.2)
                      : Colors.transparent,
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                // height: 45,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          categories.title.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ));
          }),
        )
      ],
    );
  }

  Widget searchBar() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      padding: const EdgeInsets.only(left: 0, right: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 8,
          ),
          const Icon(
            Icons.search,
            size: 30,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
                controller: controller.searchTextController,
                style: const TextStyle(color: Colors.black),
                onChanged: (text) {
                  controller.searchResult(text);
                },
                maxLines: 1,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  hintText: "Search",
                )),
          ),
          const SizedBox(
            width: 8,
          ),
          IconButton(
              onPressed: () {
                controller.searchTextController.text = "";
                controller.searchResult("");
              },
              icon: const Icon(
                Icons.close,
                size: 25,
              ))
        ],
      ),
    );
  }

  void changeSelectionStatus(int index) {
    var sid = controller.catArry.value
        .indexWhere((element) => element.isSelected == true);

    switch (sid) {
      case 0:
        controller.filterLedgerArray.value[index].isSelected =
            !(controller.filterLedgerArray.value[index].isSelected ?? false);
        controller.filterLedgerArray.refresh();
        break;
      case 1:
        controller.filterAgentArray.value[index].isSelected =
            !(controller.filterAgentArray.value[index].isSelected ?? false);
        controller.filterAgentArray.refresh();
        break;
      case 2:
        controller.filterTransportArray.value[index].isSelected =
            !(controller.filterTransportArray.value[index].isSelected ?? false);
        controller.filterTransportArray.refresh();
        break;
      default:
        break;
    }
  }

  Widget selectableWidget() {
    var sid = controller.catArry.value
        .indexWhere((element) => element.isSelected == true);
    switch (sid) {
      case 0:
        return ListView.builder(
          itemCount: controller.filterLedgerArray.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checkBoxView(
                    controller.filterLedgerArray.value[index].text ?? "",
                    index,
                    controller.filterLedgerArray.value[index].isSelected ??
                        false),
                const Divider()
              ],
            );
          },
        );

      case 1:
        return ListView.builder(
          itemCount: controller.filterAgentArray.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checkBoxView(
                    controller.filterAgentArray.value[index].text ?? "",
                    index,
                    controller.filterAgentArray.value[index].isSelected ??
                        false),
                const Divider()
              ],
            );
          },
        );

      case 2:
        return ListView.builder(
          itemCount: controller.filterTransportArray.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checkBoxView(
                    controller.filterTransportArray.value[index].name ?? "",
                    index,
                    controller.filterTransportArray.value[index].isSelected ??
                        false),
                const Divider()
              ],
            );
          },
        );
      default:
        return ListView.builder(
          itemCount: controller.filterTransportArray.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checkBoxView(
                    controller.filterTransportArray.value[index].name ?? "",
                    index,
                    controller.filterTransportArray.value[index].isSelected ??
                        false),
                const Divider()
              ],
            );
          },
        );
    }
  }

  Widget checkBoxView(String title, int index, bool isSelected) {
    return GestureDetector(
      onTap: () {
        changeSelectionStatus(index);
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Center(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  changeSelectionStatus(index);
                },
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(
                            6.0) //                 <--- border radius here
                        ),
                  ),
                  child: Container(
                    child: Center(
                      child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: isSelected ? appColor : Colors.white,
                            border: Border.all(
                                color: isSelected ? appColor : Colors.white),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    5.0) //                 <--- border radius here
                                ),
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
