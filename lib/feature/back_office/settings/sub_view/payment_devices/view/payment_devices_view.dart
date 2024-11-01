import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentDeviceView extends StatelessWidget {
  const PaymentDeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> categories = [
      CategoryModel(
        deviceName: "HOT",
        paymentSystem: "",
      ),
    ];

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const Flexible(
                flex: 1,
                child: _BottomButtonFields(),
              ),
            ]));
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

class CategoryModel {
  final String? deviceName;
  final String? paymentSystem;

  CategoryModel({this.deviceName, this.paymentSystem});
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
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Colors.grey),
          children: [
            _TableCellTitleText(title: 'Device Name'),
            _TableCellTitleText(title: 'Payment System'),
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
                child:
                    _TableCellContentText(content: category.deviceName ?? ''),
              ),
              TableRowInkWell(
                onTap: () => _onCategoryTap(category),
                child: _TableCellContentText(
                    content: category.paymentSystem ?? ''),
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
