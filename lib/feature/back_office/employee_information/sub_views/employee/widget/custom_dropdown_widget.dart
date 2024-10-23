part of '../view/employee_view.dart';

class CustomDropdownWidget extends StatefulWidget {
  const CustomDropdownWidget({
    super.key,
    required this.title,
    required this.values,
    required this.onChanged,
    this.initialValue,
  });

  final String title;
  final List<String> values;
  final Function(String?) onChanged;
  final String? initialValue;

  @override
  State<CustomDropdownWidget> createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  String? selectedValue;
  late String title;
  late List<String> values;
  late Function(String?) onChanged;
  late String? initialValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ?? widget.values.first;
    title = widget.title;
    values = widget.values;
    onChanged = widget.onChanged;
    initialValue = widget.initialValue;
  }

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
              ),
            ),
            Expanded(
              flex: 12,
              child: DropdownButton<String>(
                value: selectedValue,
                isExpanded: true,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                  onChanged(newValue);
                },
                items: values.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
