class FilterAgentResponse {
  List<Agent>? agent;

  FilterAgentResponse({this.agent});

  FilterAgentResponse.fromJson(Map<String, dynamic> json) {
    if (json['Agent'] != null) {
      agent = <Agent>[];
      json['Agent'].forEach((v) {
        agent!.add(new Agent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.agent != null) {
      data['Agent'] = this.agent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Agent {
  String? text;
  String? value;
  bool? isSelected;
  Agent({this.text, this.value, this.isSelected});

  Agent.fromJson(Map<String, dynamic> json) {
    text = json['Text'];
    value = json['Value'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Text'] = this.text;
    data['Value'] = this.value;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
