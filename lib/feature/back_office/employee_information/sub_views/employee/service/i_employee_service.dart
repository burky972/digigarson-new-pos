import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/model/employee_request_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class IEmployeeService {
  BaseResponseData<BaseResponseModel> getEmployee();
  BaseResponseData<BaseResponseModel> postEmployee(
      {required EmployeeRequestModel employeeRequestModel});
  BaseResponseData<BaseResponseModel> updateEmployee(
      {required String id, required EmployeeRequestModel employeeRequestModel});
  BaseResponseData<BaseResponseModel> deleteEmployee({required String id});
}
