import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Items/ItemsController.dart';
import 'package:textrade/SalesForm/model/searchModel.dart';

class CommanFilterController extends GetxController {
  var catArry = <Categories>[].obs;
  RxList<RxList<SearchGenericModel>> filterOptions =
      RxList<RxList<SearchGenericModel>>();
  RxList<RxList<SearchGenericModel>> defaulFilterOptionst =
      RxList<RxList<SearchGenericModel>>();

  var searchTextController = TextEditingController();

  @override
  void onInit() {
    catArry.value = Get.arguments[0];
    filterOptions.value = Get.arguments[1];
    defaulFilterOptionst.value = Get.arguments[2];
    super.onInit();
  }

  void applyFilter() async {
    var filteredVal = filterOptions.value
        .map((e) =>
            e.value.where((element) => element.isSelected == true).toList())
        .toList();
    Get.back(result: filteredVal);
  }

  void resetFilter() {
    (filterOptions.value).forEach((element) {
      element.value.forEach((val) {
        val.isSelected = false;
      });
    });

    filterOptions.refresh();
  }

  void searchResult(String searchStr) {
    var selectedCategoryIndex =
        catArry.indexWhere((element) => element.isSelected == true);

    if (searchStr != "") {
      filterOptions.value[selectedCategoryIndex].value = List.from(
          defaulFilterOptionst[selectedCategoryIndex]
              .value!
              .where((element) =>
                  element.name!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList());
    } else {
      filterOptions.value = defaulFilterOptionst.value.map((list) {
        return RxList<SearchGenericModel>.from(list.value.map((item) =>
            SearchGenericModel(item.name, item.id)
              ..isSelected = item.isSelected));
      }).toList();
    }
    filterOptions.refresh();
  }
}
