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
    this.permissions,
    this.id,
    this.role,
    this.branchId,
    this.lastName,
    this.password,
    this.name,
    this.branchCustomId,
    this.branchTitle,
  });

  final List<int>? permissions;
  final String? id;
  final String? role;
  final String? branchId;
  final String? password;
  @JsonKey(name: 'lastname')
  final String? lastName;
  final String? name;
  final int? branchCustomId;
  final String? branchTitle;

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  @override
  List<Object?> get props =>
      [permissions, id, role, branchId, password, lastName, name, branchCustomId, branchTitle];

  @override
  User fromJson(Map<String, dynamic> json) {
    return fromJson(json);
  }
}
