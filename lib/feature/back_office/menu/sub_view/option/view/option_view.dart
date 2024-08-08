import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/cubit/option_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/cubit/option_state.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_border_all_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

part '../widget/bottom_button_fields.dart';
part '../widget/option_sub_view.dart';

class OptionsView extends StatefulWidget {
  const OptionsView({
    super.key,
  });

  @override
  State<OptionsView> createState() => _MenuOptionsViewState();
}

class _MenuOptionsViewState extends State<OptionsView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<OptionCubit>().getOptions();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<OptionCubit, OptionState>(
      builder: (context, state) {
        OptionCubit optionCubit = context.read<OptionCubit>();
        bool isItemReadOnly = optionCubit.state.selectedOption?.items == null ||
            optionCubit.state.selectedOption!.items!.isEmpty;
        return Padding(
          padding: const AppPadding.largeAll(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Left Side Table Option Group List
              const _LeftSideOptionGroupTable(),
              SizedBox(width: context.dynamicWidth(0.005)),
              SizedBox(
                width: context.dynamicWidth(0.7),
                child: Column(
                  children: [
                    /// Middle Options Table
                    const Expanded(flex: 5, child: _MiddleOptionsTable()),
                    const Spacer(),

                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Option Details',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    const Expanded(
                                                        flex: 1, child: Text('Option Group')),
                                                    Expanded(
                                                      flex: 2,
                                                      child: CustomBorderAllTextfield(
                                                        isReadOnly: true,
                                                        controller:
                                                            optionCubit.optionNameController,
                                                        onChanged: (value) {},
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    const Expanded(
                                                        flex: 1, child: Text('Option Name')),
                                                    Expanded(
                                                      flex: 2,
                                                      child: CustomBorderAllTextfield(
                                                        isReadOnly: isItemReadOnly,
                                                        controller: optionCubit.itemNameController,
                                                        onChanged: (value) =>
                                                            optionCubit.updateSelectedItemValue(
                                                                UpdatedItemValue.itemName, value),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    const Expanded(
                                                        flex: 1, child: Text('Description')),
                                                    Expanded(
                                                      flex: 2,
                                                      child: CustomBorderAllTextfield(
                                                        isReadOnly: isItemReadOnly,
                                                        controller:
                                                            optionCubit.optionDescController,
                                                        onChanged: (value) {},
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    const Expanded(flex: 1, child: Text('Price')),
                                                    Expanded(
                                                      flex: 2,
                                                      child: CustomBorderAllTextfield(
                                                        isReadOnly: isItemReadOnly,
                                                        controller: optionCubit.itemPriceController,
                                                        onChanged: (value) {
                                                          optionCubit.updateSelectedItemValue(
                                                              UpdatedItemValue.itemPrice, value);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    const Expanded(
                                                        flex: 1, child: Text('Lunch Price')),
                                                    Expanded(
                                                      flex: 2,
                                                      child: CustomBorderAllTextfield(
                                                        isReadOnly: isItemReadOnly,
                                                        controller:
                                                            optionCubit.itemLPriceController,
                                                        onChanged: (value) {
                                                          optionCubit.updateSelectedItemValue(
                                                              UpdatedItemValue.itemLPrice, value);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: [
                                                Flexible(
                                                  child: Row(
                                                    children: [
                                                      const Expanded(
                                                          flex: 1, child: Text('HappyHour Price')),
                                                      Expanded(
                                                        flex: 2,
                                                        child: CustomBorderAllTextfield(
                                                          isReadOnly: isItemReadOnly,
                                                          controller:
                                                              optionCubit.itemHPriceController,
                                                          onChanged: (value) =>
                                                              optionCubit.updateSelectedItemValue(
                                                                  UpdatedItemValue.itemHPrice,
                                                                  value),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Row(
                                                    children: [
                                                      const Expanded(
                                                          flex: 1, child: Text('Delivery Price')),
                                                      Expanded(
                                                        flex: 2,
                                                        child: CustomBorderAllTextfield(
                                                          isReadOnly: isItemReadOnly,
                                                          controller:
                                                              optionCubit.itemDPriceController,
                                                          onChanged: (value) =>
                                                              optionCubit.updateSelectedItemValue(
                                                                  UpdatedItemValue.itemDPrice,
                                                                  value),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Row(
                                                    children: [
                                                      const Expanded(
                                                          flex: 1, child: Text('TakeOut Price')),
                                                      Expanded(
                                                        flex: 2,
                                                        child: CustomBorderAllTextfield(
                                                          isReadOnly: isItemReadOnly,
                                                          controller:
                                                              optionCubit.itemTPriceController,
                                                          onChanged: (value) =>
                                                              optionCubit.updateSelectedItemValue(
                                                                  UpdatedItemValue.itemTPrice,
                                                                  value),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Row(
                                                    children: [
                                                      const Expanded(
                                                        flex: 1,
                                                        child: Text('Tax% '),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: CustomBorderAllTextfield(
                                                          isReadOnly: isItemReadOnly,
                                                          // controller: _taxController,
                                                          controller: TextEditingController(),
                                                          onChanged: (value) {},
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    // setState(() {
                                                    //   selectedColor = null;
                                                    // });
                                                  },
                                                  child: Container(
                                                    width: context.dynamicHeight(0.1),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.grey)),
                                                    // child: selectedColor != null
                                                    //     ? ColoredBox(color: selectedColor!)
                                                    //     : null,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                        onTap: () {},
                                                        child: const LightBlueButton(
                                                          buttonText: 'Browse',
                                                        )),
                                                    InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return AlertDialog(
                                                                title: const Text('Bir renk seçin'),
                                                                content: SingleChildScrollView(
                                                                  child: ColorPicker(
                                                                    pickerColor: Colors.white,
                                                                    onColorChanged: (value) {
                                                                      // setState(() {

                                                                      //   selectedColor = value;
                                                                      //   debugPrint(selectedColor
                                                                      //       .toString());
                                                                      // });
                                                                    },
                                                                    pickerAreaHeightPercent: 0.8,
                                                                  ),
                                                                ),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                    child: const Text('Tamam'),
                                                                    onPressed: () {
                                                                      Navigator.of(context).pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: const LightBlueButton(
                                                            buttonText: 'Color')),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),

                    /// Bottom buttons
                    const Expanded(
                      flex: 1,
                      child: _BottomButtonFields(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TableCellTextWidget extends StatelessWidget {
  const _TableCellTextWidget({required this.item, required this.text});
  final Item item;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: GestureDetector(
        onTap: () => context.read<OptionCubit>().setSelectedItem(item),
        child: Padding(
          padding: const AppPadding.minAll(),
          child: Center(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
