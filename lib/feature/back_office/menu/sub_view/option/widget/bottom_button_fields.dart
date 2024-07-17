part of '../view/menu_option_view.dart';

class _BottomButtonFields extends StatelessWidget {
  const _BottomButtonFields();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: TextField()),
        const LightBlueButton(buttonText: 'Upload'),
        const LightBlueButton(buttonText: 'inventory'),
        const Spacer(),
        const LightBlueButton(buttonText: 'Move Up'),
        const LightBlueButton(buttonText: 'Move Down'),
        const LightBlueButton(buttonText: 'Add'),
        const LightBlueButton(buttonText: 'Delete'),
        const LightBlueButton(buttonText: 'Save'),
        const LightBlueButton(buttonText: 'Export'),
        InkWell(
            onTap: () => Navigator.pop(context), child: const LightBlueButton(buttonText: 'Exit')),
      ],
    );
  }
}
