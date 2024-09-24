import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_request_model.g.dart';

@JsonSerializable()
class ExpenseRequestModel extends BaseModel<ExpenseRequestModel> {
  final String title;
  final String description;
  final String currency;
  @JsonKey(name: 'expense_amount')
  final double expenseAmount;
  @JsonKey(name: 'payment_type')
  final int paymentType;

  ExpenseRequestModel({
    required this.title,
    required this.description,
    required this.currency,
    required this.expenseAmount,
    required this.paymentType,
  });

  factory ExpenseRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExpenseRequestModelToJson(this);

  @override
  List<Object?> get props => [title, description, currency, expenseAmount, paymentType];

  @override
  ExpenseRequestModel fromJson(Map<String, dynamic> json) => _$ExpenseRequestModelFromJson(json);
}
