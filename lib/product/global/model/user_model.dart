import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends BaseModel<UserModel> {
  UserModel({
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  final String? accessToken;
  final String? refreshToken;
  final User? user;

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [accessToken, refreshToken, user];
}

@JsonSerializable()
class User extends BaseModel<User> {
  User({
    this.id,
    this.role,
    this.lastName,
    this.name,
  });

  final String? id;
  final String? name;
  final Role? role;
  @JsonKey(name: 'lastname')
  final String? lastName;

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.empty() => User(
        id: "",
        role: Role(
          permissions: const [],
          roleId: "",
          roleName: "",
        ),
        lastName: "",
        name: "",
      );

  @override
  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  @override
  List<Object?> get props => [id, name, lastName, role];

  @override
  User fromJson(Map<String, dynamic> json) {
    return fromJson(json);
  }
}

@JsonSerializable()
class Role extends BaseModel<Role> {
  final List<int> permissions;
  final String? roleId;
  final String? roleName;

  Role({
    required this.permissions,
    required this.roleId,
    required this.roleName,
  });

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RoleToJson(this);

  @override
  Role fromJson(Map<String, dynamic> json) {
    return fromJson(json);
  }

  @override
  List<Object?> get props => [permissions, roleId, roleName];
}
