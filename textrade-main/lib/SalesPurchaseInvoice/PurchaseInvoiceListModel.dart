class PurchaseInvoiceListModel {
  List<PurchaseListTable>? table;

  PurchaseInvoiceListModel({this.table});

  PurchaseInvoiceListModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <PurchaseListTable>[];
      json['Table'].forEach((v) {
        table!.add(new PurchaseListTable.fromJson(v));
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

class PurchaseListTable {
  int? pINO;
  String? pIDATE;
  String? pARTYNAME;
  String? aGENTNAME;
  String? tRANSNAME;
  double? tOTALMTRS;
  double? tOTALPCS;
  String? rEMARKS;
  double? gRANDTOTAL;
  int? yEARID;
  List<PIDETAILS>? pIDETAILS;

  PurchaseListTable(
      {this.pINO,
      this.pIDATE,
      this.pARTYNAME,
      this.aGENTNAME,
      this.tRANSNAME,
      this.tOTALMTRS,
      this.tOTALPCS,
      this.rEMARKS,
      this.gRANDTOTAL,
      this.yEARID,
      this.pIDETAILS});

  PurchaseListTable.fromJson(Map<String, dynamic> json) {
    pINO = json['PINO'];
    pIDATE = json['PIDATE'];
    pARTYNAME = json['PARTYNAME'];
    aGENTNAME = json['AGENTNAME'];
    tRANSNAME = json['TRANSNAME'];
    tOTALMTRS = json['TOTALMTRS'];
    tOTALPCS = json['TOTALPCS'];
    rEMARKS = json['REMARKS'];
    gRANDTOTAL = json['GRANDTOTAL'];
    yEARID = json['YEARID'];
    if (json['PIDETAILS'] != null) {
      pIDETAILS = <PIDETAILS>[];
      json['PIDETAILS'].forEach((v) {
        pIDETAILS!.add(new PIDETAILS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PINO'] = this.pINO;
    data['PIDATE'] = this.pIDATE;
    data['PARTYNAME'] = this.pARTYNAME;
    data['AGENTNAME'] = this.aGENTNAME;
    data['TRANSNAME'] = this.tRANSNAME;
    data['TOTALMTRS'] = this.tOTALMTRS;
    data['TOTALPCS'] = this.tOTALPCS;
    data['REMARKS'] = this.rEMARKS;
    data['GRANDTOTAL'] = this.gRANDTOTAL;
    data['YEARID'] = this.yEARID;
    if (this.pIDETAILS != null) {
      data['PIDETAILS'] = this.pIDETAILS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PIDETAILS {
  String? iTEMNAME;
  List<ITEMDETAILS>? iTEMDETAILS;

  PIDETAILS({this.iTEMNAME, this.iTEMDETAILS});

  PIDETAILS.fromJson(Map<String, dynamic> json) {
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
  double? pCS;
  double? aMOUNT;
  double? mTRS;
  double? rATE;

  ITEMDETAILS(
      {this.dESIGN, this.cOLOR, this.pCS, this.aMOUNT, this.mTRS, this.rATE});

  ITEMDETAILS.fromJson(Map<String, dynamic> json) {
    dESIGN = json['DESIGN'];
    cOLOR = json['COLOR'];
    pCS = json['PCS'];
    aMOUNT = json['AMOUNT'];
    mTRS = json['MTRS'];
    rATE = json['RATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DESIGN'] = this.dESIGN;
    data['COLOR'] = this.cOLOR;
    data['PCS'] = this.pCS;
    data['AMOUNT'] = this.aMOUNT;
    data['MTRS'] = this.mTRS;
    data['RATE'] = this.rATE;
    return data;
  }
}
