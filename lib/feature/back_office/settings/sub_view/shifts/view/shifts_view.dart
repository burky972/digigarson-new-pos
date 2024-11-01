import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShiftsView extends StatefulWidget {
  const ShiftsView({super.key});

  @override
  State<ShiftsView> createState() => _ShiftsViewState();
}

bool isCloseBatchEnabled = false;
bool isEnableBatchEnabled = false;

class _ShiftsViewState extends State<ShiftsView> {
  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> categories = [
      CategoryModel(
        shiftName: "No Shift",
      ),
      CategoryModel(
        shiftName: "Morning Shift",
      ),
      CategoryModel(
        shiftName: "Afternoon Shift",
      ),
      CategoryModel(
        shiftName: "Evening Shift",
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: context.dynamicHeight(0.45),
            width: context.dynamicWidth(0.6),
            decoration: BoxDecoration(border: BorderConstants.borderAllSmall),
            child: ListView(
              children: [
                _TableWidget(categories: categories),
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
                      ///Middle title
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Shift Details',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),

                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 2, child: Text('Shift Name')),
                                        Expanded(flex: 3, child: TextField()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: isCloseBatchEnabled,
                                    activeColor: Colors.black,
                                    onChanged: (value) {
                                      setState(() {
                                        isCloseBatchEnabled = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Close Batch'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: isEnableBatchEnabled,
                        activeColor: Colors.black,
                        onChanged: (value) {
                          setState(() {
                            isEnableBatchEnabled = value!;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text('Enable Batch'),
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
}

class CategoryModel {
  final String? shiftName;

  CategoryModel({this.shiftName});
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
            _TableCellTitleText(title: 'Shift Name'),
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
                child: _TableCellContentText(content: category.shiftName ?? ''),
              ),
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
