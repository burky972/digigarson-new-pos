import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/model/category_model.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCategoryView extends StatefulWidget {
  const MainCategoryView({super.key});

  @override
  State<MainCategoryView> createState() => _MainCategoryViewState();
}

String? selectedValue;
String? selectedValue2;
String? selectedValue3;
List<String> list = <String>['hot', 'cold', 'freeze'];

class _MainCategoryViewState extends State<MainCategoryView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    context.read<CategoryCubit>().getCategories();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Table Widget
        Container(
          height: context.dynamicHeight(0.5),
          width: context.dynamicWidth(0.8),
          decoration: BoxDecoration(border: BorderConstants.borderAllSmall),
          child: ListView(
            children: const [
              // _TableWidget(widget: widget),
              _TableWidget(),
            ],
          ),
        ),
        SizedBox(
            height: context.dynamicHeight(0.35),
            child: BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                final imageString = state.selectedCategory?.image;
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Middle title
                          Expanded(
                            flex: 1,
                            child: Text(
                              'MenuItemGroup Details',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),

                          ///Middle all items(textfield-checkbox-selectImage)
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
                                            const Expanded(flex: 2, child: Text('Group Name')),
                                            Expanded(
                                                flex: 3,
                                                child: TextField(
                                                  controller:
                                                      context.read<CategoryCubit>().titleController,
                                                  onChanged: (value) {
                                                    context
                                                        .read<CategoryCubit>()
                                                        .updateSelectedCategoryTitle(value);
                                                  },
                                                )),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Flexible(
                                        child: Row(
                                          children: [
                                            Expanded(flex: 2, child: Text('Group Description')),
                                            Expanded(flex: 3, child: TextField()),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),

                                      ///Printer1 dropdownButton
                                      Flexible(
                                        child: Row(
                                          children: [
                                            const Expanded(flex: 2, child: Text('Printer1')),
                                            Expanded(
                                              flex: 3,
                                              child: DropdownButton<String>(
                                                hint: const Text(''),
                                                value: selectedValue,
                                                isExpanded: true,
                                                items: list
                                                    .map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedValue = newValue;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),

                                      ///Printer2 dropdownButton
                                      Flexible(
                                        child: Row(
                                          children: [
                                            const Expanded(flex: 2, child: Text('Printer2')),
                                            Expanded(
                                              flex: 3,
                                              child: DropdownButton<String>(
                                                hint: const Text(''),
                                                value: selectedValue2,
                                                isExpanded: true,
                                                items: list
                                                    .map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedValue2 = newValue;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),

                                      ///Printer3 dropdownButton
                                      Flexible(
                                        child: Row(
                                          children: [
                                            const Expanded(flex: 2, child: Text('Printer3')),
                                            Expanded(
                                              flex: 3,
                                              child: DropdownButton<String>(
                                                hint: const Text(''),
                                                value: selectedValue3,
                                                isExpanded: true,
                                                items: list
                                                    .map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedValue3 = newValue;
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

                                ///In DineIn-TakeOut-Delivery-QuickService-Bar checkBox
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                // value: widget.data[widget.selectedRowIndex!]['dinIn'],
                                                value: false,
                                                onChanged: (value) {
                                                  // if (value != null) {
                                                  //   setState(() {
                                                  //     widget.onCheckboxChanged('dinIn', value);
                                                  //   });
                                                  // }
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                              const Text('Dine In'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                // value: widget.data[widget.selectedRowIndex!]['takeOut'],
                                                value: false,

                                                onChanged: (value) {
                                                  // if (value != null) {
                                                  //   setState(() {
                                                  //     widget.onCheckboxChanged('takeOut', value);
                                                  //   });
                                                  // }
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                              const Text('Take Out'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                // value: widget.data[widget.selectedRowIndex!]
                                                // ['delivery'],
                                                value: false,

                                                onChanged: (value) {
                                                  // if (value != null) {
                                                  //   setState(() {
                                                  //     widget.onCheckboxChanged('delivery', value);
                                                  //   });
                                                  // }
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                              const Text('Delivery'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                // value: widget.data[widget.selectedRowIndex!]
                                                //     ['quickService'],
                                                value: false,
                                                onChanged: (value) {
                                                  // if (value != null) {
                                                  //   setState(() {
                                                  //     widget.onCheckboxChanged('quickService', value);
                                                  //   });
                                                  // }
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                              const Text('Quick Service'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                // value: widget.data[widget.selectedRowIndex!]['bar'],
                                                value: false,
                                                onChanged: (value) {
                                                  // if (value != null) {
                                                  //   setState(() {
                                                  //     widget.onCheckboxChanged('bar', value);
                                                  //   });
                                                  // }
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                              const Text('Bar'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),

                                ///Select image or color
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 100.0,
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.blue),
                                        ),
                                        child: imageString == null || imageString.isEmpty
                                            ? null
                                            : imageString.length < 500
                                                ? Image.network(imageString)
                                                : Image.memory(base64Decode(imageString)),
                                      ),
                                      const SizedBox(height: 15),
                                      Flexible(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            LightBlueButton(
                                              buttonText: 'Browse',
                                              onTap: () =>
                                                  context.read<CategoryCubit>().getCategoryImage(),
                                            ),
                                            const SizedBox(width: 4),
                                            LightBlueButton(
                                              buttonText: 'Clean',
                                              onTap: () => context
                                                  .read<CategoryCubit>()
                                                  .cleanCategoryImage(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                ///In Kitchen Screen checkBox
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: false,
                                        onChanged: (value) {},
                                      ),
                                      const SizedBox(width: 8),
                                      const Text('In Kitchen Screen'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          ///Bottom buttons
                          const Expanded(
                            flex: 2,
                            child: _BottomButtonFields(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ))
      ],
    );
  }
}

class _BottomButtonFields extends StatelessWidget {
  const _BottomButtonFields();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: TextField()),
        const LightBlueButton(buttonText: 'Upload'),
        const LightBlueButton(buttonText: 'inventory'),
        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
        const LightBlueButton(buttonText: 'Move Up'),
        const LightBlueButton(buttonText: 'Move Down'),
        LightBlueButton(
          buttonText: 'Add',
          onTap: () => context.read<CategoryCubit>().addNewCategory(),
        ),
        LightBlueButton(
          buttonText: 'Delete',
          onTap: context.read<CategoryCubit>().state.selectedCategory == null
              ? null
              : () async {
                  appLogger.info('DELETE CATEGORY',
                      'ID: ${context.read<CategoryCubit>().selectedCategory?.id}');
                  appLogger.info('DELETE CATEGORY',
                      'TITLE: ${context.read<CategoryCubit>().state.selectedCategory?.title ?? "X"}');

                  await patchCategory(context);
                },
        ),
        LightBlueButton(
            buttonText: 'Save',
            onTap: () async => await context.read<CategoryCubit>().saveChanges()),
        const LightBlueButton(buttonText: 'Export'),
        LightBlueButton(
          buttonText: 'Exit',
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }

  /// PATCH delete CATEGORY
  Future<void> patchCategory(BuildContext context) async {
    CategoryCubit categoryCubit = context.read<CategoryCubit>();

    final bool isSuccess =
        await categoryCubit.patchCategories(categoryId: categoryCubit.selectedCategory!.id!);

    if (!isSuccess) {
      await showOrderErrorDialog(context, '${categoryCubit.state.exception?.message}!');
      await categoryCubit.getCategories();
    } else {
      await categoryCubit
          .patchCategories(categoryId: categoryCubit.state.selectedCategory!.id!)
          .whenComplete(() => categoryCubit.getCategories());
    }
  }
}

class _TableWidget extends StatelessWidget {
  const _TableWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        switch (state.states) {
          case CategoryStates.loading:
            return const Center(child: CircularProgressIndicator());
          case CategoryStates.error:
            return const Center(child: Text('An error occurred please try again!'));
          case CategoryStates.completed:
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
                    _TableCellTitleText(title: 'Quick Service'),
                  ],
                ),
                ...state.mainCategories.asMap().entries.map((entry) {
                  // int index = entry.key;

                  CategoryModel category = entry.value;
                  return TableRow(
                    decoration: BoxDecoration(
                      color:
                          category == state.selectedCategory ? context.colorScheme.tertiary : null,
                    ),
                    children: [
                      BlocListener<CategoryCubit, CategoryState>(
                        listener: (context, state) {},
                        listenWhen: (previous, current) =>
                            previous.selectedCategory?.title != current.selectedCategory?.title,
                        child: _TableCellContentText(
                            onTap: () =>
                                context.read<CategoryCubit>().setSelectedCategory(category),
                            content: category.title ?? ''),
                      ),
                      _TableCellContentText(
                          // onTap: () => widget.onRowTap(index),
                          onTap: () => {},
                          content: category.parentCategory ?? ''),
                      _TableUnOnPressedCheckBox(
                        value: false,
                        onTap: () {},
                      ),
                      _TableUnOnPressedCheckBox(
                        value: false,
                        onTap: () {},
                      ),
                    ],
                  );
                }),
              ],
            );

          default:
        }
        return const SizedBox();
      },
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
