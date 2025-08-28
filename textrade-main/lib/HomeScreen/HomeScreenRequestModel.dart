class HomeScreenRequestModel {
  String? yearID;
  String? fromDate;
  String? toDate;

  HomeScreenRequestModel({this.yearID, this.fromDate, this.toDate});

  HomeScreenRequestModel.fromJson(Map<String, dynamic> json) {
    yearID = json['YearID'];
    fromDate = json['From_Date'];
    toDate = json['To_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['YearID'] = this.yearID;
    data['From_Date'] = this.fromDate;
    data['To_Date'] = this.toDate;
    return data;
  }
}

