import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/feature/home/checks/model/re_open_model.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/feature/home/table/widget/new_order_products_list_widget.dart';
import 'package:a_pos_flutter/feature/home/table/widget/table_button_widget.dart';
import 'package:a_pos_flutter/product/enums/button_action/button_action_enum.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:a_pos_flutter/product/global/service/response_action_service.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/utils/helper/format_double.dart';
import 'package:a_pos_flutter/product/widget/dialog/move_table_product_dialog.dart';
import 'package:a_pos_flutter/product/widget/dialog/quick_cash_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableLeftWidget extends StatefulWidget {
  const TableLeftWidget({super.key, required this.tableModel});
  final TableModel tableModel;

  @override
  State<TableLeftWidget> createState() => _TableLeftWidgetState();
}

class _TableLeftWidgetState extends State<TableLeftWidget> {
  final ScrollController _scrollController = ScrollController();
  String printer = "Print";
  final List<ReOpenModel> headTitle = [
    const ReOpenModel(text: 'Item Name', width: 0.16),
    const ReOpenModel(text: 'Qty', width: 0.06),
    const ReOpenModel(text: 'Price', width: 0.05)
  ];
  @override
  void initState() {
    setInitialSelectedEditProduct(context.read<TableCubit>().state, 0, 0, context);
    super.initState();
  }

  isOpenTable(TableModel? tableModel) {
    if (tableModel != null) {
      if (tableModel.discount.isNotEmpty ||
          tableModel.cover.isNotEmpty ||
          tableModel.serviceFee.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<ButtonAction, String>> leftWrapButtonList =
        ButtonAction.buttonLabels.entries.toList().sublist(11);
    bool isSales = false;

    return BlocBuilder<TableCubit, TableState>(
      builder: (context, state) {
        return Container(
          height: context.height,
          margin: const EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const AppPadding.extraLowVertical(),
                  width: context.dynamicWidth(.32) + (context.dynamicWidth(.06) - 55),
                  height: context.height - 60,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                      height: context.height - 350,
                      width: context.dynamicWidth(.31) + (context.dynamicWidth(.06) - 60),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                headTitle.length,
                                (index) => Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: context.width * headTitle[index].width,
                                      child: Text(headTitle[index].text,
                                          style: const TextStyle(
                                              fontSize: 16, fontWeight: FontWeight.bold)),
                                    ),
                                    index < headTitle.length - 1
                                        ? const SizedBox(
                                            width: 1,
                                            child: Text("|", style: TextStyle(fontSize: 20)),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ListView(
                                controller: _scrollController,
                                scrollDirection: Axis.vertical,
                                children: List.generate(
                                  state.selectedTable != null &&
                                          state.selectedTable!.orders.isNotEmpty
                                      ? state.selectedTable!.orders.length
                                      : state.newProducts.products.isNotEmpty
                                          ? 1
                                          : 0,
                                  (rowIndex) {
                                    return (state.selectedTable!.orders.isEmpty)
                                        ? NewOrderProductListWidget()
                                        : Column(
                                            children: [
                                              SizedBox(
                                                width: context.dynamicWidth(.32) +
                                                    (context.dynamicWidth(.06) - 100),
                                                child: Text(
                                                  'Order No: ${state.selectedTable!.orders[rowIndex].orderNum}',
                                                  style: const TextStyle(
                                                      fontSize: 17, fontWeight: FontWeight.w600),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              const Divider(thickness: 3),
                                              for (var i = 0;
                                                  i <
                                                      state.selectedTable!.orders[rowIndex].products
                                                          .length;
                                                  i++)
                                                Container(
                                                  color: context.colorScheme.onSecondary,
                                                  padding: const AppPadding.extraMinAll(),
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (state.selectedTable?.orders.isEmpty ??
                                                          true) return;
                                                      if (state.selectedTable?.orders[rowIndex]
                                                              .products[i]?.quantity ==
                                                          state.selectedTable?.orders[rowIndex]
                                                              .products[i]?.paidQuantity) return;
                                                      setSelectedEditProduct(
                                                          state.selectedTable?.orders[rowIndex]
                                                                  .products[i] ??
                                                              Product.empty(),
                                                          context);
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          padding: const EdgeInsets.only(top: 2),
                                                          decoration: BoxDecoration(
                                                              color: state
                                                                          .selectedTable!
                                                                          .orders[rowIndex]
                                                                          .products[i]!
                                                                          .id ==
                                                                      state.newOrderProduct?.product
                                                                  ? context.colorScheme.tertiary
                                                                  : Colors.transparent,
                                                              borderRadius: const BorderRadius.only(
                                                                topLeft: Radius.circular(4),
                                                              )),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Container(
                                                                  constraints: const BoxConstraints(
                                                                    minHeight: 24,
                                                                  ),
                                                                  width: context.width *
                                                                      headTitle[0].width,
                                                                  child: Text(
                                                                      '${state.selectedTable!.orders[rowIndex].products[i]!.productName?.toUpperCase()}',
                                                                      style: state
                                                                                  .selectedTable!
                                                                                  .orders[rowIndex]
                                                                                  .products[i]!
                                                                                  .cancelStatus
                                                                                  ?.isCancelled ??
                                                                              false
                                                                          ? CustomFontStyle
                                                                              .titleErrorTextStyle
                                                                          : CustomFontStyle
                                                                              .titlesTextStyle)),
                                                              Container(
                                                                padding: const EdgeInsets.only(
                                                                    left: 3, right: 3),
                                                                width: context.width *
                                                                    headTitle[2].width,
                                                                child: Text(
                                                                  DoubleConvert().formatDouble(state
                                                                          .selectedTable!
                                                                          .orders[rowIndex]
                                                                          .products[i]!
                                                                          .quantity ??
                                                                      0.0),
                                                                  style: state
                                                                              .selectedTable!
                                                                              .orders[rowIndex]
                                                                              .products[i]!
                                                                              .cancelStatus
                                                                              ?.isCancelled ??
                                                                          false
                                                                      ? CustomFontStyle
                                                                          .titleErrorTextStyle
                                                                      : CustomFontStyle
                                                                          .titlesTextStyle,
                                                                  textAlign: TextAlign.end,
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {},
                                                                child: BlocBuilder<TableCubit,
                                                                    TableState>(
                                                                  builder: (context, state) {
                                                                    return Container(
                                                                      padding:
                                                                          const EdgeInsets.only(
                                                                        left: 3,
                                                                        right: 3,
                                                                      ),
                                                                      width: context.dynamicWidth(
                                                                          headTitle[1].width),
                                                                      child: Text(
                                                                        DoubleConvert()
                                                                            .formatPriceDouble(state
                                                                                    .selectedTable!
                                                                                    .orders[
                                                                                        rowIndex]
                                                                                    .products[i]!
                                                                                    .price ??
                                                                                0.0),
                                                                        style: state
                                                                                    .selectedTable!
                                                                                    .orders[
                                                                                        rowIndex]
                                                                                    .products[i]!
                                                                                    .cancelStatus
                                                                                    ?.isCancelled ??
                                                                                false
                                                                            ? CustomFontStyle
                                                                                .titleErrorTextStyle
                                                                            : CustomFontStyle
                                                                                .titlesTextStyle,
                                                                        textAlign: TextAlign.end,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        state.selectedTable!.orders[rowIndex]
                                                                .products[i]!.options.isEmpty
                                                            ? const SizedBox()
                                                            : _ProductItemsList(
                                                                i: i,
                                                                headTitle: headTitle,
                                                                state: state,
                                                                rowIndex: rowIndex),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              (state.selectedTable!.orders.length == rowIndex + 1 &&
                                                      state.newProducts.products.isNotEmpty)
                                                  ? NewOrderProductListWidget()
                                                  : const SizedBox.shrink()
                                            ],
                                          );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: isOpenTable(state.selectedTable)
                                ? Container(
                                    color: context.colorScheme.tertiary,
                                    child: Column(
                                      children: [
                                        state.selectedTable!.serviceFee.isNotEmpty
                                            ? _DiscountCoverServiceContainer(
                                                leftText: 'Service',
                                                rightText: DoubleConvert().formatPriceDouble(
                                                    state.selectedTable!.serviceFee.fold(
                                                        0.0,
                                                        (previousValue, service) =>
                                                            service.amount! + previousValue)),
                                              )
                                            : Container(),
                                        state.selectedTable!.cover.isNotEmpty
                                            ? _DiscountCoverServiceContainer(
                                                leftText: 'Cover',
                                                rightText: DoubleConvert().formatPriceDouble(
                                                    state.selectedTable!.cover.fold(
                                                        0.0,
                                                        (previousValue, cover) =>
                                                            cover.price! + previousValue)),
                                              )
                                            : Container(),
                                        state.selectedTable!.discount.isNotEmpty
                                            ? _DiscountCoverServiceContainer(
                                                leftText: 'Discount',
                                                rightText: DoubleConvert().formatPriceDouble(
                                                    state.selectedTable!.discount.fold(
                                                        0.0,
                                                        (previousValue, discount) =>
                                                            discount.amount! + previousValue)),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  )
                                : Container(),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),

                    //! SubTotal - Total - Tax
                    Container(
                      color: context.colorScheme.primary,
                      width: context.dynamicWidth(.32) + (context.dynamicWidth(.06) - 60),
                      height: 75,
                      child: BlocBuilder<TableCubit, TableState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              _SubTotalTaxTotalWidget(
                                  leftText: 'Sub Total',
                                  rightText: DoubleConvert().formatPriceDouble(state.subPrice)),
                              _SubTotalTaxTotalWidget(
                                  leftText: 'Tax',
                                  rightText: DoubleConvert().formatPriceDouble(
                                      context.read<TableCubit>().calculateTotalTax())),
                              _SubTotalTaxTotalWidget(
                                  leftText: 'Total',
                                  rightText: DoubleConvert().formatPriceDouble(state.totalPrice)),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        width: context.dynamicWidth(.32) + (context.dynamicWidth(.06) - 60),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          runSpacing: 4,
                          children: leftWrapButtonList.map((button) {
                            final action = button.key;
                            final label = button.value;
                            return action.name == ButtonAction.sales.name
                                ? isSales
                                    ? //TODO!: IN SOME SITUATION SALES BUTTON WON'T BE SHOWING IN THE TABLE SCREEN
                                    //TODO:CHECK HERE LATER!
                                    TableButtonWidget(label)
                                    : Container(
                                        width: (context.dynamicWidth(.32) +
                                                (context.dynamicWidth(.06) - 60)) /
                                            4,
                                        constraints: const BoxConstraints(
                                          minWidth: 60,
                                          maxWidth: 110,
                                          minHeight: 55,
                                        ),
                                      )
                                : BlocBuilder<TableCubit, TableState>(
                                    builder: (context, state) {
                                      return InkWell(
                                        onTap: () async {
                                          await handleButtonAction(action, context, state);
                                        },
                                        child: TableButtonWidget(label),
                                      );
                                    },
                                  );
                          }).toList(),
                        ),
                      ),
                    )
                  ]),
                ),
                Container(
                  width: 50,
                  constraints: const BoxConstraints(minWidth: 40, maxWidth: 50),
                  child: ListView(
                    children: [
                      for (int i = 1; i <= 9; i++)
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: NumberButton(txt: "$i", color: Colors.indigo),
                        ),
                      const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: NumberButton(txt: "0", color: Colors.indigo)),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: NumberButton(txt: "C", color: Colors.red),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(2.0),
                      //   child: BlocBuilder<TableCubit,TableState>(
                      //     builder: ((context, state) =>
                      //         TableLeftNumberContainerWidget(
                      //             text: DoubleConvert()
                      //                 .formatDouble(tableListProvider.NewOrderProductAmount))),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> handleButtonAction(
      ButtonAction action, BuildContext context, TableState state) async {
    TableCubit tableCubit = context.read<TableCubit>();

    switch (action.index) {
      case 8:
        // Close Table
        break;
      case 9:
        // Checkout
        break;
      case 10:
        // Sales
        break;
      case 11:
        // New Sale
        if (state.newProducts.products.isEmpty) return;

        final response = await context.read<TableCubit>().postTableNewOrder(context);
        ResponseActionService.getTableAndNavigate(
          context: context,
          response: response,
          tableCubit: tableCubit,
          action: ButtonAction.newSale,
        );

        break;
      case 12:
        // Split
        break;
      case 13:
        // Special Item
        break;
      case 14:
        // Duplicate
        break;
      case 15:
        // Combine
        break;
      case 16:
        // Print Receipt
        break;
      case 17:
        // Settle
        break;
      case 18:
        // Re-Send
        break;
      case 19:
        // Service
        break;
      case 20:
        // Discount
        break;
      case 21:
        // Catering

        break;
      case 22:
        // Move Table
        if (state.newOrderProduct == null) return;
        tableCubit.setSelectedMoveTable(state.selectedTable!);
        if (state.selectedTable?.orders == null || state.selectedTable?.orders.isEmpty == true) {
          return;
        }
        showDialog(
          context: context,
          builder: (context) => const MoveTableProductDialog(isTransfer: true),
        );
        break;

      /// quickCash
      case 23:
        if (state.selectedTable == null || state.newOrderProduct == null) return;
        QuickCashDialog().show(context);

        break;
      default:
        break;
    }
  }

  /// set selected product in table's order
  void setSelectedEditProduct(Product product, BuildContext context) {
    if (product.cancelStatus?.isCancelled == false) {
      context.read<TableCubit>().setSelectedEditProduct(
            OrderProductModel(
              id: product.id ?? '',
              isFirst: product.isFirst ?? false,
              product: product.id ?? '',
              productName: product.productName ?? '',
              quantity: product.quantity ?? 1,
              categoryId: product.id ?? "", // TODO: Kontrol edilmeli
              tax: product.tax ?? 0,
              price: product.price ?? 1,
              priceId: product.priceId ?? '',
              cancelStatus: CancelStatus.empty(),
              priceName: '', // TODO: Kontrol edilmeli
              priceType: 'REGULAR',
              note: product.note ?? '',
              options: buildOptions(product),
            ),
          );
    }
  }

  /// set selected product in table's order
  void setInitialSelectedEditProduct(TableState state, int rowIndex, int i, BuildContext context) {
    if (state.selectedTable?.orders.isEmpty ?? true) return;

    for (var order in state.selectedTable!.orders) {
      for (var pro in order.products) {
        if (pro?.cancelStatus?.isCancelled == false) {
          Product product = pro ?? Product.empty();

          /// set selected product if product is not cancelled and if not paid
          if (product.quantity != product.paidQuantity) {
            context.read<TableCubit>().setSelectedEditProduct(
                  OrderProductModel(
                    id: product.id ?? '',
                    isFirst: product.isFirst ?? false,
                    product: product.id ?? '',
                    productName: product.productName ?? '',
                    quantity: product.quantity ?? 1,
                    categoryId: product.id ?? "", // TODO: Kontrol edilmeli
                    tax: product.tax ?? 0,
                    price: product.price ?? 1,
                    priceId: product.priceId ?? '',
                    cancelStatus: CancelStatus.empty(),
                    priceName: '', // TODO: Kontrol edilmeli
                    priceType: 'REGULAR',
                    note: product.note ?? '',
                    options: buildOptions(product),
                  ),
                );
            return;
          }
        }
      }
    }
  }

  List<Options> buildOptions(Product product) {
    if (product.options.isEmpty) {
      return [Options.empty()];
    }

    var firstOption = product.options.first;
    return [
      Options(
        name: firstOption.name ?? '',
        optionId: firstOption.optionId ?? '',
        items: buildItems(firstOption),
      ),
    ];
  }

  List<Item> buildItems(Options option) {
    if (option.items.isEmpty) {
      return [Item.empty()];
    }

    var firstItem = option.items.first;
    return [
      Item(
        itemId: firstItem.id ?? '',
        itemName: firstItem.itemName ?? '',
        id: firstItem.id ?? '',
        vatRate: firstItem.vatRate ?? 0,
        priceType: "REGULAR",
        price: firstItem.price ?? 1,
      ),
    ];
  }
}

class _ProductItemsList extends StatelessWidget {
  const _ProductItemsList({
    required this.i,
    required this.rowIndex,
    required this.headTitle,
    required this.state,
  });

  final int i;
  final int rowIndex;
  final List<ReOpenModel> headTitle;
  final TableState state;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            color: state.selectedTable!.orders[rowIndex].products[i]!.id ==
                    state.newOrderProduct?.product
                ? context.colorScheme.tertiary
                : Colors.transparent,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(4), bottomLeft: Radius.circular(4))),
        child: state.selectedTable?.orders[rowIndex].products[i]?.options.isNotEmpty == false
            ? const SizedBox()
            : Column(
                children: state.selectedTable!.orders[rowIndex].products[i]!.options.map((option) {
                return option.items.isEmpty == true
                    ? const SizedBox.shrink()
                    : Column(
                        children: option.items.map((item) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 24,
                                    ),
                                    width: context.width * headTitle[0].width,
                                    child: Text('++${item.itemName}',
                                        style: CustomFontStyle.titlesTextStyle)),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.only(left: 3, right: 3),
                                  width: context.width * headTitle[2].width,
                                  child: Text(
                                    DoubleConvert().formatDouble(item.amount?.toDouble() ?? 1.0),
                                    style: CustomFontStyle.titlesTextStyle,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: BlocBuilder<TableCubit, TableState>(
                                  builder: (context, state) {
                                    return Container(
                                      padding: const EdgeInsets.only(left: 3, right: 3),
                                      width: context.dynamicWidth(headTitle[1].width),
                                      child: Text(
                                        DoubleConvert().formatPriceDouble(item.price ?? 0.0),
                                        style: CustomFontStyle.titlesTextStyle,
                                        textAlign: TextAlign.end,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      );
              }).toList()));
  }
}

class NumberButton extends StatefulWidget {
  final String txt;
  final MaterialColor color;

  const NumberButton({super.key, required this.txt, required this.color});

  @override
  State<NumberButton> createState() => _NumberButtonState();
}

class _NumberButtonState extends State<NumberButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Provider.of<TableListProvider>(context, listen: false)
          //     .setNewOrderAmount(widget.txt, widget.txt.toLowerCase() == "c");
        },
        child: TableLeftNumberContainerWidget(
          text: widget.txt,
          textColor: widget.color,
        ));
  }
}

class TableLeftNumberContainerWidget extends StatelessWidget {
  const TableLeftNumberContainerWidget({required this.text, this.textColor, super.key});
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 10, maxWidth: 42, minHeight: 10, maxHeight: 42),
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          border: BorderConstants.borderAllSmall),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: textColor ?? Colors.lightGreen, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _DiscountCoverServiceContainer extends StatelessWidget {
  const _DiscountCoverServiceContainer({required this.leftText, required this.rightText});
  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const AppPadding.lowHorizontal(),
      height: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$leftText: ",
            style: CustomFontStyle.generalTextStyle,
          ),
          Text(
            rightText,
            style: CustomFontStyle.generalTextStyle,
          ),
        ],
      ),
    );
  }
}

class _SubTotalTaxTotalWidget extends StatelessWidget {
  const _SubTotalTaxTotalWidget({required this.leftText, required this.rightText});
  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const AppPadding.lowHorizontal(),
      height: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$leftText: ",
            style: CustomFontStyle.buttonTextStyle.copyWith(color: context.colorScheme.surface),
          ),
          Text(
            rightText,
            style: CustomFontStyle.buttonTextStyle.copyWith(color: context.colorScheme.surface),
          )
        ],
      ),
    );
  }
}
