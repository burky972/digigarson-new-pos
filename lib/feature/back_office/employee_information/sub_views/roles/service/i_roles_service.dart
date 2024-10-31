import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/model/roles_request_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class IRolesService {
  BaseResponseData<BaseResponseModel> getRoles();
  BaseResponseData<BaseResponseModel> postRoles({required RolesRequestModel rolesRequestModel});
  BaseResponseData<BaseResponseModel> updateRoles(
      {required String roleId, required RolesRequestModel rolesRequestModel});
  BaseResponseData<BaseResponseModel> deleteRole({required String roleId});
}
