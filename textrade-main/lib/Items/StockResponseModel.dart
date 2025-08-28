class StockResponseModel {
  List<ItemTable>? table;
  List<Table1>? table1;

  StockResponseModel({this.table, this.table1});

  StockResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <ItemTable>[];
      json['Table'].forEach((v) {
        table!.add(new ItemTable.fromJson(v));
      });
    }
    if (json['Table1'] != null) {
      table1 = <Table1>[];
      json['Table1'].forEach((v) {
        table1!.add(new Table1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table != null) {
      data['Table'] = this.table!.map((v) => v.toJson()).toList();
    }
    if (this.table1 != null) {
      data['Table1'] = this.table1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemTable {
  String? pIECETYPE;
  String? iTEMNAME;
  String? dESIGNNO;
  String? cOLOR;
  String? uNIT;
  String? gODOWN;
  double? pCS;
  double? mTRS;
  double? sumPcs;
  double? sumMtrs;
  int? iTEMID;
  int? dESIGNID;
  int? cOLORID;
  int? id;

  ItemTable(
      {this.pIECETYPE,
      this.iTEMNAME,
      this.dESIGNNO,
      this.cOLOR,
      this.uNIT,
      this.gODOWN,
      this.pCS,
      this.mTRS,
      this.iTEMID,
      this.dESIGNID,
      this.cOLORID,
      this.id});

  ItemTable.fromJson(Map<String, dynamic> json) {
    pIECETYPE = json['PIECETYPE'];
    iTEMNAME = json['ITEMNAME'];
    dESIGNNO = json['DESIGNNO'];
    cOLOR = json['COLOR'];
    uNIT = json['UNIT'];
    gODOWN = json['GODOWN'];
    pCS = json['PCS'];
    mTRS = json['MTRS'];
    iTEMID = json['ITEMID'];
    dESIGNID = json['DESIGNID'];
    cOLORID = json['COLORID'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PIECETYPE'] = this.pIECETYPE;
    data['ITEMNAME'] = this.iTEMNAME;
    data['DESIGNNO'] = this.dESIGNNO;
    data['COLOR'] = this.cOLOR;
    data['UNIT'] = this.uNIT;
    data['GODOWN'] = this.gODOWN;
    data['PCS'] = this.pCS;
    data['MTRS'] = this.mTRS;
    data['ITEMID'] = this.iTEMID;
    data['DESIGNID'] = this.dESIGNID;
    data['COLORID'] = this.cOLORID;
    data['id'] = this.id;
    return data;
  }
}

class Table1 {
  dynamic pCS;
  dynamic mTRS;

  Table1({this.pCS, this.mTRS});

  Table1.fromJson(Map<String, dynamic> json) {
    pCS = json['PCS'];
    mTRS = json['MTRS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PCS'] = this.pCS;
    data['MTRS'] = this.mTRS;
    return data;
  }
}
