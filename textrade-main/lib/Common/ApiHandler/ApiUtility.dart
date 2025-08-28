import 'dart:convert';

import 'package:textrade/CatalogList/CatalogModel.dart';
import 'package:textrade/Common/ApiHandler/ApiHandler.dart';
import 'package:textrade/Common/AppController.dart';
import 'package:textrade/Common/DefaultStorageKeys.dart';
import 'package:textrade/Common/StorageManager.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/CompanyList/CompanyListModal.dart';
import 'package:textrade/CompanyList/CompanyListRequest.dart';
import 'package:textrade/DateSelectionScreen/DateSelectionListResponseModel.dart';
import 'package:textrade/DateSelectionScreen/ItemTransaction/Model/ItemTransaction.dart';
import 'package:textrade/DateSelectionScreen/ItemTransaction/Model/ItemTransactionResponse.dart';
import 'package:textrade/Filter/FilterModel/CategoryListModel.dart';
import 'package:textrade/Filter/FilterModel/DesignListModel.dart';
import 'package:textrade/Filter/FilterModel/FilterItemModel.dart';
import 'package:textrade/Filter/FilterModel/GenericFilterRequestModel.dart';
import 'package:textrade/Filter/FilterModel/GoDownListModel.dart';
import 'package:textrade/Filter/FilterModel/ItemDetailsRequestModel.dart';
import 'package:textrade/Filter/FilterModel/ItemDetailsResponseModel.dart';
import 'package:textrade/Filter/FilterModel/PieceTypeListModel.dart';
import 'package:textrade/Filter/FilterModel/QualityListModel.dart';
import 'package:textrade/Filter/FilterModel/ShadeListModel.dart';
import 'package:textrade/Filter/FilterModel/UnitListModel.dart';
import 'package:textrade/GatePass/Model/GetPassModel.dart';
import 'package:textrade/GatePass/Model/SelectedChallanDetails.dart';
import 'package:textrade/GatePass/Model/challanListModel.dart';
import 'package:textrade/HomeScreen/HomeScreenRequestModel.dart';
import 'package:textrade/HomeScreen/HomeScreenResponseModel.dart';
import 'package:textrade/Items/StockRequestModel.dart';
import 'package:textrade/Items/StockResponseModel.dart';
import 'package:textrade/LoginScreen/LoginRequestModel.dart';
import 'package:textrade/LoginScreen/LoginresponseModel.dart';
import 'package:textrade/LoginScreen/verifyCompanyModel.dart';
import 'package:textrade/Outstanding/OutstandingDetaisResModel.dart';
import 'package:textrade/Outstanding/PDFGenerationReq.dart';
import 'package:textrade/Parties/Models/DesignResponse.dart';
import 'package:textrade/Parties/Models/FilterAgentRequest.dart';
import 'package:textrade/Parties/Models/FilterAreaResponse.dart';
import 'package:textrade/Parties/Models/FilterCityResponse.dart';
import 'package:textrade/Parties/Models/FilterGroupResponse.dart';
import 'package:textrade/Parties/Models/FilterLedgerRequest.dart';
import 'package:textrade/Parties/Models/FilterLedgerResponse.dart';
import 'package:textrade/Parties/Models/ItemReponse.dart';
import 'package:textrade/Parties/Models/LedgerMainRequestModel.dart';
import 'package:textrade/Parties/Models/LedgerMainResponseModel.dart';
import 'package:textrade/Parties/Models/RegNameResponse.dart';
import 'package:textrade/PartyDetail/PartyDetailRequestModel.dart';
import 'package:textrade/PartyDetail/PartyResponseModel.dart';
import 'package:textrade/SalePurchaseOrder/PurchaseOrderListModel.dart';
import 'package:textrade/SalePurchaseOrder/SaleOrderList.dart';
import 'package:textrade/SalePurchaseOrder/SaleOrderListModel.dart';
import 'package:textrade/SalesForm/model/barCodeRequest.dart';
import 'package:textrade/SalesForm/model/barcodeResponse.dart';
import 'package:textrade/SalesForm/model/partyDetailRes.dart';
import 'package:textrade/SalesForm/model/salesOrderRequest.dart';
import 'package:textrade/SalesForm/model/shipToModel.dart';
import 'package:textrade/SalesForm/model/transportlistmodel.dart';
import 'package:textrade/SalesPurchaseInvoice/PurchaseInvoiceListModel.dart';
import 'package:textrade/SalesPurchaseInvoice/salesInvoiceListModel.dart';
import 'package:textrade/TopSalePurchaseReport/TopSalePurchaseModel.dart';
import 'package:textrade/rack/model/rack_model.dart';
import 'package:textrade/rack/model/update_rack_res.dart';

import '../../Challan/ChallanGDNModel.dart';
import '../../DateSelectionScreen/DateSelectionRequestModel.dart';

class ApiUtility {
  static final shared = ApiUtility();
  Map<String, String> header = {"Content-Type": "application/json"};

  Future<LoginResponseModel?> loginApiCall(
      String userId, String password, String imei) async {
    var loginRequestModel =
        LoginRequestModel(userName: userId, passWord: password, imei: imei);
    var loginRequest = loginRequestModel.toJson();
    var body = jsonEncode(loginRequest);

    var response = await ApiHandler.shared
        .putApiCallRawData(ApiHandler.login, body, headers: header);
    return LoginResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<CompanyListModel?> companyListApiCall() async {
    var user = await StorageManager.readData(userId);
    var companyRequestModel = CompanyListRequestModel(userID: user);
    var getCompanyRequest = companyRequestModel.toJson();
    var body = jsonEncode(getCompanyRequest);

    var response = await ApiHandler.shared
        .putApiCallRawData(ApiHandler.fetchCompanyList, body, headers: header);
    return CompanyListModel.fromJson(jsonDecode(response.body));
  }

  Future<DateListResponseModel?> dateListApiCall() async {
    var compVal = AppController.shared.selectedCompany?.cmpid;
    var companyRequestModel = DateListRequestModel(CmpID: compVal.toString());
    var getCompanyRequest = companyRequestModel.toJson();
    var body = jsonEncode(getCompanyRequest);

    var response = await ApiHandler.shared
        .putApiCallRawData(ApiHandler.fetchDateList, body, headers: header);
    return DateListResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<HomeScreenResponseModel?> dashboardistApiCall(
      {Year? selectedYear}) async {
    var homeScreenRequestModel = HomeScreenRequestModel(
        fromDate: Utility.convertDateFormate(selectedYear?.text ?? ""),
        toDate: Utility.convertDateFormate(selectedYear?.text1 ?? ""),
        yearID: selectedYear?.value ?? "");
    var getHomeScreenRequestModel = homeScreenRequestModel.toJson();
    print(getHomeScreenRequestModel);
    var body = jsonEncode(getHomeScreenRequestModel);
    var response = await ApiHandler.shared
        .putApiCallRawData(ApiHandler.fetchDashboard, body, headers: header);
    return HomeScreenResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<ItemListModel?> filterFetchItemList() async {
    var requestModel = GenericFilterRequestModel(
        yearID: AppController.shared.selectedDate!.value ?? "");
    var getHomeScreenRequestModel = requestModel.toJson();
    print(getHomeScreenRequestModel);
    var body = jsonEncode(getHomeScreenRequestModel);
    var response = await ApiHandler.shared
        .putApiCallRawData(ApiHandler.fetchItemList, body, headers: header);
    return ItemListModel.fromJson(jsonDecode(response.body));
  }

  Future<DesignListModel?> filterFetchDesignList() async {
    var requestModel = GenericFilterRequestModel(
        yearID: AppController.shared.selectedDate!.value ?? "");
    var getHomeScreenRequestModel = requestModel.toJson();
    print(getHomeScreenRequestModel);
    var body = jsonEncode(getHomeScreenRequestModel);
    var response = await ApiHandler.shared
        .putApiCallRawData(ApiHandler.fetchDesignList, body, headers: header);
    return DesignListModel.fromJson(jsonDecode(response.body));
  }

  Future<ShadeListModel?> filterFetchShadeList() async {
    var requestModel = GenericFilterRequestModel(
        yearID: AppController.shared.selectedDate!.value ?? "");
    var getHomeScreenRequestModel = requestModel.toJson();
    print(getHomeScreenRequestModel);
    var body = jsonEncode(getHomeScreenRequestModel);
    var response = await ApiHandler.shared
        .putApiCallRawData(ApiHandler.fetchShadeList, body, headers: header);
    return ShadeListModel.fromJson(jsonDecode(response.body));
  }

  Future<CategoryListModel?> filterFetchCATEGORYList() async {
    var requestModel = GenericFilterRequestModel(
        yearID: AppController.shared.selectedDate!.value ?? "");
    var getHomeScreenRequestModel = requestModel.toJson();
    print(getHomeScreenRequestModel);
    var body = jsonEncode(getHomeScreenRequestModel);
    var response = await ApiHandler.shared
        .putApiCallRawData(ApiHandler.fetchCATEGORYList, body, headers: header);
    return CategoryListModel.fromJson(jsonDecode(response.body));
  }

  Future<GoDownListModel?> filterFetchGODOWNList() async {
    var requestModel = GenericFilterRequestModel(
        yearID: AppController.shared.selectedDate!.value ?? "");
    var getHomeScreenRequestModel = requestModel.toJson();
    print(getHomeScreenRequestModel);
    var body = jsonEncode(getHomeScreenRequestModel);
    var response = await ApiHandler.shared
        .putApiCallRawData(ApiHandler.fetchGODOWNList, body, headers: header);
    return GoDownListModel.fromJson(jsonDecode(response.body));
  }

  Future<PieceTypeListModel?> filterFetchPieceTypeList() async {
    var requestModel = GenericFilterRequestModel(
        yearID: AppController.shared.selectedDate!.value ?? "");
    var getHomeScreenRequestModel = requestModel.toJson();
    print(getHomeScreenRequestModel);
    var body = jsonEncode(getHomeScreenRequestModel);
    var response = await ApiHandler.shared.putApiCallRawData(
        ApiHandler.fetchPieceTypeList, body,
        headers: header);
    return PieceTypeListModel.fromJson(jsonDecode(response.body));
  }

  Future<UnitListModel?> filterFetchUnitList() async {
    var requestModel = GenericFilterRequestModel(
        yearID: AppController.shared.selectedDate!.value ?? "");
    var getHomeScreenRequestModel = requestModel.toJson();
    print(getHomeScreenRequestModel);
    var body = jsonEncode(getHomeScreenRequestModel);
    var response = await ApiHandler.shared
        .putApiCallRawData(ApiHandler.fetchUnitList, body, headers: header);
    return UnitListModel.fromJson(jsonDecode(response.body));
  }

  Future<QualityListModel?> filterFetchQualityList() async {
    var requestModel = GenericFilterRequestModel(
        yearID: AppController.shared.selectedDate!.value ?? "");
    var getHomeScreenRequestModel = requestModel.toJson();
    print(getHomeScreenRequestModel);
    var body = jsonEncode(getHomeScreenRequestModel);
    var response = await ApiHandler.shared
        .putApiCallRawData(ApiHandler.fetchQualityList, body, headers: header);
    return QualityListModel.fromJson(jsonDecode(response.body));
  }

  Future<StockResponseModel?> fetchStocks(
      StockRequestModel stockRequestModel) async {
    var request = stockRequestModel.toJson();
    var body = jsonEncode(request);
    print(request);
    var response = await ApiHandler.shared
        .postApiCallWithRawData(ApiHandler.stockList, body, headers: header);
    return StockResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<ItemTransactionResponse> fetchItemTransactions(
      ItemTransactionRequest itemTransactionRequest) async {
    var request = itemTransactionRequest.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.itemTransactions, body,
        headers: header);
    return ItemTransactionResponse.fromJson(jsonDecode(response.body));
  }

  Future<ItemDetailsResponseModel> fetchItemDetails(
      ItemDetailsRequestModel itemDetailsRequestModel) async {
    var request = itemDetailsRequestModel.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared
        .postApiCallWithRawData(ApiHandler.itemDetails, body, headers: header);
    return ItemDetailsResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<ItemReponse> fetchItem(
      FilterPartiesRequest filterPartiesRequest) async {
    var request = filterPartiesRequest.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared
        .postApiCallWithRawData(ApiHandler.FetchItem, body, headers: header);
    return ItemReponse.fromJson(jsonDecode(response.body));
  }

  Future<DesignResponse> fetchDesign(
      FilterPartiesRequest filterPartiesRequest) async {
    var request = filterPartiesRequest.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared
        .postApiCallWithRawData(ApiHandler.FetchDesign, body, headers: header);
    return DesignResponse.fromJson(jsonDecode(response.body));
  }

  Future<FilterLedgerResponse> fetchLedgerDetails(
      FilterPartiesRequest filterPartiesRequest) async {
    var request = filterPartiesRequest.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared
        .postApiCallWithRawData(ApiHandler.FetchLedger, body, headers: header);
    return FilterLedgerResponse.fromJson(jsonDecode(response.body));
  }

  Future<RegNameResponse> fetchRegNameDetails(
      FilterPartiesRequest filterPartiesRequest) async {
    var request = filterPartiesRequest.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared
        .postApiCallWithRawData(ApiHandler.FetchRegName, body, headers: header);
    return RegNameResponse.fromJson(jsonDecode(response.body));
  }

  Future<FilterAgentResponse> fetchAgentDetails(
      FilterPartiesRequest filterPartiesRequest) async {
    var request = filterPartiesRequest.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.FetchAgentList, body,
        headers: header);
    return FilterAgentResponse.fromJson(jsonDecode(response.body));
  }

  Future<FilterCityResponse> fetchCityDetails(
      FilterPartiesRequest filterPartiesRequest) async {
    var request = filterPartiesRequest.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.FetchCityList, body,
        headers: header);
    return FilterCityResponse.fromJson(jsonDecode(response.body));
  }

  Future<FilterAreaResponse> fetchAreaDetails(
      FilterPartiesRequest filterPartiesRequest) async {
    var request = filterPartiesRequest.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.FetchAreaList, body,
        headers: header);
    return FilterAreaResponse.fromJson(jsonDecode(response.body));
  }

  Future<FilterGroupResponse> fetchGroupDetails(
      FilterPartiesRequest filterPartiesRequest) async {
    var request = filterPartiesRequest.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.FetchGroupList, body,
        headers: header);
    return FilterGroupResponse.fromJson(jsonDecode(response.body));
  }

  Future<LedgerMainResponseModel> fetchMainLedgerDetails(
      LedgerMainRequest ledgerMainRequest) async {
    var request = ledgerMainRequest.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.LedgerBalance, body,
        headers: header);
    return LedgerMainResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<PartyResponseModel> fetchPartyDetail(
      PartyDetailRequestModel partyDetailRequestModel) async {
    var request = partyDetailRequestModel.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.LedgerDetails, body,
        headers: header);
    return PartyResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<OutstandingDetailResModel> fetchRecOutStanding(
      LedgerMainRequest partyDetailRequestModel) async {
    var request = partyDetailRequestModel.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.GetRecOutstanding, body,
        headers: header);
    return OutstandingDetailResModel.fromJson(jsonDecode(response.body));
  }

  Future<OutstandingDetailResModel> fetchPayOutstanding(
      LedgerMainRequest partyDetailRequestModel) async {
    var request = partyDetailRequestModel.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.GetPayOutstanding, body,
        headers: header);
    return OutstandingDetailResModel.fromJson(jsonDecode(response.body));
  }

  Future<OutstandingDetailResModel> fetchAgentRecOutStanding(
      LedgerMainRequest partyDetailRequestModel) async {
    var request = partyDetailRequestModel.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.GetAgentRecOut, body,
        headers: header);
    return OutstandingDetailResModel.fromJson(jsonDecode(response.body));
  }

  Future<OutstandingDetailResModel> fetchAgentPayOutstanding(
      LedgerMainRequest partyDetailRequestModel) async {
    var request = partyDetailRequestModel.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.GetAgentPayOut, body,
        headers: header);
    return OutstandingDetailResModel.fromJson(jsonDecode(response.body));
  }

  Future<LedgerMainResponseModel> getRecBalance(
      LedgerMainRequest ledgerMainRequest) async {
    var request = ledgerMainRequest.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.getRecBalance, body,
        headers: header);
    return LedgerMainResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<LedgerMainResponseModel> getPayBalance(
      LedgerMainRequest ledgerMainRequest) async {
    var request = ledgerMainRequest.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.getPayBalance, body,
        headers: header);
    return LedgerMainResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<LedgerMainResponseModel> getAgentRecBalance(
      LedgerMainRequest ledgerMainRequest) async {
    var request = ledgerMainRequest.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.GetAgentRecBal, body,
        headers: header);
    return LedgerMainResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<LedgerMainResponseModel> getAgentPayBalance(
      LedgerMainRequest ledgerMainRequest) async {
    var request = ledgerMainRequest.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.GetAgentPayBal, body,
        headers: header);
    return LedgerMainResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<RackModel> fetchRackList(LedgerMainRequest ledgerMainRequest) async {
    var request = ledgerMainRequest.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.FetchRackList, body,
        headers: header);
    return RackModel.fromJson(jsonDecode(response.body));
  }

  Future<UpadateRackResModel> updateRack(
      UpadateRackModel upadateRackModel) async {
    var request = upadateRackModel.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared
        .postApiCallWithRawData(ApiHandler.RackUpdate, body, headers: header);
    return UpadateRackResModel.fromJson(jsonDecode(response.body));
  }

  Future<UpadateRackResModel> updateStock(
      UpdateStockTacking upadateRackModel) async {
    var request = upadateRackModel.toJson();
    var body = jsonEncode(request);
    print(body);
    var response = await ApiHandler.shared
        .postApiCallWithRawData(ApiHandler.stockTaking, body, headers: header);
    return UpadateRackResModel.fromJson(jsonDecode(response.body));
  }

  Future<BarcodeDetailsResponse> getBarcodeDetails(
      BarcodeDetailsRequest barcodeDetailsRequest) async {
    var request = barcodeDetailsRequest.toJson();
    var body = jsonEncode(request);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.GetBarcodeDetails, body,
        headers: header);
    return BarcodeDetailsResponse.fromJson(jsonDecode(response.body));
  }

  Future<UpadateRackResModel> saveSalesOrder(
      SalesOrderRequest salesOrderRequest) async {
    var request = salesOrderRequest.toJson();
    var body = jsonEncode(request);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.saleOrderSave, body,
        headers: header);
    return UpadateRackResModel.fromJson(jsonDecode(response.body));
  }

  Future<TransportListRes> getTransportList(
      FilterPartiesRequest filterPartiesRequest) async {
    var request = filterPartiesRequest.toJson();
    var body = jsonEncode(request);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.GetTransDetails, body,
        headers: header);
    return TransportListRes.fromJson(jsonDecode(response.body));
  }

  Future<ShiptoResModel> getShipTooDetails(
      ShiptoReqModel shiptoReqModel) async {
    var request = shiptoReqModel.toJson();
    var body = jsonEncode(request);
    var response = await ApiHandler.shared
        .postApiCallWithRawData(ApiHandler.ShiptoDetail, body, headers: header);
    return ShiptoResModel.fromJson(jsonDecode(response.body));
  }

  Future<PartyDetailRes> getPartyDetails(ShiptoReqModel shiptoReqModel) async {
    var request = shiptoReqModel.toJson();
    var body = jsonEncode(request);
    var response = await ApiHandler.shared
        .postApiCallWithRawData(ApiHandler.PartyDetail, body, headers: header);
    return PartyDetailRes.fromJson(jsonDecode(response.body));
  }

  Future<GetPassListModel> getGatePassList() async {
    var requestModel = GenericFilterRequestModel(
        yearID: AppController.shared.selectedDate!.value ?? ""); //
    var gatePassReqModel = requestModel.toJson();
    print(gatePassReqModel);
    var body = jsonEncode(gatePassReqModel);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.GatePassDetail, body,
        headers: header);
    return GetPassListModel.fromJson(jsonDecode(response.body));
  }

  Future<TopSalePurchaseModel> getTopSales(
      String type,
      String itemName,
      String nameID,
      String agentId,
      String city,
      String startDateStr,
      String endDateStr) async {
    var requestModel = {
      "TYPE": type,
      "Name": nameID,
      "AgentName": agentId,
      "City": city,
      "ITEMNAME": itemName,
      "From_Date": startDateStr,
      "To_Date": endDateStr,
      "YearID": AppController.shared.selectedDate!.value ?? ""
    };
    var body = jsonEncode(requestModel);
    print(body);
    var response = await ApiHandler.shared
        .postApiCallWithRawData(ApiHandler.topSales, body, headers: header);
    return TopSalePurchaseModel.fromJson(jsonDecode(response.body));
  }

  Future<TopSalePurchaseModel> getTopPuchases(
      String type,
      String itemName,
      String nameID,
      String agentId,
      String city,
      String startDateStr,
      String endDateStr) async {
    var requestModel = {
      "TYPE": type,
      "Name": nameID,
      "AgentName": agentId,
      "City": city,
      "ITEMNAME": itemName,
      "From_Date": startDateStr,
      "To_Date": endDateStr,
      "YearID": AppController.shared.selectedDate!.value ?? ""
    };
    var body = jsonEncode(requestModel);
    print(body);
    var response = await ApiHandler.shared
        .postApiCallWithRawData(ApiHandler.topPurchases, body, headers: header);
    return TopSalePurchaseModel.fromJson(jsonDecode(response.body));
  }

  Future<PurchaseOrderListModel> getPurchaseOrderList(
      String from,
      String to,
      String nameID,
      String agentId,
      String startDateStr,
      String endDateStr) async {
    var requestModel = {
      "FROM": from,
      "TO": to,
      "PONO": "",
      "NAME": nameID,
      "AGENT": agentId,
      "From_Date": startDateStr,
      "To_Date": endDateStr,
      "YEARID": AppController.shared.selectedDate!.value ?? ""
    };

    var body = jsonEncode(requestModel);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.purchaseOrderList, body,
        headers: header);
    return PurchaseOrderListModel.fromJson(jsonDecode(response.body));
  }

  Future<SaleOrderListModel> getSaleOrderList(
      String from,
      String to,
      String nameID,
      String agentId,
      String startDateStr,
      String endDateStr) async {
    var requestModel = {
      "FROM": from,
      "TO": to,
      "SONO": "",
      "NAME": nameID,
      "AGENT": agentId,
      "From_Date": startDateStr,
      "To_Date": endDateStr,
      "YEARID": AppController.shared.selectedDate!.value ?? ""
    };

    var body = jsonEncode(requestModel);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.saleOrderList, body,
        headers: header);
    return SaleOrderListModel.fromJson(jsonDecode(response.body));
  }

  Future<PurchaseInvoiceListModel> getPurchaseInvoiceList(
      String from,
      String to,
      String nameID,
      String agentId,
      String reg,
      String startDateStr,
      String endDateStr) async {
    var requestModel = {
      "FROM": from,
      "TO": to,
      "INVNO": "",
      "REGNAME": "'$reg'",
      "NAME": nameID,
      "AGENT": agentId,
      "From_Date": startDateStr,
      "To_Date": endDateStr,
      "YEARID": AppController.shared.selectedDate!.value ?? ""
    };

    var body = jsonEncode(requestModel);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.purchaseInvoiceList, body,
        headers: header);
    return PurchaseInvoiceListModel.fromJson(jsonDecode(response.body));
  }

  Future<SalesInvoiceListModel> getDayBookList(
      String from,
      String to,
      String nameID,
      String agentId,
      String startDateStr,
      String endDateStr) async {
    var requestModel = {
      "FROM": from,
      "TO": to,
      "INVNO": "",
      "NAME": nameID,
      "AGENT": agentId,
      "From_Date": startDateStr,
      "To_Date": endDateStr,
      "YEARID": AppController.shared.selectedDate!.value ?? ""
    };

    var body = jsonEncode(requestModel);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.salesInvoiceList, body,
        headers: header);
    return SalesInvoiceListModel.fromJson(jsonDecode(response.body));
  }

  Future<SalesInvoiceListModel> getSaleInvoiceList(
      String from,
      String to,
      String nameID,
      String agentId,
      String reg,
      String startDateStr,
      String endDateStr) async {
    var requestModel = {
      "FROM": from,
      "TO": to,
      "INVNO": "",
      "REGNAME": "'$reg'",
      "NAME": nameID,
      "AGENT": agentId,
      "From_Date": startDateStr,
      "To_Date": endDateStr,
      "YEARID": AppController.shared.selectedDate!.value ?? ""
    };

    var body = jsonEncode(requestModel);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.salesInvoiceList, body,
        headers: header);
    return SalesInvoiceListModel.fromJson(jsonDecode(response.body));
  }

  Future<ChallanGDNModel> getGDNChallanList(
      String from,
      String to,
      String nameID,
      String agentId,
      String startDateStr,
      String endDateStr) async {
    var requestModel = {
      "FROM": from,
      "TO": to,
      "NAME": nameID,
      "AGENT": agentId,
      "From_Date": startDateStr,
      "To_Date": endDateStr,
      "YEARID": AppController.shared.selectedDate!.value ?? ""
    };

    var body = jsonEncode(requestModel);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.gdnChallanList, body,
        headers: header);
    return ChallanGDNModel.fromJson(jsonDecode(response.body));
  }

  Future<ChallanListModel> getChallanList(
      String nameID, String agentId, String transId, String gpNo) async {
    var requestModel = {
      "NAMEID": nameID,
      "AGENTID": agentId,
      "TRANSID": transId,
      "YEARID": AppController.shared.selectedDate!.value ?? "",
      "GPNO": gpNo
    }; //
    print(requestModel);
    var body = jsonEncode(requestModel);
    var response = await ApiHandler.shared
        .postApiCallWithRawData(ApiHandler.GetChallan, body, headers: header);
    return ChallanListModel.fromJson(jsonDecode(response.body));
  }

  Future<GetSelectedChallanBarcodeRes> getSelectChallanDetails(
      String challanNo, String challanName, int isEdit) async {
    var gatePassReqModel = {
      "CHALLANNO": challanNo,
      "NAME": challanName,
      "YEARID": AppController.shared.selectedDate!.value ?? "",
      "isEdit": isEdit
    };
    print(gatePassReqModel);
    var body = jsonEncode(gatePassReqModel);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.GetChallanBarcode, body,
        headers: header);
    return GetSelectedChallanBarcodeRes.fromJson(jsonDecode(response.body));
  }

  Future<UpadateRackResModel> submitGatePass(Map req, bool isForUpdate) async {
    var body = jsonEncode(req);
    print(body);
    String apiEndPoint = isForUpdate
        ? ApiHandler.saleGatePassUpdate
        : ApiHandler.SaleGatePassSave;
    var response = await ApiHandler.shared
        .postApiCallWithRawData(apiEndPoint, body, headers: header);
    return UpadateRackResModel.fromJson(jsonDecode(response.body));
  }

  Future<CatalogModel> getCatalogList(
      String designName, String itemName, bool isIncludeSelected) async {
    var requestModel = {
      "DesignName": designName,
      "ItemName": itemName,
      "YearID": AppController.shared.selectedDate!.value ?? "",
      "INCLUDESTOCK": isIncludeSelected == true ? 1 : 0
    };
    var body = jsonEncode(requestModel);
    print(body);
    var response = await ApiHandler.shared
        .postApiCallWithRawData(ApiHandler.catalogList, body, headers: header);
    return CatalogModel.fromJson(jsonDecode(response.body));
  }

  Future<PDFGenetarionRes> generatePDF(Map req) async {
    var body = jsonEncode(req);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawDataV1(
        ApiHandler.generatePdf, body,
        headers: header);
    return PDFGenetarionRes.fromJson(jsonDecode(response.body));
  }

  Future<PDFGenetarionRes> generateSalesPDF(Map req) async {
    var body = jsonEncode(req);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawDataV1(
        ApiHandler.generateSalesPdf, body,
        headers: header);
    return PDFGenetarionRes.fromJson(jsonDecode(response.body));
  }

  Future<PDFGenetarionRes> generateTopPDF(Map req) async {
    var body = jsonEncode(req);
    var response = await ApiHandler.shared.postApiCallWithRawDataV1(
        ApiHandler.generateTopReportsPdf, body,
        headers: header);
    return PDFGenetarionRes.fromJson(jsonDecode(response.body));
  }

  Future<PDFGenetarionRes> generateChallanPDF(Map req) async {
    var body = jsonEncode(req);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawDataV1(
        ApiHandler.generateChallanPdf, body,
        headers: header);
    return PDFGenetarionRes.fromJson(jsonDecode(response.body));
  }

  Future<PDFGenetarionRes> generateSaleOrderPDF(Map req) async {
    var body = jsonEncode(req);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawDataV1(
        ApiHandler.generateSaleOrderPdf, body,
        headers: header);
    return PDFGenetarionRes.fromJson(jsonDecode(response.body));
  }

  Future<PDFGenetarionRes> generatePurchaseOrderPDF(Map req) async {
    var body = jsonEncode(req);
    print(body);
    var response = await ApiHandler.shared.postApiCallWithRawDataV1(
        ApiHandler.generatePurchaseOrderPdf, body,
        headers: header);
    return PDFGenetarionRes.fromJson(jsonDecode(response.body));
  }

  Future<ChallanListModel> getGatePassDetail(String gpNo) async {
    var gatePassReqModel = {
      "GPNO": gpNo,
      "YEARID": AppController.shared.selectedDate!.value ?? ""
    };
    print(gatePassReqModel);
    var body = jsonEncode(gatePassReqModel);
    var response = await ApiHandler.shared.postApiCallWithRawData(
        ApiHandler.gatePassDetail, body,
        headers: header);
    return ChallanListModel.fromJson(jsonDecode(response.body));
  }

  Future<verifyCompanyModel> getCompanyDetails() async {
    var response = await ApiHandler.shared
        .postApiCallCompanyDetailsRawDataV1("", headers: header);
    return verifyCompanyModel.fromJson(jsonDecode(response.body));
  }
}
