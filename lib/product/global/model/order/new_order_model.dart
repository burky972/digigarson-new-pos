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
  final double? paidQuantity;
  final double? price;
  final bool? isSpecial;
  final double? priceAfterTax;
  final String? priceId;
  final String? note;
  final List<Options> options;
  final List<Options>? selectedOptions;
  final CancelStatus cancelStatus;
  final ServeInfoModel serveInfo;
  final bool isOptionForced;

  OrderProductModel({
    this.uniqueTimestamp,
    this.id,
    this.isFirst,
    this.product,
    this.productName,
    this.quantity,
    this.paidQuantity,
    this.categoryId,
    this.tax,
    this.price,
    required this.priceAfterTax,
    this.priceId,
    this.isSpecial,
    this.priceName,
    this.priceType,
    this.note,
    required this.options,
    required this.selectedOptions,
    required this.cancelStatus,
    required this.serveInfo,
    required this.isOptionForced,
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
        isSpecial,
        paidQuantity,
        categoryId,
        tax,
        price,
        priceAfterTax,
        priceId,
        priceName,
        priceType,
        note,
        options,
        cancelStatus,
        serveInfo,
        isOptionForced,
        selectedOptions,
      ];

  OrderProductModel copyWith({
    String? uniqueTimestamp,
    String? id,
    bool? isFirst,
    String? product,
    String? productName,
    double? quantity,
    double? paidQuantity,
    String? categoryId,
    bool? isSpecial,
    double? tax,
    double? price,
    double? priceAfterTax,
    String? priceId,
    String? priceName,
    String? priceType,
    String? note,
    List<Options>? options,
    List<Options>? selectedOptions,
    CancelStatus? cancelStatus,
    ServeInfoModel? serveInfo,
    bool? isOptionForced,
  }) {
    return OrderProductModel(
      uniqueTimestamp: uniqueTimestamp ?? this.uniqueTimestamp,
      id: id ?? this.id,
      isFirst: isFirst ?? this.isFirst,
      product: product ?? this.product,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      paidQuantity: paidQuantity ?? this.paidQuantity,
      categoryId: categoryId ?? this.categoryId,
      tax: tax ?? this.tax,
      price: price ?? this.price,
      priceAfterTax: priceAfterTax ?? this.priceAfterTax,
      priceId: priceId ?? this.priceId,
      isSpecial: isSpecial ?? this.isSpecial,
      priceName: priceName ?? this.priceName,
      priceType: priceType ?? this.priceType,
      note: note ?? this.note,
      options: options ?? this.options,
      cancelStatus: cancelStatus ?? this.cancelStatus,
      serveInfo: serveInfo ?? this.serveInfo,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      isOptionForced: isOptionForced ?? this.isOptionForced,
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

@JsonSerializable(includeIfNull: false)
class CoverRequestModel extends BaseModel<CoverRequestModel> {
  final String? type;
  final String? title;
  final double? value;
  final int? quantity;

  CoverRequestModel({
    required this.title,
    required this.type,
    required this.value,
    required this.quantity,
  });

  factory CoverRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CoverRequestModelFromJson(json);

  @override
  CoverRequestModel fromJson(Map<String, dynamic> json) => CoverRequestModel.fromJson(json);

  @override
  List<Object?> get props => [title, type, value, quantity];

  @override
  Map<String, dynamic> toJson() => _$CoverRequestModelToJson(this);
}
