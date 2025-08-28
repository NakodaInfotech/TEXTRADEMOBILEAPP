import 'package:textrade/Challan/ChallanGDNModel.dart';
import 'package:textrade/Outstanding/OutstandingDetaisResModel.dart';
import 'package:textrade/SalePurchaseOrder/PurchaseOrderListModel.dart';
import 'package:textrade/SalePurchaseOrder/SaleOrderListModel.dart';
import 'package:textrade/SalesPurchaseInvoice/salesInvoiceListModel.dart';
import 'package:textrade/TopSalePurchaseReport/TopSalePurchaseModel.dart';

class PDFGenetarionRequest {
  String? date;
  String? partyName;
  String? companyName;
  String? companyAddress;
  String? bank;
  String? account;
  String? ifsc;
  String? upi;
  List<OutTable>? pdfTable;
  List<Table1>? pdfTable1;
  List<String>? titles;

  PDFGenetarionRequest(
      {this.date,
      this.partyName,
      this.companyName,
      this.companyAddress,
      this.bank,
      this.account,
      this.ifsc,
      this.upi,
      this.pdfTable,
      this.pdfTable1,
      this.titles});

  PDFGenetarionRequest.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    partyName = json['partyName'];
    companyName = json['companyName'];
    companyAddress = json['companyAddress'];
    bank = json['bank'];
    account = json['account'];
    ifsc = json['ifsc'];
    upi = json['upi'];
    if (json['table'] != null) {
      pdfTable = <OutTable>[];
      json['table'].forEach((v) {
        pdfTable!.add(new OutTable.fromJson(v));
      });
    }
    if (json['table1'] != null) {
      pdfTable1 = <Table1>[];
      json['table1'].forEach((v) {
        pdfTable1!.add(new Table1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['partyName'] = this.partyName;
    data['companyName'] = this.companyName;
    data['companyAddress'] = this.companyAddress;
    data['bank'] = this.bank;
    data['account'] = this.account;
    data['ifsc'] = this.ifsc;
    data['upi'] = this.upi;
    if (this.pdfTable != null) {
      data['table'] = this.pdfTable!.map((v) => v.toJson()).toList();
    }
    if (this.pdfTable1 != null) {
      data['table1'] = this.pdfTable1!.map((v) => v.toJson()).toList();
    }
    if (this.titles != null) {
      data['titles'] = this.titles;
    }
    return data;
  }
}

class PDFGenetarionRes {
  bool? success;
  String? message;
  String? requirementQuotation;

  PDFGenetarionRes({this.success, this.message, this.requirementQuotation});

  PDFGenetarionRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    requirementQuotation = json['requirement_quotation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['requirement_quotation'] = this.requirementQuotation;
    return data;
  }
}

class PDFSalesOrderGenetarionRequest {
  MainCompany? mainCompany;
  List<SaleOrderListTable>? dataList;

  PDFSalesOrderGenetarionRequest({this.mainCompany, this.dataList});

  PDFSalesOrderGenetarionRequest.fromJson(Map<String, dynamic> json) {
    mainCompany = json['MainCompany'] != null
        ? new MainCompany.fromJson(json['MainCompany'])
        : null;
    if (json['dataList'] != null) {
      dataList = <SaleOrderListTable>[];
      json['dataList'].forEach((v) {
        dataList!.add(new SaleOrderListTable.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MainCompany'] = this.mainCompany;
    if (this.dataList != null) {
      data['dataList'] = this.dataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PDFPurchaseOrderGenetarionRequest {
  MainCompany? mainCompany;
  List<PurchaseOrderListTable>? dataList;

  PDFPurchaseOrderGenetarionRequest({this.mainCompany, this.dataList});

  PDFPurchaseOrderGenetarionRequest.fromJson(Map<String, dynamic> json) {
    mainCompany = json['MainCompany'] != null
        ? new MainCompany.fromJson(json['MainCompany'])
        : null;
    if (json['dataList'] != null) {
      dataList = <PurchaseOrderListTable>[];
      json['dataList'].forEach((v) {
        dataList!.add(new PurchaseOrderListTable.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MainCompany'] = this.mainCompany;
    if (this.dataList != null) {
      data['dataList'] = this.dataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PDFSalesGenetarionRequest {
  MainCompany? mainCompany;
  List<SalesListTable>? dataList;

  PDFSalesGenetarionRequest({this.mainCompany, this.dataList});

  PDFSalesGenetarionRequest.fromJson(Map<String, dynamic> json) {
    mainCompany = json['MainCompany'] != null
        ? new MainCompany.fromJson(json['MainCompany'])
        : null;
    if (json['dataList'] != null) {
      dataList = <SalesListTable>[];
      json['dataList'].forEach((v) {
        dataList!.add(new SalesListTable.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MainCompany'] = this.mainCompany;
    if (this.dataList != null) {
      data['dataList'] = this.dataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PDFTopSalesGenetarionRequest {
  MainCompany? mainCompany;
  List<List<String>> dataList;

  PDFTopSalesGenetarionRequest({
    required this.mainCompany,
    required this.dataList,
  });

  factory PDFTopSalesGenetarionRequest.fromJson(Map<String, dynamic> json) =>
      PDFTopSalesGenetarionRequest(
        mainCompany: MainCompany.fromJson(json["MainCompany"]),
        dataList: List<List<String>>.from(
            json["dataList"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "MainCompany": this.mainCompany,
        "dataList": List<dynamic>.from(
            dataList.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class PDFChallanGenetarionRequest {
  MainCompany? mainCompany;
  List<ChallanTableList>? dataList;

  PDFChallanGenetarionRequest({this.mainCompany, this.dataList});

  PDFChallanGenetarionRequest.fromJson(Map<String, dynamic> json) {
    mainCompany = json['MainCompany'] != null
        ? new MainCompany.fromJson(json['MainCompany'])
        : null;
    if (json['dataList'] != null) {
      dataList = <ChallanTableList>[];
      json['dataList'].forEach((v) {
        dataList!.add(new ChallanTableList.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MainCompany'] = this.mainCompany;
    if (this.dataList != null) {
      data['dataList'] = this.dataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainCompany {
  String? companyName;
  String? companyAddress;
  String? GSTNO;
  String? State;
  String? StateBenchMark;
  String? panno;
  String? msme;
  String? bank;
  String? account;
  String? ifsc;
  String? upi;
  String? date;
  String? reportName;

  MainCompany({
    this.companyName,
    this.companyAddress,
    this.GSTNO,
    this.State,
    this.StateBenchMark,
    this.panno,
    this.msme,
    this.bank,
    this.account,
    this.ifsc,
    this.upi,
    this.date,
    this.reportName,
  });

  MainCompany.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    companyAddress = json['companyAddress'];
    GSTNO = json['GSTNO'];
    State = json['State'];
    StateBenchMark = json['StateBenchMark'];
    panno = json['panno'];
    msme = json['msme'];
    bank = json['bank'];
    account = json['account'];
    ifsc = json['ifsc'];
    upi = json['upi'];
    date = json['date'];
    reportName = json['reportName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyName'] = this.companyName;
    data['companyAddress'] = this.companyAddress;
    data['GSTNO'] = this.GSTNO;
    data['State'] = this.State;
    data['StateBenchMark'] = this.StateBenchMark;
    data['panno'] = this.panno;
    data['msme'] = this.msme;
    data['bank'] = this.bank;
    data['account'] = this.account;
    data['ifsc'] = this.ifsc;
    data['upi'] = this.upi;
    data['date'] = this.date;
    data['reportName'] = this.reportName;
    return data;
  }
}
