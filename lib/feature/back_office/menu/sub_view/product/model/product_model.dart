// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(includeIfNull: false)
class ProductModel extends BaseModel<ProductModel> {
  final String? id;
  final String? title;
  final String? image;
  final String? category;
  final List<PriceModel>? prices;
  final String? description;
  @JsonKey(name: 'active_list')
  final List<dynamic>? activeList;
  final List<dynamic>? options;
  final bool? favorite;
  final bool? opportunity;
  final List<dynamic>? allergen;
  final String? calorie;
  final String? branch;
  final int? rank;

  ProductModel({
    this.id,
    this.title,
    this.image,
    this.category,
    this.prices,
    this.description,
    this.activeList,
    this.options,
    this.favorite,
    this.opportunity,
    this.allergen,
    this.calorie,
    this.rank,
    this.branch,
  });
  // Empty ProductModel instance
  factory ProductModel.empty() {
    return ProductModel(
      id: '',
      title: '',
      image: '',
      category: '',
      prices: [PriceModel.empty()],
      description: '',
      activeList: const [],
      options: const [],
      favorite: false,
      allergen: const [],
      calorie: '',
      rank: 0,
      opportunity: false,
      branch: '',
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  ProductModel fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  @override
  List<Object?> get props => [
        id,
        title,
        image,
        category,
        prices,
        description,
        activeList,
        options,
        favorite,
        opportunity,
        allergen,
        calorie,
        rank,
        branch
      ];

  ProductModel copyWith({
    String? id,
    String? title,
    String? image,
    String? category,
    List<PriceModel>? prices,
    String? description,
    List<dynamic>? activeList,
    List<dynamic>? options,
    bool? favorite,
    bool? opportunity,
    List<dynamic>? allergen,
    String? calorie,
    String? branch,
    int? rank,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      category: category ?? this.category,
      prices: prices ?? this.prices,
      description: description ?? this.description,
      activeList: activeList ?? this.activeList,
      options: options ?? this.options,
      favorite: favorite ?? this.favorite,
      opportunity: opportunity ?? this.opportunity,
      allergen: allergen ?? this.allergen,
      calorie: calorie ?? this.calorie,
      branch: branch ?? this.branch,
      rank: rank ?? this.rank,
    );
  }
}

@JsonSerializable()
class PriceModel extends BaseModel<PriceModel> {
  @JsonKey(name: '_id')
  final String? id;
  final double? amount;
  final String? priceName;
  final String? currency;
  @JsonKey(name: 'order_type')
  final List<dynamic>? orderType;
  @JsonKey(name: 'vat_rate')
  final double? vatRate;
  final double? price;

  PriceModel({
    this.id,
    this.amount,
    this.priceName,
    this.currency,
    this.orderType,
    this.vatRate,
    this.price,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) => _$PriceModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PriceModelToJson(this);

  @override
  PriceModel fromJson(Map<String, dynamic> json) => _$PriceModelFromJson(json);

  factory PriceModel.empty() {
    return PriceModel(
      id: '',
      amount: 0.0,
      priceName: 'Custom Price',
      currency: '',
      orderType: const [],
      vatRate: 0.0,
      price: 0.0,
    );
  }
  @override
  List<Object?> get props => [id, amount, priceName, currency, orderType, vatRate, price];

  PriceModel copyWith({
    String? id,
    double? amount,
    String? priceName,
    String? currency,
    List<dynamic>? orderType,
    double? vatRate,
    double? price,
  }) {
    return PriceModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      priceName: priceName ?? this.priceName,
      currency: currency ?? this.currency,
      orderType: orderType ?? this.orderType,
      vatRate: vatRate ?? this.vatRate,
      price: price ?? this.price,
    );
  }
}
