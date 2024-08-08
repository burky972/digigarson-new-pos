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
    required this.filter,
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
      filter: '',
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
  final String filter;

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
        filter,
      ];

  BranchState copyWith({
    BranchStates? states,
    BranchModel? Function()? branchModel,
    SectionsModel? Function()? selectedSection,
    SectionsModel? Function()? selectedMoveSection,
    CategoriesModel? Function()? selectedCategory,
    CategoriesModel? Function()? mainCategory,
    CategoriesModel? Function()? subCategory,
    List<CategoriesModel>? Function()? mainCategoryList,
    List<CategoriesModel>? Function()? originalCategoryList,
    String? Function()? filter,
  }) {
    return BranchState(
      states: states ?? this.states,
      branchModel: branchModel != null ? branchModel() : this.branchModel,
      selectedSection: selectedSection != null ? selectedSection() : this.selectedSection,
      selectedMoveSection:
          selectedMoveSection != null ? selectedMoveSection() : this.selectedMoveSection,
      selectedCategory: selectedCategory != null ? selectedCategory() : this.selectedCategory,
      mainCategory: mainCategory != null ? mainCategory() : this.mainCategory,
      subCategory: subCategory != null ? subCategory() : this.subCategory,
      mainCategoryList: mainCategoryList != null ? mainCategoryList()! : this.mainCategoryList,
      originalCategoryList:
          originalCategoryList != null ? originalCategoryList()! : this.originalCategoryList,
      filter: filter != null ? filter()! : this.filter,
    );
  }
}

enum BranchStates { initial, loading, completed, error }
