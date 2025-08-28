import 'package:textrade/DateSelectionScreen/DateSelectionListResponseModel.dart';

import '../CompanyList/CompanyListModal.dart';

class AppController {
  static final shared = AppController();

  var userId = "";
  Company? selectedCompany;
  Year? selectedDate;
  Year? selectedMainDate;
  Year? selectedDateItem;
  Year? selectedItemDetailParty;
}
