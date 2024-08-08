// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'option_model.g.dart';

@JsonSerializable()
class OptionModel extends BaseModel<OptionModel> {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  @JsonKey(name: 'special_name')
  final String? specialName;
  @JsonKey(name: 'choose_limit')
  final int? chooseLimit;
  final int? state;
  final List<Item>? items;

  OptionModel({
    this.id,
    this.name,
    this.specialName,
    this.chooseLimit,
    this.state,
    this.items,
  });

  factory OptionModel.empty() =>
      OptionModel(id: '', name: '', specialName: ' ', chooseLimit: 0, state: 1, items: const []);
  factory OptionModel.fromJson(Map<String, dynamic> json) => _$OptionModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$OptionModelToJson(this);

  @override
  OptionModel fromJson(Map<String, dynamic> json) => _$OptionModelFromJson(json);
  @override
  List<Object?> get props => [id, name, specialName, chooseLimit, state, items];

  OptionModel copyWith({
    String? id,
    String? name,
    String? specialName,
    int? chooseLimit,
    int? state,
    List<Item>? items,
  }) {
    return OptionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specialName: specialName ?? this.specialName,
      chooseLimit: chooseLimit ?? this.chooseLimit,
      state: state ?? this.state,
      items: items ?? this.items,
    );
  }
}

@JsonSerializable(includeIfNull: false)
class Item extends BaseModel<Item> {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'item_name')
  final String? itemName;
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

  Item(
      {this.id,
      this.itemName,
      this.lunchPrice,
      this.happyHourPrice,
      this.deliveryPrice,
      this.takeOutPrice,
      this.price,
      this.product,
      this.amount,
      this.vatRate});

  factory Item.empty() => Item(
      itemName: ' ',
      price: 0,
      deliveryPrice: 0,
      happyHourPrice: 0,
      lunchPrice: 0,
      takeOutPrice: 0,
      product: null,
      amount: null,
      vatRate: 0);
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  Item fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  @override
  List<Object?> get props => [
        id,
        itemName,
        price,
        deliveryPrice,
        happyHourPrice,
        lunchPrice,
        takeOutPrice,
        product,
        amount,
        vatRate
      ];

  Item copyWith({
    String? Function()? id,
    String? itemName,
    double? price,
    double? lunchPrice,
    double? happyHourPrice,
    double? deliveryPrice,
    double? takeOutPrice,
    String? product,
    int? amount,
    int? vatRate,
  }) {
    return Item(
        id: id != null ? id() : this.id,
        itemName: itemName ?? this.itemName,
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
