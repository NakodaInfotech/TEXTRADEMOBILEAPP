class SaleOrderVerificationModel {
  List<SaleOrderVerificationData>? table;

  SaleOrderVerificationModel({this.table});

  SaleOrderVerificationModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <SaleOrderVerificationData>[];
      json['Table'].forEach((v) {
        table!.add(SaleOrderVerificationData.fromJson(v));
      });
    }
  }
}

class SaleOrderVerificationData {
  String? sONO;
  String? pARTYNAME;
  String? aGENTNAME;
  double? tOTALQTY;
  double? tOTALMTRS;
  String? sHIPTO;

  SaleOrderVerificationData({
    this.sONO,
    this.pARTYNAME,
    this.aGENTNAME,
    this.tOTALQTY,
    this.tOTALMTRS,
    this.sHIPTO,
  });

  SaleOrderVerificationData.fromJson(Map<String, dynamic> json) {
    sONO = json['SONO'];
    pARTYNAME = json['PARTYNAME'];
    aGENTNAME = json['AGENTNAME'];
    tOTALQTY = double.tryParse(json['TOTALQTY'].toString());
    tOTALMTRS = double.tryParse(json['TOTALMTRS'].toString());
    sHIPTO = json['SHIPTO'];
  }
}
