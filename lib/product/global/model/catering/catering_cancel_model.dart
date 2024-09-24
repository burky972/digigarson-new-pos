import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'catering_cancel_model.g.dart';

@JsonSerializable()
class CateringCancelModel extends BaseModel<CateringCancelModel> {
  @JsonKey(name: '_id')
  final String id;
  final String tableId;
  CateringCancelModel({required this.id, required this.tableId});

  factory CateringCancelModel.fromJson(Map<String, dynamic> json) =>
      _$CateringCancelModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CateringCancelModelToJson(this);

  @override
  List<Object?> get props => [id, tableId];

  @override
  CateringCancelModel fromJson(Map<String, dynamic> json) => CateringCancelModel.fromJson(json);
}
