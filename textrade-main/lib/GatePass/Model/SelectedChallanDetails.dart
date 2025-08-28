class GetSelectedChallanBarcodeRes {
  List<SelectedChallanTable>? table;

  GetSelectedChallanBarcodeRes({this.table});

  GetSelectedChallanBarcodeRes.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      table = <SelectedChallanTable>[];
      json.forEach((key, value) {
        value.forEach((v) {
          table!.add(new SelectedChallanTable.fromJson(v));
        });
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

class SelectedChallanTable {
  int? gDNNO;
  int? gPNO;
  String? gPDATE;
  int? tYPECHALLANNO;
  String? gDNDATE;
  String? pARTYCHALLANNO;
  String? nAME;
  String? iTEMNAME;
  String? dESIGNNO;
  String? sHADE;
  double? pCS;
  double? mTRS;
  String? gODOWN;
  int? tOTALBALES;
  double? tOTALAMT;
  String? dELIVERYAT;
  String? pONO;
  int? rATE;
  String? tRANSNAME;
  String? tOCITY;
  String? fROMTYPE;
  String? bARCODE;
  String? uNIT;
  int? cHK;
  bool? isScanned;

  SelectedChallanTable(
      {this.gDNNO,
      this.gPNO,
      this.gPDATE,
      this.tYPECHALLANNO,
      this.gDNDATE,
      this.pARTYCHALLANNO,
      this.nAME,
      this.iTEMNAME,
      this.dESIGNNO,
      this.sHADE,
      this.pCS,
      this.mTRS,
      this.gODOWN,
      this.tOTALBALES,
      this.tOTALAMT,
      this.dELIVERYAT,
      this.pONO,
      this.rATE,
      this.tRANSNAME,
      this.tOCITY,
      this.fROMTYPE,
      this.bARCODE,
      this.uNIT,
      this.cHK,
      this.isScanned});

  SelectedChallanTable.fromJson(Map<String, dynamic> json) {
    gDNNO = json['GDNNO'];
    gPNO = json['GPNO'];
    gPDATE = json['GPDATE'];
    tYPECHALLANNO = json['TYPECHALLANNO'];
    gDNDATE = json['GDNDATE'];
    pARTYCHALLANNO = json['PARTYCHALLANNO'];
    nAME = json['NAME'];
    iTEMNAME = json['ITEMNAME'];
    dESIGNNO = json['DESIGNNO'];
    sHADE = json['SHADE'];
    pCS = json['PCS'];
    mTRS = json['MTRS'];
    gODOWN = json['GODOWN'];
    tOTALBALES = json['TOTALBALES'];
    tOTALAMT = json['TOTALAMT'];
    dELIVERYAT = json['DELIVERYAT'];
    pONO = json['PONO'];
    rATE = json['RATE'];
    tRANSNAME = json['TRANSNAME'];
    tOCITY = json['TOCITY'];
    fROMTYPE = json['FROMTYPE'];
    bARCODE = json['BARCODE'];
    uNIT = json['UNIT'];
    cHK = json['CHK'];
    isScanned = json['isScanned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GDNNO'] = this.gDNNO;
    data['GPNO'] = this.gPNO;
    data['GPDATE'] = this.gPDATE;
    data['TYPECHALLANNO'] = this.tYPECHALLANNO;
    data['GDNDATE'] = this.gDNDATE;
    data['PARTYCHALLANNO'] = this.pARTYCHALLANNO;
    data['NAME'] = this.nAME;
    data['ITEMNAME'] = this.iTEMNAME;
    data['DESIGNNO'] = this.dESIGNNO;
    data['SHADE'] = this.sHADE;
    data['PCS'] = this.pCS;
    data['MTRS'] = this.mTRS;
    data['GODOWN'] = this.gODOWN;
    data['TOTALBALES'] = this.tOTALBALES;
    data['TOTALAMT'] = this.tOTALAMT;
    data['DELIVERYAT'] = this.dELIVERYAT;
    data['PONO'] = this.pONO;
    data['RATE'] = this.rATE;
    data['TRANSNAME'] = this.tRANSNAME;
    data['TOCITY'] = this.tOCITY;
    data['FROMTYPE'] = this.fROMTYPE;
    data['BARCODE'] = this.bARCODE;
    data['UNIT'] = this.uNIT;
    data['CHK'] = this.cHK;
    data['isScanned'] = this.isScanned;
    return data;
  }
}
