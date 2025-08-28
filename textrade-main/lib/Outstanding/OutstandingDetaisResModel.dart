class OutstandingDetailResModel {
  List<OutTable>? table;
  List<Table1>? table1;

  OutstandingDetailResModel({this.table});

  OutstandingDetailResModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <OutTable>[];
      json['Table'].forEach((v) {
        table!.add(new OutTable.fromJson(v));
      });
    }
    if (json['Table1'] != null) {
      table1 = <Table1>[];
      json['Table1'].forEach((v) {
        table1!.add(new Table1.fromJson(v));
      });
    }
  }
}

class OutTable {
  String? nAME;
  String? dATE;
  String? tYPE;
  String? bILLINITIALS;
  String? aGENT;
  double? bILLAMT;
  double? rECDAMT;
  double? bALANCE;
  int? dAYS;

  OutTable(
      {this.nAME,
      this.dATE,
      this.tYPE,
      this.bILLINITIALS,
      this.aGENT,
      this.bILLAMT,
      this.rECDAMT,
      this.bALANCE,
      this.dAYS});

  OutTable.fromJson(Map<String, dynamic> json) {
    nAME = json['NAME'];
    dATE = json['DATE'];
    tYPE = json['TYPE'];
    bILLINITIALS = json['BILLINITIALS'];
    aGENT = json['AGENT'];
    bILLAMT = json['BILLAMT'];
    rECDAMT = json['RECDAMT'];
    bALANCE = json['BALANCE'];
    dAYS = json['DAYS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nAME != null) {
      data['NAME'] = this.nAME;
    }
    if (this.dATE != null) {
      data['DATE'] = this.dATE;
    }
    if (this.tYPE != null) {
      data['TYPE'] = this.tYPE;
    }
    if (this.bILLINITIALS != null) {
      data['BILLINITIALS'] = this.bILLINITIALS;
    }
    if (this.aGENT != null) {
      data['AGENT'] = this.aGENT;
    }
    if (this.bILLAMT != null) {
      data['BILLAMT'] = this.bILLAMT;
    }
    if (this.rECDAMT != null) {
      data['RECDAMT'] = this.rECDAMT;
    }
    if (this.bALANCE != null) {
      data['BALANCE'] = this.bALANCE;
    }
    if (this.dAYS != null) {
      data['DAYS'] = this.dAYS;
    }
    return data;
  }
}

class Table1 {
  double? TOTALBILLAMT;
  double? TOTALRECDAMT;
  double? TOTALBALANCE;

  Table1({this.TOTALBILLAMT, this.TOTALRECDAMT, this.TOTALBALANCE});

  Table1.fromJson(Map<String, dynamic> json) {
    TOTALBILLAMT = json['TOTALBILLAMT'];
    TOTALRECDAMT = json['TOTALRECDAMT'];
    TOTALBALANCE = json['TOTALBALANCE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TOTALBILLAMT'] = this.TOTALBILLAMT;
    data['TOTALRECDAMT'] = this.TOTALRECDAMT;
    data['TOTALBALANCE'] = this.TOTALBALANCE;
    return data;
  }
}
