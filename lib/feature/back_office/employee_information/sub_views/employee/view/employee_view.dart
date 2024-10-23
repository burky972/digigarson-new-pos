import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/cubit/product_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/model/product_model.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/table_cell/table_cell_widget.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_border_all_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../widget/custom_dropdown_widget.dart';
part '../widget/title_with_textfield_widget.dart';
part '../widget/bottom_button_fields.dart';
part '../widget/custom_check_box.dart';

class EmployeeView extends StatelessWidget {
  const EmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      _TopTableWidget(),
      Text('Information Details', style: CustomFontStyle.titlesTextStyle),
      _BottomInputFieldWidgets(),
      _BottomButtonFields(),
    ]);
  }
}

class _TopTableWidget extends StatelessWidget {
  const _TopTableWidget();

  @override
  Widget build(BuildContext context) {
    final ScrollController verticalScrollController = ScrollController();
    final ScrollController horizontalScrollController = ScrollController();
    const List<Widget> tableCellTitleList = [
      TableCellTitleWidget(title: 'Name'),
      TableCellTitleWidget(title: 'Employee NO:'),
      TableCellTitleWidget(title: 'Home Phone'),
      TableCellTitleWidget(title: 'Mobile Phone'),
      TableCellTitleWidget(title: 'City'),
      TableCellTitleWidget(title: 'State'),
      TableCellTitleWidget(title: 'ZipCode'),
      TableCellTitleWidget(title: 'Email'),
      TableCellTitleWidget(title: 'Wage'),
      TableCellTitleWidget(title: 'Address'),
    ];

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        List<ProductModel>? productsToDisplay = [];
        if (context.read<CategoryCubit>().selectedSubCategory?.id != null) {
          productsToDisplay =
              state.categorizedProducts?[context.read<CategoryCubit>().selectedSubCategory?.id] ??
                  [];
        }

        return Container(
          padding: const EdgeInsets.only(left: 8.0),
          width: context.dynamicWidth(0.9),
          height: context.dynamicHeight(0.45),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Scrollbar(
            controller: verticalScrollController,
            thumbVisibility: true,
            child: Scrollbar(
              controller: horizontalScrollController,
              thumbVisibility: true,
              notificationPredicate: (notification) => notification.depth == 1,
              child: SingleChildScrollView(
                controller: verticalScrollController,
                child: SingleChildScrollView(
                  controller: horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: context.dynamicWidth(0.9),
                    height: context.dynamicHeight(0.45),
                    child: Table(
                      border: TableBorder.all(),
                      defaultColumnWidth: const IntrinsicColumnWidth(),
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(color: Colors.grey),
                          children: tableCellTitleList,
                        ),
                        ...productsToDisplay.map((product) {
                          return TableRow(
                            decoration: BoxDecoration(
                              color: product.id == state.selectedProduct?.id
                                  ? context.colorScheme.tertiary
                                  : null,
                            ),
                            children: [
                              MiddleTableCellTextWidget(
                                onTap: () => context.read<ProductCubit>().setSelectedProduct(
                                    product, product.prices?.first ?? const PriceModel()),
                                text: product.title ?? '',
                              ),
                              MiddleTableCellTextWidget(
                                onTap: () => context.read<ProductCubit>().setSelectedProduct(
                                    product, product.prices?.first ?? const PriceModel()),
                                text: product.prices!.isNotEmpty
                                    ? product.prices!.first.price.toString()
                                    : '',
                              ),
                              MiddleTableCellTextWidget(
                                onTap: () => context.read<ProductCubit>().setSelectedProduct(
                                    product, product.prices?.first ?? const PriceModel()),
                                text: product.prices!.isNotEmpty
                                    ? product.prices!.first.amount.toString()
                                    : '',
                              ),
                              MiddleTableCellTextWidget(
                                onTap: () => context.read<ProductCubit>().setSelectedProduct(
                                    product, product.prices?.first ?? const PriceModel()),
                                text: product.prices!.isNotEmpty
                                    ? product.prices!.first.amount.toString()
                                    : '',
                              ),
                              MiddleTableCellTextWidget(
                                onTap: () => context.read<ProductCubit>().setSelectedProduct(
                                    product, product.prices?.first ?? const PriceModel()),
                                text: product.prices!.isNotEmpty
                                    ? product.prices!.first.amount.toString()
                                    : '',
                              ),
                              MiddleTableCellTextWidget(
                                onTap: () => context.read<ProductCubit>().setSelectedProduct(
                                    product, product.prices?.first ?? const PriceModel()),
                                text: product.prices!.isNotEmpty
                                    ? product.prices!.first.amount.toString()
                                    : '',
                              ),
                              MiddleTableCellTextWidget(
                                onTap: () => context.read<ProductCubit>().setSelectedProduct(
                                    product, product.prices?.first ?? const PriceModel()),
                                text: product.prices!.isNotEmpty
                                    ? product.prices!.first.vatRate.toString()
                                    : '',
                              ),
                              MiddleTableCellTextWidget(
                                onTap: () => context.read<ProductCubit>().setSelectedProduct(
                                    product, product.prices?.first ?? const PriceModel()),
                                text: '0',
                              ),
                              MiddleTableCellTextWidget(
                                onTap: () => context.read<ProductCubit>().setSelectedProduct(
                                    product, product.prices?.first ?? const PriceModel()),
                                text: '0',
                              ),
                              MiddleTableCellTextWidget(
                                onTap: () => context.read<ProductCubit>().setSelectedProduct(
                                    product, product.prices?.first ?? const PriceModel()),
                                text: '0',
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BottomInputFieldWidgets extends StatelessWidget {
  const _BottomInputFieldWidgets();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidth(0.9),
      height: context.dynamicHeight(0.35),
      child: Wrap(children: [
        _TitleWithTextfieldWidget(
          title: 'Employee Name',
          controller: TextEditingController(text: 'sedat'),
          maxCharacter: 50,
          onChanged: null,
        ),
        CustomDropdownWidget(
          title: 'Position',
          values: const ['Administrator', 'Owner', 'Manager', 'Wait Staff'],
          initialValue: 'Administrator',
          onChanged: (String? newValue) {
            appLogger.info('selected value:', '$newValue');
          },
        ),
        _TitleWithTextfieldWidget(
          title: 'Home Phone',
          controller: TextEditingController(text: 'sedat'),
          maxCharacter: 50,
          onChanged: null,
        ),
        _TitleWithTextfieldWidget(
          title: 'Employee NO.',
          controller: TextEditingController(text: 'sedat'),
          maxCharacter: 50,
          onChanged: null,
        ),
        _TitleWithTextfieldWidget(
          title: 'City',
          controller: TextEditingController(text: 'sedat'),
          maxCharacter: 50,
          onChanged: null,
        ),
        _TitleWithTextfieldWidget(
          title: 'Mobile Phone',
          controller: TextEditingController(text: 'sedat'),
          maxCharacter: 50,
          onChanged: null,
        ),
        _TitleWithTextfieldWidget(
          title: 'Access Code',
          controller: TextEditingController(text: 'sedat'),
          maxCharacter: 50,
          isObscure: true,
          onChanged: null,
        ),
        _TitleWithTextfieldWidget(
          title: 'State',
          controller: TextEditingController(text: 'sedat'),
          maxCharacter: 50,
          onChanged: null,
        ),
        _TitleWithTextfieldWidget(
          title: 'Email',
          controller: TextEditingController(text: 'sedat'),
          maxCharacter: 50,
          onChanged: null,
        ),
        CustomDropdownWidget(
          title: 'Favorite Screen',
          values: const ['DineIn', ' Q.Service', ' Delivery', 'Take Out', 'Pick Up', 'Bar'],
          initialValue: 'DineIn',
          onChanged: (String? newValue) {
            appLogger.info('selected value:', '$newValue');
          },
        ),
        _TitleWithTextfieldWidget(
          title: 'ZipCode',
          controller: TextEditingController(text: 'sedat'),
          maxCharacter: 50,
          onChanged: null,
        ),
        _TitleWithTextfieldWidget(
          title: 'Wage(per hour)',
          controller: TextEditingController(text: 'sedat'),
          maxCharacter: 50,
          onChanged: null,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  'Address',
                  style: CustomFontStyle.titleBoldTertiaryStyle,
                ),
              ),
              Expanded(
                flex: 25,
                child: CustomBorderAllTextfield(
                  isObscure: false,
                  isReadOnly: false,
                  controller: TextEditingController(),
                  onChanged: (value) {},
                ),
              ),
              const Expanded(flex: 1, child: SizedBox.shrink()),
              Expanded(
                  flex: 19,
                  child: CustomCheckBox(
                    initialValue: false,
                    label: 'Is Active',
                    onChanged: (bool newValue) {
                      appLogger.info('selected value:', '$newValue');
                    },
                  )),
            ],
          ),
        ),
      ]),
    );
  }
}
