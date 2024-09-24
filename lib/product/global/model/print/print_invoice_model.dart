import 'dart:convert';

import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';

class PrinterInvoiceModel {
  HeaderData headerData;
  TransactionData transactionData;
  FooterData footerData;
  String msg;

  PrinterInvoiceModel({
    required this.headerData,
    required this.transactionData,
    required this.footerData,
    required this.msg,
  });

  factory PrinterInvoiceModel.fromJson(String str) => PrinterInvoiceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrinterInvoiceModel.fromMap(Map<String, dynamic> json) => PrinterInvoiceModel(
        headerData: HeaderData.fromMap(json["headerData"]),
        transactionData: TransactionData.fromMap(json["transactionData"]),
        footerData: FooterData.fromMap(json["footerData"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toMap() => {
        "headerData": headerData.toMap(),
        "transactionData": transactionData.toMap(),
        "footerData": footerData.toMap(),
        "msg": msg,
      };
}

class PrinterKitchenInvoice {
  HeaderData headerData;
  TransactionKitchenData transactionData;
  FooterData footerData;
  String msg;

  PrinterKitchenInvoice({
    required this.headerData,
    required this.transactionData,
    required this.footerData,
    required this.msg,
  });

  factory PrinterKitchenInvoice.fromJson(String str) =>
      PrinterKitchenInvoice.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrinterKitchenInvoice.fromMap(Map<String, dynamic> json) => PrinterKitchenInvoice(
        headerData: HeaderData.fromMap(json["headerData"]),
        transactionData: TransactionKitchenData.fromMap(json["transactionData"]),
        footerData: FooterData.fromMap(json["footerData"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toMap() => {
        "headerData": headerData.toMap(),
        "transactionData": transactionData.toMap(),
        "footerData": footerData.toMap(),
        "msg": msg,
      };
}

class PrinterKitchenCancelInvoice {
  HeaderData headerData;
  TransactionKitchenCancelData transactionData;
  FooterData footerData;
  String msg;

  PrinterKitchenCancelInvoice({
    required this.headerData,
    required this.transactionData,
    required this.footerData,
    required this.msg,
  });

  factory PrinterKitchenCancelInvoice.fromJson(String str) =>
      PrinterKitchenCancelInvoice.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrinterKitchenCancelInvoice.fromMap(Map<String, dynamic> json) =>
      PrinterKitchenCancelInvoice(
        headerData: HeaderData.fromMap(json["headerData"]),
        transactionData: TransactionKitchenCancelData.fromMap(json["transactionData"]),
        footerData: FooterData.fromMap(json["footerData"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toMap() => {
        "headerData": headerData.toMap(),
        "transactionData": transactionData.toMap(),
        "footerData": footerData.toMap(),
        "msg": msg,
      };
}

class FooterData {
  String footer1;
  String footer2;

  FooterData({
    required this.footer1,
    required this.footer2,
  });

  factory FooterData.fromJson(String str) => FooterData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FooterData.fromMap(Map<String, dynamic> json) => FooterData(
        footer1: json["footer1"],
        footer2: json["footer2"],
      );

  Map<String, dynamic> toMap() => {
        "footer1": footer1,
        "footer2": footer2,
      };
}

class HeaderData {
  String header1;

  HeaderData({
    required this.header1,
  });

  factory HeaderData.fromJson(String str) => HeaderData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HeaderData.fromMap(Map<String, dynamic> json) => HeaderData(
        header1: json["header1"],
      );

  Map<String, dynamic> toMap() => {
        "header1": header1,
      };
}

class TransactionData {
  String date;
  String cashierName;
  String table;
  int orderNo;
  List<ItemPrinter> items;
  List<ServicePrinter> service;
  List<CoverPrinter> cover;
  double subTotal;
  double discountTotal;
  double taxTotal;
  double total;
  double payAmount;
  double change;

  TransactionData({
    required this.date,
    required this.cashierName,
    required this.table,
    required this.orderNo,
    required this.items,
    required this.service,
    required this.cover,
    required this.subTotal,
    required this.discountTotal,
    required this.taxTotal,
    required this.total,
    required this.payAmount,
    required this.change,
  });

  factory TransactionData.fromJson(String str) => TransactionData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransactionData.fromMap(Map<String, dynamic> json) => TransactionData(
        date: json["date"],
        cashierName: json["cashierName"],
        table: json["table"],
        orderNo: json["orderNo"],
        items: List<ItemPrinter>.from(json["items"].map((x) => ItemPrinter.fromMap(x))),
        service: List<ServicePrinter>.from(json["service"].map((x) => ServicePrinter.fromMap(x))),
        cover: List<CoverPrinter>.from(json["cover"].map((x) => CoverPrinter.fromMap(x))),
        subTotal: json["subTotal"],
        discountTotal: json["discountTotal"]?.toDouble(),
        taxTotal: json["taxTotal"]?.toDouble(),
        total: json["total"]?.toDouble(),
        payAmount: json["payAmount"],
        change: json["change"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "date": date,
        "cashierName": cashierName,
        "table": table,
        "orderNo": orderNo,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "service": List<dynamic>.from(service.map((x) => x.toMap())),
        "cover": List<dynamic>.from(cover.map((x) => x.toMap())),
        "subTotal": subTotal,
        "discountTotal": discountTotal,
        "taxTotal": taxTotal,
        "total": total,
        "payAmount": payAmount,
        "change": change,
      };
}

class TransactionKitchenData {
  String date;
  String cashierName;
  String table;
  int orderNo;
  List<ItemKitchenPrinter> items;
  List<ItemKitchenPrinter> firstItems;

  TransactionKitchenData({
    required this.date,
    required this.cashierName,
    required this.table,
    required this.orderNo,
    required this.items,
    required this.firstItems,
  });

  factory TransactionKitchenData.fromJson(String str) =>
      TransactionKitchenData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransactionKitchenData.fromMap(Map<String, dynamic> json) => TransactionKitchenData(
        date: json["date"],
        cashierName: json["cashierName"],
        table: json["table"],
        orderNo: json["orderNo"],
        items:
            List<ItemKitchenPrinter>.from(json["items"].map((x) => ItemKitchenPrinter.fromMap(x))),
        firstItems: List<ItemKitchenPrinter>.from(
            json["firstItems"].map((x) => ItemKitchenPrinter.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "date": date,
        "cashierName": cashierName,
        "table": table,
        "orderNo": orderNo,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "firstItems": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class TransactionKitchenCancelData {
  String date;
  String cashierName;
  String table;
  int orderNo;
  List<ItemKitchenCancelPrinter> items;

  TransactionKitchenCancelData({
    required this.date,
    required this.cashierName,
    required this.table,
    required this.orderNo,
    required this.items,
  });

  factory TransactionKitchenCancelData.fromJson(String str) =>
      TransactionKitchenCancelData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransactionKitchenCancelData.fromMap(Map<String, dynamic> json) =>
      TransactionKitchenCancelData(
        date: json["date"],
        cashierName: json["cashierName"],
        table: json["table"],
        orderNo: json["orderNo"],
        items: List<ItemKitchenCancelPrinter>.from(
            json["items"].map((x) => ItemKitchenCancelPrinter.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "date": date,
        "cashierName": cashierName,
        "table": table,
        "orderNo": orderNo,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class ItemKitchenPrinter {
  String itemId;
  String itemName;
  String itemPriceName;
  String note;
  List<Options> itemOption;
  double qty;

  ItemKitchenPrinter({
    required this.itemId,
    required this.itemName,
    required this.itemPriceName,
    required this.note,
    required this.itemOption,
    required this.qty,
  });

  factory ItemKitchenPrinter.fromJson(String str) => ItemKitchenPrinter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemKitchenPrinter.fromMap(Map<String, dynamic> json) => ItemKitchenPrinter(
      itemId: json["itemId"],
      itemName: json["itemName"],
      itemPriceName: json["priceName"],
      note: json["note"],
      itemOption: json["itemOption"],
      qty: json["qty"]?.toDouble());

  Map<String, dynamic> toMap() => {
        "itemId": itemId,
        "itemName": itemName,
        "priceName": itemPriceName,
        "note": note,
        "itemOption": itemOption,
        "qty": qty,
      };
}

class ItemKitchenCancelPrinter {
  String itemId;
  String itemName;
  String itemPriceName;
  String note;
  String optionString;
  double qty;

  ItemKitchenCancelPrinter({
    required this.itemId,
    required this.itemName,
    required this.itemPriceName,
    required this.note,
    required this.optionString,
    required this.qty,
  });

  factory ItemKitchenCancelPrinter.fromJson(String str) =>
      ItemKitchenCancelPrinter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemKitchenCancelPrinter.fromMap(Map<String, dynamic> json) => ItemKitchenCancelPrinter(
      itemId: json["itemId"],
      itemName: json["itemName"],
      itemPriceName: json["priceName"],
      note: json["note"],
      optionString: json["optionString"],
      qty: json["qty"]?.toDouble());

  Map<String, dynamic> toMap() => {
        "itemId": itemId,
        "itemName": itemName,
        "priceName": itemPriceName,
        "note": note,
        "optionString": optionString,
        "qty": qty,
      };
}

class CoverPrinter {
  bool isPaid;
  double price;
  double percentile;
  double quantity;
  String title;
  String id;

  CoverPrinter({
    required this.isPaid,
    required this.price,
    required this.percentile,
    required this.quantity,
    required this.title,
    required this.id,
  });

  factory CoverPrinter.fromJson(String str) => CoverPrinter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CoverPrinter.fromMap(Map<String, dynamic> json) => CoverPrinter(
        isPaid: json["is_paid"],
        price: json["price"]?.toDouble(),
        percentile: json["percentile"]?.toDouble(),
        quantity: json["quantity"],
        title: json["title"],
        id: json["_id"],
      );

  Map<String, dynamic> toMap() => {
        "is_paid": isPaid,
        "price": price,
        "percentile": percentile,
        "quantity": quantity,
        "title": title,
        "_id": id,
      };
}

class ItemPrinter {
  String itemId;
  String itemName;
  String itemPriceName;
  String itemOptionString;
  double itemPrice;
  double qty;
  double discountAmounte;
  String discountName;
  int status;

  ItemPrinter({
    required this.itemId,
    required this.itemName,
    required this.itemPriceName,
    required this.itemOptionString,
    required this.itemPrice,
    required this.qty,
    required this.discountAmounte,
    required this.discountName,
    required this.status,
  });

  factory ItemPrinter.fromJson(String str) => ItemPrinter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemPrinter.fromMap(Map<String, dynamic> json) => ItemPrinter(
        itemId: json["itemId"],
        itemName: json["itemName"],
        itemPriceName: json["priceName"],
        itemOptionString: json["itemOptionString"],
        itemPrice: json["itemPrice"].toDouble(),
        qty: json["qty"]?.toDouble(),
        discountAmounte: json["discountAmount"]?.toDouble(),
        discountName: json["discountName"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "itemId": itemId,
        "itemName": itemName,
        "priceName": itemPriceName,
        "itemOptionString": itemOptionString,
        "itemPrice": itemPrice,
        "qty": qty,
        "discountAmounte": discountAmounte,
        "discountName": discountName,
        "status": status,
      };
}

class ServicePrinter {
  double amount;
  double percentile;
  String type;
  String id;

  ServicePrinter({
    required this.amount,
    required this.percentile,
    required this.type,
    required this.id,
  });

  factory ServicePrinter.fromJson(String str) => ServicePrinter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServicePrinter.fromMap(Map<String, dynamic> json) => ServicePrinter(
        amount: json["amount"]?.toDouble(),
        percentile: json["percentile"]?.toDouble(),
        type: json["type"],
        id: json["_id"],
      );

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "percentile": percentile,
        "type": type,
        "_id": id,
      };
}
