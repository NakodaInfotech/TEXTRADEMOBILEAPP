import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';

// Main model with RxList for GetX reactivity
class SaleOrderVerificationModel {
  RxList<SaleOrderVerificationData> table;

  SaleOrderVerificationModel({RxList<SaleOrderVerificationData>? table})
      : table = table ?? <SaleOrderVerificationData>[].obs;

  factory SaleOrderVerificationModel.fromJson(Map<String, dynamic> json) {
    var list = (json['Table'] as List<dynamic>? ?? []);
    var tableList = list
        .map((e) => SaleOrderVerificationData.fromJson(e))
        .toList()
        .obs;
    return SaleOrderVerificationModel(table: tableList);
  }
}

// Data model with mutable isSelected (for checkbox)
class SaleOrderVerificationData {
  final int? sono;
  final String? name;
  final String? agentName;
  final String? itemName;
  final String? designName;
  final String? color;
  final String? type;

  RxBool isSelected;

  SaleOrderVerificationData({
    this.sono,
    this.name,
    this.agentName,
    this.itemName,
    this.designName,
    this.color,
    this.type,
    bool isSelected = false,
  }) : this.isSelected = isSelected.obs;

  factory SaleOrderVerificationData.fromJson(Map<String, dynamic> json) {
    return SaleOrderVerificationData(
      sono: json['SONO'] as int?,
      name: json['PARTYNAME'] as String?,
      agentName: json['AGENTNAME'] as String?,
      itemName: json['ITEMNAME'] as String?,
      designName: json['DESIGN']?.toString(),
      color: json['COLOR'] as String?,
      type: json['Type'] as String?,
      isSelected: false,
    );
  }
}

