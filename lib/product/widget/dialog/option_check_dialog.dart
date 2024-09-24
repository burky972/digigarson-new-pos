import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/cubit/option_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/cubit/option_state.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionCheckDialog extends StatelessWidget {
  const OptionCheckDialog({super.key, required this.product});

  final OrderProductModel product;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionCubit, OptionState>(
      builder: (context, state) {
        return Dialog(
          child: SizedBox(
            height: context.height,
            width: context.dynamicWidth(0.75),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        items: state.selectedOption?.items,
                        options: [
                          Options(
                              optionId: state.selectedOption?.id ?? '',
                              name: state.selectedOption?.name ?? '',
                              items: [])
                        ],
                        product: product,
                      ),
                      SizedBox(height: context.dynamicHeight(0.02)),
                      const _OptionBoldTitleText(text: 'Option Groups'),
                      const _OptionGroupGridView(),
                    ],
                  ),
                ),
                const Spacer(),

                /// bottom button fields
                Padding(
                  padding: const AppPadding.minAll(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const LightBlueButton(buttonText: 'Enter'),
                      const LightBlueButton(buttonText: 'Void'),
                      LightBlueButton(buttonText: 'Close', onTap: () => Navigator.pop(context)),
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
  const _OptionGroupGridView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionCubit, OptionState>(
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
            itemCount: state.allOptions.length,
            itemBuilder: (context, index) {
              return _OptionsCardWidget(
                text: state.allOptions[index]?.name,
                isSelected: state.allOptions[index] == state.selectedOption,
                onTapped: () =>
                    context.read<OptionCubit>().setSelectedOption(state.allOptions[index]!),
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
  const _OptionItemsGridView({required this.items, required this.options, required this.product});
  final List<Item>? items;
  final List<Options> options;
  final OrderProductModel product; //! cHECK THIS TOO

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      height: context.dynamicHeight(0.35),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 90 / 40,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: items?.length ?? 0,
        itemBuilder: (context, index) {
          return BlocBuilder<TableCubit, TableState>(
            builder: (context, state) {
              return _OptionsCardWidget(
                text: items?[index].itemName.toString(),
                onTapped: () {
                  appLogger.warning('item', 'on Tapped');
                  Item item =
                      items![index].copyWith(priceType: 'REGULAR', itemId: items![index].id);

                  // Set the selected item
                  context.read<OptionCubit>().setSelectedItem(item);

                  // Flag to check if item is already added in the current options
                  bool isExistInCurrentOptions = false;

                  // Iterate through the new products to check if the item already exists in any of the options
                  for (var products in state.newProducts.products) {
                    for (var option in products.options) {
                      for (var existingItem in option.items) {
                        if (existingItem.id == item.id &&
                            product.productName == products.productName) {
                          appLogger.warning('item', 'already exist-> ${item.itemName}');
                          isExistInCurrentOptions = true;
                          break;
                        }
                      }
                      if (isExistInCurrentOptions) {
                        break;
                      }
                    }
                    if (isExistInCurrentOptions) {
                      break;
                    }
                  }

                  // If item is not in the current options, add it
                  if (!isExistInCurrentOptions) {
                    context
                        .read<TableCubit>()
                        .updateNewOrderProducts(product, product.uniqueTimestamp!, [
                      ...options,
                      options.first.copyWith(items: [...options.first.items, item])
                    ]);
                    Navigator.pop(context);
                  }

                  // appLogger.warning('item', 'on Tapped');
                  // Item item =
                  //     items![index].copyWith(priceType: 'REGULAR', itemId: items![index].id);
                  // context.read<OptionCubit>().setSelectedItem(item);
                  // bool isExist = false;
                  // for (var product in state.newProducts.products) {
                  //   for (var option in product.options) {
                  //     for (var x in option.items) {
                  //       if (x.id == item.id) {
                  //         isExist = true;
                  //         break;
                  //       }
                  //     }
                  //     if (isExist) {
                  //       break;
                  //     }
                  //   }
                  // }

                  // /// if item already added don't add it again!!
                  // if (!isExist) {
                  //   context
                  //       .read<TableCubit>()
                  //       .updateNewOrderProducts(product, product.uniqueTimestamp!, [
                  //     options.first.copyWith(items: [item])
                  //   ]);
                  //   Navigator.pop(context);
                  // }
                },
              );
            },
          );
        },
      ),
    );
  }
}

/// Builds a card widget with a centered text,
class _OptionsCardWidget extends StatelessWidget {
  const _OptionsCardWidget({required this.text, required this.onTapped, this.isSelected = false});
  final String? text;
  final VoidCallback onTapped;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: isSelected ? context.colorScheme.primary : Colors.white,
      child: SizedBox(
        width: 90,
        height: 40,
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
                  style: CustomFontStyle.buttonTextStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
