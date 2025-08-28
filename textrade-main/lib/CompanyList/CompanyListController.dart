import 'package:get/get.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/DefaultStorageKeys.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/CompanyList/CompanyListModal.dart';

import '../Common/Routes.dart';
import '../Common/StorageManager.dart';

class CompanyListController extends GetxController {
  var companyListObs = CompanyListModel(table: []).obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getCompanyList();
    super.onInit();
  }

  void getCompanyList() async {
    var companyList = await ApiUtility.shared.companyListApiCall();
    if (companyList == null) {
      Utility.showErrorView("Error", "Failed to fetch company List");
      return;
    }
    companyListObs.value = companyList;
  }

  void selectedCompany(Company compVal) {
    // StorageManager.saveData(compId, compVal);
    AppController.shared.selectedCompany = compVal;
    Get.toNamed(Utility.screenName(Screens.dateListScreen));
  }
}
