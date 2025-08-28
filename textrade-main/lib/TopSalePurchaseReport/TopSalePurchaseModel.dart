import 'dart:ffi';

class TopSalePurchaseModel {
  List<TopSalePurchaseModelTable>? table;

  TopSalePurchaseModel({this.table});

  TopSalePurchaseModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <TopSalePurchaseModelTable>[];
      json['Table'].forEach((v) {
        table!.add(new TopSalePurchaseModelTable.fromJson(v));
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

class TopSalePurchaseModelTable {
  String? pARTYNAME;
  String? aGENTNAME;
  String? iTEMNAME;
  String? cITY;
  double? tOTALMTRS;
  double? tOTALQTY;
  double? tOTALAMT;
  double? aVGRATE;
  double? tAXABLEAMT;
  double? gRANDTOTAL;
  double? pERCENTAGE;

  TopSalePurchaseModelTable(
      {this.pARTYNAME,
      this.aGENTNAME,
      this.iTEMNAME,
      this.cITY,
      this.tOTALMTRS,
      this.tOTALQTY,
      this.tOTALAMT,
      this.aVGRATE,
      this.tAXABLEAMT,
      this.gRANDTOTAL,
      this.pERCENTAGE});

  TopSalePurchaseModelTable.fromJson(Map<String, dynamic> json) {
    pARTYNAME = json['PARTYNAME'];
    aGENTNAME = json['AGENTNAME'];
    iTEMNAME = json['ITEMNAME'];
    cITY = json['CITY'];
    tOTALMTRS = json['TOTALMTRS'];
    tOTALQTY = json['TOTALQTY'] == "" ? 0.0 : json['TOTALQTY'];
    tOTALAMT = json['TOTALAMT'] == "" ? 0.0 : json['TOTALAMT'];
    aVGRATE = json['AVGRATE'] == "" ? 0.0 : json['AVGRATE'];
    tAXABLEAMT = json['TAXABLEAMT'] == "" ? 0.0 : json['TAXABLEAMT'];
    gRANDTOTAL = json['GRANDTOTAL'] == "" ? 0.0 : json['GRANDTOTAL'];
    pERCENTAGE = json['PERCENTAGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PARTYNAME'] = this.pARTYNAME;
    data['AGENTNAME'] = this.aGENTNAME;
    data['ITEMNAME'] = this.iTEMNAME;
    data['CITY'] = this.cITY;
    data['TOTALMTRS'] = this.tOTALMTRS;
    data['TOTALQTY'] = this.tOTALQTY;
    data['TOTALAMT'] = this.tOTALAMT;
    data['AVGRATE'] = this.aVGRATE;
    data['TAXABLEAMT'] = this.tAXABLEAMT;
    data['GRANDTOTAL'] = this.gRANDTOTAL;
    data['PERCENTAGE'] = this.pERCENTAGE;
    return data;
  }
}
