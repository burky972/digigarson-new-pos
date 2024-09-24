import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:a_pos_flutter/product/global/model/service_fee/service_fee_model.dart';
import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quick_service_request_model.g.dart';

// Main Request Model
@JsonSerializable()
class QuickServiceRequestModel extends BaseModel<QuickServiceRequestModel> {
  final double totalPrice;
  final double totalPriceAfterTax;
  final List<OrderProductModel> products;
  final List<DiscountModel> discounts;
  final List<ServiceFeeModel> serviceFee;
  final List<Payment> payments;

  QuickServiceRequestModel({
    required this.products,
    required this.discounts,
    required this.serviceFee,
    required this.payments,
    required this.totalPrice,
    required this.totalPriceAfterTax,
  });

  factory QuickServiceRequestModel.fromJson(Map<String, dynamic> json) =>
      _$QuickServiceRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$QuickServiceRequestModelToJson(this);
    data['products'] = products.map((product) => product.toJson()).toList();
    data['discounts'] = discounts.map((discount) => discount.toJson()).toList();
    data['serviceFee'] = serviceFee.map((fee) => fee.toJson()).toList();
    data['payments'] = payments.map((payment) => payment.toJson()).toList();
    data['totalPrice'] = totalPrice;
    data['totalPriceAfterTax'] = totalPriceAfterTax;
    return data;
  }

  @override
  List<Object?> get props =>
      [products, discounts, serviceFee, payments, totalPrice, totalPriceAfterTax];

  @override
  QuickServiceRequestModel fromJson(Map<String, dynamic> json) =>
      _$QuickServiceRequestModelFromJson(json);
}
