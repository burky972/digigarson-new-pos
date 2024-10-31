import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reports_order_type_model.g.dart';

@JsonSerializable(explicitToJson: false)
class ReportsOrderTypeModel extends BaseModel<ReportsOrderTypeModel> {
  ReportsOrderTypeModel({
    required this.dineIn,
    required this.delivery,
    required this.takeOut,
    required this.quickService,
    required this.bar,
    required this.grandTotal,
  });
  final OrderTypeModel? dineIn;
  final OrderTypeModel? delivery;
  final OrderTypeModel? takeOut;
  final OrderTypeModel? quickService;
  final OrderTypeModel? bar;
  final OrderTypeModel? grandTotal;

  factory ReportsOrderTypeModel.empty() => ReportsOrderTypeModel(
        dineIn: OrderTypeModel.empty(),
        delivery: OrderTypeModel.empty(),
        takeOut: OrderTypeModel.empty(),
        quickService: OrderTypeModel.empty(),
        bar: OrderTypeModel.empty(),
        grandTotal: OrderTypeModel.empty(),
      );

  factory ReportsOrderTypeModel.fromJson(Map<String, dynamic> json) =>
      _$ReportsOrderTypeModelFromJson(json);

  @override
  ReportsOrderTypeModel fromJson(Map<String, dynamic> json) =>
      _$ReportsOrderTypeModelFromJson(json);

  @override
  List<Object?> get props => [dineIn, delivery, takeOut, quickService, bar, grandTotal];

  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

@JsonSerializable(explicitToJson: false)
class OrderTypeModel extends BaseModel<OrderTypeModel> {
  OrderTypeModel({
    required this.type,
    required this.quantity,
    required this.guests,
    required this.tax,
    required this.discount,
    required this.totalServiceFee,
    required this.tip,
    required this.cash,
    required this.creditCard,
    required this.subTotal,
    required this.total,
  });
  final int? type;
  final int? quantity;
  final int? guests;
  final double? tax;
  final double? discount;
  final double? totalServiceFee;
  final double? tip;
  final double? cash;
  final double? creditCard;
  final double? subTotal;
  final double? total;

  factory OrderTypeModel.empty() => OrderTypeModel(
        type: 0,
        quantity: 0,
        guests: 0,
        tax: 0.0,
        discount: 0.0,
        totalServiceFee: 0.0,
        tip: 0.0,
        cash: 0.0,
        creditCard: 0.0,
        subTotal: 0.0,
        total: 0.0,
      );

  factory OrderTypeModel.fromJson(Map<String, dynamic> json) => _$OrderTypeModelFromJson(json);

  @override
  OrderTypeModel fromJson(Map<String, dynamic> json) => _$OrderTypeModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();

  @override
  List<Object?> get props => [
        type,
        quantity,
        guests,
        tax,
        discount,
        totalServiceFee,
        tip,
        cash,
        creditCard,
        subTotal,
        total
      ];
}
