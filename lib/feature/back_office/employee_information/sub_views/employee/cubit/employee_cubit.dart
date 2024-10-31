import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/cubit/employee_state.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/cubit/i_employee_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/model/employee_model.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/model/employee_request_model.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/service/i_employee_service.dart';
import 'package:a_pos_flutter/product/global/service/global_service.dart';
import 'package:flutter/material.dart';

class EmployeeCubit extends IEmployeeCubit {
  EmployeeCubit(this._service) : super(EmployeeState.initial());
  final IEmployeeService _service;
  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController employeeNoController = TextEditingController();
  final TextEditingController employeeCodeController = TextEditingController();
  final TextEditingController employeeGsmController = TextEditingController();
  final TextEditingController employeeEmailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<EmployeeModel> originalEmployees = [];
  List<EmployeeModel> temporaryEmployees = [];

  @override
  void init() async {
    await getEmployee();
  }

  /// GET employee
  @override
  Future<bool> getEmployee() async {
    emit(state.copyWith(status: EmployeeStatus.loading));
    final response = await _service.getEmployee();
    response.fold(
      (l) => emit(state.copyWith(status: EmployeeStatus.error)),
      (r) {
        List<EmployeeModel> employees =
            (r.data as List).map((e) => EmployeeModel.fromJson(e)).toList();
        if (employees.isNotEmpty) {
          setSelectedEmployee(employees.first);
          originalEmployees = employees;
          temporaryEmployees = employees;
        }
        emit(state.copyWith(
            status: EmployeeStatus.success, employees: employees, temporaryEmployees: employees));
      },
    );
    return response.isRight();
  }

  /// POST employee
  @override
  Future<bool> postEmployee(EmployeeRequestModel employeeRequestModel) async {
    emit(state.copyWith(status: EmployeeStatus.loading));
    final response = await _service.postEmployee(employeeRequestModel: employeeRequestModel);
    response.fold(
        (l) => emit(state.copyWith(status: EmployeeStatus.error, errorMessage: () => l.message)),
        (r) {
      originalEmployees.add(EmployeeModel.fromJson(r.data));
      emit(state.copyWith(status: EmployeeStatus.success, employees: originalEmployees));
    });

    return response.isRight();
  }

  /// UPDATE employee
  @override
  Future<bool> updateEmployee(
      {required String id, required EmployeeRequestModel employeeRequestModel}) async {
    final response =
        await _service.updateEmployee(id: id, employeeRequestModel: employeeRequestModel);
    response.fold(
      (l) => emit(state.copyWith(status: EmployeeStatus.error, errorMessage: () => l.message)),
      (r) {
        final index = originalEmployees.indexWhere((e) => e.id == id);
        originalEmployees[index] = EmployeeModel.fromJson(r.data);
        emit(state.copyWith(status: EmployeeStatus.success, employees: originalEmployees));
      },
    );
    return response.isRight();
  }

  /// SET SELECTED EMPLOYEE
  @override
  void setSelectedEmployee(EmployeeModel employee) {
    employeeNameController.text = employee.name ?? '';

    // employeeNoController?.text = employee.employeeNo ?? '';
    // employeeCodeController?.text = employee.code ?? '';
    employeeGsmController.text = employee.gsmNo ?? '';
    employeeEmailController.text = employee.email ?? '';
    employee = employee.copyWith(role: employee.role);
    emit(state.copyWith(selectedEmployee: () => employee));
  }

  /// UPDATE SELECTED EMPLOYEE
  @override
  void updateSelectedEmployeeField(UpdateEmployeeFields fieldName, String newValue, {roleId}) {
    final selectedEmployee = state.selectedEmployee;
    if (selectedEmployee == null) return;
    final isNewEmployee = !originalEmployees.map((e) => e.id).contains(selectedEmployee.id);
    final updatedEmployee = selectedEmployee.copyWith(
      id: () => isNewEmployee ? GlobalService.generateCustomUniqueId() : selectedEmployee.id,
      name: fieldName == UpdateEmployeeFields.name ? newValue : selectedEmployee.name,
      email: fieldName == UpdateEmployeeFields.email ? newValue : selectedEmployee.email,
      lastName: fieldName == UpdateEmployeeFields.lastName ? newValue : selectedEmployee.lastName,
      gsmNo: fieldName == UpdateEmployeeFields.gsm ? newValue : selectedEmployee.gsmNo,
      password: fieldName == UpdateEmployeeFields.accessCode ? newValue : selectedEmployee.password,
      role: fieldName == UpdateEmployeeFields.role
          ? Role(roleName: newValue, roleId: roleId)
          : selectedEmployee.role,
    );

    final updatedEmployees = state.temporaryEmployees.map((employee) {
      return employee.id == selectedEmployee.id ? updatedEmployee : employee;
    }).toList();
    emit(state.copyWith(
      temporaryEmployees: updatedEmployees,
      selectedEmployee: () => updatedEmployee,
    ));
  }

  /// ADD NEW EMPTY Employee
  @override
  Future<void> addNewEmployee(Role? role) async {
    temporaryEmployees = state.temporaryEmployees;
    if (temporaryEmployees.isNotEmpty && temporaryEmployees.last.name?.isEmpty == true) return;
    // Clear text controllers
    clearAllTextController();

    // Create new employee and add
    final newEmployee = EmployeeModel.empty().copyWith(role: role);
    temporaryEmployees = List<EmployeeModel>.from(temporaryEmployees)..add(newEmployee);

    emit(state.copyWith(
      temporaryEmployees: List.from(temporaryEmployees),
      selectedEmployee: () => newEmployee,
    ));
  }

  ///save changes
  @override
  Future<void> saveChanges() async {
    if (!formKey.currentState!.validate()) return;
    // Önce silinen çalışanları kontrol et ve gerekli istekleri at
    final deletedEmployees = findDeletedEmployees();
    for (var deletedEmployee in deletedEmployees) {
      if (!deletedEmployee.id!.contains('SDT')) {
        // Sadece orijinal (sunucuda var olan) çalışanlar için silme isteği at
        await deleteEmployee(employeeId: deletedEmployee.id!);
      }
    }
    for (var employee in state.temporaryEmployees) {
      if (employee.id != null && employee.id!.contains('SDT')) {
        // New employee
        await postEmployee(EmployeeRequestModel(
          name: employee.name!,
          lastName: 'last name',
          password: employee.password!,
          role: employee.role!.roleId!,
          email: employee.email!,
          gsmNo: employee.gsmNo!,
        ));
      } else {
        // Employee exist in original list and values different
        if (originalEmployees.map((e) => e.id).contains(employee.id) &&
            areEmployeesDifferent(
                originalEmployees.firstWhere((e) => e.id == employee.id), employee)) {
          await updateEmployee(
              id: employee.id!,
              employeeRequestModel: EmployeeRequestModel(
                name: employee.name!,
                lastName: 'last name',
                password: employee.password!,
                role: employee.role!.roleId!,
                email: employee.email!,
                gsmNo: employee.gsmNo ?? '',
              ));
        }
      }
    }
  }

  @override
  bool areEmployeesDifferent(EmployeeModel original, EmployeeModel updated) {
    return original.name != updated.name ||
        original.email != updated.email ||
        original.lastName != updated.lastName ||
        original.gsmNo != updated.gsmNo ||
        original.role != updated.role ||
        original.password != updated.password;
  }

  /// DELETE Employee
  @override
  Future<bool> deleteEmployee({required String employeeId}) async {
    emit(state.copyWith(status: EmployeeStatus.loading));
    final response = await _service.deleteEmployee(id: employeeId);
    return response.fold(
      (l) {
        emit(state.copyWith(status: EmployeeStatus.error, errorMessage: () => l.message));
        return false;
      },
      (r) {
        final updatedOriginalEmployees = List<EmployeeModel>.from(originalEmployees)
          ..removeWhere((employee) => employee.id == employeeId);
        originalEmployees = updatedOriginalEmployees;
        emit(state.copyWith(
          status: EmployeeStatus.success,
          employees: updatedOriginalEmployees,
        ));
        return true;
      },
    );
  }

  // Silinen çalışanları bulan yardımcı method
  List<EmployeeModel> findDeletedEmployees() {
    return originalEmployees.where((originalEmployee) {
      return !state.temporaryEmployees
          .any((currentEmployee) => currentEmployee.id == originalEmployee.id);
    }).toList();
  }

  // UI tarafında kullanılacak silme methodu
  void deleteSelectedEmployee() {
    final employeeId = state.selectedEmployee?.id;
    final updatedEmployees = List<EmployeeModel>.from(state.temporaryEmployees)
      ..removeWhere((employee) => employee.id == employeeId);

    // Text controllerları temizle
    clearAllTextController();

    emit(state.copyWith(
      temporaryEmployees: updatedEmployees,
    ));
    setSelectedEmployee(
      updatedEmployees.isEmpty ? EmployeeModel.empty() : updatedEmployees.last,
    );
  }

  @override
  void clearTemporaryEmployees() {
    clearAllTextController();
    temporaryEmployees = originalEmployees;
    emit(state.copyWith(temporaryEmployees: temporaryEmployees));
  }

  @override
  void clearErrorMessage() {
    emit(state.copyWith(errorMessage: () => null));
  }

  @override
  void clearAllTextController() {
    employeeNameController.clear();
    employeeCodeController.clear();
    employeeGsmController.clear();
    employeeEmailController.clear();
    employeeNoController.clear();
  }

  @override
  Future<void> close() {
    employeeNameController.dispose();
    employeeNoController.dispose();
    employeeCodeController.dispose();
    employeeGsmController.dispose();
    employeeEmailController.dispose();
    return super.close();
  }
}

enum UpdateEmployeeFields { name, lastName, gsm, email, role, accessCode }
