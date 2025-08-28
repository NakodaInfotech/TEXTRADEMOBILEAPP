// To parse this JSON data, do
//
//     final companyListModel = companyListModelFromJson(jsonString);

import 'dart:convert';

CompanyListModel companyListModelFromJson(String str) =>
    CompanyListModel.fromJson(json.decode(str));

String companyListModelToJson(CompanyListModel data) =>
    json.encode(data.toJson());

class CompanyListModel {
  CompanyListModel({
    required this.table,
  });

  List<Company> table;

  factory CompanyListModel.fromJson(Map<String, dynamic> json) =>
      CompanyListModel(
        table:
            List<Company>.from(json["Table"].map((x) => Company.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Table": List<dynamic>.from(table.map((x) => x.toJson())),
      };
}

class Company {
  Company({
    required this.cmpname,
    required this.cmpid,
    required this.add1,
    required this.add2,
    required this.gSTIN,
    required this.mSME,
    required this.pANNO,
    required this.sTATENAME,
    required this.sTATEREMARK,
    required this.bank,
    required this.account,
    required this.ifsc,
    required this.upi,
    required this.GATEPASSENABLED,
  });

  String cmpname;
  int cmpid;
  String add1;
  String add2;
  String mSME;
  String pANNO;
  String gSTIN;
  String sTATENAME;
  String sTATEREMARK;
  String bank;
  String account;
  String ifsc;
  String upi;
  bool? GATEPASSENABLED;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        cmpname: json["CMPNAME"],
        cmpid: json["CMPID"],
        add1: json["ADD1"],
        add2: json["ADD2"],
        GATEPASSENABLED:
            json["GATEPASSENABLED"] == null ? false : json["GATEPASSENABLED"],
        mSME: json["MSME"],
        pANNO: json["PANNO"],
        gSTIN: json["GSTIN"],
        sTATENAME: json["STATENAME"],
        sTATEREMARK: json["STATEREMARK"],
        bank: json["BANKNAME"],
        account: json["ACNO"],
        ifsc: json["IFSCCODE"],
        upi: json["UPI"],
      );

  Map<String, dynamic> toJson() => {
        "CMPNAME": cmpname,
        "CMPID": cmpid,
        "ADD1": add1,
        "ADD2": add2,
        "GSTIN": gSTIN,
        "MSME": mSME,
        "PANNO": pANNO,
        "STATENAME": sTATENAME,
        "STATEREMARK": sTATEREMARK,
        "GATEPASSENABLED": GATEPASSENABLED,
        "BANKNAME": bank,
        "ACNO": account,
        "IFSCCODE": ifsc,
        "UPI": upi,
      };
}
