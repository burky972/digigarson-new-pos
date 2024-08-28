import 'dart:convert';

import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';

class OldCheckModel {
  String? sId;
  bool? isItPaid;
  List<Covers>? covers;
  String? branch;
  int? orderType;
  List<Payments>? payments;
  List<Orders>? orders;
  String? table;
  String? caseId;
  User? user;
  List<Discount>? discounts;
  String? customerCount;
  List<ServiceFee>? serviceFee;
  int? checkNo;
  DateTime? createdAt;
  DateTime? updatedAt;

  OldCheckModel({
    this.sId,
    this.isItPaid,
    this.covers,
    this.branch,
    this.orderType,
    this.payments,
    this.orders,
    this.table,
    this.caseId,
    this.user,
    this.discounts,
    this.customerCount,
    this.serviceFee,
    this.checkNo,
    this.createdAt,
    this.updatedAt,
  });

  OldCheckModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] != null ? json['_id'].toString() : "";
    isItPaid = json['is_it_paid'] ?? false;
    if (json['covers'] != null) {
      covers = <Covers>[];
      json['covers'].forEach((v) {
        covers!.add(Covers.fromJson(v));
      });
    }
    branch = json['branch'] ?? "";
    orderType = json['order_type'] ?? 0;
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments!.add(Payments.fromJson(v));
      });
    }
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    table = json['table'] != null ? json['table'].toString() : "";
    caseId = json['caseId'] != null ? json['caseId'].toString() : "";
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['discounts'] != null) {
      discounts = <Discount>[];
      json['discounts'].forEach((v) {
        discounts!.add(Discount.fromJson(v));
      });
    }
    customerCount = json['customerCount'] != null ? json['customerCount'].toString() : "";
    if (json['serviceFee'] != null) {
      serviceFee = <ServiceFee>[];
      json['serviceFee'].forEach((v) {
        serviceFee!.add(ServiceFee.fromJson(v));
      });
    }
    checkNo = json['checkNo'] ?? 0;
    createdAt = json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null;
    updatedAt = json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['is_it_paid'] = isItPaid;
    if (covers != null) {
      data['covers'] = covers!.map((v) => v.toJson()).toList();
    }
    data['branch'] = branch;
    data['order_type'] = orderType;
    if (payments != null) {
      data['payments'] = payments!.map((v) => v.toJson()).toList();
    }
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    data['table'] = table;
    data['caseId'] = caseId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (discounts != null) {
      data['discounts'] = discounts!.map((v) => v.toJson()).toList();
    }
    data['customerCount'] = customerCount;
    if (serviceFee != null) {
      data['serviceFee'] = serviceFee!.map((v) => v.toJson()).toList();
    }
    data['checkNo'] = checkNo;
    data['createdAt'] = createdAt.toString();
    data['updatedAt'] = updatedAt.toString();
    return data;
  }
}

class Covers {
  bool? isPaid;
  String? sId;
  String? title;
  double? quantity;
  double? price;

  Covers({this.isPaid, this.sId, this.title, this.quantity, this.price});

  Covers.fromJson(Map<String, dynamic> json) {
    isPaid = json['is_paid'] ?? false;
    sId = json['_id'] ?? "";
    title = json['title'] ?? "";
    quantity = json['quantity'] != null ? double.parse(json['quantity'].toString()) : 0;
    price = json['price'] != null ? double.parse(json['price'].toString()) : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_paid'] = isPaid;
    data['_id'] = sId;
    data['title'] = title;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}

class Payments {
  String? sId;
  int? type;
  double? amount;
  String? currency;
  DateTime? createdAt;
  DateTime? updatedAt;

  Payments({this.sId, this.type, this.amount, this.currency, this.createdAt, this.updatedAt});

  Payments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] != null ? json['_id'].toString() : "";
    type = json['type'] ?? 0;
    amount = json['amount'] != null ? double.parse(json['amount'].toString()) : 0;
    currency = json['currency'] ?? "";
    createdAt = json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null;
    updatedAt = json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['type'] = type;
    data['amount'] = amount;
    data['currency'] = currency;
    data['createdAt'] = createdAt.toString();
    data['updatedAt'] = updatedAt.toString();
    return data;
  }
}

class Orders {
  IsPrint? isPrint;
  int? checkNo;
  bool? transferred;
  List<Orders>? cancelledOrders;
  int? orderType;
  int? orderStatus;
  List<Discount>? discount;
  List<Covers>? cover;
  double? totalPrice;
  double? remainingPrice;
  int? status;
  bool? isCancelled;
  String? sId;
  int? orderNum;
  List<OldProducts>? products;
  String? waiterId;
  DateTime? updatedAt;
  DateTime? createdAt;
  DateTime? transferredDate;
  String? transferredFrom;

  Orders(
      {this.isPrint,
      this.checkNo,
      this.transferred,
      this.cancelledOrders,
      this.orderType,
      this.orderStatus,
      this.discount,
      this.cover,
      this.totalPrice,
      this.remainingPrice,
      this.status,
      this.isCancelled,
      this.sId,
      this.orderNum,
      this.products,
      this.waiterId,
      this.updatedAt,
      this.createdAt,
      this.transferredDate,
      this.transferredFrom});

  Orders.fromJson(Map<String, dynamic> json) {
    isPrint = json['isPrint'] != null ? IsPrint.fromJson(json['isPrint']) : null;
    checkNo = json['checkNo'] ?? 0;
    transferred = json['transferred'] ?? "";
    if (json['cancelled_orders'] != null) {
      cancelledOrders = <Orders>[];
      json['cancelled_orders'].forEach((v) {
        cancelledOrders!.add(Orders.fromJson(v));
      });
    }
    orderType = json['order_type'] ?? 0;
    orderStatus = json['order_status'] ?? 0;
    if (json['discount'] != null) {
      discount = <Discount>[];
      json['discount'].forEach((v) {
        discount!.add(Discount.fromJson(v));
      });
    }
    if (json['cover'] != null) {
      cover = <Covers>[];
      json['cover'].forEach((v) {
        cover!.add(Covers.fromJson(v));
      });
    }
    totalPrice = json['totalPrice'] != null ? double.parse(json['totalPrice'].toString()) : 0;
    remainingPrice =
        json['remainingPrice'] != null ? double.parse(json['remainingPrice'].toString()) : 0;
    status = json['status'] ?? 0;
    isCancelled = json['isCancelled'] ?? false;
    sId = json['_id'] != null ? json['_id'].toString() : "";
    orderNum = json['orderNum'] ?? 0;
    if (json['products'] != null) {
      products = <OldProducts>[];
      json['products'].forEach((v) {
        products!.add(OldProducts.fromJson(v));
      });
    }
    waiterId = json['waiterId'] != null ? json['waiterId'].toString() : "";
    createdAt = json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null;
    updatedAt = json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'].toString()) : null;
    transferredDate = json['transferredDate'] != null
        ? DateTime.tryParse(json['transferredDate'].toString())
        : null;
    transferredFrom = json['transferredFrom'] != null ? json['transferredFrom'].toString() : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (isPrint != null) {
      data['isPrint'] = isPrint!.toJson();
    }
    data['checkNo'] = checkNo;
    data['transferred'] = transferred;
    if (cancelledOrders != null) {
      data['cancelled_orders'] = cancelledOrders!.map((v) => v.toJson()).toList();
    }
    data['order_type'] = orderType;
    data['order_status'] = orderStatus;
    if (discount != null) {
      data['discount'] = discount!.map((v) => v.toJson()).toList();
    }
    if (cover != null) {
      data['cover'] = cover!.map((v) => v.toJson()).toList();
    }
    data['totalPrice'] = totalPrice;
    data['remainingPrice'] = remainingPrice;
    data['status'] = status;
    data['isCancelled'] = isCancelled;
    data['_id'] = sId;
    data['orderNum'] = orderNum;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['waiterId'] = waiterId;
    data['updatedAt'] = updatedAt.toString();
    data['createdAt'] = createdAt.toString();
    data['transferredDate'] = transferredDate.toString();
    data['transferredFrom'] = transferredFrom;
    return data;
  }
}

class IsPrint {
  bool? status;
  bool? print;

  IsPrint({this.status, this.print});

  IsPrint.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    print = json['print'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['print'] = print;
    return data;
  }
}

class OldProducts {
  bool? isFirst;
  bool? isDeleted;
  bool? isPrint;
  String? optionsString;
  List<Options>? options;
  List<Discount>? discount;
  int? status;
  String? note;
  DateTime? createdAt;
  String? sId;
  String? product;
  String? productName;
  double? quantity;
  String? priceId;
  double? price;
  bool? isServe;
  String? serveId;
  DateTime? updatedAt;

  OldProducts(
      {this.isFirst,
      this.isDeleted,
      this.isPrint,
      this.optionsString,
      this.options,
      this.discount,
      this.status,
      this.note,
      this.createdAt,
      this.sId,
      this.product,
      this.productName,
      this.quantity,
      this.priceId,
      this.price,
      this.isServe,
      this.serveId,
      this.updatedAt});

  OldProducts.fromJson(Map<String, dynamic> json) {
    isFirst = json['isFirst'] ?? false;
    isDeleted = json['isDeleted'] ?? false;
    isPrint = json['isPrint'] ?? false;
    optionsString = json['optionsString'] != null ? json['optionsString'].toString() : "";
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    if (json['discount'] != null) {
      discount = <Discount>[];
      json['discount'].forEach((v) {
        discount!.add(Discount.fromJson(v));
      });
    }
    status = json['status'] ?? 0;
    note = json['note'] != null ? json['note'].toString() : "";
    createdAt = json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null;
    sId = json['_id'] != null ? json['_id'].toString() : "";
    product = json['product'] != null ? json['product'].toString() : "";
    productName = json['productName'] != null ? json['productName'].toString() : "";
    quantity = json['quantity'] != null ? double.parse(json['quantity'].toString()) : 0;
    priceId = json['priceId'] != null ? json['priceId'].toString() : "";
    price = json['price'] != null ? double.parse(json['price'].toString()) : 0;
    isServe = json['isServe'] ?? false;
    serveId = json['serveId'] != null ? json['serveId'].toString() : "";
    updatedAt = json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isFirst'] = isFirst;
    data['isDeleted'] = isDeleted;
    data['isPrint'] = isPrint;
    data['optionsString'] = optionsString;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    if (discount != null) {
      data['discount'] = discount!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['note'] = note;
    data['createdAt'] = createdAt.toString();
    data['_id'] = sId;
    data['product'] = product;
    data['productName'] = productName;
    data['quantity'] = quantity;
    data['priceId'] = priceId;
    data['price'] = price;
    data['isServe'] = isServe;
    data['serveId'] = serveId;
    data['updatedAt'] = updatedAt.toString();
    return data;
  }
}

class Options {
  String? optionId;
  String? name;
  List<Item>? items;

  Options({this.optionId, this.name, this.items});

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'] != null ? json['option_id'].toString() : "";
    name = json['name'] != null ? json['name'].toString() : "";
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option_id'] = optionId;
    data['name'] = name;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? sId;
  List<int>? permissions;
  bool? isDeleted;
  String? role;
  String? branchId;
  String? password;
  String? lastname;
  String? name;
  int? branchCustomId;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.sId,
    this.permissions,
    this.isDeleted,
    this.role,
    this.branchId,
    this.password,
    this.lastname,
    this.name,
    this.branchCustomId,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] != null ? json['_id'].toString() : "";
    permissions = json['permissions'] != null ? json['permissions'].cast<int>() : [];
    isDeleted = json['isDeleted'] ?? false;
    role = json['role'] != null ? json['role'].toString() : "";
    branchId = json['branchId'] != null ? json['branchId'].toString() : "";
    password = json['password'] != null ? json['password'].toString() : "";
    lastname = json['lastname'] != null ? json['lastname'].toString() : "";
    name = json['name'] != null ? json['name'].toString() : "";
    branchCustomId = json['branch_custom_id'] ?? 0;
    createdAt = json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null;
    updatedAt = json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['permissions'] = permissions;
    data['isDeleted'] = isDeleted;
    data['role'] = role;
    data['branchId'] = branchId;
    data['password'] = password;
    data['lastname'] = lastname;
    data['name'] = name;
    data['branch_custom_id'] = branchCustomId;
    data['createdAt'] = createdAt.toString();
    data['updatedAt'] = updatedAt.toString();
    return data;
  }
}

class ServiceFee {
  int? type;
  double? amount;
  String? sId;
  double? percentile;
  String? user;
  DateTime? updatedAt;
  DateTime? createdAt;

  ServiceFee(
      {this.type,
      this.amount,
      this.sId,
      this.percentile,
      this.user,
      this.updatedAt,
      this.createdAt});

  ServiceFee.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? 0;
    amount = json['amount'] != null ? double.parse(json['amount'].toString()) : 0;
    sId = json['_id'] != null ? json['_id'].toString() : "";
    percentile = json['percentile'] != null ? double.parse(json['percentile'].toString()) : 0;
    user = json['user'] != null ? json['user'].toString() : "";
    createdAt = json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null;
    updatedAt = json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['amount'] = amount;
    data['_id'] = sId;
    data['percentile'] = percentile;
    data['user'] = user;
    data['updatedAt'] = updatedAt.toString();
    data['createdAt'] = createdAt.toString();
    return data;
  }
}

class Discount {
  String? id;
  String? note;
  double? amount;
  int? type;
  String? user;

  Discount({
    required this.id,
    required this.note,
    required this.amount,
    required this.type,
    required this.user,
  });

  Discount.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? 0;
    amount = json['amount'] != null ? double.parse(json['amount'].toString()) : 0;
    id = json['_id'] != null ? json['_id'].toString() : "";
    user = json['user'] != null ? json['user'].toString() : "";
    note = json['note'] != null ? json['note'].toString() : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['amount'] = amount;
    data['_id'] = id;
    data['note'] = note;
    data['user'] = user;
    return data;
  }
}

class Payment {
  int? type;
  double? amount;
  String? currency;
  Payment({this.type, this.amount, this.currency});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['amount'] = amount;
    data['currency'] = currency;
    return data;
  }
}

class PutPaymentModel {
  List<Payment?>? payments;

  PutPaymentModel({this.payments});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payments'] = payments?.map((v) => v?.toJson()).toList();
    return data;
  }
}

List<OldCheckModel> oldCheckFromJson(String jsonString) {
  final jsonData = jsonDecode(jsonString);
  return List<OldCheckModel>.from(jsonData.map((item) => OldCheckModel.fromJson(item)));
}
