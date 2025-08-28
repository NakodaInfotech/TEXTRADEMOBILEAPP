class ItemDetailsResponseModel {
  List<Table>? table;
  List<Table1>? table1;
  List<Table2>? table2;
  List<Table3>? table3;
  List<Table4>? table4;
  List<Table5>? table5;

  ItemDetailsResponseModel(
      {this.table,
      this.table1,
      this.table2,
      this.table3,
      this.table4,
      this.table5});

  ItemDetailsResponseModel.fromJson(Map<String, dynamic> json) {
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
    if (json['Table2'] != null) {
      table2 = <Table2>[];
      json['Table2'].forEach((v) {
        table2!.add(new Table2.fromJson(v));
      });
    }
    if (json['Table3'] != null) {
      table3 = <Table3>[];
      json['Table3'].forEach((v) {
        table3!.add(new Table3.fromJson(v));
      });
    }
    if (json['Table4'] != null) {
      table4 = <Table4>[];
      json['Table4'].forEach((v) {
        table4!.add(new Table4.fromJson(v));
      });
    }
    if (json['Table5'] != null) {
      table5 = <Table5>[];
      json['Table5'].forEach((v) {
        table5!.add(new Table5.fromJson(v));
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
    if (this.table2 != null) {
      data['Table2'] = this.table2!.map((v) => v.toJson()).toList();
    }
    if (this.table3 != null) {
      data['Table3'] = this.table3!.map((v) => v.toJson()).toList();
    }
    if (this.table4 != null) {
      data['Table4'] = this.table4!.map((v) => v.toJson()).toList();
    }
    if (this.table5 != null) {
      data['Table5'] = this.table5!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Table {
  dynamic pCS;
  dynamic mTRS;

  Table({this.pCS, this.mTRS});

  Table.fromJson(Map<String, dynamic> json) {
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

class Table1 {
  String? sALEMONTH;
  double? sALEMTRS;

  Table1({this.sALEMONTH, this.sALEMTRS});

  Table1.fromJson(Map<String, dynamic> json) {
    sALEMONTH = json['SALEMONTH'];
    sALEMTRS = json['SALEMTRS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SALEMONTH'] = this.sALEMONTH;
    data['SALEMTRS'] = this.sALEMTRS;
    return data;
  }
}

class Table2 {
  String? pURMONTH;
  double? pURMTRS;

  Table2({this.pURMONTH, this.pURMTRS});

  Table2.fromJson(Map<String, dynamic> json) {
    pURMONTH = json['PURMONTH'];
    pURMTRS = json['PURMTRS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PURMONTH'] = this.pURMONTH;
    data['PURMTRS'] = this.pURMTRS;
    return data;
  }
}

class Table3 {
  String? oRDERNAME;
  double? oRDERMTRS;

  Table3({this.oRDERNAME, this.oRDERMTRS});

  Table3.fromJson(Map<String, dynamic> json) {
    oRDERNAME = json['ORDERNAME'];
    oRDERMTRS = json['ORDERMTRS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ORDERNAME'] = this.oRDERNAME;
    data['ORDERMTRS'] = this.oRDERMTRS;
    return data;
  }
}

class Table4 {
  String? cUSNAME;
  double? cUSMTRS;

  Table4({this.cUSNAME, this.cUSMTRS});

  Table4.fromJson(Map<String, dynamic> json) {
    cUSNAME = json['CUSNAME'];
    cUSMTRS = json['CUSMTRS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CUSNAME'] = this.cUSNAME;
    data['CUSMTRS'] = this.cUSMTRS;
    return data;
  }
}

class Table5 {
  String? sUPPNAME;
  double? sUPPMTRS;

  Table5({this.sUPPNAME, this.sUPPMTRS});

  Table5.fromJson(Map<String, dynamic> json) {
    sUPPNAME = json['SUPPNAME'];
    sUPPMTRS = json['SUPPMTRS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SUPPNAME'] = this.sUPPNAME;
    data['SUPPMTRS'] = this.sUPPMTRS;
    return data;
  }
}
