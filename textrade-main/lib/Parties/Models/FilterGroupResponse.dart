class FilterGroupResponse {
  List<Group>? group;

  FilterGroupResponse({this.group});

  FilterGroupResponse.fromJson(Map<String, dynamic> json) {
    if (json['Group'] != null) {
      group = <Group>[];
      json['Group'].forEach((v) {
        group!.add(new Group.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.group != null) {
      data['Group'] = this.group!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Group {
  String? text;
  String? value;
  bool? isSelected;
  Group({this.text, this.value, this.isSelected});

  Group.fromJson(Map<String, dynamic> json) {
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
