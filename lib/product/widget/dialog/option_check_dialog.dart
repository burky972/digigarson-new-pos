import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/cubit/product_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionCheckDialog extends StatelessWidget {
  const OptionCheckDialog({
    super.key,
    required this.product,
    required this.isForce,
    this.isExistProduct = false,
    required this.onUpdate,
  });

  final OrderProductModel product;
  final bool isForce;
  final bool isExistProduct;
  final Function(List<Options>, List<Item>) onUpdate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        OptionModel selectedProductOption = state.selectedOption ?? OptionModel.empty();

        return Dialog(
          child: SizedBox(
            width: context.dynamicWidth(0.75),
            height: context.dynamicHeight(0.9),
            child: ListView(
              children: [
                /// Top option title
                Container(
                  padding: const AppPadding.lowHorizontal(),
                  child: const Text(
                    'Option',
                    style: CustomFontStyle.formsTextStyle,
                  ),
                ),

                /// Option items, option groups table
                Padding(
                  padding: const AppPadding.minAll(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _OptionBoldTitleText(text: 'Option Choice'),
                      _OptionItemsGridView(
                        items: isForce ? selectedProductOption.items : state.selectedOption?.items,
                        isExistProduct: isExistProduct,
                      ),
                      SizedBox(height: context.dynamicHeight(0.02)),
                      const _OptionBoldTitleText(text: 'Option Groups'),
                      _OptionGroupGridView(
                        state,
                        isForce: product.isOptionForced,
                      ),
                    ],
                  ),
                ),

                /// bottom button fields
                Padding(
                  padding: const AppPadding.minAll(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LightBlueButton(
                        buttonText: 'Enter',
                        onTap: () {
                          if (state.selectedItems.isNotEmpty) {
                            final updatedOptions = [
                              Options(
                                optionId: selectedProductOption.id ?? '',
                                name: selectedProductOption.name ?? '',
                                selectedItems: state.selectedItems
                                    .map((item) =>
                                        item.copyWith(priceType: 'REGULAR', itemId: item.id))
                                    .toList(),
                                items: selectedProductOption.items!.isNotEmpty
                                    ? selectedProductOption.items!
                                        .map((item) =>
                                            item.copyWith(priceType: 'REGULAR', itemId: item.id))
                                        .toList()
                                    : [],
                              )
                            ];

                            onUpdate(updatedOptions, state.selectedItems);
                            context.read<ProductCubit>().resetSelectedItems();
                            routeManager.pop();
                          }
                        },
                      ),
                      LightBlueButton(
                        buttonText: 'Void',
                        onTap: () {},
                      ),
                      LightBlueButton(
                          buttonText: 'Close',
                          onTap: () {
                            context.read<ProductCubit>().resetSelectedItems();
                            routeManager.pop();
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OptionBoldTitleText extends StatelessWidget {
  const _OptionBoldTitleText({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: CustomFontStyle.titlesTextStyle
          .copyWith(fontSize: 24, color: context.colorScheme.tertiary),
    );
  }
}

class _OptionGroupGridView extends StatelessWidget {
  const _OptionGroupGridView(this.state, {required this.isForce});
  final ProductState state;
  final bool isForce;
  @override
  Widget build(BuildContext context) {
    List<OptionModel?> options = state.productOptionList;

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(border: Border.all()),
          height: context.dynamicHeight(0.35),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, // Sabit 7 sütun
              childAspectRatio: 90 / 40, // Genişlik/yükseklik oranı (90 genişlik, 40 yükseklik)
              crossAxisSpacing: 4, // Yatay boşluk
              mainAxisSpacing: 4, // Dikey boşluk
            ),
            itemCount: isForce ? options.length : state.allOptions.length,
            itemBuilder: (context, index) {
              return _OptionsCardWidget(
                text: isForce ? options[index]?.name : state.allOptions[index]?.name,
                isSelected: isForce
                    ? options[index]?.id == state.selectedOption?.id
                    : state.allOptions[index] == state.selectedOption,
                onTapped: () => isForce //TODO: CHECK HERE
                    ? context.read<ProductCubit>().setSelectedOption(options[index]!)
                    : context.read<ProductCubit>().setSelectedOption(state.allOptions[index]!),
              );
            },
          ),
        );
      },
    );
  }
}

/// Builds a GridView of options cards with a fixed cross-axis count.
class _OptionItemsGridView extends StatelessWidget {
  const _OptionItemsGridView({
    required this.items,
    required this.isExistProduct,
  });

  final List<Item>? items;
  final bool isExistProduct;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          decoration: BoxDecoration(border: Border.all()),
          height: context.dynamicHeight(0.35),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 90 / 40,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: items?.length ?? 0,
                  itemBuilder: (context, index) {
                    return BlocBuilder<ProductCubit, ProductState>(
                      builder: (context, state) {
                        final isSelected =
                            state.selectedItems.map((item) => item.id).contains(items![index].id);
                        return _OptionsCardWidget(
                          text: items?[index].itemName.toString(),
                          onTapped: () {
                            context.read<ProductCubit>().toggleItem(items![index]);
                          },
                          isSelected: isSelected,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OptionsCardWidget extends StatelessWidget {
  const _OptionsCardWidget({
    required this.text,
    required this.onTapped,
    required this.isSelected,
  });

  final String? text;
  final VoidCallback onTapped;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: isSelected ? context.colorScheme.primary : Colors.white,
      child: InkWell(
        onTap: onTapped,
        child: Center(
          child: Padding(
            padding: const AppPadding.extraMinAll(),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text ?? '',
                textAlign: TextAlign.center,
                style: CustomFontStyle.buttonTextStyle.copyWith(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
