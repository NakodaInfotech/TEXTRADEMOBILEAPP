class LedgerMainResponseModel {
  List<TableLedger>? table;

  LedgerMainResponseModel({this.table});

  LedgerMainResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <TableLedger>[];
      json['Table'].forEach((v) {
        table!.add(new TableLedger.fromJson(v));
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

class TableLedger {
  String? nAME;
  dynamic bALANCE;
  String? dRCR;
  int? lEDGERID;

  TableLedger({this.nAME, this.bALANCE, this.dRCR, this.lEDGERID});

  TableLedger.fromJson(Map<String, dynamic> json) {
    nAME = json['NAME'] == null ? json['AGENT'] : json['NAME'];
    bALANCE = json['BALANCE'];
    dRCR = json['DRCR'];
    lEDGERID = json['LEDGERID'] == null ? json['AGENTID'] : json['LEDGERID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NAME'] = this.nAME;
    data['BALANCE'] = this.bALANCE;
    data['DRCR'] = this.dRCR;
    data['LEDGERID'] = this.lEDGERID;
    return data;
  }
}
