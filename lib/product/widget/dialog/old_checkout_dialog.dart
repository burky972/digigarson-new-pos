import 'package:a_pos_flutter/feature/home/checks/cubit/check_cubit.dart';
import 'package:a_pos_flutter/feature/home/checks/cubit/check_state.dart';
import 'package:a_pos_flutter/feature/home/checks/model/single_check_model.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/product/constant/app/app_constant.dart';
import 'package:a_pos_flutter/product/enums/payment_type/enum.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/widget/keyboard/re_open_custom_keyboard.dart';
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

  void showPutDialog(BuildContext context, SingleCheckModel? order, {int? index}) {
    payments = [];
    amountControllers = [];
    amountFocusNode = [];
    selectedPaymentMethod = [];
    remaining = 0.0;
    total = 0.0;

    currency = 'USD';
    total = order!.totalPrice!;
    for (var pay in order.payments!) {
      amountControllers.add(TextEditingController(text: order.payments?.first.amount.toString()));
      amountFocusNode.add(FocusNode());
      selectedPaymentMethod.add(PaymentType.allTypes[pay.type! - 1].toString());
      payments.add(Payment(type: pay.type, amount: pay.amount, currency: pay.currency, id: ''));
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
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.indigo.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Container(
                    width: MediaQuery.of(context).size.width * .3,
                    height: MediaQuery.of(context).size.height * .3,
                    constraints: const BoxConstraints(
                        minWidth: 400, maxWidth: 450, minHeight: 300, maxHeight: 500),
                    child: ListView.builder(
                      itemCount: payments.length + 1,
                      itemBuilder: (context, index) {
                        if (index == payments.length) {
                          return ElevatedButton(
                            onPressed: () {
                              setState(() {
                                amountControllers.add(TextEditingController());
                                amountFocusNode.add(FocusNode());
                                selectedPaymentMethod
                                    .add(AppConstants.payment_types_list[0].toString());
                                payments.add(Payment(
                                    type: 1,
                                    amount: double.parse("0"),
                                    currency: currency,
                                    id: ''));
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                  color: Colors.indigo, fontWeight: FontWeight.bold),
                              maximumSize: const Size(65, 50),
                            ),
                            child: const Text('Add New'),
                          );
                        }
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DropdownButton<String>(
                                key: UniqueKey(),
                                value: selectedPaymentMethod[index],
                                items: AppConstants.payment_types_list.map((String method) {
                                  return DropdownMenuItem<String>(
                                    value: method,
                                    child: Text(method),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedPaymentMethod[index] = value!;
                                    payments[index].type =
                                        AppConstants.payment_types_list.indexOf(value) + 1;
                                  });
                                },
                              ),
                              const SizedBox(width: 20),
                              Container(
                                width: MediaQuery.of(context).size.width * .15,
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
                      return InkWell(
                        onTap: () async {
                          // if (remaining == 0.0) {
                          //   PutPaymentModel paymentPut = PutPaymentModel(payments: payments);
                          //   showOrderWarningDialog(context, 'Order is being updated...');
                          //   bool return_ = await context.read<CheckCubit>().oldCheckPut(
                          //       // userModel: context.read<GlobalCubit>().user,
                          //       id: state.selectOrder!.orderId.toString(),
                          //       paymentPut: paymentPut);

                          //   if (return_) {
                          //     Navigator.of(context).pop();
                          //     await context.read<CheckCubit>().getAllCheck(
                          //         caseId: context.read<CaseCubit>().cases!.id.toString());
                          //     showOrderSuccessDialog(
                          //         context, "Order has been updated successfully.",
                          //         secondClose: true);
                          //   } else {
                          //     Navigator.of(context).pop();
                          //     showOrderErrorDialog(context, 'ERROR! Order was not updated',
                          //         secondClose: true);
                          //   }
                          // } else {
                          //   showOrderErrorDialog(
                          //       context, 'ERROR! You have entered too little or too much.');
                          // }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .08,
                          constraints: const BoxConstraints(
                              minWidth: 55, maxWidth: 65, minHeight: 30, maxHeight: 45),
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                              border: BorderConstants.borderAllSmall),
                          child: const Center(
                            child: Text(
                              "Change",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.indigo, fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .08,
                      constraints: const BoxConstraints(
                          minWidth: 50, maxWidth: 55, minHeight: 30, maxHeight: 45),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                          border: BorderConstants.borderAllSmall),
                      child: const Center(
                        child: Text(
                          "Close",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.indigo, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
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
      } catch (e) {
        appLogger.error("remainingTotal: ", e.toString());
      }
    }
    try {
      remaining = double.parse((total - total_).toStringAsFixed(2));
    } catch (e) {
      appLogger.error("remainingTotal: ", e.toString());
    }
    return remaining;
  }
}
