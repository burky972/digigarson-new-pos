import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reports_product_model.g.dart';

@JsonSerializable()
class ReportsProductModel extends BaseModel<ReportsProductModel> {
  ReportsProductModel({
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
    required this.products,
  });
  final int? dineInQuantity;
  final int? dineInTotal;
  final int? takeOutQuantity;
  final int? takeOutTotal;
  final int? deliveryQuantity;
  final int? deliveryTotal;
  final int? quickServiceQuantity;
  final int? quickServiceTotal;
  final int? barQuantity;
  final int? barTotal;
  final int? grandQuantity;
  final int? grandTotal;
  final String? categoryTitle;
  final String? categoryId;
  final List<ProductReportModel>? products;

  factory ReportsProductModel.fromJson(Map<String, dynamic> json) =>
      _$ReportsProductModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReportsProductModelToJson(this);

  @override
  ReportsProductModel fromJson(Map<String, dynamic> json) => _$ReportsProductModelFromJson(json);

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
        categoryId,
        products
      ];
}

@JsonSerializable()
class ProductReportModel extends BaseModel<ProductReportModel> {
  ProductReportModel({
    this.id,
    this.dineInQuantity,
    this.dineInTotal,
    this.takeOutQuantity,
    this.takeOutTotal,
    this.deliveryQuantity,
    this.deliveryTotal,
    this.quickServiceQuantity,
    this.quickServiceTotal,
    this.barQuantity,
    this.barTotal,
    this.grandQuantity,
    this.grandTotal,
    this.sId,
    this.title,
  });
  @JsonKey(name: '_id')
  final String? id;
  final int? dineInQuantity;
  final int? dineInTotal;
  final int? takeOutQuantity;
  final int? takeOutTotal;
  final int? deliveryQuantity;
  final int? deliveryTotal;
  final int? quickServiceQuantity;
  final int? quickServiceTotal;
  final int? barQuantity;
  final int? barTotal;
  final int? grandQuantity;
  final int? grandTotal;
  final String? sId;
  final String? title;

  factory ProductReportModel.fromJson(Map<String, dynamic> json) =>
      _$ProductReportModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProductReportModelToJson(this);

  @override
  ProductReportModel fromJson(Map<String, dynamic> json) => _$ProductReportModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
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
        sId,
        title
      ];
}
