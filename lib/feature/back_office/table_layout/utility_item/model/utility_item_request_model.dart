import 'package:a_pos_flutter/feature/home/table/model/table_request_model.dart';
import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'utility_item_request_model.g.dart';

@JsonSerializable()
class UtilityItemRequestModel extends BaseModel<UtilityItemRequestModel> {
  final String? title;
  final String? section;
  final int? type;
  final LocationModel? location;

  UtilityItemRequestModel({
    this.title,
    this.section,
    this.type,
    this.location,
  });

  factory UtilityItemRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UtilityItemRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UtilityItemRequestModelToJson(this);

  @override
  UtilityItemRequestModel fromJson(Map<String, dynamic> json) =>
      _$UtilityItemRequestModelFromJson(json);

  @override
  List<Object?> get props => [title, section, type, location];

  UtilityItemRequestModel copyWith({
    String? title,
    String? section,
    int? type,
    LocationModel? location,
  }) {
    return UtilityItemRequestModel(
      title: title ?? this.title,
      section: section ?? this.section,
      type: type ?? this.type,
      location: location ?? this.location,
    );
  }
}
