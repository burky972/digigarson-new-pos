import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'service_fee_request_model.g.dart';

@JsonSerializable()
class ServiceFeeRequestModel extends BaseModel<ServiceFeeRequestModel> {
  ServiceFeeRequestModel({required this.amount, required this.type});

  final int? amount;
  final String? type;

  @override
  ServiceFeeRequestModel fromJson(Map<String, dynamic> json) =>
      _$ServiceFeeRequestModelFromJson(json);

  @override
  List<Object?> get props => [amount, type];

  @override
  Map<String, dynamic> toJson() => _$ServiceFeeRequestModelToJson(this);
}
