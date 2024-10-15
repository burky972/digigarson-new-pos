import 'package:a_pos_flutter/product/constant/app/date_time_formats.dart';
import 'package:a_pos_flutter/product/extension/date_time_format/date_time_format.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:flutter/material.dart';

class SelectDateWidget extends StatefulWidget {
  const SelectDateWidget({
    super.key,
    required this.startDateController,
    required this.endDateController,
    this.isStartDay = false,
  });

  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final bool isStartDay;

  @override
  State<SelectDateWidget> createState() => _SelectDateWidgetState();
}

class _SelectDateWidgetState extends State<SelectDateWidget> {
  late TextEditingController _dateController;
  late bool _isStartDay;

  @override
  void initState() {
    super.initState();
    _isStartDay = widget.isStartDay;
    _dateController = _isStartDay ? widget.startDateController : widget.endDateController;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const AppPadding.normalAll(),
      child: TextField(
        controller: _dateController,
        decoration: InputDecoration(
          labelText: _isStartDay ? 'From' : 'To',
          filled: true,
          prefixIcon: const Icon(Icons.calendar_today),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        readOnly: true,
        onTap: () => _selectDate(context),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formattedDate = picked.toFormattedString(format: timeFormatMDY);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }
}
