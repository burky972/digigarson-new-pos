import 'package:flutter/material.dart';

class MiddleTableCellTextWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const MiddleTableCellTextWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TableRowInkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14),
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}

class TableCellTitleWidget extends StatelessWidget {
  const TableCellTitleWidget({
    required this.title,
    super.key,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              overflow: TextOverflow.visible,
            )),
      )),
    );
  }
}
