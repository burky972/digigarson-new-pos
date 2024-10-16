import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/enums/customer_count/customer_count_type.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/global/model/customer_count/customer_count_model.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/keyboard/custom_keyboard.dart';
import 'package:a_pos_flutter/product/widget/pop_up/pop_up.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCustomerCountDialog {
  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<TableCubit, TableState>(
          builder: (context, state) {
            TableCubit tableCubit = context.read<TableCubit>();
            return AlertDialog(
              title: Center(
                child: const Text(LocaleKeys.editCustomerCount,
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
                    _CustomNumberKeyboardTextField(
                        controller: tableCubit.customerCountController, width: 290),
                    const SizedBox(height: 5),
                    Expanded(
                      child: Row(
                        children: [
                          InkWell(
                            child: _BottomColorButton(
                              text: LocaleKeys.save.toUpperCase(),
                              color: Colors.green,
                              onPressed: () async {
                                int customerCount =
                                    int.parse(tableCubit.customerCountController.text);
                                bool isEdited = await tableCubit.patchCustomerCount(
                                    CustomerCountType.save,
                                    CustomerCountModel(customerCount: customerCount));
                                if (isEdited) {
                                  showOrderSuccessDialog('Customer count updated successfully',
                                      secondClose: true);
                                } else {
                                  showErrorDialog('Customer count not updated!', secondClose: true);
                                }
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () => routeManager.pop(),
                            child: _BottomColorButton(
                              text: LocaleKeys.CANCEL,
                              color: Colors.red,
                              onPressed: () => routeManager.pop(),
                            ),
                          ),
                          InkWell(
                            child: _BottomColorButton(
                              text: LocaleKeys.resetCustomerCount,
                              color: Colors.orange,
                              onPressed: () async {
                                bool isEdited = await tableCubit.patchCustomerCount(
                                    CustomerCountType.reset, CustomerCountModel(customerCount: 0));
                                if (isEdited) {
                                  showOrderSuccessDialog('Customer count updated successfully',
                                      secondClose: true);
                                } else {
                                  showErrorDialog('Customer count not updated!', secondClose: true);
                                }
                              },
                            ),
                          ),
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

class _BottomColorButton extends StatelessWidget {
  const _BottomColorButton({
    required this.text,
    required this.color,
    required this.onPressed,
  });
  final String text;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const AppPadding.normalAll(),
      margin: const AppPadding.extraLowHorizontal(),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: CustomFontStyle.titlesTextStyle
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ).tr(),
      ),
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
