// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    LoginResponseModel({
        required this.table,
    });

    List<Table> table;

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        table: List<Table>.from(json["Table"].map((x) => Table.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Table": List<dynamic>.from(table.map((x) => x.toJson())),
    };
}

class Table {
    Table({
        required this.statusMsg,
        required this.userId,
    });

    String statusMsg;
    int userId;

    factory Table.fromJson(Map<String, dynamic> json) => Table(
        statusMsg: json["StatusMsg"],
        userId: json["UserID"],
    );

    Map<String, dynamic> toJson() => {
        "StatusMsg": statusMsg,
        "UserID": userId,
    };
}
