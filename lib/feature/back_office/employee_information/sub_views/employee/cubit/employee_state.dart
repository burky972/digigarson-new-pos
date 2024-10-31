// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';

import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/model/employee_model.dart';

class EmployeeState extends BaseState {
  const EmployeeState({
    required this.status,
    required this.employees,
    required this.selectedEmployee,
    required this.temporaryEmployees,
    required this.errorMessage,
  });

  final EmployeeStatus status;
  final List<EmployeeModel> employees;
  final List<EmployeeModel> temporaryEmployees;
  final EmployeeModel? selectedEmployee;
  final String? errorMessage;

  factory EmployeeState.initial() {
    return const EmployeeState(
      status: EmployeeStatus.initial,
      employees: [],
      selectedEmployee: null,
      temporaryEmployees: [],
      errorMessage: null,
    );
  }
  @override
  List<Object?> get props =>
      [status, employees, selectedEmployee, temporaryEmployees, errorMessage];

  EmployeeState copyWith({
    EmployeeStatus? status,
    List<EmployeeModel>? employees,
    EmployeeModel? Function()? selectedEmployee,
    List<EmployeeModel>? temporaryEmployees,
    String? Function()? errorMessage,
  }) {
    return EmployeeState(
      status: status ?? this.status,
      employees: employees ?? this.employees,
      temporaryEmployees: temporaryEmployees ?? this.temporaryEmployees,
      selectedEmployee: selectedEmployee == null ? this.selectedEmployee : selectedEmployee(),
      errorMessage: errorMessage == null ? this.errorMessage : errorMessage(),
    );
  }
}

enum EmployeeStatus {
  initial,
  loading,
  success,
  error,
}
