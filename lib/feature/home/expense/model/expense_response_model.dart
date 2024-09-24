import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_response_model.g.dart';

@JsonSerializable()
class ExpenseResponseModel extends BaseModel<ExpenseResponseModel> {
  ExpenseResponseModel({
    required this.expenses,
    required this.totalCount,
  });

  final List<ExpenseModel> expenses;
  final int totalCount;

  factory ExpenseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExpenseResponseModelToJson(this);

  @override
  List<Object?> get props => [expenses, totalCount];

  @override
  ExpenseResponseModel fromJson(Map<String, dynamic> json) => _$ExpenseResponseModelFromJson(json);
}

@JsonSerializable()
class ExpenseModel extends BaseModel<ExpenseModel> {
  ExpenseModel({
    required this.id,
    required this.caseId,
    required this.title,
    required this.description,
    required this.currency,
    required this.paymentType,
    required this.expenseAmount,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'case')
  final String? caseId;
  final String? title;
  final String? description;
  final String? currency;
  @JsonKey(name: 'expense_amount')
  final double? expenseAmount;
  final User? user;
  @JsonKey(name: 'payment_type')
  final int? paymentType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => _$ExpenseModelFromJson(json);

  ExpenseModel.empty()
      : this(
          caseId: '',
          id: '',
          title: '',
          description: '',
          currency: '',
          expenseAmount: 0,
          user: User.empty(),
          paymentType: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

  @override
  Map<String, dynamic> toJson() => _$ExpenseModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        caseId,
        title,
        description,
        currency,
        paymentType,
        expenseAmount,
        user,
        createdAt,
        updatedAt,
      ];

  @override
  ExpenseModel fromJson(Map<String, dynamic> json) => _$ExpenseModelFromJson(json);
}
