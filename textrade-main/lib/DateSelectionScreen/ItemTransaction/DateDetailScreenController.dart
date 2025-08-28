import 'package:get/get.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/DateSelectionScreen/ItemTransaction/Model/ItemTransaction.dart';
import 'package:textrade/DateSelectionScreen/ItemTransaction/Model/ItemTransactionResponse.dart';
import 'package:textrade/HomeScreen/HomeScreenResponseModel.dart';

class ItemTransactionController extends GetxController {
  TableResponse? tableResponse;
  var itemTransactionResponse = ItemTransactionResponse().obs;
  var startDate = "";
  var endDate = "";
  @override
  void onInit() {
    // TODO: implement onInit
    tableResponse = Get.arguments[0];
    endDate = Get.arguments[1];
    startDate = Get.arguments[2];
    getItemTransaction();
    super.onInit();
  }

  void getItemTransaction() async {
    var selectedYear = AppController.shared.selectedDate;

    final ItemTransactionRequest itemTransactionRequest =
        ItemTransactionRequest(
            yearID: AppController.shared.selectedDate!.value ?? "",
            type: tableResponse?.tRADETYPE ?? "",
            toDate: Utility.convertDateFormate(startDate),
            fromDate: Utility.convertDateFormate(endDate));

    itemTransactionResponse.value =
        await ApiUtility.shared.fetchItemTransactions(itemTransactionRequest);
  }
}
