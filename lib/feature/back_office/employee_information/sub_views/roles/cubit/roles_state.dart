// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';

import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/model/roles_model.dart';

class RolesState extends BaseState {
  const RolesState({
    required this.status,
    required this.roles,
    required this.selectedRole,
    required this.originalRoles,
    required this.errorMessage,
  });
  final RoleStatus status;
  final List<RolesModel> roles;
  final RolesModel? selectedRole;
  final List<RolesModel> originalRoles;
  final String? errorMessage;

  factory RolesState.initial() {
    return const RolesState(
      status: RoleStatus.initial,
      roles: [],
      selectedRole: null,
      originalRoles: [],
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, roles, selectedRole, originalRoles, errorMessage];

  RolesState copyWith({
    RoleStatus? status,
    List<RolesModel>? roles,
    RolesModel? Function()? selectedRole,
    List<RolesModel>? originalRoles,
    String? Function()? errorMessage,
  }) {
    return RolesState(
      status: status ?? this.status,
      roles: roles ?? this.roles,
      selectedRole: selectedRole != null ? selectedRole() : this.selectedRole,
      originalRoles: originalRoles ?? this.originalRoles,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}

enum RoleStatus { initial, loading, success, error }
