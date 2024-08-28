// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';

part 'new_order_model.g.dart';

@JsonSerializable()
class NewOrderModel extends BaseModel<NewOrderModel> {
  NewOrderModel({
    required this.tableId,
    required this.products,
    required this.totalTax,
    required this.totalPrice,
  });

  final String? tableId;
  final List<OrderProductModel> products;
  final int? totalTax;
  final double? totalPrice;

  factory NewOrderModel.fromJson(Map<String, dynamic> json) => _$NewOrderModelFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) => _$NewOrderModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NewOrderModelToJson(this);

  @override
  List<Object?> get props => [tableId, products, totalTax, totalPrice];

  factory NewOrderModel.empty() => NewOrderModel(
        products: const [],
        tableId: '',
        totalTax: 0,
        totalPrice: 0,
      );

  NewOrderModel copyWith({
    String? tableId,
    List<OrderProductModel>? products,
    int? totalTax,
    double? totalPrice,
  }) {
    return NewOrderModel(
      tableId: tableId ?? this.tableId,
      products: products ?? this.products,
      totalTax: totalTax ?? this.totalTax,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}

@JsonSerializable(includeIfNull: false)
class OrderProductModel extends BaseModel<OrderProductModel> {
  final String? uniqueTimestamp;
  @JsonKey(name: '_id')
  final String? id;
  final String? product;
  final bool? isFirst;
  final String? categoryId;
  final double? tax;
  final String? productName;
  final String? priceType;
  final String? priceName;
  final double? quantity;
  final double? price;
  final String? priceId;
  final String? note;
  final List<Options> options;
  final CancelStatus cancelStatus;

  OrderProductModel({
    this.uniqueTimestamp,
    this.id,
    this.isFirst,
    this.product,
    this.productName,
    this.quantity,
    this.categoryId,
    this.tax,
    this.price,
    this.priceId,
    this.priceName,
    this.priceType,
    this.note,
    required this.options,
    required this.cancelStatus,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProductModelFromJson(json);
  @override
  OrderProductModel fromJson(Map<String, dynamic> json) => _$OrderProductModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$OrderProductModelToJson(this);
  @override
  List<Object?> get props => [
        id,
        isFirst,
        product,
        productName,
        quantity,
        categoryId,
        tax,
        price,
        priceId,
        priceName,
        priceType,
        note,
        options
      ];

  OrderProductModel copyWith({
    String? uniqueTimestamp,
    String? id,
    bool? isFirst,
    String? product,
    String? productName,
    double? quantity,
    String? categoryId,
    double? tax,
    double? price,
    String? priceId,
    String? priceName,
    String? priceType,
    String? note,
    List<Options>? options,
    CancelStatus? cancelStatus,
  }) {
    return OrderProductModel(
      uniqueTimestamp: uniqueTimestamp ?? this.uniqueTimestamp,
      id: id ?? this.id,
      isFirst: isFirst ?? this.isFirst,
      product: product ?? this.product,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      categoryId: categoryId ?? this.categoryId,
      tax: tax ?? this.tax,
      price: price ?? this.price,
      priceId: priceId ?? this.priceId,
      priceName: priceName ?? this.priceName,
      priceType: priceType ?? this.priceType,
      note: note ?? this.note,
      options: options ?? this.options,
      cancelStatus: cancelStatus ?? this.cancelStatus,
    );
  }
}

@JsonSerializable(includeIfNull: false)
class CancelStatus {
  final bool? isCancelled;
  final String? cancelledBy;
  final String? cancelReason;
  final DateTime? cancelledDate;

  CancelStatus({
    this.isCancelled,
    this.cancelledBy,
    this.cancelReason,
    this.cancelledDate,
  });

  factory CancelStatus.fromJson(Map<String, dynamic> json) => _$CancelStatusFromJson(json);
  Map<String, dynamic> toJson() => _$CancelStatusToJson(this);

  CancelStatus.empty()
      : isCancelled = false,
        cancelledBy = '',
        cancelReason = '',
        cancelledDate = DateTime.now();

  CancelStatus copyWith({
    bool? isCancelled,
    String? cancelledBy,
    String? cancelReason,
    DateTime? cancelledDate,
  }) {
    return CancelStatus(
      isCancelled: isCancelled ?? this.isCancelled,
      cancelledBy: cancelledBy ?? this.cancelledBy,
      cancelReason: cancelReason ?? this.cancelReason,
      cancelledDate: cancelledDate ?? this.cancelledDate,
    );
  }
}

class NewService {
  String tableId;
  double amount;
  int type;

  NewService({
    required this.tableId,
    required this.type,
    required this.amount,
  });

  factory NewService.fromJson(String str) => NewService.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "tableId": tableId,
        "type": type,
      };

  String toJson() => json.encode(toMap());

  factory NewService.fromMap(Map<String, dynamic> json) => NewService(
      amount: double.parse(json["amount"].toString()),
      tableId: json["tableId"],
      type: int.parse(json["type"].toString()));
}

class NewDiscount {
  String tableId;
  String note;
  double amount;
  int type;

  NewDiscount({
    required this.tableId,
    required this.note,
    required this.type,
    required this.amount,
  });

  factory NewDiscount.fromJson(String str) => NewDiscount.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "tableId": tableId,
        "type": type,
        "note": note,
      };

  String toJson() => json.encode(toMap());

  factory NewDiscount.fromMap(Map<String, dynamic> json) => NewDiscount(
      amount: double.parse(json["amount"].toString()),
      tableId: json["tableId"].toString(),
      note: json["note"].toString(),
      type: int.parse(json["type"].toString()));
}

class DeleteDiscount {
  String tableId;
  String discountId;
  double amount;

  DeleteDiscount({
    required this.tableId,
    required this.discountId,
    required this.amount,
  });

  factory DeleteDiscount.fromJson(String str) => DeleteDiscount.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "tableId": tableId,
        "discountId": discountId,
      };

  String toJson() => json.encode(toMap());

  factory DeleteDiscount.fromMap(Map<String, dynamic> json) => DeleteDiscount(
      amount: double.parse(json["amount"].toString()),
      tableId: json["tableId"].toString(),
      discountId: json["discountId"].toString());
}

class NewCover {
  String tableId;
  String title;
  double price;
  double perc;
  int type;
  int quantity;

  NewCover({
    required this.tableId,
    required this.title,
    required this.type,
    required this.quantity,
    required this.price,
    required this.perc,
  });

  factory NewCover.fromJson(String str) => NewCover.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
        "price": price,
        "perc": perc,
        "tableId": tableId,
        "type": type,
        "quantity": quantity,
        "title": title,
      };

  String toJson() => json.encode(toMap());

  factory NewCover.fromMap(Map<String, dynamic> json) => NewCover(
      price: double.parse(json["price"].toString()),
      perc: double.parse(json["perc"].toString()),
      tableId: json["tableId"].toString(),
      title: json["title"].toString(),
      type: int.parse(json["type"].toString()),
      quantity: int.parse(json["quantity"].toString()));
}

class DeleteCover {
  String tableId;
  String coverId;
  double coverPrice;

  DeleteCover({
    required this.tableId,
    required this.coverId,
    required this.coverPrice,
  });

  factory DeleteCover.fromJson(String str) => DeleteCover.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
        "coverPrice": coverPrice,
        "tableId": tableId,
        "coverId": coverId,
      };

  String toJson() => json.encode(toMap());

  factory DeleteCover.fromMap(Map<String, dynamic> json) => DeleteCover(
      coverPrice: double.parse(json["coverPrice"].toString()),
      tableId: json["tableId"].toString(),
      coverId: json["coverId"].toString());
}
