class PartyResponseModel {
  List<Table>? table;
  List<Table1>? table1;

  PartyResponseModel({this.table, this.table1});

  PartyResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <Table>[];
      json['Table'].forEach((v) {
        table!.add(new Table.fromJson(v));
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

class Table {
  String? aCCTYPE;
  dynamic aMT;
  String? dRCR;

  Table({this.aCCTYPE, this.aMT, this.dRCR});

  Table.fromJson(Map<String, dynamic> json) {
    aCCTYPE = json['ACCTYPE'];
    aMT = json['AMT'];
    dRCR = json['DRCR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ACCTYPE'] = this.aCCTYPE;
    data['AMT'] = this.aMT;
    data['DRCR'] = this.dRCR;
    return data;
  }
}

class Table1 {
  String? dATE;
  String? aCCTYPE;
  String? bILLNO;
  String? dESC;
  dynamic aMT;
  String? dRCR;

  Table1(
      {this.dATE, this.aCCTYPE, this.bILLNO, this.dESC, this.aMT, this.dRCR});

  Table1.fromJson(Map<String, dynamic> json) {
    dATE = json['DATE'];
    aCCTYPE = json['ACCTYPE'];
    bILLNO = json['BILLNO'];
    dESC = json['DESC'];
    aMT = json['AMT'];
    dRCR = json['DRCR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DATE'] = this.dATE;
    data['ACCTYPE'] = this.aCCTYPE;
    data['BILLNO'] = this.bILLNO;
    data['DESC'] = this.dESC;
    data['AMT'] = this.aMT;
    data['DRCR'] = this.dRCR;
    return data;
  }
}
