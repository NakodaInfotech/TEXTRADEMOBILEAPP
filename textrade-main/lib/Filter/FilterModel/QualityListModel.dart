class QualityListModel {
  List<Quality>? quality;

  QualityListModel({this.quality});

  QualityListModel.fromJson(Map<String, dynamic> json) {
    if (json['Quality'] != null) {
      quality = <Quality>[];
      json['Quality'].forEach((v) {
        quality!.add(new Quality.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quality != null) {
      data['Quality'] = this.quality!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quality {
  String? text;
  String? value;
  bool? isSelected;

  Quality({this.text, this.value, this.isSelected});

  Quality.fromJson(Map<String, dynamic> json) {
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
