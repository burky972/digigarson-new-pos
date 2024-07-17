import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'case_model.g.dart';

@JsonSerializable()
class CaseModel extends BaseModel<CaseModel> {
  final List<Map<String, dynamic>>? checks;
  final List<Map<String, dynamic>>? expenses;
  final bool? isOpen;
  final String? id;
  final String? branch;
  final List<BalanceModel>? startBalance;
  final List<BalanceModel>? balance;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CaseModel({
    this.checks,
    this.expenses,
    this.isOpen,
    this.id,
    this.branch,
    this.startBalance,
    this.balance,
    this.createdAt,
    this.updatedAt,
  });

  @override
  CaseModel fromJson(Map<String, dynamic> json) => _$CaseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CaseModelToJson(this);

  @override
  List<Object?> get props => [
        checks,
        expenses,
        isOpen,
        id,
        branch,
        startBalance,
        balance,
        createdAt,
        updatedAt,
      ];
}

@JsonSerializable()
class BalanceModel extends BaseModel<BalanceModel> {
  final String? id;
  final int? type;
  final double? amount;
  final String? currency;

  BalanceModel({
    this.id,
    this.type,
    this.amount,
    this.currency,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) => _$BalanceModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BalanceModelToJson(this);

  @override
  List<Object?> get props => [id, type, amount, currency];

  @override
  BalanceModel fromJson(Map<String, dynamic> json) {
    return _$BalanceModelFromJson(json);
  }
}
