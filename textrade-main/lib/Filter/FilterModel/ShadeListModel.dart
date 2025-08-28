class ShadeListModel {
  List<Shade>? shade;

  ShadeListModel({this.shade});

  ShadeListModel.fromJson(Map<String, dynamic> json) {
    if (json['Shade'] != null) {
      shade = <Shade>[];
      json['Shade'].forEach((v) {
        shade!.add(new Shade.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shade != null) {
      data['Shade'] = this.shade!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shade {
  String? text;
  String? value;
  bool? isSelected;

  Shade({this.text, this.value, this.isSelected});

  Shade.fromJson(Map<String, dynamic> json) {
    text = json['Text'];
    value = json['Value'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Text'] = this.text;
    data['Value'] = this.value;
    return data;
  }
}
