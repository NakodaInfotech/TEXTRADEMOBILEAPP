class UnitListModel {
  List<Unit>? unit;

  UnitListModel({this.unit});

  UnitListModel.fromJson(Map<String, dynamic> json) {
    if (json['Unit'] != null) {
      unit = <Unit>[];
      json['Unit'].forEach((v) {
        unit!.add(new Unit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.unit != null) {
      data['Unit'] = this.unit!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Unit {
  String? text;
  String? value;
  bool? isSelected;

  Unit({this.text, this.value, this.isSelected});

  Unit.fromJson(Map<String, dynamic> json) {
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
