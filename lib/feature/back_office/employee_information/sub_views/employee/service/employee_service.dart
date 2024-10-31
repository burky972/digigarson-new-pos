import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/model/employee_request_model.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/service/i_employee_service.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/core.dart';

class EmployeeService implements IEmployeeService {
  const EmployeeService(this._dioClient);
  final DioClient _dioClient;
  @override
  BaseResponseData<BaseResponseModel> getEmployee() async {
    BaseResponseModel responseModel = await _dioClient.get(
      NetworkConstants.branchEmployee,
    );
    return ApiResponseHandler.handleResponse(responseModel);
  }

  @override
  BaseResponseData<BaseResponseModel> postEmployee(
      {required EmployeeRequestModel employeeRequestModel}) async {
    BaseResponseModel responseModel = await _dioClient.post(
      NetworkConstants.branchEmployee,
      data: employeeRequestModel.toJson(),
    );
    return ApiResponseHandler.handleResponse(responseModel);
  }

  @override
  BaseResponseData<BaseResponseModel> updateEmployee(
      {required String id, required EmployeeRequestModel employeeRequestModel}) async {
    BaseResponseModel responseModel = await _dioClient.put(
      '${NetworkConstants.branchEmployee}/$id',
      data: employeeRequestModel.toJson(),
    );
    return ApiResponseHandler.handleResponse(responseModel);
  }

  @override
  BaseResponseData<BaseResponseModel> deleteEmployee({required String id}) async {
    BaseResponseModel responseModel = await _dioClient.patch(
      '${NetworkConstants.branchEmployee}/$id',
    );
    return ApiResponseHandler.handleResponse(responseModel);
  }
}
