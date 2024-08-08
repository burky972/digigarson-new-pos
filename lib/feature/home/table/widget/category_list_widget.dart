import 'package:a_pos_flutter/feature/home/branch/cubit/branch_cubit.dart';
import 'package:a_pos_flutter/feature/home/branch/cubit/branch_state.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/model/category_model.dart';
import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/global/model/branch/branch_model.dart';
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

  // categoryLength(String categoryId, String filter, List<CategoriesModel> listCategory) {
  //   categoryList.clear();
  //   categoryList.add(CategoriesModel(
  //     sId: '',
  //     isSubCategory: false,
  //     image: '',
  //     title: '',
  //     branch: '',
  //     parentCategory: '',
  //     subCategory: [],
  //   ));
  //   for (var category in listCategory) {
  //     categoryList.add(category);
  //   }
  //   return categoryList.length;
  // }

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoryList = context.read<CategoryCubit>().getAllCategories;
    return BlocBuilder<BranchCubit, BranchState>(
        builder: ((context, state) => state.states == BranchStates.loading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
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
                  itemCount:
                      context.read<CategoryCubit>().getAllCategories.length, //  categoryLength(
                  //     state.selectedCategory != null ? state.selectedCategory!.sId : "",
                  //     state.filter.toString(),
                  //     state.branchModel != null ? state.branchModel!.categories! : []),
                  itemBuilder: (context, index) {
                    return index == 0
                        ? InkWell(
                            onTap: () {
                              context.read<BranchCubit>().setCategorySelected(null);
                              context.read<BranchCubit>().setMainCategorySelected(null);
                              context.read<BranchCubit>().setSubCategorySelected(null);
                              _scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: _TableCategorySubWidget(
                              text: LocaleKeys.VIEW_ALL.tr(),
                              color: state.selectedCategory != null
                                  ? Colors.white
                                  : Colors.amberAccent,
                            ))
                        : InkWell(
                            onTap: () {
                              // context.read<BranchCubit>().setCategorySelected(categoryList[index]);
                              // if (!categoryList[index].isSubCategory) {
                              //   //TODO: this
                              //   // state.branchModel!.categories.clear();
                              //   context
                              //       .read<BranchCubit>()
                              //       .setMainCategorySelected(categoryList[index]);
                              //   context.read<BranchCubit>().setSubCategorySelected(null);
                              //   for (var category in state.mainCategoryList) {
                              //     //TODO: this

                              //     // state.branchModel!.categories.add(category);
                              //     if (category.sId == categoryList[index].sId) {
                              //       //TODO: this
                              //       // for (var sub in category.subCategory) {

                              //       // state.branchModel!.categories.add(sub);
                              //       // }
                              //     }
                              //   }
                              // } else {
                              //   if (categoryList[index].subCategory.isNotEmpty) {
                              //     state.branchModel!.categories!.clear();
                              //     context
                              //         .read<BranchCubit>()
                              //         .setSubCategorySelected(categoryList[index]);
                              //     //TODO: this
                              //     // for (var category in state.mainCategoryList) {
                              //     //   state.branchModel!.categories.add(category);
                              //     //   if (category.sId == state.mainCategory!.sId) {
                              //     //     state.branchModel!.categories.add(state.subCategory!);
                              //     //     for (var sub in state.subCategory!.subCategory) {
                              //     //       state.branchModel!.categories.add(sub);
                              //     //     }
                              //     //   }
                              //     // }
                              //   } else {
                              //     //TODO: this
                              //     // if (myBranchProvider.SubCategory != null) {
                              //     //   myBranchProvider.SubCategory ==
                              //     //           categoryList[index].parentCategory
                              //     //       ? context
                              //     //           .read<BranchCubit>()
                              //     //           .setSubCategorySelected(null)
                              //     //       : null;
                              //     // }
                              //   }
                              // }
                              // //TODO: this
                              // // categoryList[index].subCategory.isNotEmpty
                              // //     ? _scrollController.animateTo(
                              // //         state.branchModel!.categories!.indexWhere((element) =>
                              // //                 element.sId == myBranchProvider.Category!.sId) *
                              // //             0.1,
                              // //         duration: const Duration(milliseconds: 500),
                              // //         curve: Curves.easeInOut,
                              // //       )
                              // //     : null;
                            },
                            child: _TableCategorySubWidget(
                                text: categoryList[index].title ?? '',
                                // color: colorSelected(state, categoryList[index].sId)));
                                color: colorSelected(state, categoryList[index].id ?? '')));
                  },
                ),
              )));
  }

  colorSelected(BranchState state, String sId) {
    if (state.selectedCategory != null) {
      if (state.selectedCategory!.sId == sId) {
        return Colors.amberAccent;
      }
    }
    if (state.mainCategory != null) {
      if (state.mainCategory!.sId == sId) {
        return Colors.lightBlueAccent;
      }
    }
    if (state.subCategory != null) {
      if (state.subCategory!.sId == sId) {
        return Colors.greenAccent;
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
