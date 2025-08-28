class ItemReponse {
  List<Item>? item;

  ItemReponse({this.item});

  ItemReponse.fromJson(Map<String, dynamic> json) {
    if (json['Item'] != null) {
      item = <Item>[];
      json['Item'].forEach((v) {
        item!.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.item != null) {
      data['Item'] = this.item!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  String? text;
  String? value;
  bool? isSelected;
  Item({this.text, this.value, this.isSelected});

  Item.fromJson(Map<String, dynamic> json) {
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
