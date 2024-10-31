import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reports_waiter_model.g.dart';

@JsonSerializable()
class ReportsWaiterModel extends BaseModel<ReportsWaiterModel> {
  ReportsWaiterModel({
    required this.id,
    required this.name,
    required this.waiterExpenses,
    required this.payments,
    required this.cashQuantity,
    required this.cardQuantity,
    required this.subTotal,
    required this.totalDiscount,
    required this.totalTax,
    required this.total,
    required this.totalTip,
    required this.products,
    required this.cancelledProducts,
    // required this.discounts,
    // required this.ticks,
    // required this.caterings,
    required this.createdAt,
  });

  final String? id;
  final String? name;
  @JsonKey(name: 'expenses')
  final List<WaiterExpenseModel?> waiterExpenses;
  @JsonKey(name: 'payments')
  final List<WaiterPaymentModel?> payments;
  final int? cashQuantity;
  final int? cardQuantity;
  final double? subTotal;
  final double? totalDiscount;
  final double? totalTax;
  final double? total;
  final double? totalTip;
  @JsonKey(name: 'products')
  final List<WaiterProductModel?> products;
  @JsonKey(name: 'cancelledProducts')
  final List<CancelledWaiterProductModel?> cancelledProducts;
  // final List<DiscountModel?> discounts;
  // final List<TickModel?> ticks;
  // @JsonKey(name: 'caterings')
  // final List<CateringModel?> caterings;
  final DateTime? createdAt;

  factory ReportsWaiterModel.fromJson(Map<String, dynamic> json) =>
      _$ReportsWaiterModelFromJson(json);
  factory ReportsWaiterModel.empty() {
    return ReportsWaiterModel(
      id: '',
      name: '',
      waiterExpenses: const [],
      payments: [WaiterPaymentModel.empty()],
      cashQuantity: 0,
      cardQuantity: 0,
      subTotal: 0,
      totalDiscount: 0,
      totalTax: 0,
      total: 0,
      totalTip: 0,
      products: const [],
      cancelledProducts: const [],
      createdAt: DateTime.now(),
    );
  }
  @override
  ReportsWaiterModel fromJson(Map<String, dynamic> json) => ReportsWaiterModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReportsWaiterModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        waiterExpenses,
        payments,
        cashQuantity,
        cardQuantity,
        subTotal,
        totalDiscount,
        totalTax,
        total,
        totalTip,
        products,
        cancelledProducts,
        // discounts,
        // ticks,
        // caterings,
        createdAt,
      ];
}

@JsonSerializable()
class WaiterExpenseModel extends BaseModel<WaiterExpenseModel> {
  WaiterExpenseModel({
    required this.title,
    required this.description,
    required this.amount,
    required this.currency,
    required this.paymentType,
    required this.createdAt,
  });
  final String? title;
  final String? description;
  final double? amount;
  final String? currency;
  @JsonKey(name: 'payment_type')
  final int? paymentType;
  final DateTime? createdAt;

  factory WaiterExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$WaiterExpenseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WaiterExpenseModelToJson(this);

  @override
  List<Object?> get props => [title, description, amount, currency, paymentType, createdAt];

  @override
  WaiterExpenseModel fromJson(Map<String, dynamic> json) => WaiterExpenseModel.fromJson(json);
}

@JsonSerializable()
class WaiterPaymentModel extends BaseModel<WaiterPaymentModel> {
  WaiterPaymentModel({
    required this.type,
    required this.currency,
    required this.amount,
    this.id,
    required this.createdAt,
    this.updatedAt,
  });
  final int? type;
  final String? currency;
  final double? amount;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory WaiterPaymentModel.fromJson(Map<String, dynamic> json) =>
      _$WaiterPaymentModelFromJson(json);
  factory WaiterPaymentModel.empty() => WaiterPaymentModel(
        type: 1,
        currency: 'USD',
        amount: 0,
        id: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
  @override
  Map<String, dynamic> toJson() => _$WaiterPaymentModelToJson(this);

  @override
  List<Object?> get props => [type, currency, amount, id, createdAt, updatedAt];

  @override
  WaiterPaymentModel fromJson(Map<String, dynamic> json) => WaiterPaymentModel.fromJson(json);
}

@JsonSerializable()
class WaiterProductModel extends BaseModel<WaiterProductModel> {
  WaiterProductModel({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.price,
  });
  final String id;
  final String productName;
  final int quantity;
  final double price;

  factory WaiterProductModel.fromJson(Map<String, dynamic> json) =>
      _$WaiterProductModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WaiterProductModelToJson(this);

  @override
  List<Object?> get props => [id, productName, quantity, price];

  @override
  WaiterProductModel fromJson(Map<String, dynamic> json) => WaiterProductModel.fromJson(json);
}

@JsonSerializable()
class CancelledWaiterProductModel extends BaseModel<CancelledWaiterProductModel> {
  CancelledWaiterProductModel({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.cancelReason,
    required this.cancellationDate,
  });
  final String id;
  final String productName;
  final int quantity;
  final double price;
  final String cancelReason;
  final DateTime cancellationDate;

  factory CancelledWaiterProductModel.fromJson(Map<String, dynamic> json) =>
      _$CancelledWaiterProductModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CancelledWaiterProductModelToJson(this);

  @override
  List<Object?> get props => [id, productName, quantity, price, cancelReason, cancellationDate];

  @override
  CancelledWaiterProductModel fromJson(Map<String, dynamic> json) =>
      CancelledWaiterProductModel.fromJson(json);
}
