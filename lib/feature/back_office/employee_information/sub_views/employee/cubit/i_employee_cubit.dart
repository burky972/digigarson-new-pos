import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/cubit/employee_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/cubit/employee_state.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/model/employee_model.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/model/employee_request_model.dart';
import 'package:core/core.dart';

abstract class IEmployeeCubit extends BaseCubit<EmployeeState> {
  IEmployeeCubit(super.initialState);

  Future<bool> getEmployee();
  Future<bool> postEmployee(EmployeeRequestModel employeeRequestModel);
  Future<bool> updateEmployee(
      {required String id, required EmployeeRequestModel employeeRequestModel});
  Future<bool> deleteEmployee({required String employeeId});
  void setSelectedEmployee(EmployeeModel employee);
  Future<void> saveChanges();
  void clearErrorMessage();
  void clearAllTextController();
  void clearTemporaryEmployees();
  bool areEmployeesDifferent(EmployeeModel original, EmployeeModel updated);
  Future<void> addNewEmployee(Role? role);
  void updateSelectedEmployeeField(UpdateEmployeeFields fieldName, String newValue);
}
