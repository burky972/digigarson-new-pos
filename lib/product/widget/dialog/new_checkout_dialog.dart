import 'package:a_pos_flutter/feature/home/order/cubit/order_cubit.dart';
import 'package:a_pos_flutter/feature/home/order/model/pay_request_model.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/enums/button_action/button_action_enum.dart';
import 'package:a_pos_flutter/product/enums/payment_type/enum.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/global/service/response_action_service.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/keyboard/custom_checkout_keyboard.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCheckoutDialog {
  NewCheckoutDialog._();

  static show(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Checkout',
              style: CustomFontStyle.popupNotificationTextStyle
                  .copyWith(color: context.colorScheme.tertiary),
            ),
            content: Container(
              height: context.height,
              width: context.width,
              constraints: const BoxConstraints(minWidth: 400, minHeight: 250),
              child: Row(
                children: [
                  SizedBox(width: context.dynamicWidth(0.3), child: const _LeftCheckoutWidget()),
                  SizedBox(width: context.dynamicWidth(0.25), child: const _MiddleCheckoutWidget()),
                  Container(
                      padding: const AppPadding.largeAll(),
                      width: context.dynamicWidth(0.3),
                      child: const _RightCheckoutWidget()),
                ],
              ),
            ),
            actions: <Widget>[
              LightBlueButton(buttonText: 'Close', onTap: () => Navigator.pop(context)),
            ],
          );
        });
  }
}

class _TitleTextWidget extends StatelessWidget {
  const _TitleTextWidget(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
            style: CustomFontStyle.titlesTextStyle.copyWith(color: context.colorScheme.primary))
        .tr();
  }
}

class _BodyTextWidget extends StatelessWidget {
  const _BodyTextWidget(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: CustomFontStyle.popupNotificationTextStyle.copyWith(color: Colors.white),
    ).tr();
  }
}

class _LeftCheckoutWidget extends StatelessWidget {
  const _LeftCheckoutWidget();

  @override
  Widget build(BuildContext context) {
    bool isExpanded = false;
    bool isCoverExpanded = false;
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const _TitleTextWidget(LocaleKeys.receivables),
              SizedBox(height: context.dynamicHeight(.01)),
              Container(
                color: context.colorScheme.tertiary,
                padding: const AppPadding.extraMinAll(),
                child: Row(
                  children: [
                    SizedBox(
                        width: context.dynamicWidth(0.2),
                        child: const _BodyTextWidget(LocaleKeys.paymentType)),
                    SizedBox(
                      width: context.dynamicWidth(.08),
                      child: const _BodyTextWidget(LocaleKeys.price),
                    ),
                  ],
                ),
              ),
              const Text("Service And Cover", style: CustomFontStyle.formsTextStyle),
              BlocBuilder<TableCubit, TableState>(builder: (context, state) {
                return Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        '${state.selectedTable!.serviceFee.length}',
                      ),
                    ),
                    SizedBox(
                      width: context.dynamicWidth(0.1),
                      child: const Text("Service", style: CustomFontStyle.formsTextStyle),
                    ),
                    SizedBox(
                      width: context.dynamicWidth(0.1),
                      child: Text(
                        '${state.selectedTable!.serviceFee.fold(0.0, (previousValue, service) => service.amount! + previousValue)}',
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: context.colorScheme.primary),
                      onPressed: () {
                        // setState(() {
                        isExpanded = !isExpanded;
                        // });
                      },
                      child: Text(isExpanded ? '^' : '↓',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ],
                );
              }),
              BlocBuilder<TableCubit, TableState>(
                builder: ((context, state) {
                  return Container(
                    width: 200,
                    height: isExpanded
                        ? state.selectedTable!.serviceFee.length > 3
                            ? 150
                            : state.selectedTable!.serviceFee.length < 3
                                ? 50
                                : 80
                        : 0,
                    color: Colors.black12,
                    child: CustomScrollView(
                      slivers: [
                        SliverList.list(
                            children: isExpanded
                                ? state.selectedTable!.serviceFee
                                    .map((item) => Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: Row(children: [
                                            const SizedBox(
                                              width: 50,
                                              child: Text('1'),
                                            ),
                                            SizedBox(
                                              width: context.dynamicWidth(0.1),
                                              child: Text('%${item.percentile}'),
                                            ),
                                            SizedBox(
                                              width: context.dynamicWidth(0.07),
                                              child: Text('${item.amount}'),
                                            ),
                                          ]),
                                        ))
                                    .toList()
                                : []),
                      ],
                    ),
                  );
                }),
              ),
              BlocBuilder<TableCubit, TableState>(
                  builder: (context, state) => Padding(
                        padding: const AppPadding.extraLowVertical(),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: Text(state.selectedTable!.cover.length.toString()),
                            ),
                            SizedBox(
                              width: context.dynamicWidth(0.1),
                              child: const Text('Cover', style: CustomFontStyle.formsTextStyle),
                            ),
                            SizedBox(
                              width: context.dynamicWidth(0.1),
                              child: Text(
                                '${state.selectedTable!.cover.fold(0.0, (previousValue, cover) => cover.price! + previousValue)}',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // setState(() {
                                isCoverExpanded = !isCoverExpanded;
                                // });
                              },
                              child: Text(isCoverExpanded ? '^' : '↓',
                                  style:
                                      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      )),
              BlocBuilder<TableCubit, TableState>(
                builder: ((context, state) => Container(
                      width: 200,
                      height: isCoverExpanded
                          ? state.selectedTable!.cover.length > 3
                              ? 150
                              : state.selectedTable!.cover.length < 3
                                  ? 50
                                  : 80
                          : 0,
                      color: Colors.black12,
                      child: CustomScrollView(
                        slivers: [
                          SliverList.list(
                              children: isCoverExpanded
                                  ? state.selectedTable!.cover
                                      .map((cover) => Padding(
                                            padding: const AppPadding.extraLowVertical(),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 50,
                                                  child: Text('${cover.quantity}'),
                                                ),
                                                SizedBox(
                                                  width: context.dynamicWidth(0.1),
                                                  child: Text('${cover.title}'),
                                                ),
                                                SizedBox(
                                                  width: context.dynamicWidth(0.07),
                                                  child: Text('${cover.price}'),
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList()
                                  : []),
                        ],
                      ),
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.dynamicHeight(.01)),
                  const _TitleTextWidget(LocaleKeys.all_product),
                  SizedBox(height: context.dynamicHeight(.01)),
                  const _PriceProductAmountTitles(),
                  BlocBuilder<TableCubit, TableState>(
                    builder: ((context, state) {
                      state.selectedTable!.orders
                          .sort((a, b) => a.orderNum!.compareTo(b.orderNum!));
                      return Container(
                        color: Colors.black12,
                        width: context.dynamicWidth(.3),
                        height: context.dynamicHeight(.55),
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child:
                                  Text('Order No: ${state.selectedTable?.orders.first.orderNum}'),
                            ),
                            SliverList.list(
                              children: state.willPaidProducts!.map((product) {
                                return Padding(
                                    padding: const AppPadding.extraMinAll(),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const AppPadding.extraMinAll(),
                                          child: InkWell(
                                            onTap: () {
                                              if (state.totalDue > 0.0 &&
                                                  state.paidProducts!.isEmpty) {
                                                context
                                                    .read<TableCubit>()
                                                    .setInitialCheckoutProducts();
                                              }
                                              context
                                                  .read<TableCubit>()
                                                  .addProductToPaidProducts(product);
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  padding: const AppPadding.extraMinAll(),
                                                  width: context.dynamicWidth(0.1),
                                                  child: Text('${product.quantity}'),
                                                ),

                                                //! checkout left products
                                                Container(
                                                  padding: const AppPadding.extraMinAll(),
                                                  width: context.dynamicWidth(0.07),
                                                  child: Text('${product.productName}'),
                                                ),
                                                Container(
                                                  padding: const AppPadding.extraMinAll(),
                                                  width: context.dynamicWidth(0.07),
                                                  child: Text('${product.priceAfterTax}'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    }),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

/// Checkout Middle Widget
class _MiddleCheckoutWidget extends StatelessWidget {
  const _MiddleCheckoutWidget();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: const AppPadding.extraMinAll(),
          width: context.dynamicWidth(.33) + 4,
          height: context.dynamicHeight(.84),
          constraints: const BoxConstraints(
            minWidth: 400,
          ),
          child: BlocBuilder<TableCubit, TableState>(builder: ((context, state) {
            return CustomScrollView(
              slivers: [
                SliverList.list(
                  children: [
                    const _TitleTextWidget(LocaleKeys.payments),
                    Container(
                      width: context.dynamicWidth(.1),
                      constraints: const BoxConstraints(minWidth: 150, maxWidth: 160),
                      child: const _PriceProductAmountTitles(),
                    ),
                    Container(
                      constraints: const BoxConstraints(minHeight: 150),
                      color: Colors.black12,
                      height: context.dynamicHeight(.6) - 280,
                      child: BlocBuilder<TableCubit, TableState>(
                          builder: (context, state) => CustomScrollView(
                                slivers: [
                                  SliverList.list(
                                      children: state.paidProducts!.map((product) {
                                    return Padding(
                                      padding: const AppPadding.extraLowVertical(),
                                      child: InkWell(
                                        //! Secili olan urunu tiklayinca secili den kaldirmis oluyor!!
                                        onTap: () {
                                          context
                                              .read<TableCubit>()
                                              .deleteOrderToPaidProducts(product);
                                        },
                                        child: Padding(
                                          padding: const AppPadding.extraMinAll(),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: context.colorScheme.primary),
                                                onPressed: () {},
                                                child: Text('${product.quantity}',
                                                    style: const TextStyle(
                                                        fontSize: 20, fontWeight: FontWeight.bold)),
                                              ),
                                              SizedBox(
                                                width: context.dynamicWidth(.07),
                                                child: Text('${product.productName}'),
                                              ),
                                              SizedBox(
                                                width: context.dynamicWidth(.05),
                                                child: Text('${product.priceAfterTax}'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList()),
                                ],
                              )),
                    ),
                    Container(
                      constraints: const BoxConstraints(minHeight: 320),
                      child: CustomCheckoutKeyboard(onKeyPressed: (value) {
                        if (state.paidProducts!.isNotEmpty) {
                          context.read<TableCubit>().setInitialCheckoutProducts();
                          context.read<TableCubit>().clearCheckoutInput();
                          context.read<TableCubit>().setTotalDue(0);
                        }
                        //! open these comments codes later for enter payment value
                        context.read<TableCubit>().setCheckoutInput(value);
                        final checkoutInput = context.read<TableCubit>().state.checkoutInput;
                        debugPrint('input $checkoutInput');

                        if (double.parse(checkoutInput) <=
                            context.read<TableCubit>().state.selectedTable!.remainingPrice!) {
                          context.read<TableCubit>().setTotalDue(double.parse(checkoutInput));
                        }
                      }, onClearPressed: (val) {
                        context.read<TableCubit>().clearCheckoutInput();
                        context.read<TableCubit>().setTotalDue(0);
                      }),
                    ),
                  ],
                ),
              ],
            );
          }))),
    );
  }
}

class _RightCheckoutWidget extends StatelessWidget {
  const _RightCheckoutWidget();

  @override
  Widget build(BuildContext context) {
    Future<void> handlePayment(BuildContext context,
        {required TableState state, required PaymentType paymentType}) async {
      TableCubit tableCubit = context.read<TableCubit>();
      if (state.selectedTable == null ||
          state.newOrderProduct == null ||
          state.selectedTable?.orders == null ||
          state.selectedTable?.orders.isEmpty == true) return;
      if (state.selectedTable?.remainingPrice == 0) {
        showErrorDialog(context, 'No remaining price');
      }
      List<PaidProductModel> allProducts = [];

      for (var product in state.paidProducts!) {
        allProducts.add(
            PaidProductModel(id: product.id!, quantity: product.quantity!, price: product.price!));
      }
      appLogger.warning('TAG-> totalDue:', '${state.totalDue}');
      appLogger.warning('TAG-> double:', '${double.tryParse(state.checkoutInput)}');
      appLogger.warning('TAG-> checkoutInput:', state.checkoutInput);
      if (state.totalDue == 0 ||
          (allProducts.isEmpty &&
              (double.tryParse(state.checkoutInput) == null ||
                  double.tryParse(state.checkoutInput) == 0))) return;
      showOrderWarningDialog(context, "Payment completing...");
      bool isPaidSuccess = await context.read<OrderCubit>().payOrderProduct(
          payOrderModel: PayRequestModel(payments: [
            Payment(id: '', type: paymentType.value, amount: state.totalDue, currency: 'USD')
          ], paidOrderModel: [
            PaidOrderModel(
                orderNum: state.selectedTable!.orders.first.orderNum!,
                products: allProducts.isEmpty ? [] : allProducts)
          ]),
          tableId: state.selectedTable!.id!);

      await ResponseActionService.getTableAndNavigate(
          context: context,
          response: isPaidSuccess,
          tableCubit: tableCubit,
          action: ButtonAction.checkout);
    }

    return BlocBuilder<TableCubit, TableState>(
      builder: (context, state) {
        return SizedBox(
          width: context.dynamicWidth(.2),
          child: Column(
            children: [
              Container(
                width: context.dynamicWidth(.3),
                padding: const AppPadding.extraMinAll(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleKeys.total.tr()),
                    Text(state.selectedTable!.totalPriceAfterTax!.toStringAsFixed(2)),
                  ],
                ),
              ),
              Container(
                width: context.dynamicWidth(.3),
                padding: const AppPadding.extraMinAll(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleKeys.amountPayable.tr()),
                    Text(state.totalDue.toStringAsFixed(2)),
                  ],
                ),
              ),
              Container(
                width: context.dynamicWidth(.3),
                padding: const AppPadding.extraMinAll(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleKeys.remainingPrice.tr()),
                    Text(state.checkOutRemainingPrice.toStringAsFixed(2)),
                  ],
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        PaymentType.allTypes
                            .map(
                              (paymentType) => Padding(
                                padding: const AppPadding.extraLowVertical(),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: context.colorScheme.tertiary,
                                        fixedSize: const Size(60, 60),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        )),
                                    onPressed: () async {
                                      await handlePayment(context,
                                          state: state, paymentType: paymentType);
                                    },
                                    child: Text(
                                      paymentType.getServerValue(paymentType.value),
                                      style: CustomFontStyle.buttonTextStyle,
                                    )),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PriceProductAmountTitles extends StatelessWidget {
  const _PriceProductAmountTitles();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const AppPadding.minAll(),
      color: context.colorScheme.tertiary,
      child: const Row(
        children: [
          Expanded(flex: 1, child: _BodyTextWidget(LocaleKeys.amount)),
          Expanded(flex: 1, child: _BodyTextWidget(LocaleKeys.product)),
          Expanded(flex: 1, child: _BodyTextWidget(LocaleKeys.price)),
        ],
      ),
    );
  }
}

mixin NumberKeyBoardMixin on StatelessWidget {}
