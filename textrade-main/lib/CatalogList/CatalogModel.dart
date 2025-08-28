class CatalogModel {
  List<CatalogTable>? table;

  CatalogModel({this.table});

  CatalogModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <CatalogTable>[];
      json['Table'].forEach((v) {
        table!.add(new CatalogTable.fromJson(v));
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

class CatalogTable {
  bool? cHK;
  String? iTEMNAME;
  String? dESIGNNO;
  String? cOLOR;
  int? cATALOGNO;
  String? fILENAME;
  bool? isSelected;

  CatalogTable(
      {this.cHK,
      this.iTEMNAME,
      this.dESIGNNO,
      this.cOLOR,
      this.cATALOGNO,
      this.fILENAME,
      this.isSelected});

  CatalogTable.fromJson(Map<String, dynamic> json) {
    cHK = json['CHK'];
    iTEMNAME = json['ITEMNAME'];
    dESIGNNO = json['DESIGNNO'];
    cOLOR = json['COLOR'];
    cATALOGNO = json['CATALOGNO'];
    fILENAME = json['FILENAME'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CHK'] = this.cHK;
    data['ITEMNAME'] = this.iTEMNAME;
    data['DESIGNNO'] = this.dESIGNNO;
    data['COLOR'] = this.cOLOR;
    data['CATALOGNO'] = this.cATALOGNO;
    data['FILENAME'] = this.fILENAME;
    return data;
  }
}
