import 'package:a_pos_flutter/feature/home/checks/cubit/check_cubit.dart';
import 'package:a_pos_flutter/feature/home/checks/cubit/check_state.dart';
import 'package:a_pos_flutter/feature/home/checks/model/single_check_model.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/product/enums/button_action/button_action_enum.dart';
import 'package:a_pos_flutter/product/enums/payment_type/enum.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/global/service/response_action_service.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/keyboard/re_open_custom_keyboard.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OldCheckDialog {
  OverlayEntry? _overlayEntry;
  List<Payment> payments = [];
  List<TextEditingController> amountControllers = [];
  List<FocusNode> amountFocusNode = [];
  List<String> selectedPaymentMethod = [];
  double remaining = 0.0;
  double total = 0.0;
  String currency = "\$";

  void toggleFullScreen() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  void showCustomNumberKeyKeyboard(BuildContext context, TextEditingController controller,
      FocusNode focusNode, final Function(double)? enterPress) {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 30,
        left: (MediaQuery.of(context).size.width - 280) / 2,
        right: (MediaQuery.of(context).size.width - 280) / 2,
        child: ReOpenCustomKeyboard(
          onKeyPressed: (value) {
            try {
              FocusScope.of(context).unfocus();
              FocusScope.of(context).requestFocus(focusNode);
              final oldSelection = controller.selection;
              if (value.toString() == "clear") {
                final currentOffset = oldSelection.baseOffset;
                if (currentOffset > 0) {
                  controller.text = controller.text.substring(0, currentOffset - 1) +
                      controller.text.substring(currentOffset);
                  controller.selection = TextSelection.collapsed(offset: currentOffset - 1);
                }
              } else if (value.toString() == "close") {
                toggleFullScreen();
              } else {
                if (controller.text.contains(".") && value == ".") {
                  return;
                }
                controller.text = controller.text.replaceRange(
                  oldSelection.start,
                  oldSelection.end,
                  value,
                );
                controller.selection = TextSelection.collapsed(
                  offset: oldSelection.baseOffset + value.length,
                );
              }
              enterPress!.call(double.parse(controller.text.isNotEmpty ? controller.text : "0.0"));
            } catch (e) {
              appLogger.error("oldCheckOut:", e.toString());
            }
          },
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void show(BuildContext context, SingleCheckModel? order, {int? index}) {
    payments = [];
    amountControllers = [];
    amountFocusNode = [];
    selectedPaymentMethod = [];
    remaining = 0.0;
    total = 0.0;
    currency = 'USD';
    total = order!.totalPrice! + order.totalTax!;

    for (var pay in order.payments!) {
      amountControllers.add(TextEditingController(text: pay.amount.toString()));
      amountFocusNode.add(FocusNode());
      selectedPaymentMethod.add(PaymentType.allTypes[pay.type! - 1].name);
      payments.add(Payment(type: pay.type, amount: pay.amount, currency: pay.currency));
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(
                  'Total: $total    |    Remaining: $remaining',
                  style: CustomFontStyle.generalTextStyle
                      .copyWith(color: context.colorScheme.tertiary, fontWeight: FontWeight.bold),
                ),
                content: Container(
                    width: context.dynamicWidth(.3),
                    height: context.dynamicHeight(.3),
                    constraints: const BoxConstraints(
                        minWidth: 400, maxWidth: 450, minHeight: 320, maxHeight: 500),
                    child: ListView.builder(
                      itemCount: payments.length + 1,
                      itemBuilder: (context, index) {
                        if (index == payments.length) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  amountControllers.add(TextEditingController());
                                  amountFocusNode.add(FocusNode());
                                  selectedPaymentMethod.add(PaymentType.allTypes[0].name);
                                  payments.add(Payment(
                                    type: 1,
                                    amount: double.parse("0"),
                                    currency: currency,
                                  ));
                                });
                              },
                              style: ElevatedButton.styleFrom(maximumSize: const Size(65, 60)),
                              child: const Text('Add New', style: CustomFontStyle.buttonTextStyle),
                            ),
                          );
                        }
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DropdownButton<PaymentType>(
                                key: UniqueKey(),
                                value: PaymentType.values
                                    .firstWhere((e) => e.name == selectedPaymentMethod[index]),
                                items: PaymentType.allTypes.map((PaymentType method) {
                                  return DropdownMenuItem<PaymentType>(
                                    value: method,
                                    child: Text(method.name),
                                  );
                                }).toList(),
                                onChanged: (PaymentType? value) {
                                  if (value != null) {
                                    setState(() {
                                      selectedPaymentMethod[index] = value.name;
                                      payments[index].type =
                                          PaymentType.allTypes.indexOf(value) + 1;
                                    });
                                  }
                                },
                              ),
                              const SizedBox(width: 20),
                              Container(
                                width: context.dynamicWidth(.15),
                                constraints: const BoxConstraints(minWidth: 100, maxWidth: 150),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    border: BorderConstants.borderAllSmall),
                                child: TextField(
                                  onTap: () {
                                    showCustomNumberKeyKeyboard(
                                        context, amountControllers[index], amountFocusNode[index],
                                        (value) {
                                      setState(() {
                                        payments[index].amount = value;
                                        remaining = remainingTotal();
                                      });
                                    });
                                  },
                                  controller: amountControllers[index],
                                  focusNode: amountFocusNode[index],
                                  keyboardType: TextInputType.none,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 5, right: 5),
                                    hintText: 'Amount...',
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    amountControllers[index].dispose();
                                    amountFocusNode[index].dispose();
                                    amountControllers.removeAt(index);
                                    amountFocusNode.removeAt(index);
                                    selectedPaymentMethod.removeAt(index);
                                    payments.removeAt(index);
                                    remainingTotal();
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )),
                actions: <Widget>[
                  BlocBuilder<CheckCubit, CheckState>(
                    builder: (context, state) {
                      return LightBlueButton(
                        buttonText: 'Change',
                        onTap: () async {
                          TableCubit tableCubit = context.read<TableCubit>();
                          if (remaining == 0.0) {
                            SingleCheckModel paymentPut = state.selectedCheck!.copyWith(
                              payments: payments,
                              totalPriceAfterTax: total,
                            );

                            showOrderWarningDialog(context, 'Check is being updated...');
                            bool return_ = await context.read<CheckCubit>().updateCheck(
                                checkId: state.selectedCheck!.id.toString(),
                                checkModel: paymentPut);
                            await ResponseActionService.getTableAndNavigate(
                                context: context,
                                response: return_,
                                tableCubit: tableCubit,
                                action: ButtonAction.changePrice);
                          } else {
                            showOrderErrorDialog(
                                context, 'ERROR! You have entered too little or too much.');
                          }
                        },
                      );
                    },
                  ),
                  LightBlueButton(buttonText: 'Close', onTap: () => Navigator.of(context).pop()),
                ],
              );
            },
          );
        });
  }

  remainingTotal() {
    double total_ = 0.0;
    for (var txt in amountControllers) {
      try {
        total_ += double.parse(double.parse(txt.text).toStringAsFixed(2));
      } catch (e) {}
    }
    try {
      remaining = double.parse((total - total_).toStringAsFixed(2));
    } catch (e) {}
    return remaining;
  }
}
