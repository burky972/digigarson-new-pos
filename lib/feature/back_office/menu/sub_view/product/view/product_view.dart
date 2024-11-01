import 'dart:convert';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/model/category_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/cubit/product_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/model/product_model.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:a_pos_flutter/product/widget/cached_network_image/cached_network_image.dart';
import 'package:a_pos_flutter/product/widget/table_cell/table_cell_widget.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_border_all_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
part '../widget/bottom_button_fields.dart';
part '../widget/product_sub_view.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const AppPadding.minAll(),
        child: Column(
          children: [
            SizedBox(
              height: context.dynamicHeight(0.8),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Categories List
                  _CategoryListWidget(),
                  Expanded(
                    child: _MiddleProductTableWidget(),
                  )
                ],
              ),
            ),
            const Spacer(),
            const _BottomButtonFields(),
          ],
        ));
  }
}

class _TableCellTextWidget extends StatelessWidget {
  const _TableCellTextWidget({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const AppPadding.minAll(),
      child: Center(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _MiddleTableCellTextWidget extends StatelessWidget {
  const _MiddleTableCellTextWidget({required this.text, required this.product});
  final String text;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return MiddleTableCellTextWidget(
      text: text,
      onTap: () => context
          .read<ProductCubit>()
          .setSelectedProduct(product, product.prices?.first ?? const PriceModel()),
    );
  }
}

class _TableCellTitleWidget extends StatelessWidget {
  const _TableCellTitleWidget({
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}
