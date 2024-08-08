import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/model/category_model.dart';
import 'package:core/base/cubit/base_cubit.dart';

abstract class ICategoryCubit extends BaseCubit<CategoryState> {
  ICategoryCubit(super.initialState);
  CategoryModel? get category;
  Future getCategories();
  Future postCategories({required CategoryModel categoryModel});
  Future putCategories({required CategoryModel categoryModel, required String categoryId});
  Future patchCategories({required String categoryId});
  void setSelectedCategory(CategoryModel category);
  void cleanCategoryImage();
  Future<void> getCategoryImage();
}
