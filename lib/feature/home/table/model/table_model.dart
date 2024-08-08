// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:a_pos_flutter/feature/home/table/model/table_request_model.dart';

part 'table_model.g.dart';

@JsonSerializable()
class TableModel extends BaseModel<TableModel> {
  int? checkNo;
  final String? title;
  final bool? isPrinted;
  final String? branch;
  final String? section;
  final int? tableType;
  final LocationModel? location;
  final double? totalPrice;
  final double? totalTax;
  final double? remainingPrice;
  @JsonKey(name: '_id')
  final String? id;
  final List<OrderModel> orders;
  final List<PaidOrderModel>? paidOrders;
  final List<DiscountModel> discount;
  final List<CoverModel> cover;
  final List<Payment> payments;
  final List<ServiceModel> serviceFee;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  final String? url;
  @JsonKey(name: '__v')
  final int? version;

  TableModel({
    this.checkNo,
    this.title,
    this.isPrinted,
    this.branch,
    this.section,
    this.tableType,
    this.location,
    this.totalPrice,
    this.totalTax,
    this.remainingPrice,
    this.id,
    required this.orders,
    required this.paidOrders,
    required this.discount,
    required this.cover,
    required this.payments,
    required this.serviceFee,
    this.createdAt,
    this.updatedAt,
    this.url,
    this.version,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) => _$TableModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TableModelToJson(this);

  @override
  TableModel fromJson(Map<String, dynamic> json) => _$TableModelFromJson(json);

  @override
  List<Object?> get props => [
        checkNo,
        title,
        isPrinted,
        branch,
        section,
        tableType,
        location,
        totalPrice,
        totalTax,
        remainingPrice,
        id,
        orders,
        paidOrders,
        discount,
        cover,
        payments,
        serviceFee,
        createdAt,
        updatedAt,
        url,
        version
      ];

  TableModel copyWith({
    int? checkNo,
    String? title,
    bool? isPrinted,
    String? branch,
    String? section,
    int? tableType,
    LocationModel? location,
    double? totalPrice,
    double? totalTax,
    double? remainingPrice,
    String? id,
    List<OrderModel>? orders,
    List<PaidOrderModel>? paidOrders,
    List<DiscountModel>? discount,
    List<CoverModel>? cover,
    List<Payment>? payments,
    List<ServiceModel>? serviceFee,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? url,
    int? version,
  }) {
    return TableModel(
      checkNo: checkNo ?? this.checkNo,
      title: title ?? this.title,
      isPrinted: isPrinted ?? this.isPrinted,
      branch: branch ?? this.branch,
      section: section ?? this.section,
      tableType: tableType ?? this.tableType,
      location: location ?? this.location,
      totalPrice: totalPrice ?? this.totalPrice,
      totalTax: totalTax ?? this.totalTax,
      remainingPrice: remainingPrice ?? this.remainingPrice,
      id: id ?? this.id,
      orders: orders ?? this.orders,
      paidOrders: paidOrders ?? this.paidOrders,
      discount: discount ?? this.discount,
      cover: cover ?? this.cover,
      payments: payments ?? this.payments,
      serviceFee: serviceFee ?? this.serviceFee,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      url: url ?? this.url,
      version: version ?? this.version,
    );
  }

  Widget buildTable(Widget assetWidget) {
    return SizedBox(
      width: 65,
      height: 65,
      child: Stack(
        alignment: Alignment.center,
        children: [
          assetWidget,
          Positioned(
              child: Text(title ?? '',
                  style: CustomFontStyle.generalTextStyle
                      .copyWith(color: Colors.white, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}

class CoverModel {
  CoverModel({
    required this.isPaid,
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });

  bool? isPaid;
  String? id;
  String? title;
  double? quantity;
  double? price;

  CoverModel.fromJson(Map<String, dynamic> json) {
    isPaid = json["is_paid"];
    id = json["_id"]?.toString();
    title = json["title"]?.toString();
    quantity = json["quantity"] == null ? null : double.tryParse(json["quantity"].toString());
    price = json["price"] == null ? null : double.tryParse(json["price"].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['is_paid'] = isPaid;
    data['title'] = title;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }

  CoverModel.copy(CoverModel other) {
    id = other.id;
    isPaid = other.isPaid;
    title = other.title;
    quantity = other.quantity;
    price = other.price;
  }
}

class DiscountModel {
  DiscountModel({
    required this.id,
    required this.note,
    required this.amount,
    required this.type,
    required this.user,
  });

  String? id;
  String? note;
  double? amount;
  int? type;
  String? user;

  DiscountModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"]?.toString();
    note = json["note"]?.toString();
    amount = double.tryParse(json["amount"].toString());
    type = json["type"];
    user = json["user"]?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    try {
      data['_id'] = id;
      data['note'] = note;
      data['amount'] = amount;
      data['type'] = type;
      data['user'] = user;
    } catch (e) {
      print(e);
    }
    return data;
  }
}

class ServiceModel {
  ServiceModel({
    required this.id,
    required this.amount,
    required this.percentile,
    required this.type,
    required this.user,
  });

  String? id;
  double? amount;
  double? percentile;
  int? type;
  String? user;

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"]?.toString();
    amount = double.tryParse(json["amount"].toString());
    percentile = double.tryParse(json["percentile"].toString());
    type = json["type"];
    user = json["user"]?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['amount'] = amount;
    data['user'] = user;
    data['percentile'] = percentile;
    data['type'] = type;
    return data;
  }

  ServiceModel.copy(ServiceModel other) {
    id = other.id;
    amount = other.amount;
    user = other.user;
    percentile = other.percentile;
    type = other.type;
  }
}

List<TableModel> tableGetFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return List<TableModel>.from(jsonData.map((item) => TableModel.fromJson(item)));
}

class TableListModel {
  late List<TableModel> tableList = [];

  TableListModel({required this.tableList});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TableListModel'] = tableList;
    return data;
  }
}

class PaidOrderModel {
  late String id;
  late int orderNum;
  late List<PaidProductModel> products;

  PaidOrderModel({
    required this.id,
    required this.orderNum,
    required this.products,
  });

  PaidOrderModel.fromJson(Map<String, dynamic> json) {
    orderNum = json["orderNum"];
    id = json["_id"].toString();
    products =
        List<PaidProductModel>.from(json["products"].map((x) => PaidProductModel.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['orderNum'] = orderNum;
    data['products'] = products.map((products) => products.toJson()).toList();
    return data;
  }

  Map<String, dynamic> toMap() => {
        "_id": id,
        "orderNum": orderNum,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };
}

class PaidProductModel {
  late String id;
  late double quantity;
  late double price;

  PaidProductModel({
    required this.id,
    required this.quantity,
    required this.price,
  });

  PaidProductModel.fromJson(Map<String, dynamic> json) {
    price = double.tryParse(json["price"].toString()) ?? 0;
    id = json["_id"].toString();
    quantity = double.tryParse(json["quantity"].toString()) ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }

  Map<String, dynamic> toMap() => {
        "_id": id,
        "quantity": quantity,
        "price": price,
      };
}

class OrderModel {
  OrderModel({
    required this.isPrint,
    required this.checkNo,
    required this.transferred,
    required this.orderType,
    required this.orderStatus,
    required this.totalPrice,
    required this.remainingPrice,
    required this.status,
    required this.isCancelled,
    required this.id,
    required this.orderNum,
    required this.products,
    required this.waiterId,
    required this.updatedAt,
    required this.createdAt,
    required this.transferredDate,
    required this.transferredFrom,
    required this.customer,
    required this.user,
    required this.address,
  });

  late IsPrint? isPrint;
  late int? checkNo;
  late bool? transferred;
  late int? orderType;
  late int? orderStatus;
  late double? totalPrice;
  late double? remainingPrice;
  late int? status;
  late bool? isCancelled;
  late String? id;
  late int? orderNum;
  late List<Product?> products;
  late String? waiterId;
  late DateTime? updatedAt;
  late DateTime? createdAt;
  late DateTime? transferredDate;
  late String? transferredFrom;
  late CustomerModel? customer;
  late User? user;
  late String? address;

  OrderModel.fromJson(Map<String, dynamic> json) {
    isPrint = json['isPrint'] != null ? IsPrint.fromJson(json['isPrint']) : null;
    checkNo = json['checkNo'];
    transferred = json['transferred'];
    orderType = json['order_type'];
    orderStatus = json['order_status'];
    totalPrice = double.tryParse(json['totalPrice'].toString());
    remainingPrice = double.tryParse(json['remainingPrice'].toString());
    status = json['status'];
    isCancelled = json['isCancelled'];
    id = json['_id'];
    orderNum = json['orderNum'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products.add(Product.fromJson(v));
      });
    }
    waiterId = json['waiterId'];
    createdAt = DateTime.tryParse(json["createdAt"] ?? "");
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? "");
    user = null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    try {
      if (isPrint != null) {
        data['isPrint'] = isPrint!.toJson();
      }
      data['checkNo'] = checkNo;
      data['transferred'] = transferred;
      data['order_type'] = orderType;
      data['order_status'] = orderStatus;
      data['totalPrice'] = totalPrice;
      data['remainingPrice'] = remainingPrice;
      data['status'] = status;
      data['isCancelled'] = isCancelled;
      data['_id'] = id;
      data['orderNum'] = orderNum;
      data['products'] = products.map((v) => v!.toJson()).toList();
      data['waiterId'] = waiterId;
      data['updatedAt'] = updatedAt.toString();
      data['createdAt'] = createdAt.toString();
    } catch (e) {
      print('Error order: $e');
    }
    return data;
  }

  OrderModel.copy(OrderModel other) {
    id = other.id;
    products = other.products.map((product) => Product.copy(product!)).toList();
    waiterId = other.waiterId;
    checkNo = other.checkNo;
    status = other.status;
    updatedAt = other.updatedAt;
    createdAt = other.createdAt;
    orderStatus = other.orderStatus;
    isPrint = other.isPrint;
    isCancelled = other.isCancelled;
    orderNum = other.orderNum;
    orderType = other.orderType;
    checkNo = other.checkNo;
    remainingPrice = other.remainingPrice;
    totalPrice = other.totalPrice;
  }
}

class CustomerModel {
  CustomerModel(
      {required this.address,
      required this.currency,
      required this.id,
      required this.fullName,
      required this.creditAmount,
      required this.description,
      required this.gsmNo,
      required this.title,
      required this.branch,
      required this.createdAt,
      required this.updatedAt});

  late List<Address> address;
  String? currency;
  String? id;
  String? fullName;
  double? creditAmount;
  String? description;
  int? gsmNo;
  String? title;
  String? branch;
  DateTime? createdAt;
  DateTime? updatedAt;

  CustomerModel.fromJson(Map<String, dynamic> json) {
    address = json["address"] == null
        ? []
        : List<Address>.from(json["address"]!.map((x) => Address.fromJson(x)));
    currency = json["currency"].toString();
    id = json["_id"].toString();
    fullName = json["full_name"].toString();
    creditAmount = double.tryParse(json["credit_amount"].toString());
    description = json["description"].toString();
    gsmNo = json["gsm_no"];
    title = json["title"].toString();
    branch = json["branch"].toString();
    createdAt = DateTime.tryParse(json["createdAt"] ?? "");
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['address'] = address.map((address) => address.toJson()).toList();
    data['currency'] = currency;
    data['full_name'] = fullName;
    data['credit_amount'] = creditAmount;
    data['description'] = description;
    data['gsm_no'] = gsmNo;
    data['title'] = title;
    data['branch'] = branch;
    data['createdAt'] = createdAt.toString();
    data['updatedAt'] = updatedAt.toString();
    return data;
  }
}

class User {
  User({
    required this.email,
    required this.id,
    required this.name,
    required this.lastname,
  });

  String? email;
  String? id;
  String? lastname;
  String? name;

  User.fromJson(Map<String, dynamic> json) {
    email = json["email"].toString();
    id = json["_id"].toString();
    name = json["name"].toString();
    lastname = json["lastname"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['lastname'] = lastname;
    return data;
  }
}

class Address {
  Address({
    required this.address,
    required this.title,
  });

  String? address;
  String? title;

  Address.fromJson(Map<String, dynamic> json) {
    address = json["address"].toString();
    title = json["title"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['title'] = title;
    return data;
  }
}

class IsPrint {
  IsPrint({
    required this.status,
    required this.print,
  });

  bool? status;
  bool? print;

  IsPrint.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    print = json['print'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['print'] = print;
    return data;
  }
}

class Payment {
  Payment({
    required this.id,
    required this.type,
    required this.amount,
    required this.currency,
  });

  String? id;
  int? type;
  double? amount;
  String? currency;

  Payment.fromJson(Map<String, dynamic> json) {
    id = json["_id"].toString();
    type = json["type"];
    amount = double.tryParse(json["amount"].toString());
    currency = json["currency"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['type'] = type;
    data['amount'] = amount;
    data['currency'] = currency;
    return data;
  }
}

class Product {
  Product(
      {required this.isFirst,
      required this.isDeleted,
      required this.isPrint,
      required this.optionsString,
      required this.options,
      required this.discount,
      required this.status,
      required this.orderNum,
      required this.note,
      required this.id,
      required this.product,
      required this.productName,
      required this.quantity,
      required this.priceId,
      required this.price,
      required this.priceName,
      required this.isServe,
      required this.serveId,
      required this.createdAt,
      required this.cancelReason,
      required this.cancelledBy,
      required this.cancelledDate,
      required this.serveDate,
      required this.servedBy,
      required this.updatedAt,
      required this.user});

  bool? isFirst;
  bool? isDeleted;
  bool? isPrint;
  String? optionsString;
  late List<Options> options;
  late List<DiscountModel> discount;
  int? status;
  int? orderNum;
  String? note;
  String? id;
  String? product;
  String? productName;
  String? priceName;
  double? quantity;
  String? priceId;
  double? price;
  bool? isServe;
  String? serveId;
  String? cancelReason;
  String? cancelledBy;
  String? cancelledDate;
  String? serveDate;
  String? servedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  Product.fromJson(Map<String, dynamic> json) {
    isFirst = json["isFirst"];
    isDeleted = json["isDeleted"];
    isPrint = json["isPrint"];
    optionsString = json["optionsString"];
    options = json["options"] == null
        ? []
        : List<Options>.from(json["options"]!.map((x) => Options.fromJson(x)));
    discount = json["discount"] == null
        ? []
        : List<DiscountModel>.from(json["discount"]!.map((x) => DiscountModel.fromJson(x)));
    status = json["status"];
    orderNum = json["orderNum"];
    note = json["note"].toString();
    id = json["_id"].toString();
    product = json["product"].toString();
    productName = json["productName"].toString();
    priceName = json["priceName"].toString();
    quantity = double.tryParse(json["quantity"].toString());
    priceId = json["priceId"].toString();
    price = double.tryParse(json["price"].toString());
    isServe = json["isServe"];
    serveId = json["serveId"].toString();
    createdAt = DateTime.tryParse(json["createdAt"] ?? "");
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? "");
    user = json["customer"] == null ? null : User.fromJson(json["user"]);
    cancelReason = json['cancelReason'];
    cancelledBy = json['cancelledBy'];
    cancelledDate = json['cancelledDate'].toString();
    serveDate = json['serveDate'].toString();
    servedBy = json['servedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    try {
      if (id != null) data['_id'] = id;
      if (product != null) data['product'] = product;
      if (isFirst != null) data['isFirst'] = isFirst;
      if (productName != null) data['productName'] = productName;
      if (isDeleted != null) data['isDeleted'] = isDeleted;
      if (priceName != null) data['priceName'] = priceName;
      if (quantity != null) data['quantity'] = quantity;
      if (priceId != null) data['priceId'] = priceId;
      if (price != null) data['price'] = price;
      if (note != null) data['note'] = note;
      if (status != null) data['status'] = status;
      if (isPrint != null) data['isPrint'] = isPrint;
      if (isServe != null) data['isServe'] = isServe;
      if (serveId != null) data['serveId'] = serveId;
      if (optionsString != null) data['optionsString'] = optionsString;
      data['discount'] = discount.map((discount) => discount.toJson()).toList();
      data['options'] = options.map((options) => options.toJson()).toList();
      if (user != null) data['customer'] = user!.toJson();
      if (updatedAt != null) data['updatedAt'] = updatedAt.toString();
      if (createdAt != null) data['createdAt'] = createdAt.toString();
      if (orderNum != null) data['orderNum'] = orderNum;
      if (cancelReason != null) data['cancelReason'] = cancelReason;
      if (cancelledBy != null) data['cancelledBy'] = cancelledBy;
      if (cancelledDate != null) data['cancelledDate'] = cancelledDate;
      if (serveDate != null) data['serveDate'] = serveDate;
      if (servedBy != null) data['servedBy'] = servedBy;
    } catch (e) {
      print('Error OrderModel-Product: $e');
    }
    return data;
  }

  Map<String, dynamic> toMap() => {
        "isFirst": isFirst,
        "isDeleted": isDeleted,
        "isPrint": isPrint,
        "optionsString": optionsString,
        "options": List<dynamic>.from(options.map((x) => x.toMap())),
        "discount": List<dynamic>.from(discount.map((x) => x)),
        "status": status,
        "orderNum": orderNum,
        "note": note,
        "_id": id,
        "product": product,
        "productName": productName,
        "quantity": quantity,
        "priceId": priceId,
        "price": price,
        "isServe": isServe,
        "serveId": serveId,
        "createdAt": createdAt!.toIso8601String(),
        "user": user,
      };

  Product.copy(Product other) {
    id = other.id;
    isFirst = other.isFirst;
    isDeleted = other.isDeleted;
    isPrint = other.isPrint;
    status = other.status;
    updatedAt = other.updatedAt;
    createdAt = other.createdAt;
    optionsString = other.optionsString;
    discount = other.discount;
    options = other.options;
    orderNum = other.orderNum;
    note = other.note;
    product = other.product;
    productName = other.productName;
    quantity = other.quantity;
    priceId = other.priceId;
    price = other.price;
    isServe = other.isServe;
    serveId = other.serveId;
    user = other.user;
  }
}

class Options {
  Options({
    required this.optionId,
    required this.name,
    required this.items,
  });

  String? optionId;
  String? name;
  late List<Items> items;

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json["option_id"].toString();
    name = json["nameOption"].toString();
    items =
        json["items"] == null ? [] : List<Items>.from(json["items"]!.map((x) => Items.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    try {
      data['option_id'] = optionId;
      data['nameOption'] = name;
      data['items'] = items.map((items) => items.toJson()).toList();
    } catch (e) {
      print('Error option: $e');
    }

    return data;
  }

  Map<String, dynamic> toMap() => {
        "name": name,
        "option_id": optionId,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class Items {
  Items({
    required this.itemId,
    required this.price,
    required this.name,
  });

  String? itemId;
  double? price;
  String? name;

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json["item_id"].toString();
    price = double.tryParse(json["price"].toString());
    name = json["name"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    try {
      data['item_id'] = itemId;
      data['name'] = name;
      data['price'] = price;
    } catch (e) {
      print('Error item: $e');
    }

    return data;
  }

  Map<String, dynamic> toMap() => {
        "name": name,
        "item_id": itemId,
        "price": price,
      };
}

class CancelProduct {
  String tableId;
  List<Product> products;
  String cancelReason;

  CancelProduct({
    required this.tableId,
    required this.products,
    required this.cancelReason,
  });

  factory CancelProduct.fromJson(String str) => CancelProduct.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
        "cancelReason": cancelReason,
        "tableId": tableId,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };

  String toJson() => json.encode(toMap());

  factory CancelProduct.fromMap(Map<String, dynamic> json) => CancelProduct(
      cancelReason: json["cancelReason"].toString(),
      tableId: json["tableId"].toString(),
      products: json["products"] == null
          ? []
          : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))));
}

class CateringProduct {
  String tableId;
  String serveId;
  String orderId;
  int orderNum;

  CateringProduct({
    required this.tableId,
    required this.serveId,
    required this.orderId,
    required this.orderNum,
  });

  factory CateringProduct.fromJson(String str) => CateringProduct.fromMap(json.decode(str));

  Map<String, dynamic> toMap() =>
      {"serveId": serveId, "tableId": tableId, "orderId": orderId, "orderNum": orderNum};

  String toJson() => json.encode(toMap());

  factory CateringProduct.fromMap(Map<String, dynamic> json) => CateringProduct(
      serveId: json["serveId"].toString(),
      tableId: json["tableId"].toString(),
      orderId: json["orderId"].toString(),
      orderNum: json["orderNum"]);
}

class CateringCancelProduct {
  String tableId;
  List<String> products;

  CateringCancelProduct({
    required this.tableId,
    required this.products,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "products": List<dynamic>.from(products.map((x) => x)),
        "tableId": tableId,
      };
}

class MoveProduct {
  String currentTable;
  String targetTable;
  List<String> orderIds;

  MoveProduct({
    required this.currentTable,
    required this.targetTable,
    required this.orderIds,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "orderIds": List<dynamic>.from(orderIds.map((x) => x)),
        "targetTable": targetTable,
        "currentTable": currentTable,
      };
}

class QrProduct {
  String tableId;
  List<String> products;

  QrProduct({
    required this.tableId,
    required this.products,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "products": List<dynamic>.from(products.map((x) => x)),
        "tableId": tableId,
      };
}
