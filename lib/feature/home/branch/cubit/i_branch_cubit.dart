import 'package:a_pos_flutter/feature/home/branch/cubit/branch_state.dart';
import 'package:a_pos_flutter/product/global/model/branch/branch_model.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:core/base/cubit/base_cubit.dart';
import 'package:flutter/material.dart';

abstract class IBranchCubit extends BaseCubit<BranchState> {
  IBranchCubit(super.initialState);
  Future getBranch({required UserModel userModel, required Locale languageModel});
  Future<void> setNewBranch(BranchModel? branch);
  void setSectionSelected(SectionsModel sections);
  void setSectionMoveSelected(SectionsModel sections);
  void setCategorySelected(CategoriesModel? category);
  void setMainCategorySelected(CategoriesModel? category);
  void setSubCategorySelected(CategoriesModel? category);
  List<CategoriesModel> createCategoryTree(List<CategoriesModel> categories);
}
