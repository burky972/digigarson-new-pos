// import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';

// class OrderProductModel {
//   bool isFirst;
//   String product;
//   int quantity;
//   double price;
//   String note;
//   List<Options> options;
//   ServeInfoModel serveInfo;
 
//   String id;
//   String productName;
//   String priceId;
//   bool isServe;
//   String serveId;
//   String createdAt;

//   OrderProductModel({
//     required this.isFirst,
//     required this.isDeleted,
//     required this.isPrint,
//     required this.optionsString,
//     required this.status,
//     required this.note,
//     required this.id,
//     required this.product,
//     required this.productName,
//     required this.quantity,
//     required this.priceId,
//     required this.price,
//     required this.isServe,
//     required this.serveId,
//     required this.createdAt,
//   });

//   factory OrderProductModel.fromJson(Map<String, dynamic> json) {
//     return OrderProductModel(
//       isFirst: json['isFirst'],
//       isDeleted: json['isDeleted'],
//       isPrint: json['isPrint'],
//       optionsString: json['optionsString'],
//       status: json['status'],
//       note: json['note'],
//       id: json['_id'],
//       product: json['product'],
//       productName: json['productName'],
//       quantity: json['quantity'],
//       priceId: json['priceId'],
//       price: json['price'].toDouble(),
//       isServe: json['isServe'],
//       serveId: json['serveId'],
//       createdAt: json['createdAt'],
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'isFirst': isFirst,
//       'isDeleted': isDeleted,
//       'isPrint': isPrint,
//       'optionsString': optionsString,
//       'status': status,
//       'note': note,
//       '_id': id,
//       'product': product,
//       'productName': productName,
//       'quantity': quantity,
//       'priceId': priceId,
//       'price': price,
//       'isServe': isServe,
//       'serveId': serveId,
//       'createdAt': createdAt,
//     };
//   }
// }

// //TODO: odemede istek atilirken kullanilan model!!

// class OrderPay {
//   int orderNum;
//   List<OrderProductModel> products;

//   OrderPay({
//     required this.orderNum,
//     required this.products,
//   });

//   factory OrderPay.fromJson(Map<String, dynamic> json) {
//     var productList = json['products'] as List;
//     List<OrderProductModel> products =
//         productList.map((product) => OrderProductModel.fromJson(product)).toList();

//     return OrderPay(
//       orderNum: json['orderNum'],
//       products: products,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['orderNum'] = orderNum;
//     data['products'] = products;
//     return data;
//   }
// }

// class PayData {
//   String tableId;
//   List<OrderPay> orders;
//   List<Payment> payments;

//   PayData({
//     required this.tableId,
//     required this.orders,
//     required this.payments,
//   });

//   factory PayData.fromJson(Map<String, dynamic> json) {
//     var orderList = json['orders'] as List;
//     List<OrderPay> orders = orderList.map((order) => OrderPay.fromJson(order)).toList();

//     var paymentList = json['payments'] as List;
//     List<Payment> payments = paymentList.map((payment) => Payment.fromJson(payment)).toList();

//     return PayData(
//       tableId: json['tableId'],
//       orders: orders,
//       payments: payments,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['payments'] = payments;
//     data['orders'] = orders;
//     data['tableId'] = tableId;
//     return data;
//   }
// }
