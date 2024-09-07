// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'section_model.g.dart';

@JsonSerializable()
class SectionModel extends BaseModel<SectionModel> {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;

  SectionModel({
    this.id,
    this.title,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) => _$SectionModelFromJson(json);

  factory SectionModel.empty() {
    return SectionModel(id: '', title: '');
  }
  @override
  Map<String, dynamic> toJson() => _$SectionModelToJson(this);

  @override
  SectionModel fromJson(Map<String, dynamic> json) => _$SectionModelFromJson(json);

  @override
  List<Object?> get props => [id, title];

  SectionModel copyWith({
    String? id,
    String? title,
  }) {
    return SectionModel(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}
