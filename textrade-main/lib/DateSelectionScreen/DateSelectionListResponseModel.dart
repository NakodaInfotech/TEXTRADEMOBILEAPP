class DateListResponseModel {
  List<Year>? year;

  DateListResponseModel({this.year});

  DateListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['Year'] != null) {
      year = <Year>[];
      json['Year'].forEach((v) {
        year!.add(new Year.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.year != null) {
      data['Year'] = this.year!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Year {
  String? text;
  String? text1;
  String? value;

  Year({this.text, this.text1, this.value});

  Year.fromJson(Map<String, dynamic> json) {
    text = json['Text'];
    text1 = json['Text1'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Text'] = this.text;
    data['Text1'] = this.text1;
    data['Value'] = this.value;
    return data;
  }
}

