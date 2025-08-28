class TransportListRes {
  List<TransportTable>? table;

  TransportListRes({this.table});

  TransportListRes.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <TransportTable>[];
      json['Table'].forEach((v) {
        table!.add(new TransportTable.fromJson(v));
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

class TransportTable {
  String? tRANSNAME;
  int? tRANSID;

  TransportTable({this.tRANSNAME, this.tRANSID});

  TransportTable.fromJson(Map<String, dynamic> json) {
    tRANSNAME = json['TRANSNAME'];
    tRANSID = json['TRANSID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TRANSNAME'] = this.tRANSNAME;
    data['TRANSID'] = this.tRANSID;
    return data;
  }
}
