class GoDownListModel {
  List<Godown>? godown;

  GoDownListModel({this.godown});

  GoDownListModel.fromJson(Map<String, dynamic> json) {
    if (json['Godown'] != null) {
      godown = <Godown>[];
      json['Godown'].forEach((v) {
        godown!.add(new Godown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.godown != null) {
      data['Godown'] = this.godown!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Godown {
  String? text;
  String? value;
  bool? isSelected;

  Godown({this.text, this.value, this.isSelected});

  Godown.fromJson(Map<String, dynamic> json) {
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
