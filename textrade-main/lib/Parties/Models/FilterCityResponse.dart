class FilterCityResponse {
  List<City>? city;

  FilterCityResponse({this.city});

  FilterCityResponse.fromJson(Map<String, dynamic> json) {
    if (json['City'] != null) {
      city = <City>[];
      json['City'].forEach((v) {
        city!.add(new City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.city != null) {
      data['City'] = this.city!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  String? text;
  String? value;
  bool? isSelected;
  City({this.text, this.value, this.isSelected});

  City.fromJson(Map<String, dynamic> json) {
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
