import 'package:a_pos_flutter/product/widget/keyboard/custom_search_keyboard.dart';
import 'package:flutter/material.dart';

class CustomKeyboardManager {
  static final CustomKeyboardManager _instance = CustomKeyboardManager._internal();

  factory CustomKeyboardManager() {
    return _instance;
  }

  CustomKeyboardManager._internal();

  OverlayEntry? _overlayEntry;

  void showCustomKeyKeyboard(
    BuildContext context,
    TextEditingController controller,
    FocusNode focusNode, {
    double bottomPadding = 5,
    double keyboardWidth = 840,
  }) {
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: bottomPadding,
        left: (MediaQuery.of(context).size.width - keyboardWidth) / 2,
        right: (MediaQuery.of(context).size.width - keyboardWidth) / 2,
        child: CustomSearchKeyboard(
          onKeyPressed: (value) {
            _handleKeyPress(context, controller, focusNode, value);
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
    String value,
  ) {
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(focusNode);

    final oldSelection = controller.selection;

    if (value == "clear") {
      final currentOffset = oldSelection.baseOffset;
      if (currentOffset > 0) {
        controller.text = controller.text.substring(0, currentOffset - 1) +
            controller.text.substring(currentOffset);
        controller.selection = TextSelection.collapsed(offset: currentOffset - 1);
      }
    } else if (value == "close") {
      _removeOverlay();
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
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }
}
