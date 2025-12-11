import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:textrade/Common/DefaultStorageKeys.dart';
import 'package:textrade/Common/StorageManager.dart';

class ApiHandler {
  static final shared = ApiHandler();
  static const oneSpaceBaseURL = "nakodainfotech.com";
  static const baseUrl =
      String.fromEnvironment('baseIP', defaultValue: '122.179.159.186');
  static const addUrl = "/textrade/api/";
  static const addUrl1 = "/api/";
  static const login = "Login/Login";
  static const fetchCompanyList = "Company/FetchCompanyList";
  static const fetchDateList = "Year/FetchYearList";
  static const fetchDashboard = "Dashboard/Dashboard";
  static const fetchItemList = "Item/FetchItemList";
  static const fetchDesignList = "Design/FetchDesignList";
  static const fetchShadeList = "Shade/FetchShadeList";
  static const fetchCATEGORYList = "CATEGORY/FetchCATEGORYList";
  static const fetchGODOWNList = "GODOWN/FetchGODOWNList";
  static const fetchPieceTypeList = "PieceType/FetchPieceTypeList";
  static const fetchUnitList = "Unit/FetchUnitList";
  static const fetchQualityList = "Quality/FetchQualityList";
  static const stockList = "Stock/Stock";
  static const itemTransactions = "ItemTransaction/ItemTransaction";
  static const itemDetails = "ItemDetails/ItemDetails";
  static const FetchRegName = "Register/FetchRegisterList";
  static const FetchItem = "item/item";
  static const FetchDesign = "Design/Design";
  static const FetchLedger = "Ledger/FetchLedger";
  static const FetchAgentList = "Agent/FetchAgentList";
  static const FetchCityList = "City/FetchCityList";
  static const FetchAreaList = "Area/FetchAreaList";
  static const FetchGroupList = "Group/FetchGroupList";
  static const LedgerBalance = "LedgerBalance/LedgerBalance";
  static const LedgerDetails = "LedgerDetails/LedgerDetails";
  static const getRecBalance = "Rec/RecBalance";
  static const getPayBalance = "pay/PayBalance";
  static const FetchRackList = "Rack/FetchRackList";
  static const RackUpdate = "RackUpdate/RackUpdate";
  static const saleOrderSave = "SaleOrderSave/SaleOrderSave";
  static const GetBarcodeDetails = 'BarcodeDetails/GetBarcodeDetails';
  static const GetTransDetails = "TransDetails/GetTransDetails";
  static const ShiptoDetail = "ShiptoDetails/ShiptoDetail";
  static const PartyDetail = 'PartyDetails/PartyDetail';
  static const GetRecOutstanding = 'RecOutstanding/GetRecOutstanding';
  static const GetPayOutstanding = 'PayOutstanding/GetPayOutstanding';
  static const GetAgentRecBal = 'AgentRecBal/GetAgentRecBal';
  static const GetAgentPayBal = 'AgentPayBal/GetAgentPayBal';
  static const GetAgentRecOut = "AgentRecOut/GetAgentRecOut";
  static const GetAgentPayOut = "AgentPayOut/GetAgentPayOut";
  static const GatePassDetail = "GatePassDetail/GatePassDetail";
  static const GetChallan = "Challan/GetChallan";
  static const GetChallanBarcode = "ChallanBarcode/GetChallanBarcode";
  static const SaleGatePassSave = 'SaleGatePassSave/SaleGatePassSave';
  static const generatePdf = 'generatePdf';
  static const generateSaleOrderPdf = 'generateSaleOrderPdf';
  static const generatePurchaseOrderPdf = 'generatePurchaseOrderPdf';
  static const generateChallanPdf = 'generateChallanPdf';
  static const generateSalesPdf = 'generateSalesPdf';
  static const generateTopReportsPdf = 'generateTopReportsPdf';
  static const jsondetails = "/api/details.json";
  static const gatePassDetail = "GatePassDetail/GatePassDetail";
  static const saleGatePassUpdate = "SaleGatePassUpdate/SaleGatePassUpdate";
  static const gdnChallanList = "GDNDetails/GetGDNDetails";
  static const salesInvoiceList = "SaleInvoiceDetails/GetINVDetails";
  static const purchaseInvoiceList =
      "PurchaseInvoiceDetails/GetPurchaseInvoiceDetail";
  static const saleOrderList = "SaleOrderDetail/SaleOrderDetail";
  static const purchaseOrderList = "PurchaseOrderDetail/PurchaseOrderDetail";
  static const topSales = "TopSales/GetTopSales";
  static const topPurchases = "TopPurchases/GetTopPurchases";
  static const stockTaking = "StockTaking/StockTaking";
  static const catalogList = "Catalogue/Catalogue";
  static const saleOrderEnteredList = "Catalogue/Catalogue";
  static const saleOrderPendingList = "Catalogue/Catalogue";
  static const OrderVerificationEnteredList = "SaleOrderVerification/OrderVerification";
  static const OrderVerificationPendingList = "SaleOrderVerification/OrderVerification";
    static const UpdateOrderVerificationEnteredList = "UpdateSaleOrderVerification/UpdateOrderVerification";
  static const UpdateOrderVerificationPendingList = "UpdateSaleOrderVerification/UpdateOrderVerification";

  Future<http.Response> get(
      String apiName, Map<String, String> queryParams) async {
    http.Response responseJson;
    try {
      var baseUrl = await StorageManager.readData(baseUrlVal) ?? "";
      var uri = Uri.http(baseUrl, addUrl + apiName, queryParams);
      final response = await http.get(uri);
      responseJson = _response(response);
    } on SocketException {
      throw throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<http.Response> postApiCallWithRawData(String apiName, String params,
      {Map<String, String>? headers}) async {
    http.Response responseJson;
    try {
      var baseUrl = await StorageManager.readData(baseUrlVal) ?? "";
      var uri = Uri.http(baseUrl, addUrl + apiName);
      print(uri);
      print(params);

      final response = await http.post(uri, body: params, headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<http.Response> postApiCallWithRawDataV1(String apiName, String params,
      {Map<String, String>? headers}) async {
    http.Response responseJson;
    try {
      var uri = Uri.https(oneSpaceBaseURL, addUrl1 + apiName);
      print(uri);

      final response = await http.post(uri, body: params, headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<http.Response> postApiCallCompanyDetailsRawDataV1(String apiName,
      {Map<String, String>? headers}) async {
    http.Response responseJson;
    try {
      var uri = Uri.https(oneSpaceBaseURL, jsondetails);
      final response = await http.post(uri, headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<http.Response> putApiCallRawData(String apiName, String params,
      {Map<String, String>? headers}) async {
    http.Response responseJson;
    try {
      var baseUrl = await StorageManager.readData(baseUrlVal) ?? "";
      var uri = Uri.http(baseUrl, addUrl + apiName);
      print(uri);
      print(params);

      final response = await http.post(uri, body: params, headers: headers);

      print(response);
      responseJson = _response(response);
    } on SocketException {
      throw throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<http.Response> postApiCallWithMultiPart(
      String apiName, Map<String, String> params, String filePath) async {
    http.Response responseJson;
    try {
      var baseUrl = await StorageManager.readData(baseUrlVal) ?? "";
      var uri = Uri.http(baseUrl, addUrl + apiName);
      print(uri);

      var request = http.MultipartRequest(
          'POST', Uri.parse("http://" + baseUrl + addUrl + apiName));
      request.fields.addAll(params);
      if (!filePath.contains("http")) {
        var multipartFile =
            await http.MultipartFile.fromPath('photo', filePath);
        request.files.add(multipartFile);
      }

      http.StreamedResponse streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);
      responseJson = _response(response);
    } on SocketException {
      throw throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  http.Response _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw BadRequestException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        return response;
      case 500:
        throw BadRequestException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode');
    }
  }
}

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
