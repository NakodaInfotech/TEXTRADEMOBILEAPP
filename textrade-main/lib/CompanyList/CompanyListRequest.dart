class CompanyListRequestModel {
  String? userID;

  CompanyListRequestModel({this.userID});

  CompanyListRequestModel.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserID'] = userID;
    return data;
  }
}
