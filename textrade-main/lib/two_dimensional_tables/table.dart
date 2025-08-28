import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:textrade/Common/Constants.dart';

class Table extends StatelessWidget {
  final List<Map<String, String>> listOfColumns = [
    {
      "Name": "AAAAAA",
      "Number": "1",
      "State": "Yes",
      "Name": "AAAAAA",
      "Number":"1",
      "State": "Yes",
      "Name": "AAAAAA",
      "Number": "1"
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              border: TableBorder.symmetric(
                outside: BorderSide.none,
                inside: const BorderSide(
                    width: 0.5, color: Colors.grey, style: BorderStyle.solid),
              ),
              columns: const [
                DataColumn(label: Text('Item Name')),
                DataColumn(label: Text('Quantity')),
                DataColumn(label: Text('Design no.')),
                DataColumn(label: Text('Colour')),
                DataColumn(label: Text('Unit')),
                DataColumn(label: Text('Pcs')),
                DataColumn(label: Text('Mtrs')),
                DataColumn(label: Text('Colour')),
              ],
              rows:
                  listOfColumns // Loops through dataColumnText, each iteration assigning the value to element
                      .map(
                        ((element) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(element["Name"] ??
                                    "")), //Extracting from Map element the value
                                DataCell(Text(element["Name"] ?? "")),
                                DataCell(Text(element["Number"] ?? "")),
                                DataCell(Text(element["Name"] ??
                                    "")), //Extracting from Map element the value
                                DataCell(Text(element["Name"] ?? "")),
                                DataCell(Text(element["Number"] ?? "")),
                                DataCell(Text(element["Name"] ??
                                    "")), //Extracting from Map element the value
                                DataCell(Text(element["Name"] ?? "")),
                              ],
                            )),
                      )
                      .toList(),
            ),
          ),
        )));
  }
}

PreferredSizeWidget appBar() {
  return AppBar(
    backgroundColor: appColor,
    foregroundColor: Colors.black,
    automaticallyImplyLeading: false,
    title: const Text("Tex Trade"),
    // title: ,
    actions: [
      IconButton(
        icon: const Icon(Icons.share),
        onPressed: () {},
      ),
      const SizedBox(
        width: 18,
      )
    ],
  );
}
