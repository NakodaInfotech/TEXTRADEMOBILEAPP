class PieceTypeListModel {
  List<PieceType>? pieceType;

  PieceTypeListModel({this.pieceType});

  PieceTypeListModel.fromJson(Map<String, dynamic> json) {
    if (json['PieceType'] != null) {
      pieceType = <PieceType>[];
      json['PieceType'].forEach((v) {
        pieceType!.add(new PieceType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pieceType != null) {
      data['PieceType'] = this.pieceType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PieceType {
  String? text;
  String? value;
  bool? isSelected;

  PieceType({this.text, this.value});

  PieceType.fromJson(Map<String, dynamic> json) {
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
