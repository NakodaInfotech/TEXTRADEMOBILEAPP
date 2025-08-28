import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/SalesForm/controller/seachController.dart';

class SearchScreen extends StatelessWidget {
  final TexSearchController _searchController = Get.put(TexSearchController());
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController.searchTextController,
              decoration: InputDecoration(
                  labelText: 'Search',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                      onPressed: () {
                        _searchController.onClearSearch();
                      },
                      icon: const Icon(
                        Icons.close,
                      ))),
              onChanged: _searchController.onSearchChange,
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: _searchController.filteredSearchList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.back(
                              result:
                                  _searchController.filteredSearchList[index]);
                        },
                        child: ListTile(
                          title: Text(_searchController
                                  .filteredSearchList[index].name ??
                              "unknown"),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
