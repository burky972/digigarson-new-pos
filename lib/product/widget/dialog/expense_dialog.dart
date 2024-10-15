import 'package:a_pos_flutter/feature/home/expense/cubit/expense_cubit.dart';
import 'package:a_pos_flutter/feature/home/expense/cubit/expense_state.dart';
import 'package:a_pos_flutter/feature/home/expense/model/expense_request_model.dart';
import 'package:a_pos_flutter/feature/home/expense/model/expense_response_model.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/constant/app/date_time_formats.dart';
import 'package:a_pos_flutter/product/enums/expense_types/expense_type.dart';
import 'package:a_pos_flutter/product/enums/payment_type/enum.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/date_time_format/date_time_format.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/keyboard/custom_keyboard.dart';
import 'package:a_pos_flutter/product/widget/keyboard/custom_search_keyboard.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseDialog {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  PaymentType _selectedPaymentType = PaymentType.CREDIT_CARD;
  OverlayEntry? _overlayEntry;
  final FocusNode _nameNode = FocusNode();
  final FocusNode _noteNode = FocusNode();
  final FocusNode _amountNode = FocusNode();
  int type = ExpenseType.GET.value;

  void showCustomNumberKeyKeyboard(
      BuildContext context, TextEditingController controller, FocusNode focusNode, _) {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 30,
        left: (context.width - 280) / 2,
        right: (context.width - 280) / 2,
        child: Material(
          elevation: 4.0,
          child: CustomNumberKeyboard(
            onKeyPressed: (String value) {
              if (value == 'clear') {
                if (controller.text.isNotEmpty) {
                  controller.text = controller.text.substring(0, controller.text.length - 1);
                }
              } else if (value == 'allClear') {
                controller.clear();
              } else {
                controller.text += value;
              }
              controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length),
              );
            },
            onClose: () {
              _overlayEntry?.remove();
              _overlayEntry = null;
            },
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void showCustomKeyKeyboard(
      BuildContext context, TextEditingController controller, FocusNode focusNode) {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 5,
        left: (context.width - 840) / 2,
        right: (context.width - 840) / 2,
        child: CustomSearchKeyboard(
          onKeyPressed: (value) {
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
              controller.text = controller.text.replaceRange(
                oldSelection.start,
                oldSelection.end,
                value,
              );
              controller.selection = TextSelection.collapsed(
                offset: oldSelection.baseOffset + value.length,
              );
            }
          },
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void toggleFullScreen() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  void show(BuildContext context, {int? index}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          onPopInvoked: (bool didPop) {
            if (didPop) {
              toggleFullScreen();
              return;
            }
          },
          child: BlocProvider(
            create: (context) => ExpenseCubit()..getExpenses(),
            child: BlocBuilder<ExpenseCubit, ExpenseState>(
              builder: (context, state) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    title: Column(
                      children: [
                        Center(
                          child: Text(
                            type == ExpenseType.GET.value
                                ? LocaleKeys.outcome.tr()
                                : LocaleKeys.expenseAdd.tr(),
                            style: CustomFontStyle.titlesTextStyle
                                .copyWith(color: context.colorScheme.tertiary),
                          ),
                        ),
                        SizedBox(height: context.dynamicHeight(.01)),
                        Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: LightBlueButton(
                                onTap: () {
                                  setState(() {
                                    type = ExpenseType.GET.value;
                                  });
                                },
                                buttonText: LocaleKeys.expenseShow.tr(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 200,
                              child: LightBlueButton(
                                onTap: () {
                                  setState(() {
                                    type = ExpenseType.ADD.value;
                                  });
                                },
                                buttonText: LocaleKeys.expenseAdd.tr(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    content: Container(
                      width: context.dynamicWidth(.5),
                      constraints: BoxConstraints(
                        minWidth: context.dynamicWidth(0.7),
                        maxWidth: context.dynamicWidth(0.8),
                        maxHeight: type == ExpenseType.GET.value
                            ? context.dynamicHeight(0.75)
                            : context.dynamicHeight(0.5),
                      ),
                      child: type == ExpenseType.GET.value
                          ? const Column(
                              children: [
                                _ExpensesTitleContainerList(),
                                Expanded(child: _ExpensesBodyWidget()),
                              ],
                            )
                          :

                          /// ADD EXPENSE UI
                          Column(
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: context.dynamicWidth(.1),
                                        child: Text(LocaleKeys.expenseTitle.tr())),
                                    Expanded(
                                      child: _ExpenseTextField(
                                        controller: _nameController,
                                        focusNode: _nameNode,
                                        onTap: () {
                                          showCustomKeyKeyboard(
                                              context, _nameController, _nameNode);
                                        },
                                        hintText: LocaleKeys.expenseTitle.tr(),
                                        width: 500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: context.dynamicWidth(.1),
                                        child: Text(LocaleKeys.expenseAmount.tr())),
                                    _ExpenseTextField(
                                      controller: _amountController,
                                      focusNode: _amountNode,
                                      onTap: () {
                                        showCustomNumberKeyKeyboard(
                                            context, _amountController, _amountNode, _overlayEntry);
                                      },
                                      hintText: LocaleKeys.expenseAmount.tr(),
                                      width: context.dynamicWidth(.2),
                                    ),
                                    SizedBox(
                                      width: context.dynamicWidth(.08),
                                    ),
                                    SizedBox(
                                        width: context.dynamicWidth(.1),
                                        child: Text(LocaleKeys.paymentType.tr())),
                                    const Spacer(),
                                    SizedBox(
                                      width: context.dynamicWidth(.2),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: DropdownButtonFormField<PaymentType>(
                                          value: _selectedPaymentType,
                                          isExpanded: true,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          focusColor: Colors.transparent,
                                          items: PaymentType.allTypes.map((PaymentType type) {
                                            return DropdownMenuItem<PaymentType>(
                                              value: type,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(type.displayTitle),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (PaymentType? newValue) {
                                            if (newValue != null) {
                                              setState(() {
                                                _selectedPaymentType = newValue;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: context.dynamicWidth(.1),
                                        child: Text(LocaleKeys.expenseDescription.tr())),
                                    Expanded(
                                      child: _ExpenseTextField(
                                        controller: _noteController,
                                        focusNode: _noteNode,
                                        onTap: () {
                                          showCustomKeyKeyboard(
                                              context, _noteController, _noteNode);
                                        },
                                        hintText: LocaleKeys.expenseDescription.tr(),
                                        width: 500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: context.dynamicHeight(0.2)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: ElevatedButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(Colors.green)),
                                            onPressed: () async {
                                              await postExpense(context, state);
                                            },
                                            child: Padding(
                                              padding: const AppPadding.normalAll(),
                                              child: Text(LocaleKeys.save.tr(),
                                                  style: CustomFontStyle.buttonTextStyle),
                                            ))),
                                    const SizedBox(width: 20),
                                    Expanded(
                                        child: ElevatedButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(Colors.red)),
                                            onPressed: () => routeManager.pop(),
                                            child: Padding(
                                              padding: const AppPadding.normalAll(),
                                              child: Text(
                                                LocaleKeys.CANCEL.tr(),
                                                style: CustomFontStyle.buttonTextStyle,
                                              ),
                                            )))
                                  ],
                                ),
                              ],
                            ),
                    ),
                    actions: <Widget>[
                      type == ExpenseType.GET.value
                          ? SizedBox(
                              width: context.dynamicWidth(0.2),
                              child: LightBlueButton(
                                  buttonText: LocaleKeys.close.tr(),
                                  onTap: () => routeManager.pop()),
                            )
                          : const SizedBox(),
                    ],
                  );
                });
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> postExpense(
    BuildContext context,
    ExpenseState state,
  ) async {
    double amount = double.tryParse(_amountController.text) ?? -1;
    if (_nameController.text.length < 2) {
      showOrderErrorNotProductDialog(context, 'Please enter Expense Title');
    } else if (_amountController.text.isEmpty) {
      showOrderErrorNotProductDialog(context, 'Please enter Expense Amount');
    } else if (amount > 0) {
      bool return_ = await context.read<ExpenseCubit>().postExpense(
              expenseModel: ExpenseRequestModel(
            title: _nameController.text,
            paymentType: _selectedPaymentType.value,
            expenseAmount: amount,
            currency: 'USD',
            description: _noteController.text,
          ));

      if (return_) {
        showOrderSuccessDialog(context, LocaleKeys.expenseCreated.tr(), secondClose: true);
      } else {
        showOrderErrorDialog(context, LocaleKeys.expenseNotCreated.tr());
      }
    } else {
      showOrderErrorNotProductDialog(context, LocaleKeys.enterCorrectValue.tr());
      toggleFullScreen();
    }
  }
}

class _ExpenseTextField extends StatelessWidget {
  const _ExpenseTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required VoidCallback onTap,
    required String hintText,
    required double width,
  })  : _controller = controller,
        _focusNode = focusNode,
        _onTap = onTap,
        _hintText = hintText,
        _width = width;
  final TextEditingController _controller;
  final FocusNode? _focusNode;
  final VoidCallback _onTap;
  final String _hintText;
  final double _width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: BorderConstants.borderAllSmall),
      child: TextField(
        onTap: _onTap,
        controller: _controller,
        focusNode: _focusNode,
        keyboardType: TextInputType.none,
        decoration: InputDecoration(hintText: _hintText, contentPadding: const AppPadding.minAll()),
      ),
    );
  }
}

/// Expenses Title Container's List
class _ExpensesTitleContainerList extends StatelessWidget {
  const _ExpensesTitleContainerList();

  @override
  Widget build(BuildContext context) {
    final List<String> titleList = [
      LocaleKeys.description.tr(),
      LocaleKeys.paymentType.tr(),
      LocaleKeys.price.tr(),
      LocaleKeys.date.tr(),
      LocaleKeys.openAccount.tr(),
      ''
    ];
    return SizedBox(
      width: context.width,
      child: Row(
        children: titleList
            .map((e) => Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const AppPadding.extraLowHorizontal() / 5,
                    color: Theme.of(context).colorScheme.tertiary,
                    child: Text(e, textAlign: TextAlign.center),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _ExpensesBodyWidget extends StatelessWidget {
  const _ExpensesBodyWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      builder: (context, state) {
        if (state.states == ExpenseStates.loading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (state.expenseList == null || state.expenseList!.isEmpty) {
          return const SizedBox.shrink();
        }
        return ListView.builder(
          itemCount: state.expenseList!.length,
          itemBuilder: (context, index) {
            final expense = state.expenseList?[index] ?? ExpenseModel.empty();
            return Container(
              padding: const EdgeInsets.all(1),
              child: Row(
                children: [
                  Expanded(child: _ExpenseSingleTextInfoWidget(text: expense.title ?? ' ')),
                  Expanded(
                      child: _ExpenseSingleTextInfoWidget(
                          text: PaymentType.getServerValue(expense.paymentType ?? 0))),
                  Expanded(
                      child: _ExpenseSingleTextInfoWidget(
                          text:
                              '${expense.expenseAmount?.toStringAsFixed(2)} ${expense.currency}')),
                  Expanded(
                      child: _ExpenseSingleTextInfoWidget(
                          text: expense.createdAt!
                              .toLocal()
                              .toFormattedString(format: dateAndTimeFormat))),
                  const Expanded(child: _ExpenseSingleTextInfoWidget(text: '-')),
                  Expanded(
                      child: _ExpenseSingleDeleteButtonWidget(
                          text: LocaleKeys.delete.tr(), expenseId: expense.id ?? '')),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _ExpenseSingleDeleteButtonWidget extends StatelessWidget {
  const _ExpenseSingleDeleteButtonWidget({
    required this.text,
    required this.expenseId,
  });
  final String text;
  final String expenseId;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        width: context.dynamicWidth(0.15),
        margin: const AppPadding.extraLowHorizontal() / 5,
        child: LightBlueButton(
          buttonText: text,
          onTap: () async {
            bool isDeleted = await context.read<ExpenseCubit>().deleteExpense(expenseId: expenseId);
            if (isDeleted) {
              showOrderSuccessDialog(context, LocaleKeys.expenseDeleted.tr(), secondClose: true);
            } else {
              showErrorDialog(context, LocaleKeys.expenseNotDeleted.tr());
            }
          },
        ));
  }
}

class _ExpenseSingleTextInfoWidget extends StatelessWidget {
  const _ExpenseSingleTextInfoWidget({
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        margin: const AppPadding.extraLowHorizontal() / 5,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ));
  }
}
