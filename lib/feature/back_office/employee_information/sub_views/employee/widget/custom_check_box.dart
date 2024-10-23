part of '../view/employee_view.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    super.key,
    this.initialValue = false,
    required this.onChanged,
    required this.label,
  });

  final bool initialValue;
  final Function(bool) onChanged;
  final String label;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: value,
          onChanged: (newValue) {
            if (newValue != null) {
              setState(() {
                value = newValue;
                widget.onChanged(value);
                appLogger.info('selected value:', '$value');
              });
            }
          },
        ),
        Text(
          widget.label,
          style: CustomFontStyle.titleBoldTertiaryStyle,
        ),
      ],
    );
  }
}
