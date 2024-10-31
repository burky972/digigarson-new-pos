// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_request_model.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
class EmployeeRequestModel extends BaseModel<EmployeeRequestModel> {
  EmployeeRequestModel({
    required this.name,
    required this.lastName,
    required this.password,
    required this.role,
    required this.email,
    required this.gsmNo,
  });
  final String name;
  @JsonKey(name: 'lastname')
  final String lastName;
  final String password;
  final String role;
  final String email;
  @JsonKey(name: 'gsm_no')
  final String gsmNo;

  @override
  EmployeeRequestModel fromJson(Map<String, dynamic> json) {
    return fromJson(json);
  }

  @override
  List<Object?> get props => [name, lastName, password, role, email, gsmNo];

  @override
  Map<String, dynamic> toJson() => _$EmployeeRequestModelToJson(this);

  factory EmployeeRequestModel.empty() =>
      EmployeeRequestModel(name: '', lastName: '', password: '', role: '', email: '', gsmNo: '');

  EmployeeRequestModel copyWith({
    String? name,
    String? lastName,
    String? password,
    String? role,
    String? email,
    String? gsmNo,
  }) {
    return EmployeeRequestModel(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      role: role ?? this.role,
      email: email ?? this.email,
      gsmNo: gsmNo ?? this.gsmNo,
    );
  }
}
