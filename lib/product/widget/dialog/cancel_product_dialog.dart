import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/cubit/note_cubit.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/cubit/note_state.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/model/cancel_reason_model.dart';
import 'package:a_pos_flutter/feature/home/order/cubit/order_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/enums/button_action/button_action_enum.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:a_pos_flutter/product/global/service/global_service.dart';
import 'package:a_pos_flutter/product/global/service/response_action_service.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/keyboard/custom_keyboard.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelProductDialog {
  List<double> qtyList = [];
  Map<dynamic, TextEditingController> controllerList = {};
  final TextEditingController _noteController = TextEditingController();

  Map<dynamic, FocusNode> focusNodeList = {};
  OverlayEntry? _overlayEntry;
  FocusNode focusNode = FocusNode();
  final FocusNode _noteNode = FocusNode();

  String? cancelReason = '';

  final int type = 0;
  final int title = 1;
  final int notType = 1;
  final int initialValue = 1;

  void showCustomNumberKeyKeyboard(
    BuildContext context,
    TextEditingController controller,
    FocusNode focusNode, {
    double? limit,
  }) {
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 30,
        left: (MediaQuery.of(context).size.width - 280) / 2,
        right: (MediaQuery.of(context).size.width - 280) / 2,
        child: CustomNumberKeyboard(
          onKeyPressed: (value) {
            _handleKeyPress(context, controller, focusNode, value, limit);
          },
          onClose: () {
            _overlayEntry?.remove();
            _overlayEntry = null;
          },
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _handleKeyPress(
    BuildContext context,
    TextEditingController controller,
    FocusNode focusNode,
    String value, [
    double? limit,
  ]) {
    final oldSelection = controller.selection;
    if (value == "clear") {
      _handleClear(controller, oldSelection);
    } else if (value == "close") {
      _removeOverlay();
    } else {
      _handleInput(controller, oldSelection, value, limit);
    }

    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(focusNode);
  }

  void _handleClear(TextEditingController controller, TextSelection oldSelection) {
    final currentOffset = oldSelection.baseOffset;
    if (currentOffset > 0) {
      controller.text = controller.text.substring(0, currentOffset - 1) +
          controller.text.substring(currentOffset);
      controller.selection = TextSelection.collapsed(offset: currentOffset - 1);
    }
  }

  void _handleInput(
    TextEditingController controller,
    TextSelection oldSelection,
    String value, [
    double? limit,
  ]) {
    if (controller.text.contains(".") && value == ".") return;
    if (limit != null &&
        limit <
            double.parse(controller.text.replaceRange(
              oldSelection.start,
              oldSelection.end,
              value,
            ))) return;

    controller.text = controller.text.replaceRange(
      oldSelection.start,
      oldSelection.end,
      value,
    );

    controller.selection = TextSelection.collapsed(
      offset: oldSelection.baseOffset + value.length,
    );
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  void showCancelProductDialogDialog(
    GlobalKey? key,
    BuildContext context, {
    int? index,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _buildDialog(context);
      },
    );
  }

  Widget _buildDialog(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool didPop) {
        if (didPop) {
          _removeOverlay();
          return;
        }
      },
      child: BlocBuilder<NoteServePaymentCancelReasonCubit, NoteServePaymentCancelReasonState>(
        builder: (context, state) {
          cancelReason = state.selectedCancelReason;
          return AlertDialog(
            title: _buildTitle(context),
            content: _buildContent(context),
            actions: [
              BlocBuilder<TableCubit, TableState>(
                builder: (context, state) {
                  return LightBlueButton(
                      buttonText: LocaleKeys.voidText.tr(),
                      onTap: () => _handleSave(context, state));
                },
              ),
              LightBlueButton(
                buttonText: LocaleKeys.CANCEL.tr(),
                onTap: () => routeManager.pop(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      LocaleKeys.cancelProduct.tr(),
      style: CustomFontStyle.popupNotificationTextStyle
          .copyWith(color: context.colorScheme.tertiary, fontSize: 16),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .6 + 5,
      height: 250,
      constraints: const BoxConstraints(
        minWidth: 420,
        maxWidth: 520,
        maxHeight: 250,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<TableCubit, TableState>(
                builder: (context, state) {
                  return SizedBox(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('${state.newOrderProduct?.productName} - Amount',
                                      style: CustomFontStyle.titlesTextStyle
                                          .copyWith(color: context.colorScheme.primary)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color: Colors.black, width: 1.0),
                                    ),
                                    child: TextField(
                                      readOnly: true,
                                      onTap: () {
                                        // _handleProductQuantityTap(context, state);
                                      },
                                      controller: controllerList[state.newOrderProduct?.id] ??
                                          TextEditingController(),
                                      focusNode: focusNodeList[state.newOrderProduct?.id],
                                      keyboardType: TextInputType.none,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                                        hintText: '1',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select ${LocaleKeys.cancelReason.tr()}',
                      style: CustomFontStyle.titlesTextStyle
                          .copyWith(color: context.colorScheme.primary)),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    child: BlocBuilder<NoteServePaymentCancelReasonCubit,
                        NoteServePaymentCancelReasonState>(
                      buildWhen: (previous, current) =>
                          previous.selectedCancelReason != current.selectedCancelReason,
                      builder: (context, state) {
                        return DropdownButton<String>(
                          value: state.selectedCancelReason,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 20,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (newValue) {
                            if (newValue != null) {
                              cancelReason = newValue;
                              context
                                  .read<NoteServePaymentCancelReasonCubit>()
                                  .setSelectedCancelReason(newValue);
                            }
                          },
                          items: state.cancelReasonsModel.map((CancelReasonsModel note) {
                            return DropdownMenuItem<String>(
                              value: note.title,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                                child: Text(note.title ?? ""),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 50),
          CustomTextField(
            hintText: "Cancel Note...",
            onTap: () {
              GlobalService.customKeyboardManager.showCustomKeyKeyboard(
                context,
                _noteController,
                _noteNode,
              );
            },
            isBorder: true,
            controller: _noteController,
            focusNode: _noteNode,
          )
        ],
      ),
    );
  }

  void _handleSave(BuildContext context, TableState state) async {
    _removeOverlay();
    await cancelProduct(context,
            body: CancelProduct(
                cancelNote: _noteController.text.isEmpty ? "String" : _noteController.text,
                cancelReason: cancelReason ?? '',
                products: state.newOrderProducts,
                tableId: state.selectedTable!.id.toString()),
            state: state)
        .then((_) => routeManager.pop());
  }

  Future<void> cancelProduct(BuildContext context,
      {required CancelProduct body, required TableState state}) async {
    showOrderWarningDialog(context, "Product Canceling...");
    TableCubit tableCubit = context.read<TableCubit>();
    if (state.selectedTable == null ||
        state.newOrderProduct == null ||
        state.selectedTable?.orders == null ||
        state.selectedTable?.orders.isEmpty == true) return;
    bool response = await context.read<OrderCubit>().cancelOrderProduct(
        cancelProductModel: CancelProduct(
            tableId: state.selectedTable!.id!,
            cancelNote: _noteController.text.isEmpty ? "String" : _noteController.text,
            products: [
              state.newOrderProduct!.copyWith(
                  cancelStatus: CancelStatus(
                cancelReason: cancelReason,
                isCancelled: true,
              ))
            ],
            cancelReason: cancelReason ?? ''),
        tableId: state.selectedTable!.id!);

    ResponseActionService.getTableAndNavigate(
        context: context,
        response: response,
        tableCubit: tableCubit,
        action: ButtonAction.cancelProduct);
  }
}
