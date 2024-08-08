import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'case_model.g.dart';

@JsonSerializable()
class CaseResponse extends BaseModel<CaseResponse> {
  final int total;
  final List<CaseModel> cases;

  CaseResponse({required this.total, required this.cases});

  @override
  CaseResponse fromJson(Map<String, dynamic> json) => _$CaseResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CaseResponseToJson(this);

  @override
  List<Object?> get props => [total, cases];
}

@JsonSerializable()
class CaseModel extends BaseModel<CaseModel> {
  @JsonKey(name: '_id')
  final String? id;
  final String? branch;
  final String? user;

  @JsonKey(name: 'start_balance')
  final BalanceModel? startBalance;

  final List<BalanceModel?>? balance;
  final List<String?>? checks;
  final List<String?>? expenses;

  @JsonKey(name: 'is_open')
  final bool? isOpen;

  final List<Action>? actions;

  CaseModel({
    this.user,
    this.actions,
    this.checks,
    this.expenses,
    this.isOpen,
    this.id,
    this.branch,
    this.startBalance,
    this.balance,
  });

  @override
  factory CaseModel.fromJson(Map<String, dynamic> json) => _$CaseModelFromJson(json);

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
        user,
        actions,
      ];

  @override
  CaseModel fromJson(Map<String, dynamic> json) => _$CaseModelFromJson(json);
}

@JsonSerializable()
class BalanceModel extends BaseModel<BalanceModel> {
  final int? type;
  final double? amount;
  final String? currency;

  BalanceModel({
    this.type,
    this.amount,
    this.currency,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) => _$BalanceModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BalanceModelToJson(this);

  @override
  List<Object?> get props => [type, amount, currency];

  @override
  BalanceModel fromJson(Map<String, dynamic> json) {
    return _$BalanceModelFromJson(json);
  }
}

@JsonSerializable()
class Action extends BaseModel<Action> {
  final String action;
  final DateTime date;
  final String user;

  Action({required this.action, required this.date, required this.user});

  factory Action.fromJson(Map<String, dynamic> json) => _$ActionFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ActionToJson(this);

  @override
  Action fromJson(Map<String, dynamic> json) {
    return fromJson(json);
  }

  @override
  List<Object?> get props => [action, date, user];
}
