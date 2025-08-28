class RegNameResponse {
  List<Register>? register;

  RegNameResponse({this.register});

  RegNameResponse.fromJson(Map<String, dynamic> json) {
    if (json['Register'] != null) {
      register = <Register>[];
      json['Register'].forEach((v) {
        register!.add(new Register.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.register != null) {
      data['Register'] = this.register!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Register {
  String? text;
  String? value;
  bool? isSelected;

  Register({this.text, this.value, this.isSelected});

  Register.fromJson(Map<String, dynamic> json) {
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