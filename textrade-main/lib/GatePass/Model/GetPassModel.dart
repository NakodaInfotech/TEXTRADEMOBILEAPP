class GetPassListModel {
  List<Table>? _table;

  GetPassListModel({List<Table>? table}) {
    if (table != null) {
      this._table = table;
    }
  }

  List<Table>? get table => _table;

  set table(List<Table>? table) => _table = table;

  GetPassListModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      _table = <Table>[];
      json['Table'].forEach((v) {
        _table!.add(new Table.fromJson(v));
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

class Table {
  int? _tEMPENTRYNO;
  String? _dATE;
  String? _nAME;
  String? _aGENT;
  String? _tRANSPORT;
  String? _dELIVERY;
  String? _fROMCITY;
  String? _tOCITY;
  String? _rEMARKS;
  bool? _sALEDONE;
  String? _vEHICLENO;
  bool? _sENDWHATSAPP;
  double? _tOTALAMOUNT;
  bool? _PARTIALSAVE;

  Table(
      {int? tEMPENTRYNO,
      String? dATE,
      String? nAME,
      String? aGENT,
      String? tRANSPORT,
      String? dELIVERY,
      String? fROMCITY,
      String? tOCITY,
      String? rEMARKS,
      bool? sALEDONE,
      String? vEHICLENO,
      bool? sENDWHATSAPP,
      double? tOTALAMOUNT,
      bool? PARTIALSAVE}) {
    if (tEMPENTRYNO != null) {
      this._tEMPENTRYNO = tEMPENTRYNO;
    }
    if (dATE != null) {
      this._dATE = dATE;
    }
    if (nAME != null) {
      this._nAME = nAME;
    }
    if (aGENT != null) {
      this._aGENT = aGENT;
    }
    if (tRANSPORT != null) {
      this._tRANSPORT = tRANSPORT;
    }
    if (dELIVERY != null) {
      this._dELIVERY = dELIVERY;
    }
    if (fROMCITY != null) {
      this._fROMCITY = fROMCITY;
    }
    if (tOCITY != null) {
      this._tOCITY = tOCITY;
    }
    if (rEMARKS != null) {
      this._rEMARKS = rEMARKS;
    }
    if (sALEDONE != null) {
      this._sALEDONE = sALEDONE;
    }
    if (vEHICLENO != null) {
      this._vEHICLENO = vEHICLENO;
    }
    if (sENDWHATSAPP != null) {
      this._sENDWHATSAPP = sENDWHATSAPP;
    }
    if (tOTALAMOUNT != null) {
      this._tOTALAMOUNT = tOTALAMOUNT;
    }
    if (PARTIALSAVE != null) {
      this._PARTIALSAVE = PARTIALSAVE;
    }
  }

  int? get tEMPENTRYNO => _tEMPENTRYNO;

  set tEMPENTRYNO(int? tEMPENTRYNO) => _tEMPENTRYNO = tEMPENTRYNO;

  String? get dATE => _dATE;

  set dATE(String? dATE) => _dATE = dATE;

  String? get nAME => _nAME;

  set nAME(String? nAME) => _nAME = nAME;

  String? get aGENT => _aGENT;

  set aGENT(String? aGENT) => _aGENT = aGENT;

  String? get tRANSPORT => _tRANSPORT;

  set tRANSPORT(String? tRANSPORT) => _tRANSPORT = tRANSPORT;

  String? get dELIVERY => _dELIVERY;

  set dELIVERY(String? dELIVERY) => _dELIVERY = dELIVERY;

  String? get fROMCITY => _fROMCITY;

  set fROMCITY(String? fROMCITY) => _fROMCITY = fROMCITY;

  String? get tOCITY => _tOCITY;

  set tOCITY(String? tOCITY) => _tOCITY = tOCITY;

  String? get rEMARKS => _rEMARKS;

  set rEMARKS(String? rEMARKS) => _rEMARKS = rEMARKS;

  bool? get sALEDONE => _sALEDONE;

  set sALEDONE(bool? sALEDONE) => _sALEDONE = sALEDONE;

  String? get vEHICLENO => _vEHICLENO;

  set vEHICLENO(String? vEHICLENO) => _vEHICLENO = vEHICLENO;

  bool? get sENDWHATSAPP => _sENDWHATSAPP;

  set sENDWHATSAPP(bool? sENDWHATSAPP) => _sENDWHATSAPP = sENDWHATSAPP;

  double? get tOTALAMOUNT => _tOTALAMOUNT;

  set tOTALAMOUNT(double? tOTALAMOUNT) => _tOTALAMOUNT = tOTALAMOUNT;

  bool? get pPARTIALSAVE => _PARTIALSAVE;

  set PARTIALSAVE(double? PARTIALSAVE) => _PARTIALSAVE = pPARTIALSAVE;

  Table.fromJson(Map<String, dynamic> json) {
    _tEMPENTRYNO = json['TEMPENTRYNO'];
    _dATE = json['DATE'];
    _nAME = json['NAME'];
    _aGENT = json['AGENT'];
    _tRANSPORT = json['TRANSPORT'];
    _dELIVERY = json['DELIVERY'];
    _fROMCITY = json['FROMCITY'];
    _tOCITY = json['TOCITY'];
    _rEMARKS = json['REMARKS'];
    _sALEDONE = json['SALEDONE'];
    _vEHICLENO = json['VEHICLENO'];
    _sENDWHATSAPP = json['SENDWHATSAPP'];
    _tOTALAMOUNT = json['TOTALAMOUNT'];
    _PARTIALSAVE = json['PARTIALSAVE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TEMPENTRYNO'] = this._tEMPENTRYNO;
    data['DATE'] = this._dATE;
    data['NAME'] = this._nAME;
    data['AGENT'] = this._aGENT;
    data['TRANSPORT'] = this._tRANSPORT;
    data['DELIVERY'] = this._dELIVERY;
    data['FROMCITY'] = this._fROMCITY;
    data['TOCITY'] = this._tOCITY;
    data['REMARKS'] = this._rEMARKS;
    data['SALEDONE'] = this._sALEDONE;
    data['VEHICLENO'] = this._vEHICLENO;
    data['SENDWHATSAPP'] = this._sENDWHATSAPP;
    data['TOTALAMOUNT'] = this._tOTALAMOUNT;
    data['PARTIALSAVE'] = this._PARTIALSAVE;
    return data;
  }
}
