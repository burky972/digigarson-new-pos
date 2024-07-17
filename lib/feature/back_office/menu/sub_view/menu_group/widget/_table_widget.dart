part of '../view/menu_group_view.dart';

class _TableWidget extends StatelessWidget {
  const _TableWidget({
    required this.widget,
  });

  final MenuGroupView widget;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FixedColumnWidth(80.0),
        3: FixedColumnWidth(80.0),
        4: FixedColumnWidth(80.0),
        5: FixedColumnWidth(80.0),
        6: FixedColumnWidth(80.0),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Colors.grey),
          children: [
            _TableCellTitleText(title: 'Group Name'),
            _TableCellTitleText(title: 'Group Description'),
            _TableCellTitleText(title: 'Dine In'),
            _TableCellTitleText(title: 'Take Out'),
            _TableCellTitleText(title: 'Delivery'),
            _TableCellTitleText(title: 'Quick Service'),
            _TableCellTitleText(title: 'Bar'),
          ],
        ),
        ...widget.data.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> row = entry.value;
          return TableRow(
            decoration: BoxDecoration(
              color: index == widget.selectedRowIndex ? context.colorScheme.tertiary : null,
            ),
            children: [
              _TableCellContentText(
                  onTap: () => widget.onRowTap(index), content: row['groupName']!),
              _TableCellContentText(
                  onTap: () => widget.onRowTap(index), content: row['groupDescription']!),
              _TableUnOnPressedCheckBox(
                value: row['dinIn'],
                onTap: () => widget.onRowTap(index),
              ),
              _TableUnOnPressedCheckBox(
                value: row['takeOut'],
                onTap: () => widget.onRowTap(index),
              ),
              _TableUnOnPressedCheckBox(
                value: row['delivery'],
                onTap: () => widget.onRowTap(index),
              ),
              _TableUnOnPressedCheckBox(
                value: row['quickService'],
                onTap: () => widget.onRowTap(index),
              ),
              _TableUnOnPressedCheckBox(
                value: row['bar'],
                onTap: () => widget.onRowTap(index),
              )
            ],
          );
        }),
      ],
    );
  }
}

class _TableCellTitleText extends StatelessWidget {
  const _TableCellTitleText({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}

class _TableCellContentText extends StatelessWidget {
  const _TableCellContentText({required this.onTap, required this.content});
  final VoidCallback onTap;
  final String content;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const AppPadding.minAll(),
          child: Center(
            child: Text(
              content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

class _TableUnOnPressedCheckBox extends StatelessWidget {
  const _TableUnOnPressedCheckBox({required this.value, required this.onTap});
  final bool? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const AppPadding.minAll(),
          child: Center(
            child: Checkbox(
              value: value,
              onChanged: null,
            ),
          ),
        ),
      ),
    );
  }
}