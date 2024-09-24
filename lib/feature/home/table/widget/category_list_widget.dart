import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/model/category_model.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({super.key});

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoryList = context.read<CategoryCubit>().getSubCategories;
    CategoryCubit categoryCubit = context.read<CategoryCubit>();
    return BlocBuilder<CategoryCubit, CategoryState>(
        builder: ((context, state) => state.states == CategoryStates.loading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                  border: BorderConstants.borderAllSmall,
                ),
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 1,
                    childAspectRatio: 130 / 50,
                  ),
                  itemCount: categoryCubit.getSubCategories.length + 1,
                  itemBuilder: (context, index) {
                    return index == 0
                        ? InkWell(
                            onTap: () {
                              categoryCubit.setSelectedSubCategory(null);
                              _scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: _TableCategorySubWidget(
                              text: LocaleKeys.VIEW_ALL.tr(),
                              color: state.selectedSubCategory != null
                                  ? Colors.white
                                  : Colors.amberAccent,
                            ))
                        : InkWell(
                            onTap: () =>
                                categoryCubit.setSelectedSubCategory(categoryList[index - 1]),
                            child: _TableCategorySubWidget(
                              text: categoryList[index - 1].title ?? '',
                              color: colorSelected(state, categoryList[index - 1].id ?? ''),
                            ));
                  },
                ),
              )));
  }

  colorSelected(CategoryState state, String sId) {
    if (state.selectedSubCategory != null) {
      if (state.selectedSubCategory!.id == sId) {
        return Colors.amberAccent;
      }
    }
    if (state.category != null) {
      if (state.category!.id == sId) {
        return Colors.white;
      }
    }
    return Colors.white;
  }
}

class _TableCategorySubWidget extends StatelessWidget {
  const _TableCategorySubWidget({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          border: BorderConstants.borderAllSmall),
      child: Container(
        padding: const EdgeInsets.only(left: 2, right: 2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: BorderConstants.borderAllSmall,
        ),
        child: Center(
          child: Text(text,
              textAlign: TextAlign.center,
              style: CustomFontStyle.buttonTextStyle.copyWith(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
