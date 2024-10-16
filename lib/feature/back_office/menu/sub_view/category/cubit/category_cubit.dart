import 'dart:convert';
import 'dart:io';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/i_category_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/model/category_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/service/i_category_service.dart';
import 'package:a_pos_flutter/product/enums/order_type/order_type.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/global/service/global_service.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'category_state.dart';

class CategoryCubit extends ICategoryCubit {
  CategoryCubit(this._categoryService) : super(CategoryState.initial());

  final ICategoryService _categoryService;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  List<CategoryModel> originalCategories = [];
  List<CategoryModel> originalSubCategories = [];
  List<CategoryModel> originalMainCategories = [];
  int firstCategoriesLength = 0;
  @override
  void init() {}

  @override
  CategoryModel? get category => state.category;
  CategoryModel? get selectedCategory => state.selectedCategory;
  CategoryModel? get selectedSubCategory => state.selectedSubCategory;
  List<CategoryModel> get getAllCategories => state.allCategories;
  List<CategoryModel> get getSubCategories => state.subCategories;

  /// GET CATEGORIES FROM CATEGORY SERVICE
  @override
  Future getCategories() async {
    emit(state.copyWith(states: CategoryStates.loading));
    final response = await _categoryService.getCategories();
    response.fold((l) {
      emit(state.copyWith(states: CategoryStates.error));
    }, (response) {
      List<CategoryModel> categoryList = (response.data as List)
          .map((category) => CategoryModel.fromJson(category as Map<String, dynamic>))
          .toList();
      // Process categories
      List<CategoryModel> processedCategories = _processCategories(categoryList);
      // Separate main and sub categories
      List<CategoryModel> mainCategories =
          processedCategories.where((cat) => cat.parentCategory == null).toList();
      List<CategoryModel> subCategories =
          processedCategories.where((cat) => cat.parentCategory != null).toList();

      emit(state.copyWith(
        allCategories: categoryList,
        subCategories: subCategories,
        mainCategories: mainCategories,
        states: CategoryStates.completed,
      ));
      if (mainCategories.isNotEmpty) {
        originalMainCategories = mainCategories;
        setSelectedCategory(mainCategories.first);
      } else {
        setSelectedCategory(null);
      }
      if (subCategories.isNotEmpty) {
        originalSubCategories = subCategories;
        setSelectedSubCategory(subCategories.first);
      } else {
        setSelectedSubCategory(null);
      }
      firstCategoriesLength = categoryList.length;
      // Original categories are deep copied here
      originalCategories = processedCategories.map((category) => category.copyWith()).toList();
    });
  }

  List<CategoryModel> _processCategories(List<CategoryModel> categories) {
    Map<String, String> categoryTitles = {for (var cat in categories) cat.id!: cat.title!};

    return categories.map((category) {
      if (category.parentCategory != null) {
        return category.copyWith(
          parentCategoryTitle: () => categoryTitles[category.parentCategory],
        );
      }
      return category;
    }).toList();
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
  Future<bool> patchCategories({required String categoryId}) async {
    emit(state.copyWith(states: CategoryStates.loading));
    final response = await _categoryService.patchCategories(categoryId: categoryId);
    response.fold((l) {
      appLogger.info('PATCH CATEGORIES ERROR', l.message);
      emit(state.copyWith(
          states: CategoryStates.error,
          exception: AppException(message: l.message, statusCode: l.statusCode)));
    }, (r) {
      appLogger.info('PATCH CATEGORIES RIGHT', 'SUCCESS');

      CategoryModel category = CategoryModel.fromJson(r.data);
      emit(state.copyWith(category: category, states: CategoryStates.completed));
    });
    return response.isRight();
  }

  /// ADD NEW EMPTY CATEGORY
  Future<void> addNewCategory() async {
    if (state.selectedCategory == null ||
        state.mainCategories.last.title == '' ||
        state.mainCategories.last.title == null) return;
    titleController.clear();
    emit(state.copyWith(
        selectedCategory: () => null, isSelected: true, isCategoryTitleUpdated: false));
    emit(state.copyWith(
      mainCategories: List.from(state.mainCategories)
        ..add(CategoryModel(
          id: '',
          title: '',
          isSubCategory: false,
          image: '',
          activeList: const [],
        )),
    ));
    emit(state.copyWith(selectedCategory: () => state.mainCategories.last));
  }

  /// ADD NEW EMPTY CATEGORY
  Future<void> addNewSubCategory() async {
    if (state.selectedSubCategory == null ||
        state.subCategories.last.title == '' ||
        state.subCategories.last.title == null) return;
    subTitleController.clear();
    emit(state.copyWith(selectedSubCategory: () => null));
    emit(state.copyWith(
      subCategories: List.from(state.subCategories)
        ..add(CategoryModel(
          id: null,
          title: '',
          parentCategory: state.selectedCategory?.id,
          isSubCategory: true,
          image: '',
          activeList: const [],
        )),
    ));
    emit(state.copyWith(selectedSubCategory: () => state.subCategories.last));
  }

  /// SAVE CHANGES AND REQUEST TO POST CATEGORY SERVICE
  Future<void> saveChanges() async {
    List<String> postedList = [];

    // Save new mainCategories
    for (var mainCategory in state.mainCategories) {
      var isOriginal =
          originalMainCategories.any((origMainCate) => origMainCate.id == mainCategory.id);

      // If the subCategory is not in originalmainCategories, it's new and needs a POST request
      if (!isOriginal) {
        CategoryModel newMainCategory = mainCategory.copyWith(id: () => null);
        await postCategories(categoryModel: newMainCategory);
        postedList.add(mainCategory.title ?? "");
      }
    }

    // Update existing subcategories if there are changes
    for (var mainCategory in state.mainCategories) {
      var mainCategoryOriginal = originalMainCategories.firstWhere(
        (origSubCate) => origSubCate.id == mainCategory.id,
        orElse: () => CategoryModel(),
      );

      // Check if any changes are present
      if (mainCategoryOriginal.id != null &&
          (mainCategoryOriginal.title != mainCategory.title ||
              mainCategoryOriginal.image != mainCategory.image)) {
        // Ensure that a POST request hasn't already been made
        if (!postedList.contains(mainCategory.title ?? "")) {
          appLogger.info('SUBCATEGORY (PUT): ', mainCategory.toJson().toString());
          if (state.selectedCategory?.image != null &&
              (state.selectedCategory!.image!.length < 500)) {
            CategoryModel newCateModel = mainCategory.copyWith(image: () => null);
            await putCategories(
              categoryId: mainCategory.id ?? "",
              categoryModel: newCateModel,
            );
          } else {
            await putCategories(
              categoryId: mainCategory.id ?? "",
              categoryModel: mainCategory,
            );
          }
        }
      }
    }
  }

  /// SAVE CHANGES AND REQUEST TO sub POST CATEGORY SERVICE
  Future<void> saveSubCategoriesChanges() async {
    List<String> postedList = [];
    appLogger.info("TAG", 'saving SUB CATEGORIES');

    // Save new subcategories
    for (var subCategory in state.subCategories) {
      var isOriginal = originalSubCategories.any((origSubCate) => origSubCate.id == subCategory.id);

      // If the subCategory is not in originalSubCategories, it's new and needs a POST request
      if (!isOriginal) {
        CategoryModel newSubCategory = subCategory.copyWith(id: () => null);
        if (subCategory.parentCategory == null) {
          appLogger.error('SUBCATEGORY (POST): ', 'PARENT CATE CANT BE EMPTY'.toString());
        } else {
          if (state.selectedSubCategory!.image!.length < 500) {
            CategoryModel newCateModel = newSubCategory.copyWith(image: () => null, id: () => null);
            await postCategories(categoryModel: newCateModel);
            postedList.add(subCategory.title ?? "");
          } else {
            await postCategories(categoryModel: newSubCategory);
            postedList.add(subCategory.title ?? "");
          }
        }
      }
    }

    // Update existing subcategories if there are changes
    for (var subCategory in state.subCategories) {
      var originalSubCategory = originalSubCategories.firstWhere(
        (origSubCate) => origSubCate.id == subCategory.id,
        orElse: () => CategoryModel(),
      );

      // Check if any changes are present
      if (originalSubCategory.id != null &&
          (originalSubCategory.title != subCategory.title ||
              originalSubCategory.image != subCategory.image ||
              originalSubCategory.parentCategory != subCategory.parentCategory ||
              originalSubCategory.isSubCategory != subCategory.isSubCategory ||
              originalSubCategory.activeList != subCategory.activeList)) {
        // Ensure that a POST request hasn't already been made
        if (!postedList.contains(subCategory.title ?? "")) {
          CategoryModel newSubCategory = subCategory.copyWith(parentCategoryTitle: () => null);
          if (state.selectedSubCategory!.image!.length < 500) {
            CategoryModel newCateModel = newSubCategory.copyWith(image: () => null);
            await putCategories(
              categoryId: subCategory.id ?? "",
              categoryModel: newCateModel,
            );
          } else {
            await putCategories(
              categoryId: subCategory.id ?? "",
              categoryModel: newSubCategory,
            );
          }
        }
      }
    }
    await getCategories(); //TODO: CHECK THIS
  }

  void updateParentCategory(String? newParentCategoryId) {
    appLogger.warning('WARMOMG: ', '$newParentCategoryId');
    if (state.selectedSubCategory != null && newParentCategoryId != null) {
      // Create a new subcategory with the updated parentCategory
      CategoryModel updatedSubCategory = state.selectedSubCategory!.copyWith(
        parentCategory: newParentCategoryId,
      );

      // Update the subcategory in the list
      List<CategoryModel> updatedSubCategories = List.from(state.subCategories);
      int selectedIndex =
          updatedSubCategories.indexWhere((cat) => cat.id == state.selectedSubCategory!.id);

      if (selectedIndex != -1) {
        updatedSubCategories[selectedIndex] = updatedSubCategory;
      }

      // Emit the new state with the updated subcategories and selectedSubCategory
      emit(state.copyWith(
        subCategories: updatedSubCategories,
        selectedSubCategory: () => updatedSubCategory,
      ));
    }
  }

  bool isCategoryTitleUpdated = false;

  /// UPDATE SELECTED CATEGORY TITLE
  void updateSelectedCategoryTitle(String title) {
    String id;
    final selectedCategory = state.selectedCategory;
    if (selectedCategory == null) return;

    final isNewCategory = !originalMainCategories.contains(selectedCategory);
    if (isNewCategory == false) {
      emit(state.copyWith(isCategoryTitleUpdated: true, isSelected: false));
    }
    if (state.isCategoryTitleUpdated == true && state.isSelected == false) {
      appLogger.warning(
          'WARMOMG already exist: ', 'isCategoryTitleUpdated == true && isSelected == false');
      id = selectedCategory.id!;
    } else {
      appLogger.warning('WARMOMG new: ', 'isCategoryTitleUpdated == true && isSelected == false');

      id = GlobalService.generateUniqueId();
    }

    final updatedCategory = selectedCategory.copyWith(
      title: title,
      id: () => id,
    );

    final updatedCategories = state.mainCategories.map((category) {
      return category.id == selectedCategory.id ? updatedCategory : category;
    }).toList();

    emit(state.copyWith(
      mainCategories: updatedCategories,
      selectedCategory: () => updatedCategory,
    ));
  }

  /// UPDATE SELECTED SUB CATEGORY TITLE
  void updateSelectedSubCategoryTitle(String title) {
    final selectedCategory = state.selectedSubCategory;
    if (selectedCategory == null) return;

    final isNewCategory = !originalSubCategories.map((e) => e.id).contains(selectedCategory.id);
    final updatedCategory = selectedCategory.copyWith(
      title: title,
      id: isNewCategory ? () => GlobalService.generateUniqueId() : () => selectedCategory.id,
    );

    final updatedCategories = state.subCategories.map((category) {
      return category.id == selectedCategory.id ? updatedCategory : category;
    }).toList();

    emit(state.copyWith(
      subCategories: updatedCategories,
      selectedSubCategory: () => updatedCategory,
    ));
  }

  /// SET SELECTED CATEGORY
  @override
  void setSelectedCategory(CategoryModel? category) {
    titleController.text = category?.title ?? '';
    emit(state.copyWith(selectedCategory: () => category, isSelected: true));
  }

  Future<void> setSelectedSubCategory(CategoryModel? category) async {
    subTitleController.text = category?.title ?? '';
    emit(state.copyWith(selectedSubCategory: () => category, isSelected: true));
  }

  void setSelectedParentCategoryTitle(String? title) {
    emit(state.copyWith(selectedParentCategoryTitle: title));
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

  /// GET Sub CATEGORY IMAGE FROM GALLERY
  Future<void> getSubCategoryImage() async {
    final xFileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFileImage == null) return;

    final imageTemporary = File(xFileImage.path);
    final bytes = await imageTemporary.readAsBytes();
    final base64Image = base64Encode(bytes);
    updateSelectedSubCategoryImage(base64Image);
    emit(state.copyWith(
      subCategoryImage: () => imageTemporary,
    ));
  }

  /// UPDATE SELECTED CATEGORY IMAGE
  void updateSelectedCategoryImage(String base64Image) {
    if (state.selectedCategory == null) return;

    final updatedCategory = state.selectedCategory!.copyWith(image: () => base64Image);
    final updatedCategories = state.mainCategories.map((category) {
      if (category.id == state.selectedCategory!.id) {
        return updatedCategory;
      } else {
        return category;
      }
    }).toList();

    emit(state.copyWith(
      mainCategories: updatedCategories,
      selectedCategory: () => updatedCategory,
    ));
  }

  /// UPDATE SELECTED SUB CATEGORY IMAGE
  void updateSelectedSubCategoryImage(String base64Image) {
    if (state.selectedSubCategory == null) return;

    final updatedCategory = state.selectedSubCategory!.copyWith(image: () => base64Image);
    final updatedCategories = state.subCategories.map((category) {
      if (category.id == state.selectedSubCategory!.id) {
        return updatedCategory;
      } else {
        return category;
      }
    }).toList();

    emit(state.copyWith(
      subCategories: updatedCategories,
      selectedSubCategory: () => updatedCategory,
    ));
  }

  /// CLEAN CATEGORY IMAGE
  @override
  void cleanCategoryImage() {
    if (state.selectedCategory == null) return;
    final updatedCategory = state.selectedCategory!.copyWith(image: () => '');
    // update allCategories list
    final updatedCategories = state.mainCategories.map((category) {
      if (category.id == state.selectedCategory!.id) {
        return updatedCategory;
      } else {
        return category;
      }
    }).toList();

    emit(state.copyWith(
      mainCategories: updatedCategories,
      selectedCategory: () => updatedCategory,
    ));
  }

  /// CLEAN sub CATEGORY IMAGE
  void cleanSubCategoryImage() {
    if (state.selectedSubCategory == null) return;
    final updatedCategory = state.selectedSubCategory!.copyWith(image: () => '');
    // update subCategories list
    final updatedCategories = state.subCategories.map((category) {
      if (category.id == state.selectedSubCategory!.id) {
        return updatedCategory;
      } else {
        return category;
      }
    }).toList();

    emit(state.copyWith(
      subCategories: updatedCategories,
      selectedSubCategory: () => updatedCategory,
    ));
  }

  /// toggle checkBox for active list
//TODO: CHEK TO MAKE THIS CODE BETTER!
  void toggleActiveStatus(String categoryId, OrderType orderType) {
    // If the selected category exists and has been newly added, only process the selected category
    if (state.selectedSubCategory != null &&
        !originalSubCategories.map((e) => e.id).contains(state.selectedSubCategory!.id)) {
      appLogger.info('ORIGINAL SUBCATEGORIES', 'NOT FOUND');

      List<int> updatedActiveList = List.from(state.selectedSubCategory!.activeList ?? []);

      if (updatedActiveList.contains(orderType.value)) {
        updatedActiveList.remove(orderType.value);
      } else {
        updatedActiveList.add(orderType.value);
      }
      final updatedSelectedSubCategory = state.selectedSubCategory!.copyWith(
        activeList: updatedActiveList,
      );

      final updatedSubCategories =
          List<CategoryModel>.from(state.subCategories.map((category) => category));
      final selectedIndex =
          updatedSubCategories.indexWhere((category) => category == state.selectedSubCategory);

      if (selectedIndex != -1) {
        updatedSubCategories[selectedIndex] = updatedSelectedSubCategory;
      } else {
        updatedSubCategories.add(updatedSelectedSubCategory);
      }

      emit(state.copyWith(
        subCategories: updatedSubCategories,
        selectedSubCategory: () => updatedSelectedSubCategory,
      ));

      return;
    }

    // If the selected category does not exist, process all categories
    if (state.selectedSubCategory == null || state.selectedSubCategory!.id != categoryId) {
      return;
    }

    // If the selected category exists, process all categories
    final updatedSubCategories = state.subCategories.map((category) {
      if (category.id == categoryId) {
        List<int> updatedActiveList = List.from(category.activeList ?? []);
        if (updatedActiveList.contains(orderType.value)) {
          updatedActiveList.remove(orderType.value);
        } else {
          updatedActiveList.add(orderType.value);
        }
        return category.copyWith(activeList: updatedActiveList);
      }
      return category;
    }).toList();

    final updatedSelectedSubCategory = updatedSubCategories.firstWhere(
      (category) => category.id == categoryId,
      orElse: () => state.selectedSubCategory!,
    );

    emit(state.copyWith(
      subCategories: updatedSubCategories,
      selectedSubCategory: () => updatedSelectedSubCategory,
    ));
  }

  /// CLOSE TEXT EDITING CONTROLLER
  @override
  Future<void> close() {
    titleController.dispose();
    subTitleController.dispose();
    return super.close();
  }
}
