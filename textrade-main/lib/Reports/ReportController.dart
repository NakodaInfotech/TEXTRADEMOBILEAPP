import 'package:get/get.dart';
import 'package:textrade/Common/AppController.dart';

class ReportController extends GetxController {
  var listItems = [
    "Change Year",
    // "Top Report",
    // "Ledgers",
    // "Day Book",
    // "Pending Sales Order",
    // "Pending Purchase Order",
    // "Extra Report(need to added)",
    "GDN (Goods Dispatch Note)",
    "Sale Invoice",
    "Purchase Invoice",
    "Top Reports",
    "Sale Order List",
    "Purchase Order List",
    "Catalog List",
    // "Stocks",
    // "GST Reports",
    "Rack Mangement",
    "Stock Taking",
    "Sales Order",
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    if (AppController.shared.selectedCompany?.GATEPASSENABLED == true) {
      listItems.add("Gate Pass");
    }
    super.onInit();
  }
}
