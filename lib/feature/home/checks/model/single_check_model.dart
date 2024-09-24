// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:a_pos_flutter/product/global/model/service_fee/service_fee_model.dart';
import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:a_pos_flutter/feature/home/checks/model/check_response_model.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';

part 'single_check_model.g.dart';

@JsonSerializable(includeIfNull: false)
class SingleCheckModel extends BaseModel<SingleCheckModel> {
  @JsonKey(name: '_id')
  final String? id;
  final String? branch;
  @JsonKey(name: 'order_type')
  final int? orderType;
  final List<Payment>? payments;
  final List<OrderModel>? orders;
  final CheckTableModel? table;
  final User? user;
  final String? caseId;
  final List<DiscountModel>? discounts;
  final List<CoverModel>? covers;
  final int? customerCount;
  final double? totalPrice;
  final double? totalPriceAfterTax;
  final double? totalTax;
  final List<ServiceFeeModel>? serviceFee;
  final int? checkNo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SingleCheckModel({
    this.id,
    this.branch,
    this.orderType,
    this.payments,
    this.orders,
    this.table,
    this.user,
    this.caseId,
    this.discounts,
    this.covers,
    this.customerCount,
    this.totalPrice,
    this.totalPriceAfterTax,
    this.totalTax,
    this.serviceFee,
    this.checkNo,
    this.createdAt,
    this.updatedAt,
  });

  factory SingleCheckModel.fromJson(Map<String, dynamic> json) => _$SingleCheckModelFromJson(json);

  @override
  SingleCheckModel fromJson(Map<String, dynamic> json) => _$SingleCheckModelFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$SingleCheckModelToJson(this);
    if (payments != null) {
      data['payments'] = payments!.map((payment) => payment.toJson()).toList();
    }
    if (orders != null) {
      data['orders'] = orders!.map((order) => order.toJson()).toList();
    }
    if (table != null) {
      data['table'] = table!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (discounts != null) {
      data['discounts'] = discounts!.map((discount) => discount.toJson()).toList();
    }
    if (covers != null) {
      data['covers'] = covers!.map((cover) => cover.toJson()).toList();
    }
    if (serviceFee != null) {
      data['serviceFee'] = serviceFee!.map((fee) => fee.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        branch,
        orderType,
        payments,
        orders,
        table,
        user,
        caseId,
        discounts,
        covers,
        customerCount,
        totalPrice,
        totalPriceAfterTax,
        totalTax,
        serviceFee,
        checkNo,
        createdAt,
        updatedAt,
      ];

  SingleCheckModel copyWith({
    String? id,
    String? branch,
    int? orderType,
    List<Payment>? payments,
    List<OrderModel>? orders,
    CheckTableModel? table,
    User? user,
    String? caseId,
    List<DiscountModel>? discounts,
    List<CoverModel>? covers,
    int? customerCount,
    double? totalPrice,
    double? totalPriceAfterTax,
    double? totalTax,
    List<ServiceFeeModel>? serviceFee,
    int? checkNo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SingleCheckModel(
      id: id ?? this.id,
      branch: branch ?? this.branch,
      orderType: orderType ?? this.orderType,
      payments: payments ?? this.payments,
      orders: orders ?? this.orders,
      table: table ?? this.table,
      user: user ?? this.user,
      caseId: caseId ?? this.caseId,
      discounts: discounts ?? this.discounts,
      covers: covers ?? this.covers,
      customerCount: customerCount ?? this.customerCount,
      totalPrice: totalPrice ?? this.totalPrice,
      totalPriceAfterTax: totalPriceAfterTax ?? this.totalPriceAfterTax,
      totalTax: totalTax ?? this.totalTax,
      serviceFee: serviceFee ?? this.serviceFee,
      checkNo: checkNo ?? this.checkNo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
