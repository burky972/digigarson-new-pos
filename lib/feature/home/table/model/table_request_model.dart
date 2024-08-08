// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'table_request_model.g.dart';

@JsonSerializable()
class TableRequestModel extends BaseModel<TableRequestModel> {
  final String? title;
  final String? section;
  final int? tableType;
  final LocationModel? location;

  TableRequestModel({
    this.title,
    this.section,
    this.tableType,
    this.location,
  });

  factory TableRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TableRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TableRequestModelToJson(this);

  @override
  TableRequestModel fromJson(Map<String, dynamic> json) => _$TableRequestModelFromJson(json);

  @override
  List<Object?> get props => [title, section, tableType, location];

  TableRequestModel copyWith({
    String? title,
    String? section,
    int? tableType,
    LocationModel? location,
  }) {
    return TableRequestModel(
      title: title ?? this.title,
      section: section ?? this.section,
      tableType: tableType ?? this.tableType,
      location: location ?? this.location,
    );
  }
}

@JsonSerializable()
class LocationModel extends BaseModel<LocationModel> {
  final int xCoordinate;
  final int yCoordinate;

  LocationModel({
    required this.xCoordinate,
    required this.yCoordinate,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  @override
  LocationModel fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);
  @override
  List<Object?> get props => [xCoordinate, yCoordinate];

  LocationModel copyWith({
    int? xCoordinate,
    int? yCoordinate,
  }) {
    return LocationModel(
      xCoordinate: xCoordinate ?? this.xCoordinate,
      yCoordinate: yCoordinate ?? this.yCoordinate,
    );
  }
}
