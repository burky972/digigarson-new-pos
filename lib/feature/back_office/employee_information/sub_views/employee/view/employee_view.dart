import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/cubit/employee_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/cubit/employee_state.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/model/employee_model.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/cubit/roles_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/cubit/roles_state.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/model/roles_model.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:a_pos_flutter/product/widget/table_cell/table_cell_widget.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_border_all_textfield.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../widget/custom_dropdown_widget.dart';
part '../widget/title_with_textfield_widget.dart';
part '../widget/bottom_button_fields.dart';
part '../widget/custom_check_box.dart';

class EmployeeView extends StatelessWidget {
  const EmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController verticalScrollController = ScrollController();
    final ScrollController horizontalScrollController = ScrollController();
    const List<Widget> tableCellTitleList = [
      TableCellTitleWidget(title: 'Name'),
      TableCellTitleWidget(title: 'Employee NO:'),
      TableCellTitleWidget(title: 'Home Phone'),
      TableCellTitleWidget(title: 'Mobile Phone'),
      TableCellTitleWidget(title: 'City'),
      TableCellTitleWidget(title: 'State'),
      TableCellTitleWidget(title: 'ZipCode'),
      TableCellTitleWidget(title: 'Email'),
      TableCellTitleWidget(title: 'Wage'),
      TableCellTitleWidget(title: 'Address'),
    ];

    return BlocConsumer<EmployeeCubit, EmployeeState>(
      listener: (context, state) {
        if (state.status == EmployeeStatus.error) {
          showOrderDialogWithOutCustomDuration(context, state.errorMessage ?? '', onPressed: () {
            context.read<EmployeeCubit>().clearErrorMessage();
            routeManager.pop();
          });
        }
      },
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage && current.errorMessage != null,
      builder: (context, state) {
        EmployeeCubit employeeCubit = context.read<EmployeeCubit>();
        return ListView(children: [
          Container(
            padding: const EdgeInsets.only(left: 8.0),
            width: context.dynamicWidth(0.9),
            height: context.dynamicHeight(0.45),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Scrollbar(
              controller: verticalScrollController,
              thumbVisibility: true,
              child: Scrollbar(
                controller: horizontalScrollController,
                thumbVisibility: true,
                notificationPredicate: (notification) => notification.depth == 1,
                child: SingleChildScrollView(
                  controller: verticalScrollController,
                  child: SingleChildScrollView(
                    controller: horizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: context.dynamicWidth(0.9),
                      height: context.dynamicHeight(0.45),
                      child: Table(
                        border: TableBorder.all(),
                        defaultColumnWidth: const IntrinsicColumnWidth(),
                        children: [
                          const TableRow(
                            decoration: BoxDecoration(color: Colors.grey),
                            children: tableCellTitleList,
                          ),
                          ...state.temporaryEmployees.map((employee) {
                            return TableRow(
                              decoration: BoxDecoration(
                                color: employee.id == state.selectedEmployee?.id
                                    ? context.colorScheme.tertiary
                                    : null,
                              ),
                              children: [
                                MiddleTableCellTextWidget(
                                  onTap: () => employeeCubit.setSelectedEmployee(employee),
                                  text: employee.name ?? '',
                                ),
                                MiddleTableCellTextWidget(
                                  onTap: () => employeeCubit.setSelectedEmployee(employee),
                                  text: employee.branch ?? '',
                                ),
                                MiddleTableCellTextWidget(
                                  onTap: () => employeeCubit.setSelectedEmployee(employee),
                                  text: employee.gsmNo ?? '',
                                ),
                                MiddleTableCellTextWidget(
                                  onTap: () => employeeCubit.setSelectedEmployee(employee),
                                  text: employee.gsmNo ?? '',
                                ),
                                MiddleTableCellTextWidget(
                                  onTap: () => employeeCubit.setSelectedEmployee(employee),
                                  text: 'city',
                                ),
                                MiddleTableCellTextWidget(
                                  onTap: () => employeeCubit.setSelectedEmployee(employee),
                                  text: 'state',
                                ),
                                MiddleTableCellTextWidget(
                                  onTap: () => employeeCubit.setSelectedEmployee(employee),
                                  text: 'zipCode',
                                ),
                                MiddleTableCellTextWidget(
                                  onTap: () => employeeCubit.setSelectedEmployee(employee),
                                  text: employee.email ?? '',
                                ),
                                MiddleTableCellTextWidget(
                                  onTap: () => employeeCubit.setSelectedEmployee(employee),
                                  text: 'wage',
                                ),
                                MiddleTableCellTextWidget(
                                  onTap: () => employeeCubit.setSelectedEmployee(employee),
                                  text: 'address',
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Text('Information Details', style: CustomFontStyle.titlesTextStyle),
          Form(
            key: employeeCubit.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SizedBox(
              width: context.dynamicWidth(0.9),
              height: context.dynamicHeight(0.35),
              child: Wrap(children: [
                _TitleWithTextfieldWidget(
                  title: 'Employee Name',
                  controller: employeeCubit.employeeNameController,
                  validator: (value) => value!.isNotEmpty ? null : 'Name required',
                  maxCharacter: 50,
                  onChanged: (value) =>
                      employeeCubit.updateSelectedEmployeeField(UpdateEmployeeFields.name, value),
                ),
                BlocBuilder<RolesCubit, RolesState>(
                  builder: (context, state) {
                    Role? selectedRole = employeeCubit.state.selectedEmployee?.role;

                    if (state.originalRoles.isEmpty) {
                      return const CircularProgressIndicator();
                    }
                    // Filter out roles with the same name
                    final uniqueRoles =
                        state.originalRoles.fold<List<RolesModel>>([], (uniqueList, role) {
                      if (!uniqueList.any((uniqueRole) => uniqueRole.name == role.name)) {
                        uniqueList.add(role);
                      }
                      return uniqueList;
                    });

                    // Check the initialValue for the selected role
                    final initialValue = selectedRole != null &&
                            uniqueRoles.any((role) => role.id == selectedRole.roleId)
                        ? uniqueRoles.firstWhere((role) => role.id == selectedRole.roleId)
                        : uniqueRoles.first;

                    return CustomDropdownWidget<RolesModel>(
                      title: 'Position',
                      values: state.originalRoles,
                      initialValue: initialValue,
                      displayValue: (role) => role.name ?? '',
                      onChanged: (RolesModel? newSelectedRole) {
                        if (newSelectedRole != null) {
                          employeeCubit.updateSelectedEmployeeField(
                            UpdateEmployeeFields.role,
                            newSelectedRole.name ?? '',
                            roleId: newSelectedRole.id,
                          );
                        }
                      },
                    );
                  },
                ),
                _TitleWithTextfieldWidget(
                  title: 'Home Phone',
                  controller: employeeCubit.employeeGsmController,
                  maxCharacter: 50,
                  onChanged: null,
                ),
                _TitleWithTextfieldWidget(
                  title: 'Employee NO.',
                  controller: employeeCubit.employeeNoController,
                  maxCharacter: 50,
                  onChanged: null,
                ),
                _TitleWithTextfieldWidget(
                  title: 'City',
                  controller: TextEditingController(text: ''),
                  maxCharacter: 50,
                  onChanged: null,
                ),
                _TitleWithTextfieldWidget(
                  title: 'Mobile Phone',
                  controller: employeeCubit.employeeGsmController,
                  validator: (value) => value!.isNotEmpty ? null : 'Phone required',
                  maxCharacter: 50,
                  onChanged: (value) =>
                      employeeCubit.updateSelectedEmployeeField(UpdateEmployeeFields.gsm, value),
                ),
                _TitleWithTextfieldWidget(
                  title: 'Access Code',
                  controller: employeeCubit.employeeCodeController,
                  maxCharacter: 50,
                  // validator: (value) => value!.isNotEmpty ? null : 'Code required',
                  isObscure: true,
                  onChanged: (value) => employeeCubit.updateSelectedEmployeeField(
                      UpdateEmployeeFields.accessCode, value),
                ),
                _TitleWithTextfieldWidget(
                  title: 'State',
                  controller: TextEditingController(text: ''),
                  maxCharacter: 50,
                  onChanged: null,
                ),
                _TitleWithTextfieldWidget(
                  title: 'Email',
                  controller: employeeCubit.employeeEmailController,
                  validator: (value) => value!.isValidEmail() ? null : 'Invalid Email',
                  maxCharacter: 50,
                  onChanged: (value) {
                    employeeCubit.updateSelectedEmployeeField(UpdateEmployeeFields.email, value);
                  },
                ),
                _TitleWithTextfieldWidget(
                  title: 'ZipCode',
                  controller: TextEditingController(text: ''),
                  maxCharacter: 50,
                  onChanged: null,
                ),
                _TitleWithTextfieldWidget(
                  title: 'Wage(per hour)',
                  controller: TextEditingController(text: ''),
                  maxCharacter: 50,
                  onChanged: null,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          'Address',
                          style: CustomFontStyle.titleBoldTertiaryStyle,
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: CustomBorderAllTextfield(
                          isObscure: false,
                          isReadOnly: false,
                          controller: TextEditingController(),
                          onChanged: (value) {},
                        ),
                      ),
                      const Expanded(flex: 1, child: SizedBox.shrink()),
                      Expanded(
                          flex: 19,
                          child: CustomCheckBox(
                            initialValue: false,
                            label: 'Is Active',
                            onChanged: (bool newValue) {},
                          )),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          const _BottomButtonFields(),
        ]);
      },
    );
  }
}
