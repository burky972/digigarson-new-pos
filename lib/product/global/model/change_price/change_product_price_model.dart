import 'dart:convert';


class ChangeProductPriceModel {
  String? tableId;
  // List<OrderPay>? orders;

  ChangeProductPriceModel({
    this.tableId,
    // this.orders,
  });

  factory ChangeProductPriceModel.fromJson(String str) =>
      ChangeProductPriceModel.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
        "tableId": tableId,
        // "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
      };

  String toJson() => json.encode(toMap());

  factory ChangeProductPriceModel.fromMap(Map<String, dynamic> json) => ChangeProductPriceModel(
        tableId: json["tableId"],
        // orders: json["orders"] == null
        //   ? []
        //   : List<OrderPay>.from(json["orders"]!.map((x) => Product.fromJson(x)))
      );

  ChangeProductPriceModel copyWith({
    String? tableId,
    // List<OrderPay>? orders,
  }) {
    return ChangeProductPriceModel(
      tableId: tableId ?? this.tableId,
      // orders: orders ?? this.orders,
    );
  }
}
