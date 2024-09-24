// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_cubit.dart';

class CategoryState extends BaseState {
  const CategoryState({
    required this.states,
    required this.category,
    required this.selectedCategory,
    required this.selectedSubCategory,
    required this.allCategories,
    required this.categoryImage,
    required this.subCategories,
    required this.mainCategories,
    required this.selectedParentCategoryTitle,
    required this.subCategoryImage,
    required this.isCategoryTitleUpdated,
    required this.isSelected,
    this.exception,
  });

  factory CategoryState.initial() {
    return const CategoryState(
      states: CategoryStates.initial,
      category: null,
      selectedCategory: null,
      selectedSubCategory: null,
      allCategories: [],
      categoryImage: null,
      subCategories: [],
      mainCategories: [],
      selectedParentCategoryTitle: null,
      subCategoryImage: null,
      isCategoryTitleUpdated: false,
      isSelected: false,
      exception: null,
    );
  }

  final CategoryStates states;
  final CategoryModel? category;
  final CategoryModel? selectedCategory;
  final CategoryModel? selectedSubCategory;
  final List<CategoryModel> allCategories;
  final File? categoryImage;
  final File? subCategoryImage;
  final List<CategoryModel> subCategories;
  final List<CategoryModel> mainCategories;
  final String? selectedParentCategoryTitle;
  final bool isCategoryTitleUpdated;
  final bool isSelected;
  final AppException? exception;

  @override
  List<Object?> get props => [
        states,
        category,
        selectedCategory,
        selectedSubCategory,
        allCategories,
        categoryImage,
        subCategories,
        mainCategories,
        selectedParentCategoryTitle,
        subCategoryImage,
        isCategoryTitleUpdated,
        isSelected,
        exception,
      ];

  CategoryState copyWith({
    CategoryStates? states,
    CategoryModel? category,
    CategoryModel? Function()? selectedCategory,
    CategoryModel? Function()? selectedSubCategory,
    List<CategoryModel>? allCategories,
    File? Function()? categoryImage,
    File? Function()? subCategoryImage,
    List<CategoryModel>? mainCategories,
    List<CategoryModel>? subCategories,
    String? selectedParentCategoryTitle,
    bool? isCategoryTitleUpdated,
    bool? isSelected,
    AppException? exception,
  }) {
    return CategoryState(
      states: states ?? this.states,
      category: category ?? this.category,
      selectedCategory: selectedCategory != null ? selectedCategory() : this.selectedCategory,
      selectedSubCategory:
          selectedSubCategory != null ? selectedSubCategory() : this.selectedSubCategory,
      allCategories: allCategories ?? this.allCategories,
      categoryImage: categoryImage != null ? categoryImage() : this.categoryImage,
      subCategories: subCategories ?? this.subCategories,
      mainCategories: mainCategories ?? this.mainCategories,
      selectedParentCategoryTitle: selectedParentCategoryTitle ?? this.selectedParentCategoryTitle,
      subCategoryImage: subCategoryImage != null ? subCategoryImage() : null,
      isCategoryTitleUpdated: isCategoryTitleUpdated ?? this.isCategoryTitleUpdated,
      isSelected: isSelected ?? this.isSelected,
      exception: exception ?? this.exception,
    );
  }
}

enum CategoryStates { initial, loading, completed, error }
