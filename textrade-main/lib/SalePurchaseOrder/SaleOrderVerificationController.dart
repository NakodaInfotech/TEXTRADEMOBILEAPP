import 'package:get/get.dart';
import '../Common/ApiHandler/ApiUtility.dart';
import 'SaleOrderVerificationModel.dart';

class SaleOrderVerificationController extends GetxController {
  var verificationModel = SaleOrderVerificationModel().obs;
  var isLoading = false.obs;
  var selectedTab = "Pending".obs; // Default tab

  // Fetch pending sale orders
  Future<void> getPendingSaleOrders() async {
    try {
      isLoading.value = true;
      var result = await ApiUtility.shared.getPendingSaleOrder(
        "", "", "", ""
      );
      verificationModel.value = result;
      selectedTab.value = "Pending";
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch entered sale orders
  Future<void> getEnteredSaleOrders() async {
    try {
      isLoading.value = true;
      var result = await ApiUtility.shared.getEnteredSaleOrder(
        "", "", "", ""
      );
      verificationModel.value = result;
      selectedTab.value = "Entered";
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getPendingSaleOrders(); // load default tab
  }
}
