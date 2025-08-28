class ItemTransactionResponse {
  List<Table>? table;

  ItemTransactionResponse({this.table});

  ItemTransactionResponse.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <Table>[];
      json['Table'].forEach((v) {
        table!.add(new Table.fromJson(v));
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

class Table {
  String? nAME;
  dynamic aMT;

  Table({this.nAME, this.aMT});

  Table.fromJson(Map<String, dynamic> json) {
    nAME = json['NAME'];
    aMT = json['AMT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NAME'] = this.nAME;
    data['AMT'] = this.aMT;
    return data;
  }
}
