import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/Filter/FilterModel/FilterItemModel.dart';
import 'package:textrade/Items/ItemsController.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({Key? key}) : super(key: key);
  var controller = Get.find<ItemsController>();
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
              child: GetX<ItemsController>(builder: (controller) {
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

  Widget selectableWidget() {
    var sid = controller.catArry.value
        .indexWhere((element) => element.isSelected == true);

    switch (sid) {
      case 0:
        return ListView.builder(
          itemCount: controller.searchitemList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checkBoxView(
                    controller.searchitemList.value[index].text ?? "",
                    index,
                    controller.searchitemList.value[index].isSelected ?? false),
                const Divider()
              ],
            );
          },
        );

      case 1:
        return ListView.builder(
          itemCount: controller.searchqualityListModel.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checkBoxView(
                    controller.searchqualityListModel.value[index].text ?? "",
                    index,
                    controller.searchqualityListModel.value[index].isSelected ??
                        false),
                const Divider()
              ],
            );
          },
        );

      case 2:
        return ListView.builder(
          itemCount: controller.searchdesignListModel.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checkBoxView(
                    controller.searchdesignListModel.value[index].text ?? "",
                    index,
                    controller.searchdesignListModel.value[index].isSelected ??
                        false),
                const Divider()
              ],
            );
          },
        );
      case 3:
        return ListView.builder(
          itemCount: controller.searchshadeListModel.value!.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checkBoxView(
                    controller.searchshadeListModel.value[index].text ?? "",
                    index,
                    controller.searchshadeListModel.value[index].isSelected ??
                        false),
                const Divider()
              ],
            );
          },
        );

      case 4:
        return ListView.builder(
          itemCount: controller.searchgoDownListModel.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checkBoxView(
                    controller.searchgoDownListModel.value[index].text ?? "",
                    index,
                    controller.searchgoDownListModel.value[index].isSelected ??
                        false),
                const Divider()
              ],
            );
          },
        );
      case 5:
        return ListView.builder(
          itemCount: controller.searchunitListModel.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checkBoxView(
                    controller.searchunitListModel.value[index].text ?? "",
                    index,
                    controller.searchunitListModel.value[index].isSelected ??
                        false),
                const Divider()
              ],
            );
          },
        );

      case 6:
        return ListView.builder(
          itemCount: controller.searchpieceTypeListModel.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checkBoxView(
                    controller.searchpieceTypeListModel.value[index].text ?? "",
                    index,
                    controller
                            .searchpieceTypeListModel.value[index].isSelected ??
                        false),
                const Divider()
              ],
            );
          },
        );
      case 7:
        return ListView.builder(
          itemCount: controller.searchcategoryListModel.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checkBoxView(
                    controller.searchcategoryListModel.value[index].text ?? "",
                    index,
                    controller
                            .searchcategoryListModel.value[index].isSelected ??
                        false),
                const Divider()
              ],
            );
          },
        );

      default:
        return ListView.builder(
          itemCount: controller.searchcategoryListModel.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checkBoxView(
                    controller.searchcategoryListModel.value[index].text ?? "",
                    index,
                    controller
                            .searchcategoryListModel.value[index].isSelected ??
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
          child: GetX<ItemsController>(builder: (controller) {
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

  void changeSelectionStatus(int index) {
    var sid = controller.catArry.value
        .indexWhere((element) => element.isSelected == true);

    switch (sid) {
      case 0:
        controller.searchitemList.value[index].isSelected =
            !(controller.searchitemList.value[index].isSelected ?? false);
        controller.searchitemList.refresh();
        break;
      case 1:
        controller.searchqualityListModel.value[index].isSelected =
            !(controller.searchqualityListModel.value[index].isSelected ??
                false);
        controller.searchqualityListModel.refresh();
        break;
      case 2:
        controller.searchdesignListModel.value[index].isSelected =
            !(controller.searchdesignListModel.value[index].isSelected ??
                false);
        controller.searchdesignListModel.refresh();
        break;
      case 3:
        controller.searchshadeListModel.value[index].isSelected =
            !(controller.searchshadeListModel.value[index].isSelected ?? false);
        controller.searchshadeListModel.refresh();
        break;
      case 4:
        controller.searchgoDownListModel.value[index].isSelected =
            !(controller.searchgoDownListModel.value[index].isSelected ??
                false);
        controller.searchgoDownListModel.refresh();
        break;
      case 5:
        controller.searchunitListModel.value[index].isSelected =
            !(controller.searchunitListModel.value[index].isSelected ?? false);
        controller.searchunitListModel.refresh();
        break;
      case 6:
        controller.searchpieceTypeListModel.value[index].isSelected =
            !(controller.searchpieceTypeListModel.value[index].isSelected ??
                false);
        controller.searchpieceTypeListModel.refresh();
        break;
      case 7:
        controller.searchcategoryListModel.value[index].isSelected =
            !(controller.searchcategoryListModel.value[index].isSelected ??
                false);
        controller.searchcategoryListModel.refresh();
        break;
      default:
        break;
    }
  }

  Widget filterOptions(dynamic categories) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          const SizedBox(
            width: 25,
          ),
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              border: Border.all(
                  color: (categories.isSelected ?? false)
                      ? Colors.transparent
                      : Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(
                      25 / 2) //                 <--- border radius here
                  ),
            ),
            child: Container(
              child: Center(
                child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: (categories.isSelected ?? false)
                          ? appColor
                          : Colors.transparent,
                      border: Border.all(
                          color: (categories.isSelected ?? false)
                              ? appColor
                              : Colors.transparent),
                      borderRadius: const BorderRadius.all(Radius.circular(
                              15 / 2) //                 <--- border radius here
                          ),
                    )),
              ),
            ),
          ),
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
                categories.text.toString(),
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
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
}
