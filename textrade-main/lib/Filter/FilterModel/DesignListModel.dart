class DesignListModel {
  List<Design>? design;

  DesignListModel({this.design});

  DesignListModel.fromJson(Map<String, dynamic> json) {
    if (json['Design'] != null) {
      design = <Design>[];
      json['Design'].forEach((v) {
        design!.add(new Design.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.design != null) {
      data['Design'] = this.design!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Design {
  String? text;
  String? value;
  bool? isSelected;

  Design({this.text, this.value, this.isSelected});

  Design.fromJson(Map<String, dynamic> json) {
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
