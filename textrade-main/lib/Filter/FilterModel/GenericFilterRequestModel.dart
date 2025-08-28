class GenericFilterRequestModel {
  String? yearID;

  GenericFilterRequestModel({this.yearID});

  GenericFilterRequestModel.fromJson(Map<String, dynamic> json) {
    yearID = json['YearID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['YearID'] = this.yearID;
    return data;
  }
}
