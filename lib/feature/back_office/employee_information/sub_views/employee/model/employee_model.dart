import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel extends BaseModel<EmployeeModel> {
  EmployeeModel({
    required this.id,
    required this.name,
    required this.password,
    required this.lastName,
    required this.email,
    required this.gsmNo,
    required this.branch,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });
  final String? id;
  final String? name;
  @JsonKey(name: "lastname")
  final String? lastName;
  final String? password;
  final String? email;
  @JsonKey(name: "gsm_no")
  final String? gsmNo;
  final String? branch;
  final Role? role;
  final String? createdAt;
  final String? updatedAt;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => _$EmployeeModelFromJson(json);

  factory EmployeeModel.empty() => EmployeeModel(
        id: '',
        name: '',
        password: '',
        lastName: '',
        email: '',
        gsmNo: '',
        branch: '',
        role: Role(roleName: 'Admin'),
        createdAt: '',
        updatedAt: '',
      );

  @override
  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);

  @override
  EmployeeModel fromJson(Map<String, dynamic> json) => _$EmployeeModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
        name,
        lastName,
        password,
        email,
        gsmNo,
        branch,
        role,
        createdAt,
        updatedAt,
      ];

  EmployeeModel copyWith({
    String? Function()? id,
    String? name,
    String? lastName,
    String? password,
    String? email,
    String? gsmNo,
    String? branch,
    Role? role,
    String? createdAt,
    String? updatedAt,
  }) =>
      EmployeeModel(
        id: id != null ? id() : this.id,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        password: password ?? this.password,
        email: email ?? this.email,
        gsmNo: gsmNo ?? this.gsmNo,
        branch: branch ?? this.branch,
        role: role ?? this.role,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}

@JsonSerializable()
class Role {
  @JsonKey(name: "role_id")
  String? roleId;
  @JsonKey(name: "role_name")
  String? roleName;
  @JsonKey(name: "permissions")
  List<int>? permissions;

  Role({
    this.roleId,
    this.roleName,
    this.permissions,
  });

  factory Role.empty() => Role(
        roleId: '',
        roleName: 'Admin',
        permissions: [],
      );
  Role copyWith({
    String? roleId,
    String? roleName,
    List<int>? permissions,
  }) =>
      Role(
        roleId: roleId ?? this.roleId,
        roleName: roleName ?? this.roleName,
        permissions: permissions ?? this.permissions,
      );

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
