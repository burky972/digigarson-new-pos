import 'package:a_pos_flutter/feature/home/checks/model/check_response_model.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'single_check_model.g.dart';

@JsonSerializable()
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
  Map<String, dynamic> toJson() => _$SingleCheckModelToJson(this);

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
        totalTax,
        serviceFee,
        checkNo,
        createdAt,
        updatedAt,
      ];
}
