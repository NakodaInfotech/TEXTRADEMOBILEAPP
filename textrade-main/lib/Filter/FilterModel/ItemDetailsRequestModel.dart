class ItemDetailsRequestModel {
  String? itemID;
  String? designID;
  String? colorID;
  String? yearID;
  String? fromDate;
  String? toDate;

  ItemDetailsRequestModel(
      {this.itemID,
      this.designID,
      this.colorID,
      this.yearID,
      this.fromDate,
      this.toDate});

  ItemDetailsRequestModel.fromJson(Map<String, dynamic> json) {
    itemID = json['ItemID'];
    designID = json['DesignID'];
    colorID = json['ColorID'];
    yearID = json['YearID'];
    fromDate = json['From_Date'];
    toDate = json['To_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemID'] = this.itemID;
    data['DesignID'] = this.designID;
    data['ColorID'] = this.colorID;
    data['YearID'] = this.yearID;
    data['From_Date'] = this.fromDate;
    data['To_Date'] = this.toDate;
    return data;
  }
}
