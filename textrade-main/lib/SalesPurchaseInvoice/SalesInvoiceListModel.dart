class SalesInvoiceListModel {
  List<SalesListTable>? table;

  SalesInvoiceListModel({this.table});

  SalesInvoiceListModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <SalesListTable>[];
      json['Table'].forEach((v) {
        table!.add(new SalesListTable.fromJson(v));
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

class SalesListTable {
  int? iNVNO;
  String? iNVDATE;
  String? pRINTINITIALS;
  String? nAME;
  String? rEGNAME;
  String? aGENTNAME;
  double? tOTALPCS;
  double? tOTALMTRS;
  String? dISPATCHTO;
  int? yEARID;
  String? cITYNAME;
  String? tRANSNAME;
  int? bALENO;
  String? cHALLANNO;
  String? cHALLANDATE;
  int? cRDAYS;
  String? dUEDATE;
  String? pARTYADD;
  String? pARTYGSTIN;
  String? pARTYSTATE;
  String? pARTYSTATEREMARK;
  String? dISPATCHADD;
  String? dISPATCHGSTIN;
  String? dISPATCHSTATE;
  String? dISPATCHSTATEREMARK;
  String? aCKNO;
  String? iRNNO;
  String? aCKDATE;
  double? tOTALWITHMATVALUE;
  double? tOTALCGSTPER;
  double? tOTALSGSTPER;
  double? tOTALIGSTPER;
  double? tOTALCGSTAMT;
  double? tOTALSGSTAMT;
  double? tOTALIGSTAMT;
  double? rOUNDOFF;
  String? iNWORDS;
  String? rEMARKS;
  String? uSERNAME;
  String? tERMSANDCONDITIONS;
  String? eWAYBILLNO;
  String? lRNO;
  String? lRDATE;
  double? tCSPER;
  double? tCSAMT;
  double? tOTALTAXAMT;
  double? gRANDTOTAL;
  String? qRCODE;
  bool? isSelected = false;
  List<INVDETAILS>? iNVDETAILS;
  List<INVCHARGES>? iNVCHARGES;

  SalesListTable(
      {this.iNVNO,
      this.iNVDATE,
      this.pRINTINITIALS,
      this.nAME,
      this.rEGNAME,
      this.aGENTNAME,
      this.tOTALPCS,
      this.tOTALMTRS,
      this.dISPATCHTO,
      this.yEARID,
      this.cITYNAME,
      this.tRANSNAME,
      this.bALENO,
      this.cHALLANNO,
      this.cHALLANDATE,
      this.cRDAYS,
      this.dUEDATE,
      this.pARTYADD,
      this.pARTYGSTIN,
      this.pARTYSTATE,
      this.pARTYSTATEREMARK,
      this.dISPATCHADD,
      this.dISPATCHGSTIN,
      this.dISPATCHSTATE,
      this.dISPATCHSTATEREMARK,
      this.aCKNO,
      this.iRNNO,
      this.aCKDATE,
      this.tOTALWITHMATVALUE,
      this.tOTALCGSTPER,
      this.tOTALSGSTPER,
      this.tOTALIGSTPER,
      this.tOTALCGSTAMT,
      this.tOTALSGSTAMT,
      this.tOTALIGSTAMT,
      this.rOUNDOFF,
      this.iNWORDS,
      this.rEMARKS,
      this.uSERNAME,
      this.tERMSANDCONDITIONS,
      this.eWAYBILLNO,
      this.lRNO,
      this.lRDATE,
      this.tCSPER,
      this.tCSAMT,
      this.tOTALTAXAMT,
      this.gRANDTOTAL,
      this.qRCODE,
      this.isSelected,
      this.iNVDETAILS,
      this.iNVCHARGES});

  SalesListTable.fromJson(Map<String, dynamic> json) {
    iNVNO = json['INVNO'];
    iNVDATE = json['INVDATE'];
    pRINTINITIALS = json['PRINTINITIALS'];
    nAME = json['NAME'];
    rEGNAME = json['REGNAME'];
    aGENTNAME = json['AGENTNAME'];
    tOTALPCS = json['TOTALPCS'];
    tOTALMTRS = json['TOTALMTRS'];
    dISPATCHTO = json['DISPATCHTO'];
    yEARID = json['YEARID'];
    cITYNAME = json['CITYNAME'];
    tRANSNAME = json['TRANSNAME'];
    bALENO = json['BALENO'];
    cHALLANNO = json['CHALLANNO'];
    cHALLANDATE = json['CHALLANDATE'];
    cRDAYS = json['CRDAYS'];
    dUEDATE = json['DUEDATE'];
    pARTYADD = json['PARTYADD'];
    pARTYGSTIN = json['PARTYGSTIN'];
    pARTYSTATE = json['PARTYSTATE'];
    pARTYSTATEREMARK = json['PARTYSTATEREMARK'];
    dISPATCHADD = json['DISPATCHADD'];
    dISPATCHGSTIN = json['DISPATCHGSTIN'];
    dISPATCHSTATE = json['DISPATCHSTATE'];
    dISPATCHSTATEREMARK = json['DISPATCHSTATEREMARK'];
    aCKNO = json['ACKNO'];
    iRNNO = json['IRNNO'];
    aCKDATE = json['ACKDATE'];
    tOTALWITHMATVALUE = json['TOTALWITHMATVALUE'];
    tOTALCGSTPER = json['TOTALCGSTPER'];
    tOTALSGSTPER = json['TOTALSGSTPER'];
    tOTALIGSTPER = json['TOTALIGSTPER'];
    tOTALCGSTAMT = json['TOTALCGSTAMT'];
    tOTALSGSTAMT = json['TOTALSGSTAMT'];
    tOTALIGSTAMT = json['TOTALIGSTAMT'];
    rOUNDOFF = json['ROUNDOFF'];
    iNWORDS = json['INWORDS'];
    rEMARKS = json['REMARKS'];
    uSERNAME = json['USERNAME'];
    tERMSANDCONDITIONS = json['TERMSANDCONDITIONS'];
    eWAYBILLNO = json['EWAYBILLNO'];
    lRNO = json['LRNO'];
    lRDATE = json['LRDATE'];
    tCSPER = json['TCSPER'];
    tCSAMT = json['TCSAMT'];
    tOTALTAXAMT = json['TOTALTAXAMT'];
    gRANDTOTAL = json['GRANDTOTAL'];
    qRCODE = json['QRCODE'];
    isSelected = false;
    if (json['INVDETAILS'] != null) {
      iNVDETAILS = <INVDETAILS>[];
      json['INVDETAILS'].forEach((v) {
        iNVDETAILS!.add(new INVDETAILS.fromJson(v));
      });
    }
    if (json['INVCHARGES'] != null) {
      iNVCHARGES = <INVCHARGES>[];
      json['INVCHARGES'].forEach((v) {
        iNVCHARGES!.add(new INVCHARGES.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['INVNO'] = this.iNVNO;
    data['INVDATE'] = this.iNVDATE;
    data['PRINTINITIALS'] = this.pRINTINITIALS;
    data['NAME'] = this.nAME;
    data['REGNAME'] = this.rEGNAME;
    data['AGENTNAME'] = this.aGENTNAME;
    data['TOTALPCS'] = this.tOTALPCS;
    data['TOTALMTRS'] = this.tOTALMTRS;
    data['DISPATCHTO'] = this.dISPATCHTO;
    data['YEARID'] = this.yEARID;
    data['CITYNAME'] = this.cITYNAME;
    data['TRANSNAME'] = this.tRANSNAME;
    data['BALENO'] = this.bALENO;
    data['CHALLANNO'] = this.cHALLANNO;
    data['CHALLANDATE'] = this.cHALLANDATE;
    data['CRDAYS'] = this.cRDAYS;
    data['DUEDATE'] = this.dUEDATE;
    data['PARTYADD'] = this.pARTYADD;
    data['PARTYGSTIN'] = this.pARTYGSTIN;
    data['PARTYSTATE'] = this.pARTYSTATE;
    data['PARTYSTATEREMARK'] = this.pARTYSTATEREMARK;
    data['DISPATCHADD'] = this.dISPATCHADD;
    data['DISPATCHGSTIN'] = this.dISPATCHGSTIN;
    data['DISPATCHSTATE'] = this.dISPATCHSTATE;
    data['DISPATCHSTATEREMARK'] = this.dISPATCHSTATEREMARK;
    data['ACKNO'] = this.aCKNO;
    data['IRNNO'] = this.iRNNO;
    data['ACKDATE'] = this.aCKDATE;
    data['TOTALWITHMATVALUE'] = this.tOTALWITHMATVALUE;
    data['TOTALCGSTPER'] = this.tOTALCGSTPER;
    data['TOTALSGSTPER'] = this.tOTALSGSTPER;
    data['TOTALIGSTPER'] = this.tOTALIGSTPER;
    data['TOTALCGSTAMT'] = this.tOTALCGSTAMT;
    data['TOTALSGSTAMT'] = this.tOTALSGSTAMT;
    data['TOTALIGSTAMT'] = this.tOTALIGSTAMT;
    data['ROUNDOFF'] = this.rOUNDOFF;
    data['INWORDS'] = this.iNWORDS;
    data['REMARKS'] = this.rEMARKS;
    data['USERNAME'] = this.uSERNAME;
    data['TERMSANDCONDITIONS'] = this.tERMSANDCONDITIONS;
    data['EWAYBILLNO'] = this.eWAYBILLNO;
    data['LRNO'] = this.lRNO;
    data['LRDATE'] = this.lRDATE;
    data['TCSPER'] = this.tCSPER;
    data['TCSAMT'] = this.tCSAMT;
    data['TOTALTAXAMT'] = this.tOTALTAXAMT;
    data['GRANDTOTAL'] = this.gRANDTOTAL;
    data['QRCODE'] = this.qRCODE;
    data['isSelected'] = this.isSelected;
    if (this.iNVDETAILS != null) {
      data['INVDETAILS'] = this.iNVDETAILS!.map((v) => v.toJson()).toList();
    }
    if (this.iNVCHARGES != null) {
      data['INVCHARGES'] = this.iNVCHARGES!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class INVDETAILS {
  String? iTEMNAME;
  String? hSN;
  String? wIDTH;
  String? dESIGN;
  String? sHADE;
  double? pCS;
  double? mTRS;
  double? rATE;
  double? aMOUNT;
  String? uOM;

  INVDETAILS(
      {this.iTEMNAME,
      this.hSN,
      this.wIDTH,
      this.dESIGN,
      this.sHADE,
      this.pCS,
      this.mTRS,
      this.rATE,
      this.aMOUNT,
      this.uOM});

  INVDETAILS.fromJson(Map<String, dynamic> json) {
    iTEMNAME = json['ITEMNAME'];
    hSN = json['HSN'];
    wIDTH = json['WIDTH'];
    dESIGN = json['DESIGN'];
    sHADE = json['SHADE'];
    pCS = json['PCS'];
    mTRS = json['MTRS'];
    rATE = json['RATE'];
    aMOUNT = json['AMOUNT'];
    uOM = json['UOM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ITEMNAME'] = this.iTEMNAME;
    data['HSN'] = this.hSN;
    data['WIDTH'] = this.wIDTH;
    data['DESIGN'] = this.dESIGN;
    data['SHADE'] = this.sHADE;
    data['PCS'] = this.pCS;
    data['MTRS'] = this.mTRS;
    data['RATE'] = this.rATE;
    data['AMOUNT'] = this.aMOUNT;
    data['UOM'] = this.uOM;
    return data;
  }
}

class INVCHARGES {
  String? cHARGES;
  double? cHARGESPER;
  double? cHARGESAMT;

  INVCHARGES({this.cHARGES, this.cHARGESPER, this.cHARGESAMT});

  INVCHARGES.fromJson(Map<String, dynamic> json) {
    cHARGES = json['CHARGES'];
    cHARGESPER = json['CHARGESPER'];
    cHARGESAMT = json['CHARGESAMT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CHARGES'] = this.cHARGES;
    data['CHARGESPER'] = this.cHARGESPER;
    data['CHARGESAMT'] = this.cHARGESAMT;
    return data;
  }
}
