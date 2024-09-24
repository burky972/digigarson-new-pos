import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';

part 'pay_request_model.g.dart';

@JsonSerializable(includeIfNull: false)
class PayRequestModel extends BaseModel<PayRequestModel> {
  PayRequestModel({
    required this.payments,
    required this.paidOrderModel,
  });
  final List<Payment> payments;
  @JsonKey(name: 'orders')
  final List<PaidOrderModel> paidOrderModel;

  @override
  PayRequestModel fromJson(Map<String, dynamic> json) => _$PayRequestModelFromJson(json);
  @override
  List<Object?> get props => [payments, paidOrderModel];

  @override
  Map<String, dynamic> toJson() => _$PayRequestModelToJson(this);

  PayRequestModel copyWith({
    List<Payment>? payments,
    List<PaidOrderModel>? paidOrderModel,
  }) {
    return PayRequestModel(
      payments: payments ?? this.payments,
      paidOrderModel: paidOrderModel ?? this.paidOrderModel,
    );
  }
}
