import 'dart:ffi';

class ChallanGDNModel {
  List<ChallanTableList>? table;

  ChallanGDNModel({this.table});

  ChallanGDNModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <ChallanTableList>[];
      json['Table'].forEach((v) {
        table!.add(new ChallanTableList.fromJson(v));
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

class ChallanTableList {
  int? gDNNO;
  String? dATE;
  String? nAME;
  String? aGENT;
  double? tOTALPCS;
  double? tOTALMTRS;
  String? dISPATCHTO;
  int? yEARID;
  String? cITYNAME;
  String? tRANSNAME;
  int? bALENO;
  String? pARTYADD;
  String? pARTYGSTIN;
  String? pARTYSTATE;
  String? pARTYSTATEREMARK;
  String? dISPATCHADD;
  String? dISPATCHGSTIN;
  String? dISPATCHSTATE;
  String? dISPATCHSTATEREMARK;
  String? uSERNAME;
  String? tERMSANDCONDITIONS;
  bool? isSelected = false;
  List<GDNDETAILS>? gDNDETAILS;

  ChallanTableList(
      {this.gDNNO,
      this.dATE,
      this.nAME,
      this.aGENT,
      this.tOTALPCS,
      this.tOTALMTRS,
      this.dISPATCHTO,
      this.yEARID,
      this.cITYNAME,
      this.tRANSNAME,
      this.bALENO,
      this.pARTYADD,
      this.pARTYGSTIN,
      this.pARTYSTATE,
      this.pARTYSTATEREMARK,
      this.dISPATCHADD,
      this.dISPATCHGSTIN,
      this.dISPATCHSTATE,
      this.dISPATCHSTATEREMARK,
      this.uSERNAME,
      this.tERMSANDCONDITIONS,
      this.isSelected,
      this.gDNDETAILS});

  ChallanTableList.fromJson(Map<String, dynamic> json) {
    gDNNO = json['GDNNO'];
    dATE = json['DATE'];
    nAME = json['NAME'];
    aGENT = json['AGENT'];
    tOTALPCS = json['TOTALPCS'];
    tOTALMTRS = json['TOTALMTRS'];
    dISPATCHTO = json['DISPATCHTO'];
    yEARID = json['YEARID'];
    cITYNAME = json['CITYNAME'];
    tRANSNAME = json['TRANSNAME'];
    bALENO = json['BALENO'];
    pARTYADD = json['PARTYADD'];
    pARTYGSTIN = json['PARTYGSTIN'];
    pARTYSTATE = json['PARTYSTATE'];
    pARTYSTATEREMARK = json['PARTYSTATEREMARK'];
    dISPATCHADD = json['DISPATCHADD'];
    dISPATCHGSTIN = json['DISPATCHGSTIN'];
    dISPATCHSTATE = json['DISPATCHSTATE'];
    dISPATCHSTATEREMARK = json['DISPATCHSTATEREMARK'];
    uSERNAME = json['USERNAME'];
    tERMSANDCONDITIONS = json['TERMSANDCONDITIONS'];
    isSelected = false;
    if (json['GDNDETAILS'] != null) {
      gDNDETAILS = <GDNDETAILS>[];
      json['GDNDETAILS'].forEach((v) {
        gDNDETAILS!.add(new GDNDETAILS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GDNNO'] = this.gDNNO;
    data['DATE'] = this.dATE;
    data['NAME'] = this.nAME;
    data['AGENT'] = this.aGENT;
    data['TOTALPCS'] = this.tOTALPCS;
    data['TOTALMTRS'] = this.tOTALMTRS;
    data['DISPATCHTO'] = this.dISPATCHTO;
    data['YEARID'] = this.yEARID;
    data['CITYNAME'] = this.cITYNAME;
    data['TRANSNAME'] = this.tRANSNAME;
    data['BALENO'] = this.bALENO;
    data['PARTYADD'] = this.pARTYADD;
    data['PARTYGSTIN'] = this.pARTYGSTIN;
    data['PARTYSTATE'] = this.pARTYSTATE;
    data['PARTYSTATEREMARK'] = this.pARTYSTATEREMARK;
    data['DISPATCHADD'] = this.dISPATCHADD;
    data['DISPATCHGSTIN'] = this.dISPATCHGSTIN;
    data['DISPATCHSTATE'] = this.dISPATCHSTATE;
    data['DISPATCHSTATEREMARK'] = this.dISPATCHSTATEREMARK;
    data['USERNAME'] = this.uSERNAME;
    data['TERMSANDCONDITIONS'] = this.tERMSANDCONDITIONS;
    data['isSelected'] = this.isSelected;
    if (this.gDNDETAILS != null) {
      data['GDNDETAILS'] = this.gDNDETAILS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GDNDETAILS {
  String? iTEMNAME;
  String? hSN;
  String? wIDTH;
  List<ITEMDETAILS>? iTEMDETAILS;

  GDNDETAILS({this.iTEMNAME, this.hSN, this.wIDTH, this.iTEMDETAILS});

  GDNDETAILS.fromJson(Map<String, dynamic> json) {
    iTEMNAME = json['ITEMNAME'];
    hSN = json['HSN'];
    wIDTH = json['WIDTH'];
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
    data['HSN'] = this.hSN;
    data['WIDTH'] = this.wIDTH;
    if (this.iTEMDETAILS != null) {
      data['ITEMDETAILS'] = this.iTEMDETAILS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ITEMDETAILS {
  String? dESIGN;
  String? sHADE;
  String? cUTSTEMP = "";
  double? pCS;
  double? cUTS;
  double? mTRS;
  double? rATE;
  String? bARCODE;

  ITEMDETAILS(
      {this.dESIGN,
      this.sHADE,
      this.pCS,
      this.cUTSTEMP,
      this.cUTS,
      this.mTRS,
      this.rATE,
      this.bARCODE});

  ITEMDETAILS.fromJson(Map<String, dynamic> json) {
    dESIGN = json['DESIGN'];
    sHADE = json['SHADE'];
    pCS = json['PCS'];
    cUTSTEMP = "";
    cUTS = json['CUTS'];
    mTRS = json['MTRS'];
    rATE = json['RATE'];
    bARCODE = json['BARCODE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DESIGN'] = this.dESIGN;
    data['SHADE'] = this.sHADE;
    data['cUTSTEMP'] = this.cUTSTEMP;
    data['CUTS'] = this.cUTS;
    data['PCS'] = this.pCS;
    data['MTRS'] = this.mTRS;
    data['RATE'] = this.rATE;
    data['BARCODE'] = this.bARCODE;
    return data;
  }
}
