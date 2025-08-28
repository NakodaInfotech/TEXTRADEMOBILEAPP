class BarcodeDetailsRequest {
  String? bARCODE;
  String? yearID;

  BarcodeDetailsRequest({this.bARCODE, this.yearID});

  BarcodeDetailsRequest.fromJson(Map<String, dynamic> json) {
    bARCODE = json['BARCODE'];
    yearID = json['YearID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BARCODE'] = this.bARCODE;
    data['YearID'] = this.yearID;
    return data;
  }
}
