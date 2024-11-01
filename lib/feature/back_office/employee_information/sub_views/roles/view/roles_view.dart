import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/cubit/roles_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/cubit/roles_state.dart';
import 'package:a_pos_flutter/product/enums/permission/staff_permissions.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_border_all_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RolesView extends StatefulWidget {
  const RolesView({super.key});

  @override
  State<RolesView> createState() => _RolesViewState();
}

class _RolesViewState extends State<RolesView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RolesCubit, RolesState>(
      listener: (context, state) {
        if (state.status == RoleStatus.error) {
          showOrderDialogWithOutCustomDuration(context, state.errorMessage ?? '', onPressed: () {
            context.read<RolesCubit>().clearErrorMessage();
            routeManager.pop();
          });
        }
      },
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage && current.errorMessage != null,
      builder: (context, state) {
        return const Scaffold(
          body: Column(
            children: [
              _TopTableWidget(),
              SizedBox(height: 20),
              _PositionDetailWidget(),
              Spacer(),
              _BottomButtonFields(),
            ],
          ),
        );
      },
    );
  }
}

class _TopTableWidget extends StatelessWidget {
  const _TopTableWidget();

  @override
  Widget build(BuildContext context) {
    final ScrollController verticalScrollController = ScrollController();
    final ScrollController horizontalScrollController = ScrollController();

    final List<Widget> tableCellTitleList = [
      const TableCellTitleWidget(title: 'Position Name', width: 150),
      ...StaffPermissions.values.map((permission) {
        return TableCellTitleWidget(
          title: permission.value.toString(),
          width: 50,
          tooltip: permission.description,
        );
      }),
    ];

    return BlocBuilder<RolesCubit, RolesState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          width: context.dynamicWidth(0.95),
          height: context.dynamicHeight(0.45),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.grey.shade200,
                        child: Row(
                          children: tableCellTitleList,
                        ),
                      ),
                      Column(
                        children: state.roles.map((role) {
                          return InkWell(
                            onTap: () => context.read<RolesCubit>().setSelectedRole(role),
                            child: ColoredBox(
                                color: state.selectedRole == role
                                    ? context.colorScheme.tertiary
                                    : Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 150,
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          role.name ?? '',
                                          style: CustomFontStyle.titlesTextStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      ...StaffPermissions.values
                                          .map((permission) => _PermissionCheckbox(
                                                value: role.hasPermission(permission),
                                                onChanged: (value) {
                                                  if (state.selectedRole == state.roles.first) {
                                                    return;
                                                  }
                                                  context
                                                      .read<RolesCubit>()
                                                      .togglePermissionForRole(permission);
                                                },
                                              )),
                                    ],
                                  ),
                                )),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PermissionCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const _PermissionCheckbox({
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 40,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

class _PositionDetailWidget extends StatelessWidget {
  const _PositionDetailWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RolesCubit, RolesState>(
      builder: (context, state) {
        RolesCubit roleCubit = context.read<RolesCubit>();
        return Container(
          padding: const EdgeInsets.all(16),
          width: context.dynamicWidth(0.95),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TitleWithTextfieldWidget(
                title: 'Position Name',
                controller: roleCubit.roleNameController,
                isReadOnly: state.selectedRole == state.roles.first,
                maxCharacter: 50,
                onChanged: (value) => roleCubit.updateSelectedRoleField(value),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: StaffPermissions.values.map((permission) {
                  return _PermissionDetailItem(
                    permission: permission,
                    isChecked: state.selectedRole?.hasPermission(permission) ?? false,
                    state: state,
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PermissionDetailItem extends StatelessWidget {
  final StaffPermissions permission;
  final bool isChecked;
  final RolesState state;

  const _PermissionDetailItem({
    required this.permission,
    required this.isChecked,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Row(
        children: [
          Checkbox(
            value: isChecked, // Checkbox değeri artık isChecked
            onChanged: (value) {
              if (state.selectedRole == state.roles.first) {
                return;
              }
              context.read<RolesCubit>().togglePermissionForRole(permission);
            },
          ),
          Expanded(
            child: Text(
              '${permission.value} - ${permission.description}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class TableCellTitleWidget extends StatelessWidget {
  final String title;
  final double width;
  final String? tooltip;

  const TableCellTitleWidget({
    required this.title,
    this.width = 100,
    this.tooltip,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = Container(
      width: width,
      padding: const EdgeInsets.all(8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: titleWidget,
      );
    }

    return titleWidget;
  }
}

class _BottomButtonFields extends StatelessWidget {
  const _BottomButtonFields();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LightBlueButton(
            buttonText: 'Add',
            onTap: () {
              context.read<RolesCubit>().addNewRole();
            }),
        LightBlueButton(
          buttonText: 'Delete',
          onTap: () {
            if (context.read<RolesCubit>().state.selectedRole?.name == 'Admin') {
              return;
            }
            context.read<RolesCubit>().deleteSelectedRole();
          },
        ),
        LightBlueButton(
          buttonText: 'Save',
          onTap: () async {
            await context.read<RolesCubit>().saveChanges();
          },
        ),
        LightBlueButton(
          buttonText: 'Exit',
          onTap: () {
            context.read<RolesCubit>().clearTemporaryRoles();
            routeManager.pop();
          },
        ),
      ],
    );
  }
}

class _TitleWithTextfieldWidget extends StatelessWidget {
  const _TitleWithTextfieldWidget({
    required this.title,
    required this.controller,
    required this.maxCharacter,
    required this.onChanged,
    this.isObscure = false,
    this.validator,
    this.isReadOnly = false,
  });
  final String title;
  final TextEditingController controller;
  final int maxCharacter;
  final void Function(String)? onChanged;
  final bool isObscure;
  final bool isReadOnly;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidth(0.3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                flex: 4,
                child: Text(
                  title,
                  style: CustomFontStyle.titleBoldTertiaryStyle,
                )),
            Expanded(
              flex: 12,
              child: CustomBorderAllTextfield(
                maxCharacter: maxCharacter,
                validator: validator,
                isObscure: isObscure,
                isReadOnly: isReadOnly,
                controller: controller,
                onChanged: onChanged,
              ),
            ),
            const Expanded(
              flex: 1,
              child: Text(''),
            ),
          ],
        ),
      ),
    );
  }
}