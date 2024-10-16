import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/model/special_item_request_model.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
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

enum _SelectedNode {
  quantity,
  price,
}

class SpecialItemDialog {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  OverlayEntry? _overlayEntry;
  final FocusNode _titleNode = FocusNode();
  final FocusNode _priceNode = FocusNode();
  final FocusNode _quantityNode = FocusNode();
  late _SelectedNode _selectedNode = _SelectedNode.price;

  FocusNode get selectedNode =>
      _selectedNode == _SelectedNode.quantity ? _quantityNode : _priceNode;

  TextEditingController get selectedController =>
      _selectedNode == _SelectedNode.quantity ? _quantityController : _priceController;

  void setSelectedNode(node) {
    _selectedNode = node;
    selectedNode.requestFocus();
  }

  void toggleFullScreen() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  void show(BuildContext context, {int? index}) {
    _quantityController.text = 1.toString();
    showDialog(
      context: context,
      barrierDismissible: true, //! make this false later on!
      builder: (BuildContext context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _titleController.selection = TextSelection.fromPosition(
            TextPosition(offset: _titleController.text.length),
          );
          selectedController.selection = TextSelection.fromPosition(
            TextPosition(offset: selectedController.text.length),
          );
        });

        return BlocBuilder<TableCubit, TableState>(
          builder: (context, state) {
            return StatefulBuilder(builder: (context, setState) {
              bool isFullScreen = context.width > 1400;
              return AlertDialog(
                title: Text(
                  LocaleKeys.specialItem.tr(),
                  style: CustomFontStyle.formsTextStyle.copyWith(fontSize: 14),
                ),
                content: SizedBox(
                    width: context.dynamicWidth(.9),
                    height: context.dynamicHeight(.7),
                    child: ListView(
                      children: [
                        /// TOP INPUT FIELD
                        Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _BoldTitleWidget(title: LocaleKeys.itemName.tr()),

                                  /// Item name text field
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        border: BorderConstants.borderAllSmall),
                                    child: TextField(
                                      onTap: () {},
                                      controller: _titleController,
                                      focusNode: _titleNode,
                                      keyboardType: TextInputType.none,
                                      decoration: InputDecoration(
                                          hintText: '${LocaleKeys.itemName.tr()}...',
                                          contentPadding: const AppPadding.minAll()),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: context.dynamicWidth(.01)),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  _BoldTitleWidget(title: LocaleKeys.qty.tr()),

                                  /// Quantity text field
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        border: BorderConstants.borderAllSmall),
                                    child: TextField(
                                      onTap: () {
                                        setState(() {
                                          setSelectedNode(_SelectedNode.quantity);
                                        });
                                      },
                                      controller: _quantityController,
                                      focusNode: _quantityNode,
                                      keyboardType: TextInputType.none,
                                      decoration: InputDecoration(
                                          hintText: LocaleKeys.qty.tr(),
                                          contentPadding: const AppPadding.minAll()),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: context.dynamicWidth(.01)),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  _BoldTitleWidget(title: LocaleKeys.price.tr()),

                                  /// Price text field
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        border: BorderConstants.borderAllSmall),
                                    child: TextField(
                                      onTap: () {
                                        setState(() {
                                          setSelectedNode(_SelectedNode.price);
                                        });
                                      },
                                      controller: _priceController,
                                      focusNode: _priceNode,
                                      keyboardType: TextInputType.none,
                                      decoration: InputDecoration(
                                          hintText: LocaleKeys.price.tr(),
                                          contentPadding: const AppPadding.minAll()),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        /// CENTER KEYBOARDS  FIELD
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Item name keyboard
                            Expanded(
                              flex: isFullScreen ? 8 : 7,
                              child: _ItemKeyboardWidget(
                                  titleController: _titleController, titleNode: _titleNode),
                            ),

                            /// Item quantity - price number keyboard
                            Expanded(
                              flex: isFullScreen ? 3 : 2,
                              child: Container(
                                color: context.colorScheme.primary,
                                padding: const AppPadding.minAll(),
                                child: _ItemQtyPriceNumberKeyboard(
                                  selectedController: selectedController,
                                  selectedNode: selectedNode,
                                ),
                              ),
                            ),
                            isFullScreen
                                ? SizedBox(width: context.dynamicWidth(.01))
                                : const SizedBox.shrink(),
                          ],
                        ),
                        SizedBox(height: context.dynamicHeight(.02)),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: _BoldTitleWidget(
                                  title: LocaleKeys.printers.tr(),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                height: context.dynamicHeight(.2),
                                padding: const AppPadding.minAll().copyWith(top: 16),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Checkbox(
                                              value: false,
                                              onChanged: (value) {
                                                setState(() {});
                                              },
                                            ),
                                            Text(LocaleKeys.hot.tr()),
                                          ],
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Checkbox(
                                              value: false,
                                              onChanged: (value) {
                                                setState(() {});
                                              },
                                            ),
                                            Text(LocaleKeys.kitchen.tr()),
                                          ],
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Checkbox(
                                              value: false,
                                              onChanged: (value) {
                                                setState(() {});
                                              },
                                            ),
                                            Text(LocaleKeys.receipt.tr()),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                actions: [
                  /// save - close buttons
                  LightBlueButton(
                    buttonText: LocaleKeys.save.tr(),
                    onTap: () async => _handleCreateSpecialItem(context),
                  ),
                  LightBlueButton(
                      buttonText: LocaleKeys.close.tr(), onTap: () => routeManager.pop()),
                ],
              );
            });
          },
        );
      },
    );
  }

  Future<void> _handleCreateSpecialItem(BuildContext context) async {
    if (_titleController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _priceController.text.isEmpty) return;
    final priceModel = PriceModel(
      amount: 1.0,
      vatRate: 0.0,
      priceName: 'REGULAR',
      priceType: 'REGULAR',
      currency: 'USD',
      orderType: const [],
      price: double.tryParse(_priceController.text),
    );

    final response = await context.read<TableCubit>().createSpecialItem(
          specialItemModel: SpecialItemRequestModel(
            prices: [priceModel],
            title: _titleController.text,
            activeList: const [1],
            isSpecial: true,
          ),
          repeatIndex: int.tryParse(_quantityController.text) ?? 1,
        );

    if (response) {
      showOrderSuccessDialog('Special item created successfully', secondClose: true);
    } else {
      showErrorDialog('Special item not created');
    }
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

/// Item name keyboard widget
class _ItemKeyboardWidget extends StatelessWidget {
  const _ItemKeyboardWidget({
    required TextEditingController titleController,
    required FocusNode titleNode,
  })  : _titleController = titleController,
        _titleNode = titleNode;
  final TextEditingController _titleController;
  final FocusNode _titleNode;

  @override
  Widget build(BuildContext context) {
    return CustomSearchKeyboard(
      onKeyPressed: (value) {
        FocusScope.of(context).unfocus();
        FocusScope.of(context).requestFocus(_titleNode);
        final oldSelection = _titleController.selection;
        TextSelection selection = _titleController.selection;
        if (selection.baseOffset < 0 || selection.extentOffset > _titleController.text.length) {
          selection = TextSelection.collapsed(offset: _titleController.text.length);
        }
        if (value.toString() == "clear") {
          final currentOffset = oldSelection.baseOffset;
          if (currentOffset > 0) {
            _titleController.text = _titleController.text.substring(0, currentOffset - 1) +
                _titleController.text.substring(currentOffset);
            _titleController.selection = TextSelection.collapsed(offset: currentOffset - 1);
          }
        } else if (value.toString() == "close") {
          _titleController.text = "";
          _titleController.selection = const TextSelection.collapsed(offset: 0);
        } else {
          _titleController.text = _titleController.text.replaceRange(
            oldSelection.start,
            oldSelection.end,
            value,
          );
          _titleController.selection = TextSelection.collapsed(
            offset: oldSelection.baseOffset + value.length,
          );
        }
      },
    );
  }
}

/// Item quantity - price keyboard widget
class _ItemQtyPriceNumberKeyboard extends StatelessWidget {
  const _ItemQtyPriceNumberKeyboard({required this.selectedController, required this.selectedNode});
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
