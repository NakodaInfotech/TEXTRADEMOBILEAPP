class PartyDetailRes {
  List<PartyDetailTable>? table;

  PartyDetailRes({this.table});

  PartyDetailRes.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <PartyDetailTable>[];
      json['Table'].forEach((v) {
        table!.add(new PartyDetailTable.fromJson(v));
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

class PartyDetailTable {
  int? sHIPTOID;
  String? sHIPTO;
  int? cITYID;
  String? cITY;
  int? tRANSID;
  String? tRANSNAME;
  int? aGENTID;
  String? aGENTNAME;

  PartyDetailTable(
      {this.sHIPTOID,
      this.sHIPTO,
      this.cITYID,
      this.cITY,
      this.tRANSID,
      this.tRANSNAME,
      this.aGENTID,
      this.aGENTNAME});

  PartyDetailTable.fromJson(Map<String, dynamic> json) {
    sHIPTOID = json['SHIPTOID'];
    sHIPTO = json['SHIPTO'];
    cITYID = json['CITYID'];
    cITY = json['CITY'];
    tRANSID = json['TRANSID'];
    tRANSNAME = json['TRANSNAME'];
    aGENTID = json['AGENTID'];
    aGENTNAME = json['AGENTNAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SHIPTOID'] = this.sHIPTOID;
    data['SHIPTO'] = this.sHIPTO;
    data['CITYID'] = this.cITYID;
    data['CITY'] = this.cITY;
    data['TRANSID'] = this.tRANSID;
    data['TRANSNAME'] = this.tRANSNAME;
    data['AGENTID'] = this.aGENTID;
    data['AGENTNAME'] = this.aGENTNAME;
    return data;
  }
}
