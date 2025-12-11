import 'package:get/get.dart';
import 'package:textrade/CatalogList/CatalogList.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/CommonFilter/CommanFilterScreen.dart';
import 'package:textrade/DateSelectionScreen/ItemTransaction/DateDetailScreen.dart';
import 'package:textrade/Filter/FilterScreen.dart';
import 'package:textrade/GDNChallanDetails/GDNChallanDetails.dart';
import 'package:textrade/GatePass/screens/ChallanListScreen.dart';
import 'package:textrade/GatePass/screens/ChallansFilter.dart';
import 'package:textrade/GatePass/screens/GatePassForm.dart';
import 'package:textrade/GatePass/screens/GetPassListing.dart';
import 'package:textrade/Items/ItemDetailScreen/ItemDetailScreen.dart';
import 'package:textrade/Items/ItemsScreen.dart';
import 'package:textrade/LoginScreen/LoginScreen.dart';
import 'package:textrade/Outstanding/Outstanding.dart';
import 'package:textrade/Outstanding/OutstandingDetailScreen.dart';
import 'package:textrade/Outstanding/OutstandingFilertScreen.dart';
import 'package:textrade/Parties/PartiesFilter/PartiesFilterScreen.dart';
import 'package:textrade/Parties/Screens/PartyScreen.dart';
import 'package:textrade/PartyDetail/PartyDetailScreen.dart';
import 'package:textrade/QRScreen/QrScanner.dart';
import 'package:textrade/SalePurchaseOrder/PurchaseOrderList.dart';
import 'package:textrade/SalePurchaseOrder/PurchaseOrderListDetail.dart';
import 'package:textrade/SalePurchaseOrder/SaleOrderList.dart';
import 'package:textrade/SalePurchaseOrder/SaleOrderListDetail.dart';
import 'package:textrade/SalesForm/screen/salesFormScreen.dart';
import 'package:textrade/SalesForm/screen/search_screen.dart';
import 'package:textrade/SalesPurchaseInvoice/PurchaseInvoiceDetails.dart';
import 'package:textrade/SalesPurchaseInvoice/PurchaseInvoiceList.dart';
import 'package:textrade/SalesPurchaseInvoice/SalesInvoiceDetails.dart';
import 'package:textrade/SalesPurchaseInvoice/SalesInvoiceList.dart';
import 'package:textrade/SplashScreen/SplashScreen.dart';
import 'package:textrade/TopReport/topReportScreen.dart';
import 'package:textrade/TopSalePurchaseReport/TopReportFilterScreen.dart';
import 'package:textrade/TopSalePurchaseReport/TopSalePurchaseReportDetail.dart';
import 'package:textrade/rack/screens/rack_screen.dart';
import 'package:textrade/two_dimensional_tables/table.dart';
import 'package:textrade/SalePurchaseOrder/SaleOrderVerificationScreen.dart';
import '../Challan/ChallanGDNScreen.dart';
import '../CompanyList/CompanyListScreen.dart';
import '../DateSelectionScreen/DateSelectionScreen.dart';
import '../tabbar/tabbar.dart';

class Routes {
  static var shared = Routes();

  List<GetPage<dynamic>>? pages = [
    GetPage(
        name: Utility.screenName(Screens.splash), page: () => SplashScreen()),
    GetPage(
        name: Utility.screenName(Screens.loginScreen),
        page: () => LoginScreen()),
    GetPage(name: Utility.screenName(Screens.tabBar), page: () => TabBar()),
    GetPage(
        name: Utility.screenName(Screens.companyListScreen),
        page: () => CompanyListScreen()),
    GetPage(
        name: Utility.screenName(Screens.dateListScreen),
        page: () => DateListScreen()),
    GetPage(
        name: Utility.screenName(Screens.itemScreen),
        page: () => ItemsScreen()),
    GetPage(
        name: Utility.screenName(Screens.filterScreen),
        page: () => FilterScreen()),
    GetPage(name: Utility.screenName(Screens.tableScreen), page: () => Table()),
    GetPage(
        name: Utility.screenName(Screens.itemTransactionsScreen),
        page: () => ItemTransactionsScreen()),
    GetPage(
        name: Utility.screenName(Screens.OutstandingScreen),
        page: () => OutstandingScreen()),
    GetPage(
        name: Utility.screenName(Screens.itemDetailScreen),
        page: () => ItemDetailScreen()),
    GetPage(
        name: Utility.screenName(Screens.partyScreen),
        page: () => PartyScreen()),
    GetPage(
        name: Utility.screenName(Screens.partiesFilterScreen),
        page: () => PartiesFilterScreen()),
    GetPage(
        name: Utility.screenName(Screens.partyDetailScreen),
        page: () => PartyDetailScreen()),
    GetPage(
        name: Utility.screenName(Screens.OutstandingDetailScreen),
        page: () => OutstandingDetailScreen()),
    GetPage(
        name: Utility.screenName(Screens.outStandingFilterScreen),
        page: () => OutStandingFilterScreen()),
    GetPage(
        name: Utility.screenName(Screens.qrScanner),
        page: () => QRScannerTexTrade()),
    GetPage(
        name: Utility.screenName(Screens.rackScreen), page: () => RackScreen()),
    GetPage(
        name: Utility.screenName(Screens.salesForm),
        page: () => SalesFormScreen()),
    GetPage(
        name: Utility.screenName(Screens.searchScreen),
        page: () => SearchScreen()),
    GetPage(
        name: Utility.screenName(Screens.topReports), page: () => TopReports()),
    GetPage(
        name: Utility.screenName(Screens.gatePassScreen),
        page: () => GatePassList()),
    GetPage(
        name: Utility.screenName(Screens.challanListScreen),
        page: () => ChallanList()),
    GetPage(
        name: Utility.screenName(Screens.gatePassFormScreen),
        page: () => GatePassFormScreen()),
    GetPage(
        name: Utility.screenName(Screens.challanFiler),
        page: () => ChallansFilter()),
    GetPage(
        name: Utility.screenName(Screens.challanScreen),
        page: () => ChallanGDNScreen()),
    GetPage(
        name: Utility.screenName(Screens.gdnChallanDetailsScreen),
        page: () => GDNChallanDetails()),
    GetPage(
        name: Utility.screenName(Screens.salesInvoiceListScreen),
        page: () => SalesInvoiceList()),
    GetPage(
        name: Utility.screenName(Screens.salesInvoiceListDetailScreen),
        page: () => SalesInvoiceDetails()),
    GetPage(
        name: Utility.screenName(Screens.purchaseInvoiceListScreen),
        page: () => PurchaseInvoiceList()),
    GetPage(
        name: Utility.screenName(Screens.purchaseInvoiceListDetailScreen),
        page: () => PurchaseInvoiceDetails()),
    GetPage(
        name: Utility.screenName(Screens.saleOrderScreen),
        page: () => SaleOrderList()),
    GetPage(
        name: Utility.screenName(Screens.saleOrderDetailScreen),
        page: () => SaleOrderListDetail()),
    GetPage(
        name: Utility.screenName(Screens.purchaseOrderScreen),
        page: () => PurchaseOrderList()),
    GetPage(
        name: Utility.screenName(Screens.purchaseOrderDetailScreen),
        page: () => PurchaseOrderListDetail()),
    GetPage(
        name: Utility.screenName(Screens.topSalePurchaseDetailScreen),
        page: () => TopSalePurchaseReportDetail()),
    GetPage(
        name: Utility.screenName(Screens.commonFilter),
        page: () => CommanFilterScreen()),
    GetPage(
        name: Utility.screenName(Screens.topReportsFilter),
        page: () => TopReportFilterScreen()),
    GetPage(
        name: Utility.screenName(Screens.catalogListScreen),
        page: () => CatalogList()),
    GetPage(
        name: Utility.screenName(Screens.saleOrderVerificationScreen),
        page: () => SaleOrderVerificationScreen()),
  ];
}

enum Screens {
  splash,
  loginScreen,
  tabBar,
  companyListScreen,
  dateListScreen,
  itemScreen,
  filterScreen,
  tableScreen,
  itemTransactionsScreen,
  OutstandingScreen,
  itemDetailScreen,
  partyScreen,
  partiesFilterScreen,
  partyDetailScreen,
  OutstandingDetailScreen,
  outStandingFilterScreen,
  qrScanner,
  rackScreen,
  salesForm,
  searchScreen,
  topReports,
  gatePassScreen,
  challanListScreen,
  gatePassFormScreen,
  challanFiler,
  challanScreen,
  gdnChallanDetailsScreen,
  salesInvoiceListScreen,
  salesInvoiceListDetailScreen,
  purchaseInvoiceListScreen,
  purchaseInvoiceListDetailScreen,
  saleOrderScreen,
  saleOrderDetailScreen,
  purchaseOrderScreen,
  purchaseOrderDetailScreen,
  topSalePurchaseDetailScreen,
  commonFilter,
  topReportsFilter,
  catalogListScreen,
  saleOrderVerificationScreen
}
