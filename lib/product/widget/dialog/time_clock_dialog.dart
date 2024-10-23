import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/keyboard/custom_keyboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TimeClockDialog {
  final TextEditingController _swipeController = TextEditingController();
  OverlayEntry? _overlayEntry;
  final FocusNode _swipeNode = FocusNode();

  void setSelectedNode(node) {
    _swipeNode.requestFocus();
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
      barrierDismissible: true, //! make this false later on!
      builder: (BuildContext context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _swipeController.selection = TextSelection.fromPosition(
            TextPosition(offset: _swipeController.text.length),
          );
        });
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(
              LocaleKeys.timeClock.tr(),
              style: CustomFontStyle.formsTextStyle.copyWith(fontSize: 14),
            ),
            content: SizedBox(
                width: context.dynamicWidth(.2),
                height: context.dynamicHeight(.4),
                child: ListView(
                  children: [
                    /// TOP INPUT FIELD
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _BoldTitleWidget(title: LocaleKeys.swipeCard.tr()),
                        SizedBox(height: context.dynamicHeight(0.01)),

                        /// Swipe text field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: BorderConstants.borderAllSmall,
                          ),
                          child: TextField(
                            controller: _swipeController,
                            focusNode: _swipeNode,
                            obscureText: true,
                            keyboardType: TextInputType.none,
                            decoration: const InputDecoration(
                              contentPadding: AppPadding.minAll(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: context.dynamicHeight(0.02)),

                    /// Swipe number keyboard
                    Container(
                      color: context.colorScheme.primary,
                      padding: const AppPadding.minAll(),
                      child: _SwipeNumberKeyboard(
                        selectedController: _swipeController,
                        selectedNode: _swipeNode,
                      ),
                    ),
                  ],
                )),
            actions: [
              /// Buttons(time in, time out, exit)
              LightBlueButton(
                buttonText: LocaleKeys.timeIn.tr(),
                onTap: () {
                  appLogger.info('_swipeController: ', _swipeController.text.toString());
                },
              ),
              LightBlueButton(
                buttonText: LocaleKeys.timeOut.tr(),
                onTap: () {},
              ),
              LightBlueButton(
                buttonText: LocaleKeys.exit.tr(),
                onTap: () => routeManager.pop(),
              ),
            ],
          );
        });
      },
    );
  }
}

class _BoldTitleWidget extends StatelessWidget {
  const _BoldTitleWidget({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: CustomFontStyle.titlesTextStyle
          .copyWith(color: context.colorScheme.tertiary, fontWeight: FontWeight.bold, fontSize: 24),
    );
  }
}

/// Swipe number keyboard widget
class _SwipeNumberKeyboard extends StatelessWidget {
  const _SwipeNumberKeyboard({required this.selectedController, required this.selectedNode});
  final TextEditingController selectedController;
  final FocusNode selectedNode;

  @override
  Widget build(BuildContext context) {
    return CustomNumberKeyboard(
      onKeyPressed: (String value) {
        FocusScope.of(context).unfocus();
        FocusScope.of(context).requestFocus(selectedNode);
        final oldSelection = selectedController.selection;
        TextSelection selection = selectedController.selection;
        if (selection.baseOffset < 0 || selection.extentOffset > selectedController.text.length) {
          selection = TextSelection.collapsed(offset: selectedController.text.length);
        }
        if (value.toString() == "clear") {
          final currentOffset = oldSelection.baseOffset;
          if (currentOffset > 0) {
            selectedController.text = selectedController.text.substring(0, currentOffset - 1) +
                selectedController.text.substring(currentOffset);
            selectedController.selection = TextSelection.collapsed(offset: currentOffset - 1);
          }
        } else if (value.toString() == "allClear") {
          selectedController.text = "";
          selectedController.selection = const TextSelection.collapsed(offset: 0);
        } else {
          selectedController.text = selectedController.text.replaceRange(
            oldSelection.start,
            oldSelection.end,
            value,
          );
          selectedController.selection = TextSelection.collapsed(
            offset: oldSelection.baseOffset + value.length,
          );
        }
      },
      onClose: () {},
    );
  }
}
