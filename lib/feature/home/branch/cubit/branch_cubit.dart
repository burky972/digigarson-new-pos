import 'dart:ui';

import 'package:a_pos_flutter/feature/home/branch/cubit/branch_state.dart';
import 'package:a_pos_flutter/feature/home/branch/cubit/i_branch_cubit.dart';
import 'package:a_pos_flutter/feature/home/branch/service/branch_service.dart';
import 'package:a_pos_flutter/feature/home/branch/service/i_branch_service.dart';
import 'package:a_pos_flutter/product/global/model/branch/branch_model.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:core/logger/a_pos_logger.dart';

class BranchCubit extends IBranchCubit {
  BranchCubit() : super(BranchState.initial()) {
    init();
  }
  //TODO: SEPERATE BRANCH TO CATEGORIES-PRODUCTS-SECTIONS-TABLES-OPTIONS!
  late IBranchService _branchService;
  final TAG = "BranchCubit";
  BranchModel? branchModel;
  SectionsModel? selectedSection;
  SectionsModel? selectedMoveSection;
  CategoriesModel? selectedCategory;
  CategoriesModel? mainCategory;
  CategoriesModel? subCategory;
  List<CategoriesModel> mainCategoryList = [];
  List<CategoriesModel> originalCategoryList = [];

  /// initialize func
  @override
  Future<void> init() async {
    _branchService = BranchService();
  }

  @override
  Future getBranch({required UserModel userModel, required Locale languageModel}) async {
    mainCategoryList.clear();
    originalCategoryList.clear();
    emit(state.copyWith(states: BranchStates.loading));
    final response =
        await _branchService.getBranch(userModel: userModel, languageModel: languageModel);
    response.fold(
        (_) => emit(
              state.copyWith(states: BranchStates.error),
            ), (response) {
      branchModel = BranchModel.fromJson(response.data);
      emit(state.copyWith(branchModel: () => branchModel));
      if (branchModel != null) {
        List<CategoriesModel> categoryList = [];
        branchModel!.sections!.isNotEmpty
            ? emit(state.copyWith(selectedSection: () => branchModel!.sections?.first))
            : emit(state.copyWith(selectedSection: null));
        branchModel!.sections?.add(SectionsModel(sId: "Setting", title: "Setting"));
        if (branchModel!.categories!.isNotEmpty) {
          originalCategoryList.addAll(branchModel!.categories!);
          emit(state.copyWith(originalCategoryList: () => originalCategoryList));
          categoryList = createCategoryTree(branchModel!.categories!);
        }
        branchModel!.categories = [];
        branchModel!.categories!.addAll(categoryList);
        for (var category in branchModel!.categories!) {
          mainCategoryList.add(category);
        }
        emit(state.copyWith(
            mainCategoryList: () => mainCategoryList, states: BranchStates.completed));
      }
    });
  }

  @override
  List<CategoriesModel> createCategoryTree(List<CategoriesModel> categories) {
    try {
      Map<String, CategoriesModel> categoryMap = {};
      for (var category in categories) {
        categoryMap[category.sId] = category;
      }
      for (var category in categories) {
        if (category.parentCategory != null || category.parentCategory.toString() != "null") {
          CategoriesModel parentCategory = categoryMap[category.parentCategory]!;
          parentCategory.subCategory.add(category);
        }
      }
      return categories.where((category) => category.parentCategory == null).toList();
    } catch (e) {
      APosLogger.instance!.error('BRANCH CUBIT', 'CREATE CATEGORY TREE ${e.toString()}');
      emit(state.copyWith(states: BranchStates.error));
    }
    return categories;
  }

  @override
  Future<void> setNewBranch(BranchModel? branch) async {
    emit(state.copyWith(states: BranchStates.loading));
    branchModel = branch;
    emit(state.copyWith(branchModel: () => branch));
    if (branchModel != null) {
      branchModel!.sections!.isNotEmpty
          ? emit(state.copyWith(selectedSection: () => branchModel!.sections?.first))
          : emit(state.copyWith(selectedSection: null));
      branchModel!.sections?.add(SectionsModel(sId: "Setting", title: "Setting"));

      List<CategoriesModel> categoryList = [];
      if (branchModel!.categories!.isNotEmpty) {
        originalCategoryList.addAll(branchModel!.categories!);
        emit(state.copyWith(originalCategoryList: () => originalCategoryList));
        categoryList = createCategoryTree(branchModel!.categories!);
        branchModel!.categories = [];
        branchModel!.categories!.addAll(categoryList);
        for (var category in branchModel!.categories!) {
          mainCategoryList.add(category);
        }
        emit(state.copyWith(mainCategoryList: () => mainCategoryList));
      }
    }
  }

  @override
  void setSectionMoveSelected(SectionsModel sections) {
    emit(state.copyWith(selectedMoveSection: () => sections));
  }

  @override
  void setSectionSelected(SectionsModel sections) {
    emit(state.copyWith(selectedSection: () => sections));
  }

  @override
  void setCategorySelected(CategoriesModel? category) {
    emit(state.copyWith(selectedCategory: () => category));
  }

  @override
  void setMainCategorySelected(CategoriesModel? category) {
    emit(state.copyWith(mainCategory: () => category));
  }

  @override
  void setSubCategorySelected(CategoriesModel? category) {
    emit(state.copyWith(subCategory: () => category));
  }

  setFilter(String filter_) {
    emit(state.copyWith(filter: () => filter_));
  }
}
