import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/model/roles_request_model.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/service/i_roles_service.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';

class RolesService implements IRolesService {
  const RolesService(this._dioClient);
  final DioClient _dioClient;

  @override
  BaseResponseData<BaseResponseModel> getRoles() async {
    BaseResponseModel responseModel = await _dioClient.get(
      NetworkConstants.branchRoles,
    );
    return ApiResponseHandler.handleResponse(responseModel);
  }

  @override
  BaseResponseData<BaseResponseModel> postRoles(
      {required RolesRequestModel rolesRequestModel}) async {
    BaseResponseModel responseModel =
        await _dioClient.post(NetworkConstants.branchRoles, data: rolesRequestModel.toJson());
    return ApiResponseHandler.handleResponse(responseModel);
  }

  @override
  BaseResponseData<BaseResponseModel> updateRoles(
      {required String roleId, required RolesRequestModel rolesRequestModel}) async {
    BaseResponseModel responseModel = await _dioClient
        .put('${NetworkConstants.branchRoles}/$roleId', data: rolesRequestModel.toJson());
    return ApiResponseHandler.handleResponse(responseModel);
  }

  @override
  BaseResponseData<BaseResponseModel> deleteRole({required String roleId}) async {
    BaseResponseModel responseModel =
        await _dioClient.delete('${NetworkConstants.branchRoles}/$roleId');
    return ApiResponseHandler.handleResponse(responseModel);
  }
}
