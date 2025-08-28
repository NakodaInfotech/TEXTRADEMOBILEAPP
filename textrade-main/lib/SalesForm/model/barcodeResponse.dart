import 'package:flutter/material.dart';

class BarcodeDetailsResponse {
  List<BarcodeTable>? table;

  BarcodeDetailsResponse({this.table});

  BarcodeDetailsResponse.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <BarcodeTable>[];
      json['Table'].forEach((v) {
        table!.add(new BarcodeTable.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table != null) {
      data['Table'] = this.table!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BarcodeTable {
  String? barcode;
  String? iTEMNAME;
  String? dESIGNNO;
  String? cOLOR;
  TextEditingController? desc = TextEditingController();
  TextEditingController? qty = TextEditingController(text: "1");
  TextEditingController? mtrs = TextEditingController();
  TextEditingController? rate = TextEditingController();

  BarcodeTable({this.barcode, this.iTEMNAME, this.dESIGNNO, this.cOLOR});

  BarcodeTable.fromJson(Map<String, dynamic> json) {
    barcode = null;
    iTEMNAME = json['ITEMNAME'];
    dESIGNNO = json['DESIGNNO'];
    cOLOR = json['COLOR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ITEMNAME'] = this.iTEMNAME;
    data['DESIGNNO'] = this.dESIGNNO;
    data['COLOR'] = this.cOLOR;
    return data;
  }
}
