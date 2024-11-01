import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrintersView extends StatefulWidget {
  const PrintersView({super.key});

  @override
  State<PrintersView> createState() => _PrintersViewState();
}

bool isBuzzerEnabled = false;
String? selectedValue;
String? selectedValue2;
List<String> printerList = <String>[
  'OneNote for Windows 10',
  'Microsoft XPS Document Writer',
  'Microsoft Print to PDF',
  'Fax',
  'AnyDesk Printer'
];
List<String> typeList = <String>[
  'Star',
  'Others',
];

class _PrintersViewState extends State<PrintersView> {
  CategoryModel? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> categories = [
      CategoryModel(
          printerName: "HOT",
          printer: "OneNote for Windows 10",
          type: "Star",
          paperWidth: "73"),
      CategoryModel(
          printerName: "TEST",
          printer: "Microsoft XPS Document Writer",
          type: "Others",
          paperWidth: "72"),
      CategoryModel(
          printerName: "KITCHEN",
          printer: "Microsoft Print to PDF",
          type: "Star",
          paperWidth: "72"),
      CategoryModel(
          printerName: "Receipt",
          printer: "Fax",
          type: "Others",
          paperWidth: "72"),
    ];

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: context.dynamicHeight(0.45),
            width: context.dynamicWidth(0.8),
            decoration: BoxDecoration(border: BorderConstants.borderAllSmall),
            child: ListView(
              children: [
                _TableWidget(
                  categories: categories,
                  onCategoryTap: _onCategoryTap,
                ),
              ],
            ),
          ),
          SizedBox(
            height: context.dynamicHeight(0.25),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Printer Details',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            flex: 2,
                                            child: Text('Printer Name')),
                                        Expanded(
                                          flex: 3,
                                          child: TextField(
                                            controller: TextEditingController(
                                                text: _selectedCategory
                                                        ?.printerName ??
                                                    ''),
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedCategory?.printerName =
                                                    value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Flexible(
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            flex: 2, child: Text('Printer')),
                                        Expanded(
                                          flex: 3,
                                          child: DropdownButton<String>(
                                            value: selectedValue,
                                            items: printerList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedValue = newValue;
                                                _selectedCategory?.printer =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Flexible(
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            flex: 2, child: Text('Type')),
                                        Expanded(
                                          flex: 3,
                                          child: DropdownButton<String>(
                                            value: selectedValue2,
                                            items: typeList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedValue2 = newValue;
                                                _selectedCategory?.type =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Flexible(
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            flex: 2,
                                            child: Text('Paper Width(mm)')),
                                        Expanded(
                                          flex: 3,
                                          child: TextField(
                                            controller: TextEditingController(
                                                text: _selectedCategory
                                                        ?.paperWidth ??
                                                    ''),
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedCategory?.paperWidth =
                                                    value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 50),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isBuzzerEnabled,
                                    activeColor: Colors.black,
                                    onChanged: (value) {
                                      setState(() {
                                        isBuzzerEnabled = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Enable Buzzer'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 2,
            child: _BottomButtonFields(),
          ),
        ],
      ),
    );
  }

  void _onCategoryTap(CategoryModel category) {
    setState(() {
      _selectedCategory = category;
      selectedValue = category.printer;
      selectedValue2 = category.type;
    });
  }
}

class CategoryModel {
  String? printerName;
  String? printer;
  String? type;
  String? paperWidth;

  CategoryModel({this.printerName, this.printer, this.type, this.paperWidth});

  set setPrinterName(String name) => printerName = name;
  set setPrinter(String printerValue) => printer = printerValue;
  set setType(String typeValue) => type = typeValue;
  set setPaperWidth(String width) => paperWidth = width;
}

class _TableWidget extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function(CategoryModel) onCategoryTap;

  const _TableWidget({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(120.0),
        1: FlexColumnWidth(200.0),
        2: FixedColumnWidth(100.0),
        3: FixedColumnWidth(120.0),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Colors.grey),
          children: [
            _TableCellTitleText(title: 'Printer Name'),
            _TableCellTitleText(title: 'Printer'),
            _TableCellTitleText(title: 'Type'),
            _TableCellTitleText(title: 'Paper Width'),
          ],
        ),
        ...categories.map((category) {
          return TableRow(
            children: [
              TableRowInkWell(
                onTap: () => onCategoryTap(category),
                child:
                    _TableCellContentText(content: category.printerName ?? ''),
              ),
              TableRowInkWell(
                onTap: () => onCategoryTap(category),
                child: _TableCellContentText(content: category.printer ?? ''),
              ),
              TableRowInkWell(
                onTap: () => onCategoryTap(category),
                child: _TableCellContentText(content: category.type ?? ''),
              ),
              TableRowInkWell(
                onTap: () => onCategoryTap(category),
                child:
                    _TableCellContentText(content: category.paperWidth ?? ''),
              ),
            ],
          );
        }),
      ],
    );
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

class _BottomButtonFields extends StatelessWidget {
  const _BottomButtonFields();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
        LightBlueButton(
          buttonText: 'Add',
          onTap: () => context.read<CategoryCubit>().addNewCategory(),
        ),
        LightBlueButton(
          buttonText: 'Delete',
          onTap: context.read<CategoryCubit>().state.selectedCategory == null
              ? null
              : () async {
                  await patchCategory(context);
                },
        ),
        LightBlueButton(
          buttonText: 'Edit',
          onTap: context.read<CategoryCubit>().state.selectedCategory == null
              ? null
              : () async {
                  await patchCategory(context);
                },
        ),
        LightBlueButton(
            buttonText: 'Save',
            onTap: () async =>
                await context.read<CategoryCubit>().saveChanges()),
        LightBlueButton(
          buttonText: 'Exit',
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Future<void> patchCategory(BuildContext context) async {
    CategoryCubit categoryCubit = context.read<CategoryCubit>();

    final bool isSuccess = await categoryCubit.patchCategories(
        categoryId: categoryCubit.selectedCategory!.id!);

    if (!isSuccess) {
      await showOrderErrorDialog('${categoryCubit.state.exception?.message}!');
      await categoryCubit.getCategories();
    } else {
      await categoryCubit
          .patchCategories(
              categoryId: categoryCubit.state.selectedCategory!.id!)
          .whenComplete(() => categoryCubit.getCategories());
    }
  }
}
