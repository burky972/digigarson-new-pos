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
          onTap: () {},
        ),
        LightBlueButton(
          buttonText: 'Delete',
          onTap: () {},
        ),
        LightBlueButton(
          buttonText: 'Save',
          onTap: () {},
        ),
        const LightBlueButton(buttonText: 'Export'),
        LightBlueButton(
          buttonText: 'Exit',
          onTap: () => routeManager.pop(),
        ),
      ],
    );
  }
}
