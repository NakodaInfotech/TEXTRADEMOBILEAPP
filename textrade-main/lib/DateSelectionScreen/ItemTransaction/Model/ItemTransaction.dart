class ItemTransactionRequest {
  String? yearID;
  String? fromDate;
  String? toDate;
  String? type;

  ItemTransactionRequest({this.yearID, this.fromDate, this.toDate, this.type});

  ItemTransactionRequest.fromJson(Map<String, dynamic> json) {
    yearID = json['YearID'];
    fromDate = json['From_Date'];
    toDate = json['To_Date'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['YearID'] = this.yearID;
    data['From_Date'] = this.fromDate;
    data['To_Date'] = this.toDate;
    data['Type'] = this.type;
    return data;
  }
}
