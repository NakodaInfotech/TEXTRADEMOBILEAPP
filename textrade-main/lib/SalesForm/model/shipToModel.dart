class ShiptoReqModel {
  String? sHIPTOID;
  String? yEARID;
  String? nameId;

  ShiptoReqModel({this.sHIPTOID, this.yEARID, this.nameId});

  ShiptoReqModel.fromJson(Map<String, dynamic> json) {
    sHIPTOID = json['SHIPTOID'];
    yEARID = json['YEARID'];
    nameId = json['NAMEID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SHIPTOID'] = this.sHIPTOID;
    data['YEARID'] = this.yEARID;
    data['NAMEID'] = this.nameId;
    return data;
  }
}

class ShiptoResModel {
  List<Table>? table;

  ShiptoResModel({this.table});

  ShiptoResModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <Table>[];
      json['Table'].forEach((v) {
        table!.add(new Table.fromJson(v));
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

class Table {
  int? cITYID;
  String? cITY;
  int? tRANSID;
  String? tRANSNAME;

  Table({this.cITYID, this.cITY, this.tRANSID, this.tRANSNAME});

  Table.fromJson(Map<String, dynamic> json) {
    cITYID = json['CITYID'];
    cITY = json['CITY'];
    tRANSID = json['TRANSID'];
    tRANSNAME = json['TRANSNAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CITYID'] = this.cITYID;
    data['CITY'] = this.cITY;
    data['TRANSID'] = this.tRANSID;
    data['TRANSNAME'] = this.tRANSNAME;
    return data;
  }
}
