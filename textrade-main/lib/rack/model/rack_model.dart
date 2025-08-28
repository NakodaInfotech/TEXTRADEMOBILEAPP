class RackModel {
  List<RackTable>? table;

  RackModel({this.table});

  RackModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <RackTable>[];
      json['Table'].forEach((v) {
        table!.add(new RackTable.fromJson(v));
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

class RackTable {
  String? rACKNAME;
  int? rACKId;

  RackTable({this.rACKNAME, this.rACKId});

  RackTable.fromJson(Map<String, dynamic> json) {
    rACKNAME = json['RACK_NAME'];
    rACKId = json['RACK_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RACK_NAME'] = this.rACKNAME;
    data['RACK_id'] = this.rACKId;
    return data;
  }
}
