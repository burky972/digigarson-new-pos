import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/cubit/i_roles_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/cubit/roles_state.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/model/roles_model.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/model/roles_request_model.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/service/i_roles_service.dart';
import 'package:a_pos_flutter/product/enums/permission/staff_permissions.dart';
import 'package:a_pos_flutter/product/global/service/global_service.dart';
import 'package:flutter/widgets.dart';

class RolesCubit extends IRolesCubit {
  RolesCubit(this._rolesService) : super(RolesState.initial());
  final IRolesService _rolesService;
  final TextEditingController roleNameController = TextEditingController();
  List<RolesModel> originalRoles = [];
  List<RolesModel> temporaryRoles = [];

  @override
  Future<void> init() async {
    await getRoles();
  }

  /// GET ROLES
  @override
  Future<bool> getRoles() async {
    emit(state.copyWith(status: RoleStatus.loading));
    final response = await _rolesService.getRoles();
    response.fold(
      (l) => emit(state.copyWith(status: RoleStatus.error)),
      (r) {
        List<RolesModel> roles = (r.data as List).map((e) => RolesModel.fromJson(e)).toList();
        if (roles.isNotEmpty) {
          originalRoles = roles;
          temporaryRoles = roles;
          emit(state.copyWith(
            status: RoleStatus.success,
            roles: roles,
            selectedRole: () => roles.first,
            originalRoles: roles,
          ));
          setSelectedRole(roles.first);
        } else {
          emit(state.copyWith(status: RoleStatus.success, roles: roles));
        }
      },
    );

    return response.isRight();
  }

  /// POST ROLES
  @override
  Future<bool> postRoles({required RolesRequestModel rolesRequestModel}) async {
    emit(state.copyWith(status: RoleStatus.loading));

    final response = await _rolesService.postRoles(rolesRequestModel: rolesRequestModel);
    response.fold(
      (l) => emit(state.copyWith(status: RoleStatus.error, errorMessage: () => l.message)),
      (r) {
        RolesModel? role = RolesModel.fromJson(r.data);
        originalRoles.add(role);
        emit(state.copyWith(
          status: RoleStatus.success,
          originalRoles: originalRoles,
        ));
      },
    );
    return response.isRight();
  }

  /// UPDATE ROLES
  @override
  Future<bool> updateRoles(
      {required String roleId, required RolesRequestModel rolesRequestModel}) async {
    emit(state.copyWith(status: RoleStatus.loading));

    final response =
        await _rolesService.updateRoles(roleId: roleId, rolesRequestModel: rolesRequestModel);
    response.fold(
      (l) => emit(state.copyWith(status: RoleStatus.error, errorMessage: () => l.message)),
      (r) {
        final index = originalRoles.indexWhere((e) => e.id == roleId);
        originalRoles[index] = RolesModel.fromJson(r.data);
        emit(state.copyWith(
          status: RoleStatus.success,
          selectedRole: () => originalRoles.first,
          originalRoles: originalRoles,
        ));
      },
    );
    return response.isRight();
  }

  /// SELECT ROLE
  @override
  void setSelectedRole(RolesModel role) {
    roleNameController.text = role.name ?? '';
    emit(state.copyWith(selectedRole: () => role));
  }

  @override
  void togglePermissionForRole(StaffPermissions toggledPermission) {
    final selectedRole = state.selectedRole;
    if (selectedRole == null) return;

    final updatedPermissions = List<int>.from(selectedRole.permissions);

    if (updatedPermissions.contains(toggledPermission.value)) {
      updatedPermissions.remove(toggledPermission.value);
    } else {
      updatedPermissions.add(toggledPermission.value);
    }
    final updatedRole = selectedRole.copyWith(permissions: updatedPermissions);
    final roles = state.roles.map((e) => e.id == updatedRole.id ? updatedRole : e).toList();
    emit(state.copyWith(roles: roles, selectedRole: () => updatedRole));
  }

  @override
  void clearAllTextController() {
    roleNameController.clear();
  }

  /// ADD NEW EMPTY Employee
  @override
  Future<void> addNewRole() async {
    temporaryRoles = state.roles;
    if (temporaryRoles.isNotEmpty && temporaryRoles.last.name?.isEmpty == true) return;
    clearAllTextController();

    // Create new employee and add
    final newRole = RolesModel.empty();
    temporaryRoles = List<RolesModel>.from(temporaryRoles)..add(newRole);

    emit(state.copyWith(
      roles: List.from(temporaryRoles),
      selectedRole: () => newRole,
    ));
  }

  /// UPDATE SELECTED EMPLOYEE
  @override
  void updateSelectedRoleField(String newValue) {
    final selectedRole = state.selectedRole;
    if (selectedRole == null) return;
    final isNewRole = !originalRoles.map((e) => e.id).contains(selectedRole.id);
    final updatedEmployee = selectedRole.copyWith(
      id: () => isNewRole ? GlobalService.generateCustomUniqueId() : selectedRole.id,
      name: newValue,
    );
    final updatedRoles = state.roles.map((employee) {
      return employee.id == selectedRole.id ? updatedEmployee : employee;
    }).toList();
    emit(state.copyWith(
      roles: updatedRoles,
      selectedRole: () => updatedEmployee,
    ));
  }

  @override
  Future<void> saveChanges() async {
    // First check deleted roles
    final deletedRoles = findDeletedRoles();
    for (var deletedRole in deletedRoles) {
      if (!deletedRole.id!.contains('SDT')) {
        // Only send delete request for original roles (roles that exist in server)
        await deleteRole(roleId: deletedRole.id!);
      }
    }
    for (var role in state.roles) {
      if (role.id != null && role.id!.contains('SDT')) {
        final success = await postRoles(
            rolesRequestModel: RolesRequestModel(
          name: role.name!,
          permissions: role.permissions,
        ));

        if (success) {
          final updatedRoles = List<RolesModel>.from(state.roles);
          final index = updatedRoles.indexWhere((r) => r.id == role.id);
          if (index != -1) {
            updatedRoles[index] = state.originalRoles.last;
          }
          emit(state.copyWith(roles: updatedRoles));
        }
      } else {
        // Employee exist in original list and values different
        if (originalRoles.map((e) => e.id).contains(role.id) &&
            areRolesDifferent(originalRoles.firstWhere((e) => e.id == role.id), role)) {
          await updateRoles(
              roleId: role.id!,
              rolesRequestModel: RolesRequestModel(
                name: role.name!,
                permissions: role.permissions,
              ));
        }
      }
    }
  }

  // Helper method to find deleted roles
  @override
  List<RolesModel> findDeletedRoles() {
    // Find roles that exist in originalRoles but not in state.roles
    return originalRoles.where((originalRole) {
      return !state.roles.any((currentRole) => currentRole.id == originalRole.id);
    }).toList();
  }

  // DELETE ROLE
  @override
  Future<bool> deleteRole({required String roleId}) async {
    emit(state.copyWith(status: RoleStatus.loading));

    final response = await _rolesService.deleteRole(roleId: roleId);
    return response.fold(
      (l) {
        emit(state.copyWith(status: RoleStatus.error, errorMessage: () => l.message));
        return false;
      },
      (r) {
        // Update originalRoles list after successful deletion
        final updatedOriginalRoles = List<RolesModel>.from(originalRoles)
          ..removeWhere((role) => role.id == roleId);
        emit(state.copyWith(
          status: RoleStatus.success,
          originalRoles: updatedOriginalRoles,
        ));
        return true;
      },
    );
  }

  @override
  void deleteSelectedRole() {
    final roleId = state.selectedRole?.id;
    final updatedRoles = List<RolesModel>.from(state.roles)
      ..removeWhere((role) => role.id == roleId);

    emit(state.copyWith(
      roles: updatedRoles,
      selectedRole: updatedRoles.isEmpty ? null : () => updatedRoles.last,
    ));
  }

  @override
  bool areRolesDifferent(RolesModel original, RolesModel updated) {
    return original.name != updated.name || original.permissions != updated.permissions;
  }

  @override
  void clearErrorMessage() {
    emit(state.copyWith(errorMessage: () => null));
  }

  @override
  void clearTemporaryRoles() {
    clearAllTextController();
    emit(state.copyWith(roles: originalRoles));
  }

  @override
  Future<void> close() {
    roleNameController.dispose();
    return super.close();
  }
}
