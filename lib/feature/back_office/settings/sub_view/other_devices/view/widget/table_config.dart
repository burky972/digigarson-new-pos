import 'package:flutter/material.dart';

class TableConfig extends StatefulWidget {
  const TableConfig({super.key});

  @override
  State<TableConfig> createState() => _TableConfigState();
}

class _TableConfigState extends State<TableConfig> {
  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> categories = [];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Scale Port Configuration",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  flex: 9,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: ListView(
                      children: [
                        _TableWidget(categories: categories),
                      ],
                    ),
                  ),
                ),
              ])),
    );
  }
}

class CategoryModel {
  final String? tableID;
  final String? tableName;
  final String? paymentDevice;

  CategoryModel({this.tableID, this.tableName, this.paymentDevice});
}

class _TableWidget extends StatefulWidget {
  final List<CategoryModel> categories;

  const _TableWidget({super.key, required this.categories});

  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<_TableWidget> {
  CategoryModel? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(100.0),
        1: FlexColumnWidth(100.0),
        2: FlexColumnWidth(100.0),
        3: FlexColumnWidth(60.0),
        4: FlexColumnWidth(60.0),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Colors.grey),
          children: [
            _TableCellTitleText(title: 'Table ID'),
            _TableCellTitleText(title: 'Table Name'),
            _TableCellTitleText(title: 'Payemnt Device'),
            _TableCellTitleText(title: ''),
            _TableCellTitleText(title: ''),
          ],
        ),
        ...widget.categories.map((category) {
          return TableRow(
            decoration: BoxDecoration(
              color: category == _selectedCategory
                  ? Theme.of(context).colorScheme.primaryFixed
                  : null,
            ),
            children: [
              TableRowInkWell(
                onTap: () => _onCategoryTap(category),
                child: _TableCellContentText(content: category.tableID ?? ''),
              ),
              TableRowInkWell(
                onTap: () => _onCategoryTap(category),
                child: _TableCellContentText(content: category.tableName ?? ''),
              ),
              TableRowInkWell(
                onTap: () => _onCategoryTap(category),
                child: _TableCellContentText(
                    content: category.paymentDevice ?? ''),
              ),
              const _TableCellContentText(content: ''),
              const _TableCellContentText(content: ''),
            ],
          );
        }),
      ],
    );
  }

  void _onCategoryTap(CategoryModel category) {
    setState(() {
      _selectedCategory = category;
    });
  }
}

class _TableCellTitleText extends StatelessWidget {
  final String title;

  const _TableCellTitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _TableCellContentText extends StatelessWidget {
  final String content;

  const _TableCellContentText({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        content,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
