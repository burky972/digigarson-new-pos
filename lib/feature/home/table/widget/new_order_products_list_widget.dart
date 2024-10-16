import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/cubit/product_cubit.dart';
import 'package:a_pos_flutter/feature/home/checks/model/re_open_model.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/utils/helper/format_double.dart';
import 'package:a_pos_flutter/product/widget/dialog/option_check_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewOrderProductListWidget extends StatelessWidget {
  NewOrderProductListWidget({super.key});

  final List<ReOpenModel> headTitle = [
    const ReOpenModel(text: 'Item', width: 0.16),
    const ReOpenModel(text: 'Price', width: 0.06),
    const ReOpenModel(text: 'Qty', width: 0.05)
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableCubit, TableState>(
      builder: (context, state) {
        return Column(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .32 +
                (MediaQuery.of(context).size.width * .06 - 100),
            child: Text(
              'New Order',
              style: CustomFontStyle.titlesTextStyle
                  .copyWith(color: context.colorScheme.tertiary, fontSize: 18),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .32 +
                (MediaQuery.of(context).size.width * .06 - 80),
            height: 2.0,
            color: Colors.black,
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
              height: context.dynamicHeight(0.5),
              child: BlocBuilder<TableCubit, TableState>(
                builder: (context, state) {
                  return ListView.builder(
                      itemCount: state.newProducts.products.length,
                      itemBuilder: (context, index) {
                        final product = state.newProducts.products[index];
                        return ColoredBox(
                          color: state.newOrderProduct?.product == product.product
                              ? context.colorScheme.tertiary
                              : Colors.white,
                          child: InkWell(
                            onDoubleTap: () async {
                              /// if product is specialItem do not show dialog
                              if (product.isSpecial == true) return;

                              List<Item> selectedItems = [];
                              context.read<ProductCubit>().getExistProductOptions(product.product!);
                              context.read<ProductCubit>().resetSelectedItems();
                              if (product.selectedOptions?.isNotEmpty == true) {
                                for (var option in product.selectedOptions!) {
                                  for (var item in option.selectedItems) {
                                    selectedItems.add(item);
                                  }
                                }
                                context.read<ProductCubit>().setSelectedItems(selectedItems);
                              }
                              showDialog(
                                context: context,
                                builder: (context) => OptionCheckDialog(
                                  product: product,
                                  isForce: product.options.isNotEmpty,
                                  isExistProduct: true,
                                  onUpdate: (updatedOptions, selectedItems) {
                                    context.read<TableCubit>().updateNewOrderProducts(
                                          product,
                                          product.uniqueTimestamp!,
                                          updatedOptions,
                                          selectedItems,
                                        );
                                  },
                                ),
                              );
                            },
                            child: Column(children: [
                              _NewProductList(headTitle: headTitle, product: product),
                              product.selectedOptions?.isNotEmpty == true
                                  ? _ItemListWidget(product: product, headTitle: headTitle)
                                  : const SizedBox.shrink(),
                            ]),
                          ),
                        );
                      });
                },
              )),
        ]);
      },
    );
  }
}

class _NewProductList extends StatelessWidget {
  const _NewProductList({
    required this.headTitle,
    required this.product,
  });

  final List<ReOpenModel> headTitle;
  final OrderProductModel product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          constraints: const BoxConstraints(
            minHeight: 35,
          ),
          padding: const EdgeInsets.only(left: 3, right: 3),
          width: MediaQuery.of(context).size.width * headTitle[0].width,
          child: Row(
            children: [
              /// delete product
              InkWell(
                onTap: () {
                  if (product.options.isNotEmpty) {}
                  context.read<TableCubit>().removeNewOrderProduct(product);
                  context.read<ProductCubit>().resetSelectedItems();
                },
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 35,
                    maxWidth: 30,
                  ),
                  padding: const EdgeInsets.only(
                    left: 1,
                    right: 1,
                  ),
                  child: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                ),
              ),
              Container(
                constraints: const BoxConstraints(minHeight: 35),
                padding: const EdgeInsets.only(left: 2, right: 2),
                width: MediaQuery.of(context).size.width * headTitle[0].width - 33,
                child: Align(
                  alignment: const Alignment(-1.0, 0.0),
                  child: Text(product.productName?.trim() ?? '',
                      style: const TextStyle(fontSize: 17), textAlign: TextAlign.start),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 3, right: 3),
          width: MediaQuery.of(context).size.width * headTitle[1].width,
          constraints: const BoxConstraints(
            minHeight: 35,
          ),
          child: Align(
            alignment: const Alignment(1.0, 0.0),
            child: Text(
              DoubleConvert().formatPriceDouble(product.quantity ?? 1),
              style: const TextStyle(fontSize: 17),
              textAlign: TextAlign.end,
            ),
          ),
        ),

        ///* WHEN click on product price!!
        InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(left: 3, right: 3),
              width: MediaQuery.of(context).size.width * headTitle[2].width,
              constraints: const BoxConstraints(
                minHeight: 35,
              ),
              child: Align(
                alignment: const Alignment(1.0, 0.0),
                child: Text(
                  DoubleConvert().formatDouble(product.price ?? 0),
                  style: const TextStyle(fontSize: 17),
                  textAlign: TextAlign.end,
                ),
              ),
            )),
      ],
    );
  }
}

/// Showing Option's item list under each product
class _ItemListWidget extends StatelessWidget {
  const _ItemListWidget({
    required this.product,
    required this.headTitle,
  });

  final OrderProductModel product;
  final List<ReOpenModel> headTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: product.selectedOptions?.isNotEmpty == true
          ? product.selectedOptions!.map((option) {
              return Column(
                children: option.selectedItems.isNotEmpty == true
                    ? option.selectedItems.map((item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                minHeight: 35,
                              ),
                              padding: const EdgeInsets.only(left: 3, right: 3),
                              width: MediaQuery.of(context).size.width * headTitle[0].width,
                              child: Row(
                                children: [
                                  /// delete product's items
                                  InkWell(
                                    onTap: () {
                                      /// check if at least 1 option is required for product
                                      if (product.isOptionForced == true) {
                                        context
                                            .read<TableCubit>()
                                            .removeItemFromProduct(product, item, true);
                                      } else {
                                        context
                                            .read<TableCubit>()
                                            .removeItemFromProduct(product, item, false);
                                      }
                                    },
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        minHeight: 35,
                                        maxWidth: 30,
                                      ),
                                      padding: const EdgeInsets.only(
                                        left: 1,
                                        right: 1,
                                      ),
                                      child: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    constraints: const BoxConstraints(minHeight: 35),
                                    padding: const EdgeInsets.only(left: 2, right: 2),
                                    width:
                                        MediaQuery.of(context).size.width * headTitle[0].width - 33,
                                    child: Align(
                                      alignment: const Alignment(-1.0, 0.0),
                                      child: Text('++${item.itemName}',
                                          style: const TextStyle(fontSize: 17),
                                          textAlign: TextAlign.start),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 3, right: 3),
                              width: MediaQuery.of(context).size.width * headTitle[1].width,
                              constraints: const BoxConstraints(
                                minHeight: 35,
                              ),
                              child: const Align(
                                alignment: Alignment(1.0, 0.0),
                                child: Text(
                                  '-',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 3, right: 3),
                              width: MediaQuery.of(context).size.width * headTitle[2].width,
                              constraints: const BoxConstraints(
                                minHeight: 35,
                              ),
                              child: Align(
                                alignment: const Alignment(1.0, 0.0),
                                child: Text(
                                  DoubleConvert().formatDouble(item.price ?? 0.0),
                                  style: const TextStyle(fontSize: 17),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList()
                    : [],
              );
            }).toList()
          : [],
    );
  }
}
