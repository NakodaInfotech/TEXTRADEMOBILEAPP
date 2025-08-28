class LoginRequestModel {
  String? userName;
  String? passWord;
  String? imei;

  LoginRequestModel({this.userName, this.passWord, this.imei});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    passWord = json['PassWord'];
    imei = json['DeviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserName'] = userName;
    data['PassWord'] = passWord;
    data['DeviceId'] = imei;
    return data;
  }
}
