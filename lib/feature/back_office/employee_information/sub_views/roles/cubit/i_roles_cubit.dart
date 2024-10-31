import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/cubit/roles_state.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/model/roles_model.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/model/roles_request_model.dart';
import 'package:a_pos_flutter/product/enums/permission/staff_permissions.dart';
import 'package:core/base/cubit/base_cubit.dart';

abstract class IRolesCubit extends BaseCubit<RolesState> {
  IRolesCubit(super.initialState);
  Future<bool> getRoles();
  Future<bool> postRoles({required RolesRequestModel rolesRequestModel});
  Future<bool> updateRoles({required String roleId, required RolesRequestModel rolesRequestModel});
  Future<bool> deleteRole({required String roleId});
  Future<void> addNewRole();
  Future<void> saveChanges();
  void updateSelectedRoleField(String newValue);
  void clearAllTextController();
  void clearTemporaryRoles();
  void clearErrorMessage();
  void setSelectedRole(RolesModel role);
  void togglePermissionForRole(StaffPermissions toggledPermission);
  bool areRolesDifferent(RolesModel original, RolesModel updated);
  void deleteSelectedRole();
  List<RolesModel> findDeletedRoles();
}
