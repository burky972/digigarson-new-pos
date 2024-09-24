// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable(includeIfNull: false)
class CategoryModel extends BaseModel<CategoryModel> {
  final String? id;
  final String? title;
  final String? image;
  @JsonKey(name: 'is_sub_category')
  final bool? isSubCategory;
  @JsonKey(name: 'parent_category')
  final String? parentCategory;
  @JsonKey(name: 'active_list')
  final List<int>? activeList;
  final String? parentCategoryTitle;

  CategoryModel({
    this.id,
    this.title,
    this.image,
    this.isSubCategory,
    this.parentCategory,
    this.activeList,
    this.parentCategoryTitle,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
  factory CategoryModel.empty() => CategoryModel(
        id: '',
        title: '',
        image: '',
        parentCategoryTitle: '',
        isSubCategory: false,
        parentCategory: '',
        activeList: const [],
      );
  @override
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  CategoryModel fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

  @override
  List<Object?> get props =>
      [id, title, image, isSubCategory, parentCategory, parentCategoryTitle, activeList];

  CategoryModel copyWith({
    String? Function()? id,
    String? title,
    String? Function()? image,
    String? Function()? parentCategoryTitle,
    bool? isSubCategory,
    String? parentCategory,
    List<int>? activeList,
  }) {
    return CategoryModel(
      id: id != null ? id() : this.id,
      title: title ?? this.title,
      parentCategoryTitle:
          parentCategoryTitle != null ? parentCategoryTitle() : this.parentCategoryTitle,
      image: image != null ? image() : this.image,
      isSubCategory: isSubCategory ?? this.isSubCategory,
      parentCategory: parentCategory ?? this.parentCategory,
      activeList: activeList ?? this.activeList,
    );
  }
}
