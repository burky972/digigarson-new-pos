import 'package:core/base/model/base_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'special_item_request_model.g.dart';

@JsonSerializable(includeIfNull: false)
class SpecialItemRequestModel extends BaseModel<SpecialItemRequestModel> {
  final String? title;
  final String? image;
  final List<PriceModel>? prices;
  final bool? isSpecial;
  final String? description;
  @JsonKey(name: 'active_list')
  final List<int>? activeList;
  final bool? favorite;
  final bool? opportunity;
  final List<dynamic>? allergen;
  final String? calorie;
  final String? branch;
  final int? rank;

  SpecialItemRequestModel({
    this.title,
    this.image,
    this.prices,
    this.description,
    this.isSpecial,
    this.activeList,
    this.favorite,
    this.opportunity,
    this.allergen,
    this.calorie,
    this.rank,
    this.branch,
  });
  // Empty SpecialItemRequestModel instance
  factory SpecialItemRequestModel.empty() {
    return SpecialItemRequestModel(
      title: '',
      image: '',
      prices: [PriceModel.empty()],
      description: '',
      activeList: const [],
      favorite: false,
      allergen: const [],
      calorie: '',
      rank: 0,
      opportunity: false,
      isSpecial: true,
      branch: '',
    );
  }

  factory SpecialItemRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialItemRequestModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SpecialItemRequestModelToJson(this);

  @override
  SpecialItemRequestModel fromJson(Map<String, dynamic> json) =>
      _$SpecialItemRequestModelFromJson(json);
  @override
  List<Object?> get props => [
        title,
        image,
        prices,
        description,
        activeList,
        favorite,
        opportunity,
        allergen,
        calorie,
        isSpecial,
        rank,
        branch
      ];

  SpecialItemRequestModel copyWith({
    String? title,
    String? Function()? image,
    List<PriceModel>? prices,
    String? description,
    List<int>? activeList,
    bool? isSpecial,
    bool? favorite,
    bool? opportunity,
    List<dynamic>? allergen,
    String? calorie,
    String? branch,
    int? rank,
  }) {
    return SpecialItemRequestModel(
      title: title ?? this.title,
      image: image != null ? image() : this.image,
      prices: prices ?? this.prices,
      description: description ?? this.description,
      isSpecial: isSpecial ?? this.isSpecial,
      activeList: activeList ?? this.activeList,
      favorite: favorite ?? this.favorite,
      opportunity: opportunity ?? this.opportunity,
      allergen: allergen ?? this.allergen,
      calorie: calorie ?? this.calorie,
      branch: branch ?? this.branch,
      rank: rank ?? this.rank,
    );
  }
}

@JsonSerializable(includeIfNull: false)
class PriceModel extends Equatable {
  final double? amount;
  final String? priceName;
  final String? priceType;
  final String? currency;
  @JsonKey(name: 'order_type')
  final List<dynamic>? orderType;
  @JsonKey(name: 'vat_rate')
  final double? vatRate;
  final double? price;

  const PriceModel({
    this.amount,
    this.priceName,
    this.priceType,
    this.currency,
    this.orderType,
    this.vatRate,
    this.price,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) => _$PriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PriceModelToJson(this);

  factory PriceModel.empty() {
    return const PriceModel(
      amount: 1.0,
      priceName: 'REGULAR',
      priceType: 'REGULAR',
      currency: 'USD',
      orderType: [],
      vatRate: 0.0,
      price: 0.0,
    );
  }
  @override
  List<Object?> get props => [amount, priceName, priceType, currency, orderType, vatRate, price];

  PriceModel copyWith({
    double? amount,
    String? priceName,
    String? priceType,
    String? currency,
    List<dynamic>? orderType,
    double? vatRate,
    double? price,
  }) {
    return PriceModel(
      amount: amount ?? this.amount,
      priceName: priceName ?? this.priceName,
      priceType: priceType ?? this.priceType,
      currency: currency ?? this.currency,
      orderType: orderType ?? this.orderType,
      vatRate: vatRate ?? this.vatRate,
      price: price ?? this.price,
    );
  }
}
