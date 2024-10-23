import 'package:a_pos_flutter/feature/home/case/cubit/case_cubit.dart';
import 'package:a_pos_flutter/feature/home/checks/cubit/check_cubit.dart';
import 'package:a_pos_flutter/feature/home/order/cubit/order_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/enums/button_action/button_action_enum.dart';
import 'package:a_pos_flutter/product/enums/payment_type/enum.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/cubit/quick_service/quick_service_cubit.dart';
import 'package:a_pos_flutter/product/global/cubit/quick_service/quick_service_state.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/global/model/quick_service/quick_service_request_model.dart';
import 'package:a_pos_flutter/product/global/service/response_action_service.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/keyboard/custom_checkout_keyboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuickServiceCheckoutDialog {
  QuickServiceCheckoutDialog._();

  static show(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Quick Service Checkout',
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
              LightBlueButton(
                  buttonText: 'Close',
                  onTap: () {
                    QuickServiceCubit quickServiceCubit = context.read<QuickServiceCubit>();
                    quickServiceCubit.clearAll();

                    routeManager.pop();
                  }),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.dynamicHeight(.01)),
                  const _TitleTextWidget(LocaleKeys.all_product),
                  SizedBox(height: context.dynamicHeight(.01)),
                  const _PriceProductAmountTitles(),
                  BlocBuilder<QuickServiceCubit, QuickServiceState>(
                    builder: ((context, state) {
                      return Container(
                        color: Colors.black12,
                        width: context.dynamicWidth(.3),
                        height: context.dynamicHeight(.55),
                        child: CustomScrollView(
                          slivers: [
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
                                              context
                                                  .read<QuickServiceCubit>()
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
                                                  child: Text(
                                                      '${context.read<QuickServiceCubit>().calculatePriceAfterTax(product)}'),
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
    return BlocBuilder<QuickServiceCubit, QuickServiceState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
              padding: const AppPadding.extraMinAll(),
              width: context.dynamicWidth(.33) + 4,
              height: context.dynamicHeight(.84),
              constraints: const BoxConstraints(
                minWidth: 400,
              ),
              child: CustomScrollView(
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
                          child: CustomScrollView(
                            slivers: [
                              SliverList.list(
                                  children: state.paidProducts!.map((product) {
                                return Padding(
                                  padding: const AppPadding.extraLowVertical(),
                                  child: InkWell(
                                    //! Secili olan urunu tiklayinca secili den kaldirmis oluyor!!
                                    onTap: () {
                                      context
                                          .read<QuickServiceCubit>()
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
                                            child: Text(
                                                '${context.read<QuickServiceCubit>().calculatePriceAfterTax(product)}'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList()),
                            ],
                          )),
                      Container(
                        constraints: const BoxConstraints(minHeight: 320),
                        child: CustomCheckoutKeyboard(onKeyPressed: (value) {
                          if (state.paidProducts!.isNotEmpty) {
                            context.read<QuickServiceCubit>().clearCheckoutInput();
                            context.read<QuickServiceCubit>().setTotalDue(0);
                          }
                          //! open these comments codes later for enter payment value
                          context.read<QuickServiceCubit>().setCheckoutInput(value);
                          final checkoutInput =
                              context.read<QuickServiceCubit>().state.checkoutInput;
                          if (double.parse(checkoutInput) <= state.totalRemaining) {
                            context
                                .read<QuickServiceCubit>()
                                .setTotalDue(double.parse(checkoutInput));
                          }
                        }, onClearPressed: (val) {
                          context.read<QuickServiceCubit>().clearCheckoutInput();
                          context.read<QuickServiceCubit>().setTotalDue(0);
                        }),
                      ),
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }
}

class _RightCheckoutWidget extends StatelessWidget {
  const _RightCheckoutWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuickServiceCubit, QuickServiceState>(
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
                    Text(state.totalPriceWithTax.toStringAsFixed(2)),
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
                    Text((state.checkOutRemainingPrice).toStringAsFixed(2)),
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
                                      TableCubit tableCubit = context.read<TableCubit>();
                                      QuickServiceCubit quickServiceCubit =
                                          context.read<QuickServiceCubit>();
                                      if (state.totalDue <= 0) return;
                                      quickServiceCubit.addPayment(Payment(
                                          type: paymentType.value,
                                          amount: state.totalDue,
                                          currency: 'USD'));
                                      if (state.totalRemaining != 0) return;

                                      bool isSales =
                                          await context.read<OrderCubit>().postQuickService(
                                                quickServiceModel: QuickServiceRequestModel(
                                                  products: state.allProducts,
                                                  totalPrice: state.totalPriceWithTax,
                                                  totalPriceAfterTax: state.totalPriceWithTax,
                                                  discounts: const [],
                                                  serviceFee: const [],
                                                  payments: context
                                                      .read<QuickServiceCubit>()
                                                      .state
                                                      .paymentsList,
                                                ),
                                              );
                                      quickServiceCubit.clearAll();

                                      await ResponseActionService.getTableAndNavigate(
                                        response: isSales,
                                        tableCubit: tableCubit,
                                        action: ButtonAction.quickCash,
                                        callback: () => context.read<CheckCubit>().getAllCheck(
                                              caseId:
                                                  context.read<CaseCubit>().cases?.id.toString() ??
                                                      "",
                                            ),
                                      );
                                    },
                                    child: Text(
                                      PaymentType.getServerValue(paymentType.value),
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
