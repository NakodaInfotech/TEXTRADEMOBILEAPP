import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:textrade/Common/ApiHandler/ApiUtility.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/Parties/Models/FilterLedgerRequest.dart';
import 'package:textrade/SalesForm/model/barCodeRequest.dart';
import 'package:textrade/SalesForm/model/barcodeResponse.dart';
import 'package:textrade/SalesForm/model/salesOrderRequest.dart';
import 'package:textrade/SalesForm/model/searchModel.dart';
import 'package:textrade/SalesForm/model/shipToModel.dart';

enum SalesFormType { party, ship, agent, transport, city }

class SalesFormController extends GetxController {
  var partyName = "Party Name".obs;
  var shipToo = "Ship to".obs;
  var agent = "Agent".obs;
  var transport = "Transport".obs;
  var city = "City".obs;
  TextEditingController descTextField = TextEditingController();
  TextEditingController qtyTextField = TextEditingController();
  TextEditingController mtrsTextField = TextEditingController();
  TextEditingController rateTextField = TextEditingController();

  var scannedQrCodes = <BarcodeTable>[].obs;
  var partyList = <SearchGenericModel>[];
  var cityList = <SearchGenericModel>[];
  var agentList = <SearchGenericModel>[];
  var transPortList = <SearchGenericModel>[];

  var selectedParty = SearchGenericModel("Party Name", "0");
  var selectedCity = SearchGenericModel("City", "0");
  var selectedShipToo = SearchGenericModel("Ship to", "0");
  var selectedTransport = SearchGenericModel("Transport", "0");
  var selectedAgent = SearchGenericModel("Agent", "0");

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  @override
  void onReady() {
    fetchData();
    super.onReady();
  }

  fetchData() async {
    var yearID = AppController.shared.selectedDate?.value;
    Utility.showLoader(title: 'Loading contents...');
    var appUtility = ApiUtility();
    var filterPartiesRequest = FilterPartiesRequest(yearID: yearID);
    var partyName = await appUtility.fetchLedgerDetails(filterPartiesRequest);
    var cityName = await appUtility.fetchCityDetails(filterPartiesRequest);
    var agenName = await appUtility.fetchAgentDetails(filterPartiesRequest);
    var transportName = await appUtility.getTransportList(filterPartiesRequest);

    if (partyName.ledger?.isNotEmpty ?? false) {
      partyList = (partyName.ledger ?? [])
          .map((e) => SearchGenericModel(e.text, e.value))
          .toList();
    }
    if (cityName.city?.isNotEmpty ?? false) {
      cityList = (cityName.city ?? [])
          .map((e) => SearchGenericModel(e.text, e.value))
          .toList();
    }
    if (agenName.agent?.isNotEmpty ?? false) {
      agentList = (agenName.agent ?? [])
          .map((e) => SearchGenericModel(e.text, e.value))
          .toList();
    }
    if (transportName.table?.isNotEmpty ?? false) {
      transPortList = (transportName.table ?? [])
          .map((e) => SearchGenericModel(e.tRANSNAME, e.tRANSID.toString()))
          .toList();
    }
    Utility.hideLoader();
  }

  openSearch(SalesFormType type) {
    var list = <SearchGenericModel>[];
    if (type == SalesFormType.city) {
      list = cityList;
    } else if (type == SalesFormType.agent) {
      list = agentList;
    } else if (type == SalesFormType.transport) {
      list = transPortList;
    } else {
      list = partyList;
    }
    Get.toNamed(Utility.screenName(Screens.searchScreen), arguments: list)
        ?.then((value) {
      switch (type) {
        case SalesFormType.party:
          selectedParty = value;
          selectedShipToo = value;

          partyName.value = value.name;
          shipToo.value = value.name;

          getPartyDetails();
          break;
        case SalesFormType.ship:
          selectedShipToo = value;
          shipToo.value = value.name;
          getShipTooDetails();
          break;
        case SalesFormType.agent:
          selectedAgent = value;
          agent.value = value.name;
          break;
        case SalesFormType.transport:
          selectedTransport = value;
          transport.value = value.name;
          break;
        case SalesFormType.city:
          selectedCity = value;
          city.value = value.name;
          break;
      }
    });
  }

  getShipTooDetails() async {
    if (selectedParty.id == "0") {
      Utility.showErrorView('Alert', 'Please select party name',
          alertType: AlertType.error);
      return;
    }
    var yearID = AppController.shared.selectedDate?.value;
    var shipToRequest =
        ShiptoReqModel(sHIPTOID: selectedShipToo.id, yEARID: yearID);
    Utility.showLoader(title: 'Loading...');
    var value = await ApiUtility().getShipTooDetails(shipToRequest);
    Utility.hideLoader();
    if (value.table?.isNotEmpty ?? false) {
      var data = value.table;
      if (data?.isNotEmpty ?? false) {
        var firstData = data?.first;
        if (firstData != null) {
          selectedCity = SearchGenericModel(
              firstData.cITY ?? '', (firstData.cITYID ?? 0).toString());
          city.value = firstData.cITY ?? '';
          selectedTransport = SearchGenericModel(
              firstData.tRANSNAME ?? '', (firstData.tRANSID ?? 0).toString());
          transport.value = firstData.tRANSNAME ?? '';
        }
      } else {
        Utility.showErrorView('Alert', 'No Ship to found',
            alertType: AlertType.error);
      }
    }
  }

  getPartyDetails() async {
    if (selectedParty.id == "0") {
      Utility.showErrorView('Alert', 'Please select party name',
          alertType: AlertType.error);
      return;
    }
    var yearID = AppController.shared.selectedDate?.value;
    var shipToRequest =
        ShiptoReqModel(nameId: selectedShipToo.id, yEARID: yearID);
    Utility.showLoader(title: 'Loading...');
    var value = await ApiUtility().getPartyDetails(shipToRequest);
    Utility.hideLoader();
    if (value.table?.isNotEmpty ?? false) {
      var data = value.table;
      if (data?.isNotEmpty ?? false) {
        var firstData = data?.first;
        if (firstData != null) {
          selectedCity = SearchGenericModel(
              firstData.cITY ?? '', (firstData.cITYID ?? 0).toString());
          city.value = firstData.cITY ?? '';

          selectedTransport = SearchGenericModel(
              firstData.tRANSNAME ?? '', (firstData.tRANSID ?? 0).toString());
          transport.value = firstData.tRANSNAME ?? '';

          selectedShipToo = SearchGenericModel(
              firstData.sHIPTO ?? '', (firstData.sHIPTOID ?? 0).toString());
          shipToo.value = firstData.sHIPTO ?? '';

          selectedAgent = SearchGenericModel(
              firstData.aGENTNAME ?? '', (firstData.aGENTID ?? 0).toString());
          agent.value = firstData.aGENTNAME ?? '';

          selectedTransport = SearchGenericModel(
              firstData.tRANSNAME ?? '', (firstData.tRANSID ?? 0).toString());
          transport.value = firstData.tRANSNAME ?? '';
        }
      } else {
        Utility.showErrorView('Alert', 'No Ship to found',
            alertType: AlertType.error);
      }
    }
  }

  updateSalesOrder() async {
    if (partyName.value == "Party Name") {
      Utility.showErrorView('Alert', 'Please select party name',
          alertType: AlertType.error);
      return;
    } else if (shipToo.value == "Ship to") {
      Utility.showErrorView('Alert', 'Please select Ship to',
          alertType: AlertType.error);
      return;
    } else if (agent.value == "Agent") {
      Utility.showErrorView('Alert', 'Please select Agent name',
          alertType: AlertType.error);
      return;
    } else if (transport.value == "Transport") {
      Utility.showErrorView('Alert', 'Please select transport',
          alertType: AlertType.error);
      return;
    } else if (city.value == "City") {
      Utility.showErrorView('Alert', 'Please select city',
          alertType: AlertType.error);
      return;
    } else if (scannedQrCodes.isEmpty) {
      Utility.showErrorView('Alert', 'Please Add Items via qr code.',
          alertType: AlertType.error);
      return;
    }

    for (var element in scannedQrCodes) {
      if (element.qty?.text.removeAllWhitespace.isEmpty ?? true) {
        Utility.showErrorView('Alert', 'Please Add Qtys',
            alertType: AlertType.error);
        return;
      } else if (int.parse(element.qty?.text ?? "0") <= 0) {
        Utility.showErrorView('Alert', 'Qty should be greater then 0',
            alertType: AlertType.error);
        return;
      } else if (element.rate?.text.removeAllWhitespace.isEmpty ?? true) {
        Utility.showErrorView('Alert', 'Please Add rates',
            alertType: AlertType.error);
        return;
      } else if (element.mtrs?.text.removeAllWhitespace.isEmpty ?? true) {
        Utility.showErrorView('Alert', 'Please Add Mtrs',
            alertType: AlertType.error);
        return;
      }
    }

    var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var desc = scannedQrCodes.value.map((e) => e.desc?.text ?? "").toList();
    var itemName = scannedQrCodes.value.map((e) => e.iTEMNAME ?? "").toList();
    var color = scannedQrCodes.value.map((e) => e.cOLOR ?? "").toList();
    var designName = scannedQrCodes.value.map((e) => e.dESIGNNO ?? "").toList();
    var mtrs = scannedQrCodes.value.map((e) => e.mtrs?.text ?? "").toList();
    var qty = scannedQrCodes.value.map((e) => e.qty?.text ?? "").toList();
    var ratings = scannedQrCodes.value.map((e) => e.rate?.text ?? "").toList();

    var salesOrderRequest = SalesOrderRequest(
        dATE: date,
        nAMEID: selectedParty.id,
        cITYID: selectedCity.id,
        sHIPTOID: selectedShipToo.id,
        tRANSID: selectedTransport.id,
        aGENTID: selectedAgent.id,
        uSERID: AppController.shared.userId,
        yearID: AppController.shared.selectedDate?.value,
        cMPID: (AppController.shared.selectedCompany?.cmpid ?? 0).toString(),
        cOLOR: color.join('|'),
        iTEMNAME: itemName.join('|'),
        dESIGNNAME: designName.join('|'),
        gRIDREMARKS: desc.join('|'),
        mTRS: mtrs.join('|'),
        qTY: qty.join('|'),
        rATE: ratings.join('|'));

    Utility.showLoader(title: 'Loading...');
    var data = await ApiUtility.shared.saveSalesOrder(salesOrderRequest);
    Utility.hideLoader();
    if ((data.table?[0].column1 ?? false) == true) {
      Get.back();
      Utility.showErrorView("Alert!", (data.table?[0].column2 ?? ""));
    } else {
      Utility.showErrorView("Alert!", (data.table?[0].column2 ?? ""),
          alertType: AlertType.error);
    }
  }

  getBarCodeDetails(String barcode) async {
    var barcodeRequest = BarcodeDetailsRequest(
        bARCODE: "'${barcode}'",
        yearID: AppController.shared.selectedDate?.value);
    var res = await ApiUtility().getBarcodeDetails(barcodeRequest);
    if (res.table?.isNotEmpty ?? false) {
      var dataRes = res.table;
      if (dataRes?.isNotEmpty ?? false) {
        for (var data in dataRes!) {
          data.barcode = barcode;
          scannedQrCodes.value.add(data);
        }
      }

      scannedQrCodes.refresh();
    } else {
      Utility.showErrorView("Error", "Something Went wrong",
          alertType: AlertType.error);
    }
  }
}
