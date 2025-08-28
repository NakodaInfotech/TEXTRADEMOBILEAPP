class DateListRequestModel {
  String? CmpID;

  DateListRequestModel({this.CmpID});

  DateListRequestModel.fromJson(Map<String, dynamic> json) {
    CmpID = json['CmpID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CmpID'] = CmpID;
    return data;
  }
}
