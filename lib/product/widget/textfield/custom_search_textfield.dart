import 'package:a_pos_flutter/feature/home/branch/cubit/branch_cubit.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/widget/keyboard/custom_search_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchTextfield extends StatelessWidget {
  const CustomSearchTextfield({
    super.key,
    required this.isSuffixIcon,
    required this.searchController,
    required this.onChanged,
    required this.onClearClicked,
  });
  final bool isSuffixIcon;
  final TextEditingController searchController;
  final void Function(String)? onChanged;
  final VoidCallback onClearClicked;
  @override
  Widget build(BuildContext context) {
    OverlayEntry? overlayEntry;
    final FocusNode topNode = FocusNode();

    void toggleFullScreen() {
      if (overlayEntry != null) {
        overlayEntry?.remove();
        overlayEntry = null;
      }
    }

    void showCustomKeyKeyboard(
        BuildContext context, TextEditingController controller, FocusNode focusNode) {
      if (overlayEntry != null) {
        overlayEntry?.remove();
        overlayEntry = null;
      }
      overlayEntry = OverlayEntry(
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
              context.read<BranchCubit>().setFilter(controller.text);
            },
          ),
        ),
      );
      Overlay.of(context).insert(overlayEntry!);
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        onTap: () {
          showCustomKeyKeyboard(context, searchController, topNode);
        },
        focusNode: topNode,
        keyboardType: TextInputType.none,
        controller: searchController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          hintText: 'Search...',
          suffixIcon:
              // state.filter.isNotEmpty
              isSuffixIcon
                  ? IconButton(icon: const Icon(Icons.clear), onPressed: onClearClicked)
                  : IconButton(
                      icon: Icon(
                        Icons.search,
                        color: context.colorScheme.primary,
                      ),
                      onPressed: null,
                    ),
        ),
      ),
    );
  }
}
