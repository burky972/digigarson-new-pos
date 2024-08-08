import 'package:a_pos_flutter/feature/home/reopen/model/re_open_model.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/feature/home/table/widget/table_button_widget.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/constant/app/app_constant.dart';
import 'package:a_pos_flutter/product/enums/button_action/button_action_enum.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/utils/helper/format_double.dart';
import 'package:easy_localization/easy_localization.dart';
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
  late TextEditingController _branch_custom_idController; //TODO: check here later!!
  final FocusNode _branch_custom_idNode = FocusNode();
  String printer = "Print";
  final List<ReOpenModel> headTitle = [
    const ReOpenModel(text: 'Item Name', width: 0.16),
    const ReOpenModel(text: 'Qty', width: 0.06),
    const ReOpenModel(text: 'Price', width: 0.05)
  ];

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
  void initState() {
    super.initState();
    _branch_custom_idController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<ButtonAction, String>> leftWrapButtonList =
        ButtonAction.buttonLabels.entries.toList().sublist(10);
    bool isSales = false;

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
                        child: BlocBuilder<TableCubit, TableState>(builder: ((context, state) {
                          if (state.newProducts.products.isNotEmpty) {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent + 200,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                          return Container(
                            child: ListView(
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              children: List.generate(
                                state.selectedTable != null
                                    ? state.selectedTable!.orders.isNotEmpty
                                        ? state.selectedTable!.orders.length
                                        : state.newProducts.products.isNotEmpty
                                            ? kOne
                                            : kZero
                                    : kZero,
                                (rowIndex) {
                                  return (state.selectedTable!.orders.isEmpty)
                                      ? const SizedBox.shrink()
                                      //  NewOrderProductListWidget()//!TODO: CHECK THIS WIDGET LATER AND CREATE IT IN DIFFERENT FILE
                                      : Container(
                                          child: Column(
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
                                            const SizedBox(height: 5),
                                            for (var i = 0;
                                                i <
                                                    state.selectedTable!.orders[rowIndex].products
                                                        .length;
                                                i++)
                                              Container(
                                                // color: state.SelectProducts.indexOf(state
                                                //             .selectedTable!
                                                //             .orders[rowIndex]
                                                //             .products[i]!) >=
                                                //         0
                                                //     ? Colors.green
                                                //     : state.selectedTable!.orders[rowIndex].user !=
                                                //             null
                                                //         ? state.selectedTable!.orders[rowIndex]
                                                //                     .products[i]!.status ==
                                                //                 1
                                                //             ? Colors.yellow
                                                //             : Colors.white
                                                //         : Colors.white,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        // debugPrint('SELECTED ON pREssed!!!');
                                                        // state.selectedTable!.orders[rowIndex]
                                                        //         .products[i]!.orderNum =
                                                        //     state.selectedTable!.orders[rowIndex]
                                                        //         .orderNum;
                                                        // int indexOf = state.SelectProducts.indexOf(
                                                        //     state.selectedTable!.orders[rowIndex]
                                                        //         .products[i]!);
                                                        // state.setSelectProduct(
                                                        //     state.selectedTable!.orders[rowIndex],
                                                        //     state.selectedTable!.orders[rowIndex]
                                                        //         .products[i]!,
                                                        //     del: indexOf >= 0 ? indexOf : null);
                                                      },
                                                      child: Container(
                                                        constraints: const BoxConstraints(
                                                          minHeight: 32,
                                                        ),
                                                        padding: const EdgeInsets.only(
                                                            left: 3, right: 3),
                                                        width: context.width * headTitle[0].width,
                                                        child: Text.rich(TextSpan(children: [
                                                          state.selectedTable!.orders[rowIndex]
                                                                  .products[i]!.isFirst!
                                                              ? const TextSpan(
                                                                  text: "** ",
                                                                  style: TextStyle(
                                                                      fontSize: 12,
                                                                      color: Colors.green,
                                                                      fontWeight: FontWeight.bold))
                                                              : TextSpan(
                                                                  text: state
                                                                              .selectedTable!
                                                                              .orders[rowIndex]
                                                                              .products[i]!
                                                                              .note
                                                                              .toString()
                                                                              .isNotEmpty ||
                                                                          state
                                                                              .selectedTable!
                                                                              .orders[rowIndex]
                                                                              .products[i]!
                                                                              .optionsString
                                                                              .toString()
                                                                              .isNotEmpty
                                                                      ? "++ "
                                                                      : "",
                                                                  style: const TextStyle(
                                                                      fontSize: 11,
                                                                      color: Colors.red,
                                                                      fontWeight: FontWeight.bold)),
                                                          TextSpan(
                                                              text:
                                                                  '${state.selectedTable!.orders[rowIndex].products[i]!.productName}',
                                                              style: const TextStyle(fontSize: 17))
                                                        ])),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        //TODO: CHECK THIS LATER
                                                        // state
                                                        //             .selectedTable!
                                                        //             .orders[rowIndex]
                                                        //             .products[i]!
                                                        //             .note
                                                        //             .toString()
                                                        //             .isNotEmpty ||
                                                        //         state
                                                        //             .selectedTable!
                                                        //             .orders[rowIndex]
                                                        //             .products[i]!
                                                        //             .optionsString
                                                        //             .toString()
                                                        //             .isNotEmpty
                                                        //     ? CheckDetailDialog().showCheckDialog(
                                                        //         context,
                                                        //         tableListProvider.selectedTable!
                                                        //             .orders[rowIndex].products[i]!)
                                                        //     : null;
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.only(
                                                            left: 3, right: 3),
                                                        width: context.width * headTitle[2].width,
                                                        child: Text(
                                                          DoubleConvert().formatDouble(state
                                                                  .selectedTable!
                                                                  .orders[rowIndex]
                                                                  .products[i]!
                                                                  .quantity ??
                                                              0.0),
                                                          style: const TextStyle(fontSize: 17),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        //TODO: CHECK THIS LATER !
                                                        // tableListProvider
                                                        //             .selectedTable!
                                                        //             .orders[rowIndex]
                                                        //             .products[i]!
                                                        //             .note
                                                        //             .toString()
                                                        //             .isNotEmpty ||
                                                        //         tableListProvider
                                                        //             .selectedTable!
                                                        //             .orders[rowIndex]
                                                        //             .products[i]!
                                                        //             .optionsString
                                                        //             .toString()
                                                        //             .isNotEmpty
                                                        //     ? CheckDetailDialog().showCheckDialog(
                                                        //         context,
                                                        //         tableListProvider.selectedTable!
                                                        //             .orders[rowIndex].products[i]!)
                                                        //     : null;
                                                      },
                                                      child: BlocBuilder<TableCubit, TableState>(
                                                        builder: (context, state) {
                                                          return Container(
                                                            padding: const EdgeInsets.only(
                                                                left: 3, right: 3),
                                                            width: context
                                                                .dynamicWidth(headTitle[1].width),
                                                            child: Text(
                                                              //! product's price
                                                              state.selectedTable!.orders[rowIndex]
                                                                          .products[i]!.status ==
                                                                      0
                                                                  ? LocaleKeys.CANCEL.tr()
                                                                  : state
                                                                          .selectedTable!
                                                                          .orders[rowIndex]
                                                                          .products[i]!
                                                                          .isServe!
                                                                      ? LocaleKeys.catering.tr()
                                                                      : DoubleConvert()
                                                                          .formatPriceDouble(state
                                                                                  .selectedTable!
                                                                                  .orders[rowIndex]
                                                                                  .products[i]!
                                                                                  .price ??
                                                                              0.0),
                                                              style: const TextStyle(fontSize: 17),
                                                              textAlign: TextAlign.end,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            (state.selectedTable!.orders.length == rowIndex + 1 &&
                                                    state.newProducts.products.isNotEmpty)
                                                ? const SizedBox.shrink()
                                                //TODO: CHECK THIS LATER
                                                // NewOrderProductListWidget()
                                                : Container()
                                          ],
                                        ));
                                },
                              ),
                            ),
                          );
                        })),
                      )),
                      BlocBuilder<TableCubit, TableState>(
                          builder: ((context, state) => Container(
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
                              )))
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
                              rightText: DoubleConvert().formatPriceDouble(subTotal(state))),
                          _SubTotalTaxTotalWidget(
                              leftText: 'Tax',
                              rightText: DoubleConvert().formatPriceDouble(taxTotal(state))),
                          _SubTotalTaxTotalWidget(
                              leftText: 'Total',
                              rightText: DoubleConvert()
                                  .formatPriceDouble(state.selectedTable!.remainingPrice ?? 0.0)),
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
                            : InkWell(
                                onTap: () async {
                                  await handleButtonAction(action, context);
                                },
                                child: TableButtonWidget(label),
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
  }

  subTotal(TableState state) {
    double subTot = 0.0;

    ///  creating new order's sub total price
    if (state.selectedTable!.orders.isEmpty) {
      for (var product in state.newProducts.products) {
        subTot += (product.price * product.quantity);
      }
    }

    /// created order's sub total price
    for (var order in state.selectedTable!.orders) {
      for (var product in order.products) {
        if (product!.status != 0 || !product.isServe!) {
          subTot += product.price!;
        }
      }
    }
    return subTot;
  }

  taxTotal(TableState state) {
    double subTot = 0.0;
    for (var order in state.selectedTable!.orders) {
      for (var product in order.products) {
        if (product!.status != 0 || !product.isServe!) {
          subTot += (product.price! * 08) / 100;
        }
      }
    }
    return subTot;
  }

  Future<void> handleButtonAction(ButtonAction action, BuildContext context) async {
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
      default:
        break;
    }
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
