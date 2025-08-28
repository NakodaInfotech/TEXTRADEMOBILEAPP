class PurchaseOrderListModel {
  List<PurchaseOrderListTable>? table;

  PurchaseOrderListModel({this.table});

  PurchaseOrderListModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <PurchaseOrderListTable>[];
      json['Table'].forEach((v) {
        table!.add(new PurchaseOrderListTable.fromJson(v));
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

class PurchaseOrderListTable {
  int? pONO;
  String? pODATE;
  String? dELDATE;
  String? pARTYNAME;
  String? aGENTNAME;
  String? tRANSNAME;
  String? dELPERIOD;
  String? cRDAYS;
  String? aDDRESS;
  String? gSTIN;
  String? sPECIALREMARKS;
  String? uSERNAME;
  double? tOTALMTRS;
  double? dISC;
  int? yEARID;
  bool? isSelected = false;
  List<PODETAILS>? pODETAILS;

  PurchaseOrderListTable(
      {this.pONO,
      this.pODATE,
      this.dELDATE,
      this.pARTYNAME,
      this.aGENTNAME,
      this.tRANSNAME,
      this.dELPERIOD,
      this.cRDAYS,
      this.aDDRESS,
      this.gSTIN,
      this.sPECIALREMARKS,
      this.uSERNAME,
      this.tOTALMTRS,
      this.dISC,
      this.yEARID,
      this.isSelected,
      this.pODETAILS});

  PurchaseOrderListTable.fromJson(Map<String, dynamic> json) {
    pONO = json['PONO'];
    pODATE = json['PODATE'];
    dELDATE = json['DELDATE'];
    pARTYNAME = json['PARTYNAME'];
    aGENTNAME = json['AGENTNAME'];
    tRANSNAME = json['TRANSNAME'];
    dELPERIOD = json['DELPERIOD'];
    cRDAYS = json['CRDAYS'];
    aDDRESS = json['ADDRESS'];
    gSTIN = json['GSTIN'];
    sPECIALREMARKS = json['SPECIALREMARKS'];
    uSERNAME = json['USERNAME'];
    tOTALMTRS = json['TOTALMTRS'];
    dISC = json['DISC'];
    yEARID = json['YEARID'];
    isSelected = false;
    if (json['PODETAILS'] != null) {
      pODETAILS = <PODETAILS>[];
      json['PODETAILS'].forEach((v) {
        pODETAILS!.add(new PODETAILS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PONO'] = this.pONO;
    data['PODATE'] = this.pODATE;
    data['DELDATE'] = this.dELDATE;
    data['PARTYNAME'] = this.pARTYNAME;
    data['AGENTNAME'] = this.aGENTNAME;
    data['TRANSNAME'] = this.tRANSNAME;
    data['DELPERIOD'] = this.dELPERIOD;
    data['CRDAYS'] = this.cRDAYS;
    data['ADDRESS'] = this.aDDRESS;
    data['GSTIN'] = this.gSTIN;
    data['SPECIALREMARKS'] = this.sPECIALREMARKS;
    data['USERNAME'] = this.uSERNAME;
    data['TOTALMTRS'] = this.tOTALMTRS;
    data['DISC'] = this.dISC;
    data['YEARID'] = this.yEARID;
    data['isSelected'] = this.isSelected;
    if (this.pODETAILS != null) {
      data['PODETAILS'] = this.pODETAILS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PODETAILS {
  String? iTEMNAME;
  List<ITEMDETAILS>? iTEMDETAILS;

  PODETAILS({this.iTEMNAME, this.iTEMDETAILS});

  PODETAILS.fromJson(Map<String, dynamic> json) {
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
  String? rEMARKS;
  String? dYEING;
  double? aMOUNT;
  double? mTRS;
  double? rATE;

  ITEMDETAILS(
      {this.dESIGN,
      this.cOLOR,
      this.rEMARKS,
      this.dYEING,
      this.aMOUNT,
      this.mTRS,
      this.rATE});

  ITEMDETAILS.fromJson(Map<String, dynamic> json) {
    dESIGN = json['DESIGN'];
    cOLOR = json['COLOR'];
    rEMARKS = json['REMARKS'];
    dYEING = json['DYEING'];
    aMOUNT = json['AMOUNT'];
    mTRS = json['MTRS'];
    rATE = json['RATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DESIGN'] = this.dESIGN;
    data['COLOR'] = this.cOLOR;
    data['REMARKS'] = this.rEMARKS;
    data['DYEING'] = this.dYEING;
    data['AMOUNT'] = this.aMOUNT;
    data['MTRS'] = this.mTRS;
    data['RATE'] = this.rATE;
    return data;
  }
}
