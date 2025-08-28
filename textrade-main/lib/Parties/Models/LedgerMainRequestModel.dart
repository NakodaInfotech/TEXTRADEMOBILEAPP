class LedgerMainRequest {
  String? name;
  String? agentName;
  String? city;
  String? area;
  String? group;
  String? yearID;
  String? fromDate;
  String? toDate;

  LedgerMainRequest(
      {this.name,
      this.agentName,
      this.city,
      this.area,
      this.group,
      this.yearID,
      this.fromDate,
      this.toDate});

  LedgerMainRequest.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    agentName = json['AgentName'];
    city = json['City'];
    area = json['Area'];
    group = json['Group'];
    yearID = json['YearID'];
    fromDate = json['From_Date'];
    toDate = json['To_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name ?? "";
    data['AgentName'] = agentName ?? "";
    data['City'] = city ?? "";
    data['Area'] = area ?? "";
    data['Group'] = group ?? "";
    data['YearID'] = yearID ?? "";
    data['From_Date'] = fromDate ?? "";
    data['To_Date'] = toDate ?? "";
    return data;
  }
}
