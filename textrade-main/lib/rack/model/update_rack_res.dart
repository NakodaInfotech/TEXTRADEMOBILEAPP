class UpadateRackModel {
  String? rACKID;
  String? bARCODE;
  String? cMPID;
  String? uSERID;
  String? yEARID;

  UpadateRackModel(
      {this.rACKID, this.bARCODE, this.cMPID, this.uSERID, this.yEARID});

  UpadateRackModel.fromJson(Map<String, dynamic> json) {
    rACKID = json['RACKID'];
    bARCODE = json['BARCODE'];
    cMPID = json['CMPID'];
    uSERID = json['USERID'];
    yEARID = json['YEARID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RACKID'] = this.rACKID;
    data['BARCODE'] = this.bARCODE;
    data['CMPID'] = this.cMPID;
    data['USERID'] = this.uSERID;
    data['YEARID'] = this.yEARID;
    return data;
  }
}

class UpdateStockTacking {
  String? rACKID;
  String? bARCODE;
  String? cMPID;
  String? uSERID;
  String? remark;
  String? yEARID;

  UpdateStockTacking(
      {this.rACKID,
      this.bARCODE,
      this.cMPID,
      this.uSERID,
      this.yEARID,
      this.remark});

  UpdateStockTacking.fromJson(Map<String, dynamic> json) {
    rACKID = json['RACKID'];
    bARCODE = json['BARCODE'];
    cMPID = json['CMPID'];
    uSERID = json['USERID'];
    yEARID = json['YEARID'];
    remark = json['REMARK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RACKID'] = this.rACKID;
    data['BARCODE'] = this.bARCODE;
    data['CMPID'] = this.cMPID;
    data['USERID'] = this.uSERID;
    data['YEARID'] = this.yEARID;
    data['REMARK'] = this.remark;
    return data;
  }
}

class UpadateRackResModel {
  List<UpdateRackResTable>? table;

  UpadateRackResModel({this.table});

  UpadateRackResModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <UpdateRackResTable>[];
      json['Table'].forEach((v) {
        table!.add(new UpdateRackResTable.fromJson(v));
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

class UpdateRackResTable {
  bool? column1;
  String? column2;

  UpdateRackResTable({this.column1, this.column2});

  UpdateRackResTable.fromJson(Map<String, dynamic> json) {
    column1 = json['Column1'];
    column2 = json['Column2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Column1'] = this.column1;
    data['Column2'] = this.column2;
    return data;
  }
}
