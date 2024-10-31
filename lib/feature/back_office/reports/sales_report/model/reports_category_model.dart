import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reports_category_model.g.dart';

@JsonSerializable()
class ReportsCategoryModel extends BaseModel<ReportsCategoryModel> {
  ReportsCategoryModel({
    required this.dineInQuantity,
    required this.dineInTotal,
    required this.takeOutQuantity,
    required this.takeOutTotal,
    required this.deliveryQuantity,
    required this.deliveryTotal,
    required this.quickServiceQuantity,
    required this.quickServiceTotal,
    required this.barQuantity,
    required this.barTotal,
    required this.grandQuantity,
    required this.grandTotal,
    required this.categoryTitle,
    required this.categoryId,
  });
  @JsonKey(name: "dineInQuantity")
  final int? dineInQuantity;
  @JsonKey(name: "dineInTotal")
  final int? dineInTotal;
  @JsonKey(name: "takeOutQuantity")
  final int? takeOutQuantity;
  @JsonKey(name: "takeOutTotal")
  final int? takeOutTotal;
  @JsonKey(name: "deliveryQuantity")
  final int? deliveryQuantity;
  @JsonKey(name: "deliveryTotal")
  final int? deliveryTotal;
  @JsonKey(name: "quickServiceQuantity")
  final int? quickServiceQuantity;
  @JsonKey(name: "quickServiceTotal")
  final int? quickServiceTotal;
  @JsonKey(name: "barQuantity")
  final int? barQuantity;
  @JsonKey(name: "barTotal")
  final int? barTotal;
  @JsonKey(name: "grandQuantity")
  final int? grandQuantity;
  @JsonKey(name: "grandTotal")
  final int? grandTotal;
  @JsonKey(name: "categoryTitle")
  final String? categoryTitle;
  @JsonKey(name: "categoryId")
  final String? categoryId;

  factory ReportsCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ReportsCategoryModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReportsCategoryModelToJson(this);

  @override
  ReportsCategoryModel fromJson(Map<String, dynamic> json) => _$ReportsCategoryModelFromJson(json);

  @override
  List<Object?> get props => [
        dineInQuantity,
        dineInTotal,
        takeOutQuantity,
        takeOutTotal,
        deliveryQuantity,
        deliveryTotal,
        quickServiceQuantity,
        quickServiceTotal,
        barQuantity,
        barTotal,
        grandQuantity,
        grandTotal,
        categoryTitle,
        categoryId
      ];

  ReportsCategoryModel copyWith({
    int? dineInQuantity,
    int? dineInTotal,
    int? takeOutQuantity,
    int? takeOutTotal,
    int? deliveryQuantity,
    int? deliveryTotal,
    int? quickServiceQuantity,
    int? quickServiceTotal,
    int? barQuantity,
    int? barTotal,
    int? grandQuantity,
    int? grandTotal,
    String? categoryTitle,
    String? categoryId,
  }) =>
      ReportsCategoryModel(
        dineInQuantity: dineInQuantity ?? this.dineInQuantity,
        dineInTotal: dineInTotal ?? this.dineInTotal,
        takeOutQuantity: takeOutQuantity ?? this.takeOutQuantity,
        takeOutTotal: takeOutTotal ?? this.takeOutTotal,
        deliveryQuantity: deliveryQuantity ?? this.deliveryQuantity,
        deliveryTotal: deliveryTotal ?? this.deliveryTotal,
        quickServiceQuantity: quickServiceQuantity ?? this.quickServiceQuantity,
        quickServiceTotal: quickServiceTotal ?? this.quickServiceTotal,
        barQuantity: barQuantity ?? this.barQuantity,
        barTotal: barTotal ?? this.barTotal,
        grandQuantity: grandQuantity ?? this.grandQuantity,
        grandTotal: grandTotal ?? this.grandTotal,
        categoryTitle: categoryTitle ?? this.categoryTitle,
        categoryId: categoryId ?? this.categoryId,
      );
}
