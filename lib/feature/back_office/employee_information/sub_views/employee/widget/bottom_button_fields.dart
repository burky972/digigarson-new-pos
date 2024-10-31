part of '../view/employee_view.dart';

class _BottomButtonFields extends StatelessWidget {
  const _BottomButtonFields();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LightBlueButton(
          buttonText: 'Add',
          onTap: () => context.read<EmployeeCubit>().addNewEmployee(Role(
                roleId: context.read<RolesCubit>().state.roles.first.id,
                roleName: context.read<RolesCubit>().state.roles.first.name,
              )),
        ),
        LightBlueButton(
          buttonText: 'Delete',
          onTap: () {
            context.read<EmployeeCubit>().deleteSelectedEmployee();
          },
        ),
        LightBlueButton(
          buttonText: 'Save',
          onTap: () async {
            await context.read<EmployeeCubit>().saveChanges();
          },
        ),
        const LightBlueButton(buttonText: 'Export'),
        LightBlueButton(
          buttonText: 'Exit',
          onTap: () {
            context.read<EmployeeCubit>().clearTemporaryEmployees();
            routeManager.pop();
          },
        ),
      ],
    );
  }
}
