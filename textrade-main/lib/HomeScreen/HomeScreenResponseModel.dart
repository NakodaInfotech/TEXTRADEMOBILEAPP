class HomeScreenResponseModel {
  List<TableResponse>? table;

  HomeScreenResponseModel({this.table});

  HomeScreenResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <TableResponse>[];
      json['Table'].forEach((v) {
        table!.add(new TableResponse.fromJson(v));
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

class TableResponse {
  String? tRADETYPE;
  double? aMT;

  TableResponse({this.tRADETYPE, this.aMT});

  TableResponse.fromJson(Map<String, dynamic> json) {
    tRADETYPE = json['TRADETYPE'];
    aMT = json['AMT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TRADETYPE'] = this.tRADETYPE;
    data['AMT'] = this.aMT;
    return data;
  }
}
