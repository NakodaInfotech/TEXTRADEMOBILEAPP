class SalesOrderRequest {
  String? dATE;
  String? nAMEID;
  String? sHIPTOID;
  String? aGENTID;
  String? tRANSID;
  String? cITYID;
  String? cMPID;
  String? uSERID;
  String? yearID;
  String? iTEMNAME;
  String? dESIGNNAME;
  String? cOLOR;
  String? gRIDREMARKS;
  String? qTY;
  String? mTRS;
  String? rATE;

  SalesOrderRequest(
      {this.dATE,
      this.nAMEID,
      this.sHIPTOID,
      this.aGENTID,
      this.tRANSID,
      this.cITYID,
      this.cMPID,
      this.uSERID,
      this.yearID,
      this.iTEMNAME,
      this.dESIGNNAME,
      this.cOLOR,
      this.gRIDREMARKS,
      this.qTY,
      this.mTRS,
      this.rATE});

  SalesOrderRequest.fromJson(Map<String, dynamic> json) {
    dATE = json['DATE'];
    nAMEID = json['NAMEID'];
    sHIPTOID = json['SHIPTOID'];
    aGENTID = json['AGENTID'];
    tRANSID = json['TRANSID'];
    cITYID = json['CITYID'];
    cMPID = json['CMPID'];
    uSERID = json['USERID'];
    yearID = json['YearID'];
    iTEMNAME = json['ITEMNAME'];
    dESIGNNAME = json['DESIGNNAME'];
    cOLOR = json['COLOR'];
    gRIDREMARKS = json['GRIDREMARKS'];
    qTY = json['QTY'];
    mTRS = json['MTRS'];
    rATE = json['RATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DATE'] = this.dATE;
    data['NAMEID'] = this.nAMEID;
    data['SHIPTOID'] = this.sHIPTOID;
    data['AGENTID'] = this.aGENTID;
    data['TRANSID'] = this.tRANSID;
    data['CITYID'] = this.cITYID;
    data['CMPID'] = this.cMPID;
    data['USERID'] = this.uSERID;
    data['YearID'] = this.yearID;
    data['ITEMNAME'] = this.iTEMNAME;
    data['DESIGNNAME'] = this.dESIGNNAME;
    data['COLOR'] = this.cOLOR;
    data['GRIDREMARKS'] = this.gRIDREMARKS;
    data['QTY'] = this.qTY;
    data['MTRS'] = this.mTRS;
    data['RATE'] = this.rATE;
    return data;
  }
}

class SaleOrderRes {
  List<SalesTable>? table;

  SaleOrderRes({this.table});

  SaleOrderRes.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <SalesTable>[];
      json['Table'].forEach((v) {
        table!.add(new SalesTable.fromJson(v));
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

class SalesTable {
  String? column1;

  SalesTable({this.column1});

  SalesTable.fromJson(Map<String, dynamic> json) {
    column1 = json['Column1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Column1'] = this.column1;
    return data;
  }
}
