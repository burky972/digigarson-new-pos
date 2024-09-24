import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_fee_model.g.dart';

@JsonSerializable()
class ServiceFeeModel extends BaseModel<ServiceFeeModel> {
  ServiceFeeModel({
    required this.id,
    required this.amount,
    required this.percentile,
    required this.type,
    required this.user,
  });

  @JsonKey(name: '_id')
  final String? id;
  final double? amount;
  final double? percentile;
  final String? type;
  final String? user;

  factory ServiceFeeModel.fromJson(Map<String, dynamic> json) => _$ServiceFeeModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ServiceFeeModelToJson(this);

  @override
  ServiceFeeModel fromJson(Map<String, dynamic> json) => _$ServiceFeeModelFromJson(json);

  @override
  List<Object?> get props => [id, amount, percentile, type, user];
}
