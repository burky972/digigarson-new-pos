import 'dart:convert';
import 'dart:io';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/i_category_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/model/category_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/service/category_service.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/service/i_category_service.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/global/service/global_service.dart';
import 'package:core/base/cubit/base_cubit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'category_state.dart';

class CategoryCubit extends ICategoryCubit {
  CategoryCubit() : super(CategoryState.initial());

  final ICategoryService _categoryService = CategoryService();
  final TextEditingController titleController = TextEditingController();
  List<CategoryModel> originalCategories = [];
  int firstCategoriesLength = 0;
  @override
  void init() {}

  @override
  CategoryModel? get category => state.category;
  CategoryModel? get selectedCategory => state.selectedCategory;
  List<CategoryModel> get getAllCategories => state.allCategories;

  /// GET CATEGORIES FROM CATEGORY SERVICE
  @override
  Future getCategories() async {
    appLogger.warning('TAG', 'GET OPTION CALLED@@@');
    emit(state.copyWith(states: CategoryStates.loading));
    final response = await _categoryService.getCategories();
    response.fold((l) {
      emit(state.copyWith(states: CategoryStates.error));
    }, (response) {
      List<CategoryModel> categoryList = (response.data as List)
          .map((category) => CategoryModel.fromJson(category as Map<String, dynamic>))
          .toList();

      emit(state.copyWith(allCategories: categoryList, states: CategoryStates.completed));
      categoryList.isNotEmpty ? setSelectedCategory(categoryList.first) : setSelectedCategory(null);
      firstCategoriesLength = categoryList.length;
      // Original categories are deep copied here
      originalCategories = categoryList
          .map((category) => CategoryModel(
                parentCategory: category.parentCategory,
                id: category.id,
                title: category.title,
                image: category.image,
                isSubCategory: category.isSubCategory,
                activeList: category.activeList,
              ))
          .toList();
    });
  }

  /// POST CATEGORIES TO CATEGORY SERVICE
  @override
  Future postCategories({required CategoryModel categoryModel}) async {
    emit(state.copyWith(states: CategoryStates.loading));

    final response = await _categoryService.postCategories(categoriesModel: categoryModel);
    response.fold((l) {
      emit(state.copyWith(states: CategoryStates.error));
    }, (r) {
      CategoryModel category = CategoryModel.fromJson(r.data);
      emit(state.copyWith(category: category, states: CategoryStates.completed));
    });
  }

  /// PUT CATEGORIES TO CATEGORY SERVICE
  @override
  Future putCategories({required CategoryModel categoryModel, required String categoryId}) async {
    emit(state.copyWith(states: CategoryStates.loading));
    final response = await _categoryService.putCategories(
        categoryId: categoryId, categoriesModel: categoryModel);
    response.fold((l) {
      emit(state.copyWith(states: CategoryStates.error));
    }, (r) async {
      emit(state.copyWith(states: CategoryStates.completed));
    });
  }

  /// PATCH CATEGORIES TO CATEGORY SERVICE
  @override
  Future patchCategories({required String categoryId}) async {
    emit(state.copyWith(states: CategoryStates.loading));
    final response = await _categoryService.patchCategories(categoryId: categoryId);
    response.fold((l) {
      emit(state.copyWith(states: CategoryStates.error));
    }, (r) {
      CategoryModel category = CategoryModel.fromJson(r.data);
      emit(state.copyWith(category: category, states: CategoryStates.completed));
    });
  }

  /// ADD NEW EMPTY CATEGORY
  Future<void> addNewCategory() async {
    if (state.selectedCategory == null) return;
    titleController.clear();
    emit(state.copyWith(selectedCategory: () => null));
    emit(state.copyWith(
      allCategories: List.from(state.allCategories)
        ..add(CategoryModel(
          id: '',
          title: '',
          isSubCategory: false,
          image: '',
          activeList: const [1],
        )),
    ));
    emit(state.copyWith(selectedCategory: () => state.allCategories.last));
  }

  /// SAVE CHANGES AND REQUEST TO POST CATEGORY SERVICE
  Future<void> saveChanges() async {
    List<String> postedList = [];
    for (var category in state.allCategories.sublist(firstCategoriesLength)) {
      CategoryModel newCategory = category.copyWith(id: () => null);
      await postCategories(categoryModel: newCategory);
      postedList.add(category.title ?? "");
      continue;
    }

    /// IF EXIST CATEGORIES HAVE ANY CHANGES SEND PUT REQUEST TO SERVICE
    for (var category in state.allCategories) {
      var originalCategory = originalCategories.firstWhere(
        (origCate) => origCate.id == category.id,
        orElse: () => CategoryModel(),
      );
      if ((originalCategory.title != category.title ||
          originalCategory.image != category.image ||
          originalCategory.isSubCategory != category.isSubCategory)) {
        if (!postedList.contains(category.title ?? "")) {
          appLogger.info('CATEGORY (PUT): ', category.toJson().toString());

          await putCategories(
            categoryId: category.id ?? "",
            categoryModel: category,
          );
        }
      }
    }
  }

  /// UPDATE SELECTED CATEGORY TITLE
  void updateSelectedCategoryTitle(String title) {
    final selectedCategory = state.selectedCategory;
    if (selectedCategory == null) return;

    final isNewCategory = !originalCategories.contains(selectedCategory);
    final updatedCategory = selectedCategory.copyWith(
      title: title,
      id: isNewCategory ? () => GlobalService.generateUniqueId() : () => selectedCategory.id,
    );

    final updatedCategories = state.allCategories.map((category) {
      return category.id == selectedCategory.id ? updatedCategory : category;
    }).toList();

    emit(state.copyWith(
      allCategories: updatedCategories,
      selectedCategory: () => updatedCategory,
    ));
  }

  /// SET SELECTED CATEGORY
  @override
  void setSelectedCategory(CategoryModel? category) {
    titleController.text = category?.title ?? '';
    emit(state.copyWith(selectedCategory: () => category));
  }

  /// GET CATEGORY IMAGE FROM GALLERY
  @override
  Future<void> getCategoryImage() async {
    final xFileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFileImage == null) return;

    final imageTemporary = File(xFileImage.path);
    final bytes = await imageTemporary.readAsBytes();
    final base64Image = base64Encode(bytes);
    updateSelectedCategoryImage(base64Image);
    emit(state.copyWith(
      categoryImage: () => imageTemporary,
    ));
  }

  /// UPDATE SELECTED CATEGORY IMAGE
  void updateSelectedCategoryImage(String base64Image) {
    if (state.selectedCategory == null) return;

    final updatedCategory = state.selectedCategory!.copyWith(image: base64Image);
    final updatedCategories = state.allCategories.map((category) {
      if (category.id == state.selectedCategory!.id) {
        return updatedCategory;
      } else {
        return category;
      }
    }).toList();

    emit(state.copyWith(
      allCategories: updatedCategories,
      selectedCategory: () => updatedCategory,
    ));
  }

  /// CLEAN CATEGORY IMAGE
  @override
  void cleanCategoryImage() {
    if (state.selectedCategory == null) return;

    final updatedCategory = state.selectedCategory!.copyWith(image: '');
    // update allCategories list
    final updatedCategories = state.allCategories.map((category) {
      if (category.id == state.selectedCategory!.id) {
        return updatedCategory;
      } else {
        return category;
      }
    }).toList();

    emit(state.copyWith(
      allCategories: updatedCategories,
      selectedCategory: () => updatedCategory,
    ));
  }

  /// CLOSE TEXT EDITING CONTROLLER
  @override
  Future<void> close() {
    titleController.dispose();
    return super.close();
  }
}
