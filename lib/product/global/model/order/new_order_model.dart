import 'dart:convert';

class NewOrderModel {
  String tableId;
  List<NewOrderProduct> products;

  NewOrderModel({
    required this.tableId,
    required this.products,
  });

  factory NewOrderModel.fromJson(String str) => NewOrderModel.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };

  String toJson() => json.encode(toMap());

  factory NewOrderModel.fromMap(Map<String, dynamic> json) => NewOrderModel(
        products:
            List<NewOrderProduct>.from(json["products"].map((x) => NewOrderProduct.fromMap(x))),
        tableId: '',
      );
}

class NewOrderProduct {
  bool isFirst;
  String product;
  String productName;
  double quantity;
  String categoryId;
  double price;
  String priceId;
  String priceName;
  String note;
  List<NewOrderOption> options;

  NewOrderProduct({
    required this.isFirst,
    required this.product,
    required this.productName,
    required this.quantity,
    required this.categoryId,
    required this.price,
    required this.priceId,
    required this.priceName,
    required this.note,
    required this.options,
  });

  NewOrderProduct clone() {
    return NewOrderProduct(
      price: price,
      isFirst: isFirst,
      note: note,
      options: List.from(options),
      priceId: priceId,
      categoryId: categoryId,
      priceName: priceName,
      product: product,
      productName: productName,
      quantity: quantity,
    );
  }

  factory NewOrderProduct.fromJson(String str) => NewOrderProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewOrderProduct.fromMap(Map<String, dynamic> json) => NewOrderProduct(
        product: json["product"],
        productName: json["productName"],
        isFirst: json["isFirst"],
        quantity: json["quantity"],
        categoryId: json["categoryId"],
        price: json["price"],
        priceId: json["priceId"],
        priceName: json["priceName"],
        note: "",
        options: List<NewOrderOption>.from(json["options"].map((x) => NewOrderOption.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "product": product,
        "isFirst": isFirst,
        "categoryId": categoryId,
        "quantity": quantity,
        "price": priceId,
        "note": note,
        "options": List<dynamic>.from(options.map((x) => x.toMap())),
      };
}

class NewOrderOption {
  String nameOption;
  String optionId;
  List<NewOrderItem> items;

  NewOrderOption({
    required this.nameOption,
    required this.optionId,
    required this.items,
  });

  factory NewOrderOption.fromJson(String str) => NewOrderOption.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewOrderOption.fromMap(Map<String, dynamic> json) => NewOrderOption(
        nameOption: json["nameOption"],
        optionId: json["optionId"],
        items: List<NewOrderItem>.from(json["items"].map((x) => NewOrderItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "nameOption": nameOption,
        "option_id": optionId,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class NewOrderItem {
  String name;
  String itemId;
  double price;

  NewOrderItem({
    required this.name,
    required this.itemId,
    required this.price,
  });

  factory NewOrderItem.fromJson(String str) => NewOrderItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewOrderItem.fromMap(Map<String, dynamic> json) => NewOrderItem(
        name: json["name"],
        itemId: json["itemId"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "item_id": itemId,
        "price": price,
      };
}

class NewService {
  String tableId;
  double amount;
  int type;

  NewService({
    required this.tableId,
    required this.type,
    required this.amount,
  });

  factory NewService.fromJson(String str) => NewService.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "tableId": tableId,
        "type": type,
      };

  String toJson() => json.encode(toMap());

  factory NewService.fromMap(Map<String, dynamic> json) => NewService(
      amount: double.parse(json["amount"].toString()),
      tableId: json["tableId"],
      type: int.parse(json["type"].toString()));
}

class NewDiscount {
  String tableId;
  String note;
  double amount;
  int type;

  NewDiscount({
    required this.tableId,
    required this.note,
    required this.type,
    required this.amount,
  });

  factory NewDiscount.fromJson(String str) => NewDiscount.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "tableId": tableId,
        "type": type,
        "note": note,
      };

  String toJson() => json.encode(toMap());

  factory NewDiscount.fromMap(Map<String, dynamic> json) => NewDiscount(
      amount: double.parse(json["amount"].toString()),
      tableId: json["tableId"].toString(),
      note: json["note"].toString(),
      type: int.parse(json["type"].toString()));
}

class DeleteDiscount {
  String tableId;
  String discountId;
  double amount;

  DeleteDiscount({
    required this.tableId,
    required this.discountId,
    required this.amount,
  });

  factory DeleteDiscount.fromJson(String str) => DeleteDiscount.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "tableId": tableId,
        "discountId": discountId,
      };

  String toJson() => json.encode(toMap());

  factory DeleteDiscount.fromMap(Map<String, dynamic> json) => DeleteDiscount(
      amount: double.parse(json["amount"].toString()),
      tableId: json["tableId"].toString(),
      discountId: json["discountId"].toString());
}

class NewCover {
  String tableId;
  String title;
  double price;
  double perc;
  int type;
  int quantity;

  NewCover({
    required this.tableId,
    required this.title,
    required this.type,
    required this.quantity,
    required this.price,
    required this.perc,
  });

  factory NewCover.fromJson(String str) => NewCover.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
        "price": price,
        "perc": perc,
        "tableId": tableId,
        "type": type,
        "quantity": quantity,
        "title": title,
      };

  String toJson() => json.encode(toMap());

  factory NewCover.fromMap(Map<String, dynamic> json) => NewCover(
      price: double.parse(json["price"].toString()),
      perc: double.parse(json["perc"].toString()),
      tableId: json["tableId"].toString(),
      title: json["title"].toString(),
      type: int.parse(json["type"].toString()),
      quantity: int.parse(json["quantity"].toString()));
}

class DeleteCover {
  String tableId;
  String coverId;
  double coverPrice;

  DeleteCover({
    required this.tableId,
    required this.coverId,
    required this.coverPrice,
  });

  factory DeleteCover.fromJson(String str) => DeleteCover.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
        "coverPrice": coverPrice,
        "tableId": tableId,
        "coverId": coverId,
      };

  String toJson() => json.encode(toMap());

  factory DeleteCover.fromMap(Map<String, dynamic> json) => DeleteCover(
      coverPrice: double.parse(json["coverPrice"].toString()),
      tableId: json["tableId"].toString(),
      coverId: json["coverId"].toString());
}
