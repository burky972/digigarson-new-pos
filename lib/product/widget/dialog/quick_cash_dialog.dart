import 'package:a_pos_flutter/feature/home/order/cubit/order_cubit.dart';
import 'package:a_pos_flutter/feature/home/order/model/pay_request_model.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/enums/button_action/button_action_enum.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/global/service/response_action_service.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Quick cash dialog (checkout dialog)
class QuickCashDialog {
  void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _buildDialog(context);
      },
    );
  }

  Widget _buildDialog(BuildContext context) {
    return BlocSelector<TableCubit, TableState, double>(
      selector: (state) => state.selectedTable!.remainingPrice ?? 0.0,
      builder: (context, totalPrice) {
        return AlertDialog(
          title: Text(
            LocaleKeys.checkout.tr(),
            style: CustomFontStyle.popupNotificationTextStyle
                .copyWith(color: context.colorScheme.tertiary, fontSize: 16),
          ),
          content: Container(
              width: MediaQuery.of(context).size.width * .6 + 5,
              height: 250,
              constraints: const BoxConstraints(
                minWidth: 420,
                maxWidth: 520,
                maxHeight: 350,
              ),
              child: Text(
                'Close out sale to the exact amount of \$${totalPrice.toStringAsFixed(2)} ? ',
                style: CustomFontStyle.titlesTextStyle
                    .copyWith(color: context.colorScheme.error, fontSize: 32),
              )),
          actions: [
            BlocBuilder<TableCubit, TableState>(
              builder: (context, state) {
                return LightBlueButton(
                    buttonText: LocaleKeys.YES.tr(),
                    onTap: () async => await _handleQuickCash(context, state: state)
                        .then((_) => Navigator.pop(context)));
              },
            ),
            LightBlueButton(
              buttonText: LocaleKeys.NO.tr(),
              onTap: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleQuickCash(BuildContext context, {required TableState state}) async {
    showOrderWarningDialog(context, "Payment completing...");
    TableCubit tableCubit = context.read<TableCubit>();
    if (state.selectedTable == null ||
        state.newOrderProduct == null ||
        state.selectedTable?.orders == null ||
        state.selectedTable?.orders.isEmpty == true) return;
    List<PaidProductModel> allProducts = [];
    for (var product in state.selectedTable!.orders.first.products) {
      allProducts.add(
          PaidProductModel(id: product!.id!, quantity: product.quantity!, price: product.price!));
    }
    bool isPaidSuccess = await context.read<OrderCubit>().payOrderProduct(
        payOrderModel: PayRequestModel(payments: [
          Payment(id: '', type: 1, amount: state.selectedTable?.remainingPrice, currency: 'USD')
        ], paidOrderModel: [
          PaidOrderModel(
              orderNum: state.selectedTable!.orders.first.orderNum!, products: allProducts)
        ]),
        tableId: state.selectedTable!.id!);
    tableCubit.clearPriceInfos();
    await ResponseActionService.getTableAndNavigate(
        context: context,
        response: isPaidSuccess,
        tableCubit: tableCubit,
        action: ButtonAction.checkout);
  }
}
