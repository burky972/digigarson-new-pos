import 'package:a_pos_flutter/product/enums/permission/staff_permissions.dart';
import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'roles_model.g.dart';

@JsonSerializable()
class RolesModel extends BaseModel<RolesModel> {
  RolesModel({
    required this.id,
    required this.name,
    required this.branch,
    required this.permissions,
  });
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? branch;
  final List<int> permissions;

  factory RolesModel.fromJson(Map<String, dynamic> json) => _$RolesModelFromJson(json);

  @override
  RolesModel fromJson(Map<String, dynamic> json) => _$RolesModelFromJson(json);

  factory RolesModel.empty() => RolesModel(
        id: '',
        name: '',
        branch: '',
        permissions: const [],
      );

  @override
  List<Object?> get props => [id, name, branch, permissions];

  @override
  Map<String, dynamic> toJson() => _$RolesModelToJson(this);

  RolesModel copyWith({
    String? Function()? id,
    String? name,
    String? branch,
    List<int>? permissions,
  }) {
    return RolesModel(
      id: id != null ? id() : this.id,
      name: name ?? this.name,
      branch: branch ?? this.branch,
      permissions: permissions ?? this.permissions,
    );
  }

  bool hasPermission(StaffPermissions permission) {
    return permissions.contains(permission.value);
  }
}
