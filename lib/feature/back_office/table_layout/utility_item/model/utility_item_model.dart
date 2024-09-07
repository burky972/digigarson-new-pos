// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:a_pos_flutter/feature/home/table/model/table_request_model.dart';

part 'utility_item_model.g.dart';

@JsonSerializable()
class UtilityItemModel extends BaseModel<UtilityItemModel> {
  @JsonKey(name: '_id')
  final String? id;
  final String? section;
  final int? type;
  final LocationModel? location;

  UtilityItemModel({
    required this.id,
    required this.section,
    required this.type,
    required this.location,
  });

  factory UtilityItemModel.fromJson(Map<String, dynamic> json) => _$UtilityItemModelFromJson(json);

  @override
  UtilityItemModel fromJson(Map<String, dynamic> json) => _$UtilityItemModelFromJson(json);

  @override
  List<Object?> get props => [id, section, type, location];

  @override
  Map<String, dynamic> toJson() => _$UtilityItemModelToJson(this);

  UtilityItemModel copyWith({
    String? id,
    String? title,
    String? sectionId,
    int? type,
    LocationModel? location,
  }) {
    return UtilityItemModel(
      id: id ?? this.id,
      section: sectionId ?? section,
      type: type ?? this.type,
      location: location ?? this.location,
    );
  }

  Widget buildUtilityItem(Widget assetWidget) {
    return SizedBox(
      width: 65,
      height: 65,
      child: Center(
        child: assetWidget,
      ),
    );
  }
}
