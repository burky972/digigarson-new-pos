// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_cubit.dart';

class CategoryState extends BaseState {
  const CategoryState({
    required this.states,
    required this.category,
    required this.selectedCategory,
    required this.allCategories,
    required this.categoryImage,
  });

  factory CategoryState.initial() {
    return const CategoryState(
      states: CategoryStates.initial,
      category: null,
      selectedCategory: null,
      allCategories: [],
      categoryImage: null,
    );
  }

  final CategoryStates states;
  final CategoryModel? category;
  final CategoryModel? selectedCategory;
  final List<CategoryModel> allCategories;
  final File? categoryImage;

  @override
  List<Object?> get props => [states, category, selectedCategory, allCategories, categoryImage];

  CategoryState copyWith({
    CategoryStates? states,
    CategoryModel? category,
    CategoryModel? Function()? selectedCategory,
    List<CategoryModel>? allCategories,
    File? Function()? categoryImage,
  }) {
    return CategoryState(
      states: states ?? this.states,
      category: category ?? this.category,
      selectedCategory: selectedCategory != null ? selectedCategory() : this.selectedCategory,
      allCategories: allCategories ?? this.allCategories,
      categoryImage: categoryImage != null ? categoryImage() : this.categoryImage,
    );
  }
}

enum CategoryStates { initial, loading, completed, error }
