import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reports_expense_model.g.dart';

@JsonSerializable()
class ReportsExpenseModel extends BaseModel<ReportsExpenseModel> {
  ReportsExpenseModel({
    required this.id,
    required this.branch,
    required this.user,
    required this.caseReportModel,
    required this.title,
    required this.description,
    required this.currency,
    required this.expenseAmount,
    required this.paymentType,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? branch;
  final String? user;
  @JsonKey(name: 'case')
  final CaseReportModel? caseReportModel;
  final String? title;
  final String? description;
  final String? currency;
  @JsonKey(name: 'expense_amount')
  final double? expenseAmount;
  @JsonKey(name: 'payment_type')
  final int? paymentType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ReportsExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ReportsExpenseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReportsExpenseModelToJson(this);
  @override
  ReportsExpenseModel fromJson(Map<String, dynamic> json) => ReportsExpenseModel.fromJson(json);

  ReportsExpenseModel copyWith({
    String? id,
    String? branch,
    CaseReportModel? caseReportModel,
    String? title,
    String? description,
    String? currency,
    double? expenseAmount,
    String? user,
    int? paymentType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReportsExpenseModel(
      id: id ?? this.id,
      branch: branch ?? this.branch,
      user: user ?? this.user,
      caseReportModel: caseReportModel ?? this.caseReportModel,
      title: title ?? this.title,
      description: description ?? this.description,
      currency: currency ?? this.currency,
      expenseAmount: expenseAmount ?? this.expenseAmount,
      paymentType: paymentType ?? this.paymentType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        branch,
        CaseReportModel,
        title,
        description,
        currency,
        expenseAmount,
        paymentType,
        createdAt,
        updatedAt,
      ];
}

@JsonSerializable()
class CaseReportModel extends BaseModel<CaseReportModel> {
  CaseReportModel({
    required this.id,
    required this.user,
  });

  @JsonKey(name: '_id')
  final String? id;
  final ExpenseUser? user;

  factory CaseReportModel.fromJson(Map<String, dynamic> json) => _$CaseReportModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CaseReportModelToJson(this);

  @override
  CaseReportModel fromJson(Map<String, dynamic> json) => CaseReportModel.fromJson(json);

  CaseReportModel copyWith({
    String? id,
    ExpenseUser? user,
  }) {
    return CaseReportModel(
      id: id ?? this.id,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [id, user];
}

@JsonSerializable()
class ExpenseUser extends BaseModel<ExpenseUser> {
  ExpenseUser({
    required this.id,
    required this.name,
    required this.lastName,
  });

  @JsonKey(name: "_id")
  final String? id;
  final String? name;
  @JsonKey(name: "lastname")
  final String? lastName;

  factory ExpenseUser.fromJson(Map<String, dynamic> json) => _$ExpenseUserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExpenseUserToJson(this);

  @override
  ExpenseUser fromJson(Map<String, dynamic> json) => ExpenseUser.fromJson(json);

  @override
  List<Object?> get props => [
        id,
        name,
        lastName,
      ];

  ExpenseUser copyWith({
    String? id,
    String? name,
    String? lastName,
  }) =>
      ExpenseUser(
        id: id ?? this.id,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
      );
}
