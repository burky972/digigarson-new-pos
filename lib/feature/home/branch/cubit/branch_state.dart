import 'package:a_pos_flutter/product/global/model/branch/branch_model.dart';
import 'package:core/base/cubit/base_cubit.dart';

class BranchState extends BaseState {
  const BranchState({
    required this.states,
    required this.branchModel,
    required this.selectedSection,
    required this.selectedMoveSection,
    required this.selectedCategory,
    required this.mainCategory,
    required this.subCategory,
    required this.mainCategoryList,
    required this.originalCategoryList,
  });

  factory BranchState.initial() {
    return const BranchState(
      states: BranchStates.initial,
      branchModel: null,
      selectedSection: null,
      selectedMoveSection: null,
      selectedCategory: null,
      mainCategory: null,
      subCategory: null,
      mainCategoryList: [],
      originalCategoryList: [],
    );
  }
  final BranchStates states;
  final BranchModel? branchModel;
  final SectionsModel? selectedSection;
  final SectionsModel? selectedMoveSection;
  final CategoriesModel? selectedCategory;
  final CategoriesModel? mainCategory;
  final CategoriesModel? subCategory;
  final List<CategoriesModel> mainCategoryList;
  final List<CategoriesModel> originalCategoryList;

  @override
  List<Object?> get props => [
        states,
        branchModel,
        selectedSection,
        selectedMoveSection,
        selectedCategory,
        mainCategory,
        subCategory,
        mainCategoryList,
        originalCategoryList,
      ];

  BranchState copyWith({
    BranchStates? states,
    bool? isLoading,
    BranchModel? branchModel,
    SectionsModel? selectedSection,
    SectionsModel? selectedMoveSection,
    CategoriesModel? selectedCategory,
    CategoriesModel? mainCategory,
    CategoriesModel? subCategory,
    List<CategoriesModel>? mainCategoryList,
    List<CategoriesModel>? originalCategoryList,
  }) {
    return BranchState(
      states: states ?? this.states,
      branchModel: branchModel ?? this.branchModel,
      selectedSection: selectedSection ?? this.selectedSection,
      selectedMoveSection: selectedMoveSection ?? this.selectedMoveSection,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      mainCategory: mainCategory ?? this.mainCategory,
      subCategory: subCategory ?? this.subCategory,
      mainCategoryList: mainCategoryList ?? this.mainCategoryList,
      originalCategoryList: originalCategoryList ?? this.originalCategoryList,
    );
  }
}

enum BranchStates { initial, loading, completed, error }
