class ReOpenModel {
  final String text;
  final double width;
  const ReOpenModel({required this.text, required this.width});
}

class OrderModel {
  late String orderId;
  late String table;
  late double gratuity;
  late int gst;
  late List<ItemModel> item;
  late double cash;
  late double card;
  late double total;
  late String closedBy;
  late DateTime openDate;
  late DateTime closedDate;
  late double discount;
  late double service;
  late double cover;
  late double Tax;

  OrderModel(
      {required this.orderId,
      required this.table,
      required this.gratuity,
      required this.gst,
      required this.item,
      required this.cash,
      required this.card,
      required this.total,
      required this.closedBy,
      required this.openDate,
      required this.closedDate,
      required this.discount,
      required this.service,
      required this.cover,
      required this.Tax});
}

class ItemModel {
  late int statusType;
  late double price;
  late double quantitty;
  late String itemName;
  ItemModel(
      {required this.statusType,
      required this.itemName,
      required this.price,
      required this.quantitty});
}
