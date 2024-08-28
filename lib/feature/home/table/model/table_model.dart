// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:a_pos_flutter/feature/home/table/model/table_request_model.dart';

part 'table_model.g.dart';

@JsonSerializable()
class TableModel extends BaseModel<TableModel> {
  @JsonKey(name: '_id')
  final String? id;
  int? checkNo;
  final String? title;
  final bool? isPrinted;
  final String? branch;
  final String? section;
  @JsonKey(name: 'table_type')
  final int? tableType;
  final LocationModel? location;
  final double? totalPrice;
  final double? totalTax;
  final double? remainingPrice;

  final List<OrderModel> orders;
  final List<PaidOrderModel>? paidOrders;
  final List<CoverModel> cover; //X
  final List<DiscountModel> discount;
  final List<Payment> payments;
  final List<ServiceFeeModel> serviceFee;
  final int? customerCount;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  final String? url;
  @JsonKey(name: '__v')
  final int? version;
  final DateTime? lastOrderDate;

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
    this.customerCount,
    this.lastOrderDate,
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
        customerCount,
        version,
        lastOrderDate,
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
    List<ServiceFeeModel>? serviceFee,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? url,
    int? version,
    int? customerCount,
    DateTime? lastOrderDate,
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
      customerCount: customerCount ?? this.customerCount,
      payments: payments ?? this.payments,
      serviceFee: serviceFee ?? this.serviceFee,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      url: url ?? this.url,
      version: version ?? this.version,
      lastOrderDate: lastOrderDate ?? this.lastOrderDate,
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
    required this.id,
    required this.type,
    required this.title,
    required this.quantity,
    required this.price,
    required this.percentile,
    required this.totalPrice,
    required this.user,
    required this.isPaid,
  });

  String? id;
  String? type;
  String? title;
  double? quantity;
  double? price;
  double? percentile;
  double? totalPrice;
  String? user;
  bool? isPaid;

  CoverModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"]?.toString();
    type = json["type"]?.toString();
    title = json["title"]?.toString();
    quantity = json["quantity"] == null ? null : double.tryParse(json["quantity"].toString());
    price = json["price"] == null ? null : double.tryParse(json["price"].toString());
    percentile = json["percentile"] == null ? null : double.tryParse(json["percentile"].toString());
    totalPrice = json["totalPrice"] == null ? null : double.tryParse(json["totalPrice"].toString());
    user = json["user"]?.toString();
    isPaid = json["is_paid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['type'] = type;
    data['user'] = user;
    data['percentile'] = percentile;
    data['totalPrice'] = totalPrice;
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
    type = other.type;
    user = other.user;
    percentile = other.percentile;
    totalPrice = other.totalPrice;
  }
}

class DiscountModel {
  DiscountModel({
    required this.id,
    required this.note,
    required this.amount,
    required this.type,
    required this.user,
    required this.percentile,
  });

  String? id;
  String? note;
  double? amount;
  int? type;
  String? user;
  double? percentile;

  DiscountModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"]?.toString();
    note = json["note"]?.toString();
    amount = double.tryParse(json["amount"].toString());
    type = json["type"];
    user = json["user"]?.toString();
    percentile = double.tryParse(json["percentile"].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    try {
      data['_id'] = id;
      data['note'] = note;
      data['amount'] = amount;
      data['type'] = type;
      data['user'] = user;
      data['percentile'] = percentile;
    } catch (e) {
      print(e);
    }
    return data;
  }
}

class ServiceFeeModel {
  ServiceFeeModel({
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

  ServiceFeeModel.fromJson(Map<String, dynamic> json) {
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

  ServiceFeeModel.copy(ServiceFeeModel other) {
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
  late String? id;
  late int orderNum;
  late List<PaidProductModel> products;

  PaidOrderModel({
    this.id,
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
    id = json["id"].toString();
    quantity = double.tryParse(json["quantity"].toString()) ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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
    required this.orderNum,
    required this.products,
    required this.updatedAt,
    required this.createdAt,
  });

  late int? orderNum;
  late List<Product?> products;

  late DateTime? updatedAt;
  late DateTime? createdAt;

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderNum = json['orderNum'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products.add(Product.fromJson(v));
      });
    }
    createdAt = DateTime.tryParse(json["createdAt"] ?? "");
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    try {
      data['orderNum'] = orderNum;
      data['products'] = products.map((v) => v!.toJson()).toList();
      data['updatedAt'] = updatedAt.toString();
      data['createdAt'] = createdAt.toString();
    } catch (e) {
      print('Error order: $e');
    }
    return data;
  }

  OrderModel.copy(OrderModel other) {
    products = other.products.map((product) => Product.copy(product!)).toList();
    updatedAt = other.updatedAt;
    createdAt = other.createdAt;
    orderNum = other.orderNum;
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
  Product({
    required this.isFirst,
    required this.options,
    required this.tax,
    required this.note,
    required this.id,
    required this.product,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.priceId,
    required this.cancelStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  bool? isFirst;
  String? product;
  String? productName;
  double? quantity;
  double? price;
  String? priceId;
  late List<Options> options;
  String? note;
  String? id;
  double? tax;
  CancelStatus? cancelStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Product.empty() {
    return Product(
      isFirst: false,
      options: [],
      tax: 0.0,
      note: '',
      id: '',
      product: '',
      productName: '',
      quantity: 0.0,
      priceId: '',
      price: 0.0,
      cancelStatus: CancelStatus.empty(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Product.fromJson(Map<String, dynamic> json) {
    isFirst = json["isFirst"];
    options = json["options"] == null
        ? []
        : List<Options>.from(json["options"]!.map((x) => Options.fromJson(x)));
    note = json["note"].toString();
    id = json["_id"].toString();
    product = json["product"].toString();
    productName = json["productName"].toString();
    quantity = double.tryParse(json["quantity"].toString());
    tax = (json['tax'] as num?)?.toDouble();
    priceId = json["priceId"].toString();
    cancelStatus = CancelStatus.fromJson(json["cancelStatus"]);
    price = double.tryParse(json["price"].toString());
    createdAt = DateTime.tryParse(json["createdAt"] ?? "");
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    try {
      if (id != null) data['_id'] = id;
      if (product != null) data['product'] = product;
      if (isFirst != null) data['isFirst'] = isFirst;
      if (productName != null) data['productName'] = productName;
      if (cancelStatus != null) {
        data["cancelStatus"] = cancelStatus;
      }

      if (quantity != null) data['quantity'] = quantity;
      if (priceId != null) data['priceId'] = priceId;
      if (price != null) data['price'] = price;
      if (price != null) data['tax'] = tax;
      if (note != null) data['note'] = note;

      data['options'] = options.map((options) => options.toJson()).toList();
      if (updatedAt != null) data['updatedAt'] = updatedAt.toString();
      if (createdAt != null) data['createdAt'] = createdAt.toString();
    } catch (e) {
      print('Error OrderModel-Product: $e');
    }
    return data;
  }

  Map<String, dynamic> toMap() => {
        "isFirst": isFirst,
        "options": List<dynamic>.from(options.map((x) => x.toMap())),
        "note": note,
        "_id": id,
        "product": product,
        "productName": productName,
        "quantity": quantity,
        "priceId": priceId,
        "price": price,
        "createdAt": createdAt!.toIso8601String(),
      };

  Product.copy(Product other) {
    id = other.id;
    isFirst = other.isFirst;
    updatedAt = other.updatedAt;
    createdAt = other.createdAt;
    options = other.options;
    note = other.note;
    product = other.product;
    productName = other.productName;
    quantity = other.quantity;
    priceId = other.priceId;
    price = other.price;
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
  late List<Item> items;
  factory Options.empty() {
    return Options(
      optionId: '',
      name: '',
      items: [],
    );
  }

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json["option_id"].toString();
    name = json["nameOption"].toString();
    items = json["items"] == null
        ? []
        : List<Item>.from(json["items"]
            .map((x) => x == null ? null : Item.fromJson(x))
            .where((item) => item != null));
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
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };

  Options copyWith({
    String? optionId,
    String? name,
    List<Item>? items,
  }) {
    return Options(
      optionId: optionId ?? this.optionId,
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }
}

class CancelProduct {
  String tableId;
  List<OrderProductModel> products;
  String cancelReason;
  String cancelNote;

  CancelProduct({
    required this.tableId,
    required this.products,
    required this.cancelReason,
    required this.cancelNote,
  });

  factory CancelProduct.fromJson(String str) => CancelProduct.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
        "cancelReason": cancelReason,
        "cancelNote": cancelNote,
        "tableId": tableId,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };

  String toJson() => json.encode(toMap());

  factory CancelProduct.fromMap(Map<String, dynamic> json) => CancelProduct(
      cancelReason: json["cancelReason"].toString(),
      cancelNote: json["cancelNote"].toString(),
      tableId: json["tableId"].toString(),
      products: json["products"] == null
          ? []
          : List<OrderProductModel>.from(json["products"]!.map((x) => Product.fromJson(x))));
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
  List<String> orderIds;

  MoveProduct({
    required this.orderIds,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "orderIds": List<dynamic>.from(orderIds.map((x) => x)),
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
