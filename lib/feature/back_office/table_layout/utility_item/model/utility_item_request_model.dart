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

@JsonSerializable()
class UtilityItemUpdateRequestModel extends BaseModel<UtilityItemUpdateRequestModel> {
  final String? title;
  final int? type;
  final LocationModel? location;

  UtilityItemUpdateRequestModel({
    this.title,
    this.type,
    this.location,
  });

  factory UtilityItemUpdateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UtilityItemUpdateRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UtilityItemUpdateRequestModelToJson(this);

  @override
  UtilityItemUpdateRequestModel fromJson(Map<String, dynamic> json) =>
      _$UtilityItemUpdateRequestModelFromJson(json);

  @override
  List<Object?> get props => [title, type, location];

  UtilityItemRequestModel copyWith({
    String? title,
    int? type,
    LocationModel? location,
  }) {
    return UtilityItemRequestModel(
      title: title ?? this.title,
      type: type ?? this.type,
      location: location ?? this.location,
    );
  }
}
