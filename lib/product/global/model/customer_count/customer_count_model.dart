import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_count_model.g.dart';

@JsonSerializable()
class CustomerCountModel extends BaseModel<CustomerCountModel> {
  CustomerCountModel({required this.customerCount});
  final int? customerCount;

  @override
  CustomerCountModel fromJson(Map<String, dynamic> json) => _$CustomerCountModelFromJson(json);

  @override
  List<Object?> get props => [customerCount];

  @override
  Map<String, dynamic> toJson() => _$CustomerCountModelToJson(this);
}
