class FilterLedgerResponse {
  List<Ledger>? ledger;

  FilterLedgerResponse({this.ledger});

  FilterLedgerResponse.fromJson(Map<String, dynamic> json) {
    if (json['Ledger'] != null) {
      ledger = <Ledger>[];
      json['Ledger'].forEach((v) {
        ledger!.add(new Ledger.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ledger != null) {
      data['Ledger'] = this.ledger!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ledger {
  String? text;
  String? value;
  bool? isSelected;

  Ledger({this.text, this.value, this.isSelected});

  Ledger.fromJson(Map<String, dynamic> json) {
    text = json['Text'];
    value = json['Value'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Text'] = this.text;
    data['Value'] = this.value;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
