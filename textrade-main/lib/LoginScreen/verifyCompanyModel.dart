// To parse this JSON data, do
//
//     final verifyCompanyResponseModel = verifyCompanyResponseModelFromJson(jsonString);

import 'dart:convert';

class verifyCompanyModel {
  List<companyDetails>? response;

  verifyCompanyModel({this.response});

  verifyCompanyModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <companyDetails>[];
      json['response'].forEach((v) {
        response!.add(companyDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class companyDetails {
  String? ipAddress;
  String? company;
  String? code;

  companyDetails({this.ipAddress, this.company, this.code});

  companyDetails.fromJson(Map<String, dynamic> json) {
    ipAddress = json['ipAddress'];
    company = json['company'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Text'] = this.ipAddress;
    data['Value'] = this.company;
    data['isSelected'] = this.code;
    return data;
  }
}
