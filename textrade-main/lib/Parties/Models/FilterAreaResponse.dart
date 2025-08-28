class FilterAreaResponse {
  List<AREA>? aREA;

  FilterAreaResponse({this.aREA});

  FilterAreaResponse.fromJson(Map<String, dynamic> json) {
    if (json['AREA'] != null) {
      aREA = <AREA>[];
      json['AREA'].forEach((v) {
        aREA!.add(new AREA.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aREA != null) {
      data['AREA'] = this.aREA!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AREA {
  String? text;
  String? value;
  bool? isSelected;
  AREA({this.text, this.value, this.isSelected});

  AREA.fromJson(Map<String, dynamic> json) {
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
