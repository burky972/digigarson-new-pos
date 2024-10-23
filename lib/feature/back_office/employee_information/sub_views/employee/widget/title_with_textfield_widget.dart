part of '../view/employee_view.dart';

class _TitleWithTextfieldWidget extends StatelessWidget {
  const _TitleWithTextfieldWidget({
    required this.title,
    required this.controller,
    required this.maxCharacter,
    required this.onChanged,
    this.isObscure = false,
  });
  final String title;
  final TextEditingController controller;
  final int maxCharacter;
  final void Function(String)? onChanged;
  final bool isObscure;

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
                isObscure: isObscure,
                isReadOnly: false,
                controller: TextEditingController(
                  text: controller.text,
                ),
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