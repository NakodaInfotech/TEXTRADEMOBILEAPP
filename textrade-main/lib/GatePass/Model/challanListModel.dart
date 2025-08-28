class ChallanListModel {
  List<ChallanTable>? _table;

  ChallanListModel({List<ChallanTable>? table}) {
    if (table != null) {
      this._table = table;
    }
  }

  List<ChallanTable>? get table => _table;

  set table(List<ChallanTable>? table) => _table = table;

  ChallanListModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      _table = <ChallanTable>[];
      json['Table'].forEach((v) {
        _table!.add(new ChallanTable.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._table != null) {
      data['Table'] = this._table!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChallanTable {
  bool? _cHK;
  int? _gDNNO;
  int? _gPNO;
  String? _gPDATE;
  int? _tYPECHALLANNO;
  String? _gDNDATE;
  String? _pARTYCHALLANNO;
  String? _nAME;
  String? _iTEMNAME;
  String? _dESIGNNO;
  String? _sHADE;
  double? _pCS;
  double? _mTRS;
  String? _gODOWN;
  int? _tOTALBALES;
  double? _tOTALAMT;
  String? _dELIVERYAT;
  String? _pONO;
  dynamic _rATE;
  String? _tRANSNAME;
  String? _tOCITY;
  String? _fROMTYPE;
  bool? _isSelected = false;
  bool? _isSelectedAndDontUnselect = false;
  String? _VEHICLENO;
  bool? _CHK;
  String? _BARCODE;
  String? _TRANSPORT;

  Table(
      {bool? cHK,
      int? gDNNO,
      int? gPNO,
      String? gPDATE,
      int? tYPECHALLANNO,
      String? gDNDATE,
      String? pARTYCHALLANNO,
      String? nAME,
      String? iTEMNAME,
      String? dESIGNNO,
      String? sHADE,
      double? pCS,
      double? mTRS,
      String? gODOWN,
      int? tOTALBALES,
      double? tOTALAMT,
      String? dELIVERYAT,
      String? pONO,
      dynamic rATE,
      String? tRANSNAME,
      String? tOCITY,
      String? fROMTYPE,
      bool? isSelected,
      bool? isSelectedAndDontUnselect,
      String? VEHICLENO,
      bool? CHK,
      String? BARCODE,
      String? TRANSPORT}) {
    if (cHK != null) {
      this._cHK = cHK;
    }
    if (gDNNO != null) {
      this._gDNNO = gDNNO;
    }
    if (gPNO != null) {
      this._gPNO = gPNO;
    }
    if (gPDATE != null) {
      this._gPDATE = gPDATE;
    }
    if (tYPECHALLANNO != null) {
      this._tYPECHALLANNO = tYPECHALLANNO;
    }
    if (gDNDATE != null) {
      this._gDNDATE = gDNDATE;
    }
    if (pARTYCHALLANNO != null) {
      this._pARTYCHALLANNO = pARTYCHALLANNO;
    }
    if (nAME != null) {
      this._nAME = nAME;
    }
    if (iTEMNAME != null) {
      this._iTEMNAME = iTEMNAME;
    }
    if (dESIGNNO != null) {
      this._dESIGNNO = dESIGNNO;
    }
    if (sHADE != null) {
      this._sHADE = sHADE;
    }
    if (pCS != null) {
      this._pCS = pCS;
    }
    if (mTRS != null) {
      this._mTRS = mTRS;
    }
    if (gODOWN != null) {
      this._gODOWN = gODOWN;
    }
    if (tOTALBALES != null) {
      this._tOTALBALES = tOTALBALES;
    }
    if (tOTALAMT != null) {
      this._tOTALAMT = tOTALAMT;
    }
    if (dELIVERYAT != null) {
      this._dELIVERYAT = dELIVERYAT;
    }
    if (pONO != null) {
      this._pONO = pONO;
    }
    if (rATE != null) {
      this._rATE = rATE;
    }
    if (tRANSNAME != null) {
      this._tRANSNAME = tRANSNAME;
    }
    if (tOCITY != null) {
      this._tOCITY = tOCITY;
    }
    if (fROMTYPE != null) {
      this._fROMTYPE = fROMTYPE;
    }
    if (isSelected != null) {
      this._isSelected = isSelected;
    }
    if (isSelectedAndDontUnselect != null) {
      this._isSelectedAndDontUnselect = isSelectedAndDontUnselect;
    }
    if (VEHICLENO != null) {
      this.VEHICLENO = VEHICLENO;
    }
    if (CHK != null) {
      this.CHK = CHK;
    }
    if (BARCODE != null) {
      this.BARCODE = BARCODE;
    }
    if (TRANSPORT != null) {
      this.TRANSPORT = TRANSPORT;
    }
  }

  // bool? get cHK => _cHK;

  // set cHK(bool? cHK) => _cHK = cHK;

  int? get gDNNO => _gDNNO;

  set gDNNO(int? gDNNO) => _gDNNO = gDNNO;

  int? get gPNO => _gPNO;

  set gPNO(int? gPNO) => _gPNO = gPNO;

  String? get gPDATE => _gPDATE;

  set gPDATE(String? gPDATE) => _gPDATE = gPDATE;

  int? get tYPECHALLANNO => _tYPECHALLANNO;

  set tYPECHALLANNO(int? tYPECHALLANNO) => _tYPECHALLANNO = tYPECHALLANNO;

  String? get gDNDATE => _gDNDATE;

  set gDNDATE(String? gDNDATE) => _gDNDATE = gDNDATE;

  String? get pARTYCHALLANNO => _pARTYCHALLANNO;

  set pARTYCHALLANNO(String? pARTYCHALLANNO) =>
      _pARTYCHALLANNO = pARTYCHALLANNO;

  String? get nAME => _nAME;

  set nAME(String? nAME) => _nAME = nAME;

  String? get iTEMNAME => _iTEMNAME;

  set iTEMNAME(String? iTEMNAME) => _iTEMNAME = iTEMNAME;

  String? get dESIGNNO => _dESIGNNO;

  set dESIGNNO(String? dESIGNNO) => _dESIGNNO = dESIGNNO;

  String? get sHADE => _sHADE;

  set sHADE(String? sHADE) => _sHADE = sHADE;

  double? get pCS => _pCS;

  set pCS(double? pCS) => _pCS = pCS;

  double? get mTRS => _mTRS;

  set mTRS(double? mTRS) => _mTRS = mTRS;

  String? get gODOWN => _gODOWN;

  set gODOWN(String? gODOWN) => _gODOWN = gODOWN;

  int? get tOTALBALES => _tOTALBALES;

  set tOTALBALES(int? tOTALBALES) => _tOTALBALES = tOTALBALES;

  double? get tOTALAMT => _tOTALAMT;

  set tOTALAMT(double? tOTALAMT) => _tOTALAMT = tOTALAMT;

  String? get dELIVERYAT => _dELIVERYAT;

  set dELIVERYAT(String? dELIVERYAT) => _dELIVERYAT = dELIVERYAT;

  String? get pONO => _pONO;

  set pONO(String? pONO) => _pONO = pONO;

  dynamic get rATE => _rATE;

  set rATE(dynamic rATE) => _rATE = rATE;

  String? get tRANSNAME => _tRANSNAME;

  set tRANSNAME(String? tRANSNAME) => _tRANSNAME = tRANSNAME;

  String? get tOCITY => _tOCITY;

  set tOCITY(String? tOCITY) => _tOCITY = tOCITY;

  String? get fROMTYPE => _fROMTYPE;

  set fROMTYPE(String? fROMTYPE) => _fROMTYPE = fROMTYPE;

  bool? get isSelected => _isSelected;

  set isSelected(bool? isSelected) => _isSelected = isSelected;

  bool? get isSelectedAndDontUnselect => _isSelectedAndDontUnselect;

  set isSelectedAndDontUnselect(bool? isSelectedAndDontUnselect) =>
      _isSelectedAndDontUnselect = isSelectedAndDontUnselect;

  String? get VEHICLENO => _VEHICLENO;

  set VEHICLENO(String? VEHICLENO) => _VEHICLENO = VEHICLENO;

  bool? get CHK => _CHK;

  set CHK(bool? CHK) => _CHK = CHK;

  String? get BARCODE => _BARCODE;

  set BARCODE(String? BARCODE) => _BARCODE = BARCODE;

  String? get TRANSPORT => _TRANSPORT;

  set TRANSPORT(String? TRANSPORT) => _TRANSPORT = TRANSPORT;

  ChallanTable.fromJson(Map<String, dynamic> json) {
    _cHK = json['CHK'];
    _gDNNO = json['GDNNO'];
    _gPNO = json['GPNO'];
    _gPDATE = json['GPDATE'];
    _tYPECHALLANNO = json['TYPECHALLANNO'];
    _gDNDATE = json['GDNDATE'];
    _pARTYCHALLANNO = json['PARTYCHALLANNO'];
    _nAME = json['NAME'];
    _iTEMNAME = json['ITEMNAME'];
    _dESIGNNO = json['DESIGNNO'];
    _sHADE = json['SHADE'];
    _pCS = json['PCS'];
    _mTRS = json['MTRS'];
    _gODOWN = json['GODOWN'];
    _tOTALBALES = json['TOTALBALES'];
    _tOTALAMT = json['TOTALAMT'];
    _dELIVERYAT = json['DELIVERYAT'];
    _pONO = json['PONO'];
    _rATE = json['RATE'];
    _tRANSNAME = json['TRANSNAME'];
    _tOCITY = json['TOCITY'];
    _fROMTYPE = json['FROMTYPE'];
    isSelected = false;
    _isSelectedAndDontUnselect = false;
    _VEHICLENO = json['VEHICLENO'];
    _CHK = json['CHK'];
    _BARCODE = json['BARCODE'];
    _TRANSPORT = json['TRANSPORT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CHK'] = this._cHK;
    data['GDNNO'] = this._gDNNO;
    data['GPNO'] = this._gPNO;
    data['GPDATE'] = this._gPDATE;
    data['TYPECHALLANNO'] = this._tYPECHALLANNO;
    data['GDNDATE'] = this._gDNDATE;
    data['PARTYCHALLANNO'] = this._pARTYCHALLANNO;
    data['NAME'] = this._nAME;
    data['ITEMNAME'] = this._iTEMNAME;
    data['DESIGNNO'] = this._dESIGNNO;
    data['SHADE'] = this._sHADE;
    data['PCS'] = this._pCS;
    data['MTRS'] = this._mTRS;
    data['GODOWN'] = this._gODOWN;
    data['TOTALBALES'] = this._tOTALBALES;
    data['TOTALAMT'] = this._tOTALAMT;
    data['DELIVERYAT'] = this._dELIVERYAT;
    data['PONO'] = this._pONO;
    data['RATE'] = this._rATE;
    data['TRANSNAME'] = this._tRANSNAME;
    data['TOCITY'] = this._tOCITY;
    data['FROMTYPE'] = this._fROMTYPE;
    data['isSelected'] = this._isSelected;
    data['isSelectedAndDontUnselect'] = this._isSelectedAndDontUnselect;
    data['VEHICLENO'] = this._VEHICLENO;
    data['CHK'] = this._CHK;
    data['BARCODE'] = this._BARCODE;
    data['TRANSPORT'] = this._TRANSPORT;
    return data;
  }
}
