part of '../view/menu_group_view.dart';

class _BottomButtonFields extends StatelessWidget {
  const _BottomButtonFields();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: TextField()),
        const LightBlueButton(buttonText: 'Upload'),
        const LightBlueButton(buttonText: 'inventory'),
        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
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
