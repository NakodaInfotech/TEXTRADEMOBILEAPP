class FilterPartiesRequest {
  String? yearID;

  FilterPartiesRequest({this.yearID});

  FilterPartiesRequest.fromJson(Map<String, dynamic> json) {
    yearID = json['YearID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['YearID'] = this.yearID;
    return data;
  }
}
