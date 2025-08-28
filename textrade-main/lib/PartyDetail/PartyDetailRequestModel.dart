class PartyDetailRequestModel {
  String? name;
  String? agent;
  String? yearID;
  String? fromDate;
  String? toDate;

  PartyDetailRequestModel(
      {this.name, this.agent, this.yearID, this.fromDate, this.toDate});

  PartyDetailRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    agent = json['AgentName'];
    yearID = json['YearID'];
    fromDate = json['From_Date'];
    toDate = json['To_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['AgentName'] = this.agent;
    data['YearID'] = this.yearID;
    data['From_Date'] = this.fromDate;
    data['To_Date'] = this.toDate;
    return data;
  }
}
