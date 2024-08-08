import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'section_model.g.dart';

@JsonSerializable()
class SectionModel extends BaseModel<SectionModel> {
  final String id;
  final String title;

  SectionModel({
    required this.id,
    required this.title,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) => _$SectionModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SectionModelToJson(this);

  @override
  SectionModel fromJson(Map<String, dynamic> json) => _$SectionModelFromJson(json);

  @override
  List<Object?> get props => [id, title];
}
