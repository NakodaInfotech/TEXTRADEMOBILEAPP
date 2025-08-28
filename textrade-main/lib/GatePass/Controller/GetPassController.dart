import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/GatePass/Model/GetPassModel.dart';
import 'package:textrade/GatePass/Model/SelectedChallanDetails.dart';
import 'package:textrade/GatePass/Model/challanListModel.dart';
import 'package:textrade/Items/ItemsController.dart';
import 'package:textrade/Parties/Models/FilterAgentRequest.dart';
import 'package:textrade/Parties/Models/FilterLedgerRequest.dart';
import 'package:textrade/Parties/Models/FilterLedgerResponse.dart';
import 'package:textrade/SalesForm/model/searchModel.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class GatePassController extends GetxController {
  var getPassListModel = GetPassListModel().obs;
  var challanList = ChallanListModel().obs;
  var detailCahllanList =
      ChallanListModel(); //called only when there is a gate pass no for detail purpose
  var selectedChallans = <ChallanTable>[];
  var xfile = XFile("").obs;
  var selectedChallanBarcodes = <SelectedChallanTable>[].obs;
  var transPortList = <SearchGenericModel>[];
  var selectedTransport = SearchGenericModel("LOCAL TRANSPORT", "0").obs;

  var filterLedgerResponse = FilterLedgerResponse().obs;
  var filterAgentResponse = FilterAgentResponse().obs;

  //
  var filterLedgerArray = <Ledger>[].obs;
  var filterAgentArray = <Agent>[].obs;
  var filterTransportArray = <SearchGenericModel>[].obs;

  var vehicalNoFieldController = TextEditingController().obs;
  var isForEditing = false;

  // filter
  var searchTextController = TextEditingController();
  var catArry = [
    Categories("Party", true),
    Categories("Agent", false),
    Categories("Transport", false)
  ].obs;

  String? editingGatePassNo;

  //

  @override
  void onReady() {
    getGatePassList(false);
    super.onReady();
  }

  //
  void openQrScanner() {
    var barCodeList = selectedChallanBarcodes
        .where((element) =>
            element.isScanned == false || element.isScanned == null)
        .map((e) => e.bARCODE)
        .toList();
    Get.toNamed(Utility.screenName(Screens.qrScanner),
        arguments: [true, barCodeList])?.then((value) {
      if (value != null) {
        for (var item in value) {
          var index = selectedChallanBarcodes
              .indexWhere((element) => element.bARCODE == item);
          selectedChallanBarcodes.value[index].isScanned = true;
          selectedChallanBarcodes.refresh();
        }
      }
    });
  }

  void updateScannedItems(List<String> scannedItems) {
    for (var item in scannedItems) {
      var index = selectedChallanBarcodes
          .indexWhere((element) => element.bARCODE == item);
      selectedChallanBarcodes.value[index].isScanned = true;
      selectedChallanBarcodes.refresh();
    }
    selectedChallanBarcodes.refresh();
  }

  //
  void loadChalanScreen({String? gpNo}) {
    editingGatePassNo = gpNo;
    Get.toNamed(Utility.screenName(Screens.challanListScreen))?.then((value) {
      if (value == true) {
        getGatePassList(true);
      }
    });
    getChallanList("", "", "", gpNo ?? "");
  }

  resetForm() {
    if (!isForEditing) {
      selectedChallans = [];
      selectedChallanBarcodes.value = [];
      vehicalNoFieldController.value.text = "";
      selectedTransport.value = SearchGenericModel("LOCAL TRANSPORT", "0");
      xfile.value = XFile("");
    }
  }

  //
  void loadGatePassForm() async {
    resetForm();
    selectedChallans = challanList.value.table
            ?.where((element) => element.isSelected == true)
            .toList() ??
        [];

    if (selectedChallans.isNotEmpty) {
      loadTransportList();
      var ids = (selectedChallans.map((e) => e.gDNNO).toList()).join("|");
      var names = selectedChallans.map((e) => e.nAME).toList().join("|");
      Utility.showLoader(title: "Loading");
      var barcodes = await ApiUtility.shared
          .getSelectChallanDetails(ids, names, isForEditing ? 1 : 0);
      Utility.hideLoader();
      if (barcodes?.table?.isNotEmpty ?? false) {
        selectedChallanBarcodes.value = barcodes.table ?? [];
        if (isForEditing == true &&
            (detailCahllanList.table ?? []).isNotEmpty) {
          var listOfBarcodes = detailCahllanList.table
              ?.where((element) => element.CHK == true)
              .map((e) => e.BARCODE ?? "")
              .toList();
          updateScannedItems(listOfBarcodes ?? []);
        }

        Get.toNamed(Utility.screenName(Screens.gatePassFormScreen),
            arguments: barcodes);
      } else {
        Utility.showErrorView(
            "Alert!", "No barcode found for selected Challan.");
      }
    } else {
      Utility.showErrorView("Alert!", "Please select at least one Challan.");
    }
  }

  loadTransportList() async {
    // For transport list
    var yearID = AppController.shared.selectedDate?.value;
    var filterPartiesRequest = FilterPartiesRequest(yearID: yearID);
    var transportName =
        await ApiUtility.shared.getTransportList(filterPartiesRequest);
    if (transportName.table?.isNotEmpty ?? false) {
      transPortList = (transportName.table ?? [])
          .map((e) => SearchGenericModel(e.tRANSNAME, e.tRANSID.toString()))
          .toList();
      filterTransportArray.value = transPortList;

      if (transPortList.isNotEmpty) {
        var trans = transPortList.firstWhereOrNull((element) =>
            element.name == detailCahllanList.table?.first.TRANSPORT);
        trans?.isSelected = true;
        selectedTransport.value =
            SearchGenericModel(trans?.name ?? "", trans?.id ?? "");
        selectedTransport.refresh();
      }
    }

    //...
  }
   //Compress image from camera 

    Future<XFile> compressFile({required XFile? file}) async {
      final filePath = file!.path;
    
      // Create output file path
      // eg:- "Volume/VM/abcd_out.jpeg"
      final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
      final splitted = filePath.substring(0, (lastIndex));
      final outPath = '${splitted}_out${filePath.substring(lastIndex)}';
      var result = await FlutterImageCompress.compressAndGetFile(
        file.path,
        outPath,
        quality: 5,
      );
      return result!;
    }
  openSearch() {
    Get.toNamed(Utility.screenName(Screens.searchScreen),
            arguments: transPortList)
        ?.then((value) {
      print(value.name);
      selectedTransport.value = value;
      selectedTransport.refresh();
    });
  }

  //submitGatePassForm
  void submitGatePassForm() async {
    var scannedItems = selectedChallanBarcodes.value
        .where((element) => element.isScanned == true || element.cHK == 1)
        .toList();
    var ids = (selectedChallanBarcodes.map((e) => e.gDNNO).toList()).join("|");
    var formTypes =
        (selectedChallanBarcodes.map((e) => e.fROMTYPE).toList()).join("|");
    // var ids = (scannedItems.map((e) => e.gDNNO).toList()).join("|");
    // var formTypes =
    //     (scannedItems.map((e) => e.fROMTYPE).toList()).join("|");
    var barcodes = (scannedItems.map((e) => e.bARCODE).toList()).join("|");
    // else if (scannedItems.length != selectedChallanBarcodes.length) {
    // Utility.showErrorView("Alert", "Please scan all the bales...");
    // return;
    // }
    if (selectedTransport.value.id == "0") {
      Utility.showErrorView("Alert", "Please select transport.");
      return;
    } else if (vehicalNoFieldController.value.text.removeAllWhitespace == "") {
      Utility.showErrorView("Alert", "Please enter vehicle number.");
      return;
    } else if (xfile.value.path == "") {
      Utility.showErrorView("Alert", "Please vehicle select image.");
      return;
    } else {
      final bytes = await xfile.value.readAsBytes();
      final base64Image = base64Encode(bytes);
      var submitReq = {
        "DATE": Utility.dateTimeToString(DateTime.now(), "yyyy-MM-dd"),
        "TRANSID": selectedTransport.value.id,
        "REMARKS": "TEST",
        "VEHICLENO": vehicalNoFieldController.value.text,
        "IMAGE": base64Image,
        "CMPID": AppController.shared.selectedCompany?.cmpid ?? '',
        "USERID": AppController.shared.userId ?? '',
        "YearID": AppController.shared.selectedDate?.value ?? '',
        "GDNNO": ids,
        "GDNTYPE": formTypes,
        "BARCODE": barcodes
      };

      if (isForEditing) {
        var tempMap = {"TEMPENTRYNO": editingGatePassNo};
        submitReq.addAll(tempMap);
      }
      Utility.showLoader(title: "Submitting data please wait...");
      var data =
          await ApiUtility.shared.submitGatePass(submitReq, isForEditing);
      Utility.hideLoader();
      if ((data.table?[0].column1 ?? false) == true) {
        Get.back(result: true);
        Get.back(result: true);
      } else {
        Utility.showErrorView("Error", "Failed to submit Gate Pass.");
      }
    }
  }

  getGatePassList(bool showSuccessOfSubmission) async {
    Utility.showLoader(title: "Loading");
    getPassListModel.value = await ApiUtility.shared.getGatePassList();
    Utility.hideLoader();
    if (getPassListModel.value == null) {
      Utility.showErrorView("Error", "Failed to fetch Gate Pass List");
    } else if ((getPassListModel.value.table ?? []).isEmpty) {
      Utility.showErrorView("Error", "No List Found.");
    } else {
      if (showSuccessOfSubmission) {
        Utility.showErrorView("Success", "Gate Pass submitted successfully.");
      }
      getPassListModel.refresh();
    }
  }

  getChallanList(
      String nameID, String agentId, String transId, String gatePassNo) async {
    Utility.showLoader(title: "Loading");
    challanList.value = await ApiUtility.shared
        .getChallanList(nameID, agentId, transId, gatePassNo);
    if (gatePassNo != "") {
      detailCahllanList = await ApiUtility.shared.getGatePassDetail(gatePassNo);
      for (var item in detailCahllanList.table ?? []) {
        vehicalNoFieldController.value.text =
            detailCahllanList.table?.first.VEHICLENO ?? "";

        var index = challanList.value.table
            ?.indexWhere((element) => element.gDNNO == item.gDNNO);
        if (index != -1) {
          challanList.value.table![index!].isSelected = true;
          challanList.value.table![index!].isSelectedAndDontUnselect = true;
        }
      }
    }
    Utility.hideLoader();
    if (challanList.value == null) {
      Utility.showErrorView("Error", "Failed to fetch Gate Pass List");
    } else if ((challanList.value.table ?? []).isEmpty) {
      Utility.showErrorView("Error", "No List Found.");
    } else {
      challanList.refresh();
    }
  }

  selectOrDeselectChallan(ChallanTable? table) {
    if (table != null) {
      if (table.isSelectedAndDontUnselect == true) {
        Utility.showErrorView("Alert", "This challan can't be unselected.");
        return;
      }
      table.isSelected = !table.isSelected!;
      challanList.refresh();
    }
  }

  selectImageClicked() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera,imageQuality: 1);
    if (photo != null) {
      final img = await compressFile(file: photo);
      xfile.value = img;

      //make it base64
    }
  }


  //Filter
  void searchResult(String searchStr) {
    var selectedCategoryIndex =
        catArry.indexWhere((element) => element.isSelected == true);
    switch (selectedCategoryIndex) {
      case 0:
        if (searchStr != "") {
          filterLedgerArray.value = filterLedgerResponse.value!.ledger!
              .where((element) =>
                  element.text!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList();
        } else {
          filterLedgerArray.value = filterLedgerResponse.value.ledger!;
        }
        filterLedgerArray.refresh();
        break;
      case 1:
        if (searchStr != "") {
          filterAgentArray.value = filterAgentResponse.value.agent!
              .where((element) =>
                  element.text!.toLowerCase().contains(searchStr.toLowerCase()))
              .toList();
        } else {
          filterAgentArray.value = filterAgentResponse.value.agent!;
        }
        filterAgentArray.refresh();
        break;
      case 2:
        if (searchStr != "") {
          filterTransportArray.value = transPortList!
              .where((element) => element!.name!
                  .toLowerCase()
                  .contains(searchStr.toLowerCase()))
              .toList();
        } else {
          filterTransportArray.value = transPortList!;
        }
        filterTransportArray.refresh();
        break;
      default:
    }
  }

  getSearchList() async {
    Utility.showLoader(title: "Loading");

    var yearId = AppController.shared.selectedDate?.value;
    final FilterPartiesRequest filterLedgerRequest =
        FilterPartiesRequest(yearID: yearId);
    filterLedgerResponse.value =
        await ApiUtility.shared.fetchLedgerDetails(filterLedgerRequest);
    if (filterLedgerResponse.value.ledger != null) {
      filterLedgerArray.value = filterLedgerResponse.value.ledger!;
    }

    filterAgentResponse.value =
        await ApiUtility.shared.fetchAgentDetails(filterLedgerRequest);
    if (filterAgentResponse.value.agent != null) {
      filterAgentArray.value = filterAgentResponse.value.agent!;
    }
    loadTransportList();
    Utility.hideLoader();
  }

  void resetFilter() {
    (filterAgentArray.value).forEach((element) {
      element.isSelected = false;
    });
    filterAgentArray.refresh();
    filterLedgerArray.forEach((element) {
      element.isSelected = false;
    });
    filterLedgerArray.refresh();

    (filterTransportArray.value ?? []).forEach((element) {
      element.isSelected = false;
    });
    filterTransportArray.refresh();
  }

  void applyFilter() async {
    final String itemName = filterLedgerResponse.value.ledger!
        .where((p0) => p0.isSelected == true)
        .map((e) => e.value)
        .join(",");
    final String agent = filterAgentResponse.value.agent!
        .where((p0) => p0.isSelected == true)
        .map((e) => e.value)
        .join(",");
    final String transport = transPortList!
        .where((p0) => p0.isSelected == true)
        .map((e) => e.id)
        .join(",");
    print(itemName);
    print(agent);
    print(transport);
    Get.back(result: [itemName, agent, transport]);
  }
//..
}
