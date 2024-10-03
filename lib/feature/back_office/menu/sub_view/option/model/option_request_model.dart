import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'option_request_model.g.dart';

@JsonSerializable(includeIfNull: false)
class OptionRequestModel extends BaseModel<OptionRequestModel> {
  final String? name;
  @JsonKey(name: 'special_name')
  final String? specialName;
  @JsonKey(name: 'choose_limit')
  final int? chooseLimit;
  final int? state;
  final List<ItemRequestModel>? items;

  OptionRequestModel({
    this.name,
    this.specialName,
    this.chooseLimit,
    this.state,
    this.items,
  });

  factory OptionRequestModel.empty() =>
      OptionRequestModel(name: '', specialName: ' ', chooseLimit: 0, state: 1, items: const []);
  factory OptionRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OptionRequestModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$OptionRequestModelToJson(this);

  @override
  OptionRequestModel fromJson(Map<String, dynamic> json) => _$OptionRequestModelFromJson(json);
  @override
  List<Object?> get props => [name, specialName, chooseLimit, state, items];

  OptionRequestModel copyWith({
    String? name,
    String? specialName,
    int? chooseLimit,
    int? state,
    List<ItemRequestModel>? items,
  }) {
    return OptionRequestModel(
      name: name ?? this.name,
      specialName: specialName ?? this.specialName,
      chooseLimit: chooseLimit ?? this.chooseLimit,
      state: state ?? this.state,
      items: items ?? this.items,
    );
  }
}

@JsonSerializable(includeIfNull: false)
class ItemRequestModel extends BaseModel<ItemRequestModel> {
  @JsonKey(name: 'item_name')
  final String? itemName;
  final String? priceType;
  final double? price;
  @JsonKey(name: 'lunch_price')
  final double? lunchPrice;
  @JsonKey(name: 'happy_hour_price')
  final double? happyHourPrice;
  @JsonKey(name: 'delivery_price')
  final double? deliveryPrice;
  @JsonKey(name: 'take_out_price')
  final double? takeOutPrice;
  final String? product;
  final int? amount;
  @JsonKey(name: 'vat_rate')
  final int? vatRate;

  ItemRequestModel(
      {this.itemName,
      this.priceType,
      this.lunchPrice,
      this.happyHourPrice,
      this.deliveryPrice,
      this.takeOutPrice,
      this.price,
      this.product,
      this.amount,
      this.vatRate});

  factory ItemRequestModel.empty() => ItemRequestModel(
      itemName: ' ',
      priceType: 'REGULAR',
      price: 0,
      deliveryPrice: 0,
      happyHourPrice: 0,
      lunchPrice: 0,
      takeOutPrice: 0,
      product: null,
      amount: null,
      vatRate: 0);
  factory ItemRequestModel.fromJson(Map<String, dynamic> json) => _$ItemRequestModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ItemRequestModelToJson(this);

  @override
  ItemRequestModel fromJson(Map<String, dynamic> json) => _$ItemRequestModelFromJson(json);

  @override
  List<Object?> get props => [
        itemName,
        priceType,
        price,
        deliveryPrice,
        happyHourPrice,
        lunchPrice,
        takeOutPrice,
        product,
        amount,
        vatRate
      ];

  ItemRequestModel copyWith({
    String? itemId,
    String? itemName,
    String? priceType,
    double? price,
    double? lunchPrice,
    double? happyHourPrice,
    double? deliveryPrice,
    double? takeOutPrice,
    String? product,
    int? amount,
    int? vatRate,
  }) {
    return ItemRequestModel(
        itemName: itemName ?? this.itemName,
        priceType: priceType ?? this.priceType,
        price: price ?? this.price,
        lunchPrice: lunchPrice ?? this.lunchPrice,
        happyHourPrice: happyHourPrice ?? this.happyHourPrice,
        deliveryPrice: deliveryPrice ?? this.deliveryPrice,
        takeOutPrice: takeOutPrice ?? this.takeOutPrice,
        product: product ?? this.product,
        amount: amount ?? this.amount,
        vatRate: vatRate ?? this.vatRate);
  }
}
