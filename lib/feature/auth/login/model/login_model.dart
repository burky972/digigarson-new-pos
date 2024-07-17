import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends BaseModel<LoginModel> {
  LoginModel({this.branch_custom_id, this.password});
  final String? branch_custom_id;
  final String? password;

  @override
  LoginModel fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  @override
  List<Object?> get props => [branch_custom_id, password];
}
