// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cancel_reason_model.g.dart';

@JsonSerializable()
class CancelReasonsModel extends BaseModel<CancelReasonsModel> {
  CancelReasonsModel({
    this.id,
    this.title,
    this.branch,
  });

  final String? id;
  final String? title;
  final String? branch;

  factory CancelReasonsModel.fromJson(Map<String, dynamic> json) =>
      _$CancelReasonsModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CancelReasonsModelToJson(this);

  @override
  CancelReasonsModel fromJson(Map<String, dynamic> json) => _$CancelReasonsModelFromJson(json);

  @override
  List<Object?> get props => [id, title, branch];

  CancelReasonsModel copyWith({
    String? id,
    String? title,
    String? branch,
  }) {
    return CancelReasonsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      branch: branch ?? this.branch,
    );
  }
}
