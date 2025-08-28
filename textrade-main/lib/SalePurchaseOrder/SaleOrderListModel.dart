class SaleOrderListModel {
  List<SaleOrderListTable>? table;

  SaleOrderListModel({this.table});

  SaleOrderListModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <SaleOrderListTable>[];
      json['Table'].forEach((v) {
        table!.add(new SaleOrderListTable.fromJson(v));
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

class SaleOrderListTable {
  int? sONO;
  String? sODATE;
  String? dELDATE;
  String? pARTYNAME;
  String? aGENTNAME;
  String? tRANSNAME;
  String? cITY;
  String? pARTYPONO;
  String? cRDAYS;
  String? aDDRESS;
  String? gSTIN;
  String? sPECIALREMARKS;
  String? uSERNAME;
  String? sHIPTO;
  double? tOTALQTY;
  double? tOTALMTRS;
  int? yEARID;
  bool? isSelected = false;
  List<SODETAILS>? sODETAILS;

  SaleOrderListTable(
      {this.sONO,
      this.sODATE,
      this.dELDATE,
      this.pARTYNAME,
      this.aGENTNAME,
      this.tRANSNAME,
      this.cITY,
      this.pARTYPONO,
      this.cRDAYS,
      this.aDDRESS,
      this.gSTIN,
      this.sPECIALREMARKS,
      this.uSERNAME,
      this.sHIPTO,
      this.tOTALQTY,
      this.tOTALMTRS,
      this.yEARID,
      this.sODETAILS,
      this.isSelected});

  SaleOrderListTable.fromJson(Map<String, dynamic> json) {
    sONO = json['SONO'];
    sODATE = json['SODATE'];
    dELDATE = json['DELDATE'];
    pARTYNAME = json['PARTYNAME'];
    aGENTNAME = json['AGENTNAME'];
    tRANSNAME = json['TRANSNAME'];
    cITY = json['CITY'];
    pARTYPONO = json['PARTYPONO'];
    cRDAYS = json['CRDAYS'];
    aDDRESS = json['ADDRESS'];
    gSTIN = json['GSTIN'];
    sPECIALREMARKS = json['SPECIALREMARKS'];
    uSERNAME = json['USERNAME'];
    sHIPTO = json['SHIPTO'];
    tOTALQTY = json['TOTALQTY'];
    tOTALMTRS = json['TOTALMTRS'];
    yEARID = json['YEARID'];
    isSelected = false;
    if (json['SODETAILS'] != null) {
      sODETAILS = <SODETAILS>[];
      json['SODETAILS'].forEach((v) {
        sODETAILS!.add(new SODETAILS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SONO'] = this.sONO;
    data['SODATE'] = this.sODATE;
    data['DELDATE'] = this.dELDATE;
    data['PARTYNAME'] = this.pARTYNAME;
    data['AGENTNAME'] = this.aGENTNAME;
    data['TRANSNAME'] = this.tRANSNAME;
    data['CITY'] = this.cITY;
    data['PARTYPONO'] = this.pARTYPONO;
    data['CRDAYS'] = this.cRDAYS;
    data['ADDRESS'] = this.aDDRESS;
    data['GSTIN'] = this.gSTIN;
    data['SPECIALREMARKS'] = this.sPECIALREMARKS;
    data['USERNAME'] = this.uSERNAME;
    data['SHIPTO'] = this.sHIPTO;
    data['TOTALQTY'] = this.tOTALQTY;
    data['TOTALMTRS'] = this.tOTALMTRS;
    data['YEARID'] = this.yEARID;
    data['isSelected'] = this.isSelected;
    if (this.sODETAILS != null) {
      data['SODETAILS'] = this.sODETAILS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SODETAILS {
  String? iTEMNAME;
  List<ITEMDETAILS>? iTEMDETAILS;

  SODETAILS({this.iTEMNAME, this.iTEMDETAILS});

  SODETAILS.fromJson(Map<String, dynamic> json) {
    iTEMNAME = json['ITEMNAME'];
    if (json['ITEMDETAILS'] != null) {
      iTEMDETAILS = <ITEMDETAILS>[];
      json['ITEMDETAILS'].forEach((v) {
        iTEMDETAILS!.add(new ITEMDETAILS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ITEMNAME'] = this.iTEMNAME;
    if (this.iTEMDETAILS != null) {
      data['ITEMDETAILS'] = this.iTEMDETAILS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ITEMDETAILS {
  String? dESIGN;
  String? cOLOR;
  double? qTY;
  double? mTRS;
  double? rATE;
  double? aMOUNT;
  String? uNIT;
  String? rEMARK;
  double? cUT;

  ITEMDETAILS(
      {this.dESIGN,
      this.cOLOR,
      this.qTY,
      this.mTRS,
      this.rATE,
      this.aMOUNT,
      this.uNIT,
      this.rEMARK,
      this.cUT});

  ITEMDETAILS.fromJson(Map<String, dynamic> json) {
    dESIGN = json['DESIGN'];
    cOLOR = json['COLOR'];
    qTY = json['QTY'];
    mTRS = json['MTRS'];
    rATE = json['RATE'];
    aMOUNT = json['AMOUNT'];
    uNIT = json['UNIT'];
    rEMARK = json['REMARK'];
    cUT = json['CUT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DESIGN'] = this.dESIGN;
    data['COLOR'] = this.cOLOR;
    data['QTY'] = this.qTY;
    data['MTRS'] = this.mTRS;
    data['RATE'] = this.rATE;
    data['AMOUNT'] = this.aMOUNT;
    data['UNIT'] = this.uNIT;
    data['REMARK'] = this.rEMARK;
    data['CUT'] = this.cUT;
    return data;
  }
}
