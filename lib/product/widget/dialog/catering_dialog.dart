import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/global/model/catering/catering_cancel_model.dart';
import 'package:a_pos_flutter/product/global/model/catering/catering_model.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/keyboard/custom_keyboard.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CateringDialog {
  void show(BuildContext context, [bool isCancel = false]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<TableCubit, TableState>(
          builder: (context, state) {
            return AlertDialog(
              title: Center(
                child: Text(isCancel ? 'Cancel Catering' : LocaleKeys.catering,
                        style: CustomFontStyle.popupNotificationTextStyle)
                    .tr(),
              ),
              content: Container(
                width: context.dynamicWidth(.3),
                height: context.dynamicHeight(.15),
                constraints: BoxConstraints(
                  minWidth: 320,
                  maxWidth: 750,
                  maxHeight: context.dynamicHeight(.3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LightBlueButton(
                              buttonText: LocaleKeys.save.tr().toUpperCase(),
                              onTap: () async {
                                if (isCancel) {
                                  bool isCancelCatering =
                                      await context.read<TableCubit>().cancelCatering(
                                              cateringCancelModel: CateringCancelModel(
                                            id: state.newOrderProduct!.id!,
                                            tableId: state.selectedTable!.id!,
                                          ));
                                  if (isCancelCatering) {
                                    showOrderSuccessDialog(context, LocaleKeys.cancelCatering.tr(),
                                        secondClose: true);
                                  } else {
                                    showErrorDialog(context, 'Please try again!',
                                        secondClose: true);
                                  }
                                } else {
                                  bool isCatered = await context.read<TableCubit>().postCatering(
                                          cateringModel: CateringModel(
                                        tableId: state.selectedTable!.id,
                                        serveId: '66e7fc768374d00a472ab58a',
                                        productId: state.newOrderProduct?.id!,
                                        orderNum: state.selectedTable?.orders.first.orderNum,
                                        quantity: 1,
                                      ));

                                  if (isCatered) {
                                    showOrderSuccessDialog(context, LocaleKeys.addedCatering.tr(),
                                        secondClose: true);
                                  } else {
                                    showErrorDialog(context, 'Please try again!',
                                        secondClose: true);
                                  }
                                }
                              }),
                          LightBlueButton(
                            buttonText: LocaleKeys.CANCEL.tr().toUpperCase(),
                            onTap: () => routeManager.pop(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _CustomNumberKeyboardTextField extends StatefulWidget {
  const _CustomNumberKeyboardTextField({
    required this.controller,
    required this.width,
  });
  final TextEditingController controller;
  final double width;

  @override
  State<_CustomNumberKeyboardTextField> createState() => __CustomNumberKeyboardTextFieldState();
}

class __CustomNumberKeyboardTextFieldState extends State<_CustomNumberKeyboardTextField> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: widget.controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        onTap: () {
          _showKeyboard(context);
        },
      ),
    );
  }

  void _showKeyboard(BuildContext context) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }

    _overlayEntry = _createOverlayEntry();

    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: widget.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            child: CustomNumberKeyboard(
              height: 320,
              width: widget.width,
              onKeyPressed: (String value) {
                if (value == 'clear') {
                  if (widget.controller.text.isNotEmpty) {
                    widget.controller.text =
                        widget.controller.text.substring(0, widget.controller.text.length - 1);
                  }
                } else if (value == 'allClear') {
                  widget.controller.clear();
                } else {
                  widget.controller.text += value;
                }
                widget.controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: widget.controller.text.length),
                );
              },
              onClose: () {
                _overlayEntry?.remove();
                _overlayEntry = null;
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }
    super.dispose();
  }
}
