import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'roles_request_model.g.dart';

@JsonSerializable(createFactory: false) // don't need to create fromJson or factory
class RolesRequestModel extends BaseModel<RolesRequestModel> {
  RolesRequestModel({
    required this.name,
    required this.permissions,
  });
  final String name;
  final List<int> permissions;

  @override
  RolesRequestModel fromJson(Map<String, dynamic> json) => throw UnimplementedError();

  @override
  List<Object?> get props => [name, permissions];

  @override
  Map<String, dynamic> toJson() => _$RolesRequestModelToJson(this);
}
