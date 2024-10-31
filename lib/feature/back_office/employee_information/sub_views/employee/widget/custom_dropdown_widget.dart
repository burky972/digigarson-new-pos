part of '../view/employee_view.dart';

class CustomDropdownWidget<T> extends StatefulWidget {
  const CustomDropdownWidget({
    super.key,
    required this.title,
    required this.values,
    required this.onChanged,
    required this.displayValue,
    this.initialValue,
  });

  final String title;
  final List<T> values;
  final T? initialValue;
  final String Function(T) displayValue;
  final ValueChanged<T?> onChanged;

  @override
  State<CustomDropdownWidget<T>> createState() => _CustomDropdownWidgetState<T>();
}

class _CustomDropdownWidgetState<T> extends State<CustomDropdownWidget<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(CustomDropdownWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        selectedValue = widget.initialValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ensure selectedValue is always valid
    if (selectedValue == null || !widget.values.contains(selectedValue)) {
      selectedValue = widget.initialValue ?? widget.values.first;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Text(
                widget.title,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
            Expanded(
              flex: 12,
              child: DropdownButton<T>(
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
                onChanged: (T? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                  widget.onChanged(newValue);
                },
                items: widget.values.map<DropdownMenuItem<T>>((T value) {
                  return DropdownMenuItem<T>(
                    value: value,
                    child: Text(widget.displayValue(value)),
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
