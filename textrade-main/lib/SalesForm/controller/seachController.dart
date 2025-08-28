import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/SalesForm/model/searchModel.dart';

class TexSearchController extends GetxController {
  var filteredSearchList = <SearchGenericModel>[].obs;
  var searchList = <SearchGenericModel>[];
  TextEditingController searchTextController = TextEditingController();

  @override
  void onInit() {
    getSearchList();
    super.onInit();
  }

  getSearchList() {
    searchList = Get.arguments;
    filteredSearchList.value.addAll(searchList);
  }

  onSearchChange(String text) {
    print(searchList);
    filteredSearchList.value = searchList
        .where((element) =>
            (element.name?.toLowerCase().contains(text.toLowerCase()) ?? false))
        .toList();

    filteredSearchList.refresh();
  }

  onClearSearch() {
    searchTextController.clear();
    filteredSearchList.value.addAll(searchList);
    filteredSearchList.refresh();
  }
}
