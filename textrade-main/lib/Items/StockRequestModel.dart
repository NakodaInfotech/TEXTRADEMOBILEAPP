class StockRequestModel {
  String? itemName;
  String? designName;
  String? color;
  String? category;
  String? godown;
  String? quality;
  String? pieceType;
  String? unit;
  String? yearID;

  StockRequestModel(
      {this.itemName,
      this.designName,
      this.color,
      this.category,
      this.godown,
      this.quality,
      this.pieceType,
      this.unit,
      this.yearID});

  StockRequestModel.fromJson(Map<String, dynamic> json) {
    itemName = json['ItemName'];
    designName = json['DesignName'];
    color = json['Color'];
    category = json['Category'];
    godown = json['Godown'];
    quality = json['Quality'];
    pieceType = json['PieceType'];
    unit = json['Unit'];
    yearID = json['YearID'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['ItemName'] = this.itemName ?? "";
    data['DesignName'] = this.designName ?? "";
    data['Color'] = this.color ?? "";
    data['Category'] = this.category ?? "";
    data['Godown'] = this.godown ?? "";
    data['Quality'] = this.quality ?? "";
    data['PieceType'] = this.pieceType ?? "";
    data['Unit'] = this.unit ?? "";
    data['YearID'] = this.yearID ?? "";
    return data;
  }
}
