import 'dart:convert';

import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';

class BranchModel {
  late List<CategoriesModel>? categories = [];
  late List<ProductsModel>? products = [];
  late List<SectionsModel>? sections = [];
  late List<TablesModel>? tables = [];
  late List<OptionsModel>? options = [];
  late CurrencySettingsModel? currencySettings;

  BranchModel(
      {required this.categories,
      required this.products,
      required this.sections,
      required this.tables,
      required this.options,
      required this.currencySettings});

  BranchModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null && json['categories'] is List<dynamic>) {
      categories = <CategoriesModel>[];
      json['categories'].forEach((v) {
        categories?.add(CategoriesModel.fromJson(v));
      });
    }
    if (json['products'] != null && json['products'] is List<dynamic>) {
      products = <ProductsModel>[];
      json['products'].forEach((v) {
        products?.add(ProductsModel.fromJson(v));
      });
    }
    if (json['sections'] != null && json['sections'] is List<dynamic>) {
      sections = <SectionsModel>[];
      sections?.add(SectionsModel(sId: "all", title: "all"));
      json['sections'].forEach((v) {
        sections?.add(SectionsModel.fromJson(v));
      });
    }
    if (json['tables'] != null && json['tables'] is List<dynamic>) {
      tables = <TablesModel>[];
      json['tables'].forEach((v) {
        tables?.add(TablesModel.fromJson(v));
      });
    }
    if (json['options'] != null && json['options'] is List<dynamic>) {
      options = <OptionsModel>[];
      json['options'].forEach((v) {
        options?.add(OptionsModel.fromJson(v));
      });
    }
    currencySettings = json['currencySettings'] != null
        ? CurrencySettingsModel.fromJson(json['currencySettings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categories'] = categories;
    data['products'] = products;
    data['sections'] = sections;
    data['tables'] = tables;
    data['options'] = options;
    data['currencySettings'] = currencySettings;
    return data;
  }
}

class CategoriesModel {
  late String sId;
  late bool isSubCategory;
  late String? image;
  late String title;
  late String branch;
  late String? parentCategory;
  late List<CategoriesModel> subCategory;

  CategoriesModel(
      {required this.sId,
      required this.isSubCategory,
      required this.image,
      required this.title,
      required this.branch,
      required this.parentCategory,
      required this.subCategory});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    isSubCategory = json['is_sub_category'];
    image = json['image'].toString();
    title = json['title'].toString();
    branch = json['branch'].toString();
    parentCategory = json['parent_category']?.toString();
    subCategory = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['is_sub_category'] = isSubCategory;
    data['image'] = image;
    data['title'] = title;
    data['branch'] = branch;
    data['parent_category'] = parentCategory;
    data['subCategory'] = subCategory.map((category) => category.toJson()).toList();
    return data;
  }
}

class ProductsModel {
  late String sId;
  late List<int> activeList;
  late List<Options> options;
  late List<Prices> prices;
  late String endTime;
  late String startTime;
  late String image;
  late String branch;
  late String category;
  late String description;
  late String title;
  late int saleType;
  late String stockCode;

  ProductsModel(
      {required this.sId,
      required this.activeList,
      required this.options,
      required this.prices,
      required this.endTime,
      required this.startTime,
      required this.image,
      required this.branch,
      required this.category,
      required this.description,
      required this.title,
      required this.saleType,
      required this.stockCode});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    activeList = json['active_list'].cast<int>();
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options.add(Options.fromJson(v));
      });
    }
    if (json['prices'] != null) {
      prices = <Prices>[];
      json['prices'].forEach((v) {
        prices.add(Prices.fromJson(v));
      });
    }
    endTime = json['end_time'] ?? "";
    startTime = json['start_time'] ?? "";
    image = json['image'];
    branch = json['branch'];
    category = json['category'];
    description = json['description'];
    title = json['title'];
    saleType = json['sale_type'];
    stockCode = json['stock_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['active_list'] = activeList;
    data['end_time'] = endTime;
    data['start_time'] = startTime;
    data['image'] = image;
    data['branch'] = branch;
    data['category'] = category;
    data['description'] = description;
    data['title'] = title;
    data['sale_type'] = saleType;
    data['stock_code'] = stockCode;
    data['prices'] = prices.map((prices) => prices.toJson()).toList();
    data['options'] = options.map((options) => options.toJson()).toList();
    return data;
  }
}

class Prices {
  late List<int> orderType;
  late String sId;
  late String priceName;
  late String currency;
  late int vatRate;
  late double amount;
  late String price;
  late DateTime? createdAt;
  late DateTime? updatedAt;
  late int saleType;

  Prices(
      {required this.orderType,
      required this.sId,
      required this.priceName,
      required this.currency,
      required this.vatRate,
      required this.amount,
      required this.price,
      required this.createdAt,
      required this.updatedAt,
      required this.saleType});

  Prices.fromJson(Map<String, dynamic> json) {
    orderType = json['order_type'].cast<int>();
    sId = json['_id'];
    priceName = json['priceName'] ?? "";
    currency = json['currency'];
    vatRate = json['vat_rate'];
    amount = double.parse(json['amount'].toString());
    price = json['price'].toString();
    createdAt = DateTime.tryParse(json["createdAt"] ?? "");
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? "");
    saleType = json['sale_type'] ?? 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['order_type'] = orderType.map((orderType) => int.parse(orderType.toString())).toList();
    data['priceName'] = priceName;
    data['currency'] = currency;
    data['vat_rate'] = vatRate;
    data['amount'] = amount;
    data['price'] = price;
    data['createdAt'] = createdAt.toString();
    data['updatedAt'] = updatedAt.toString();
    data['sale_type'] = saleType;
    return data;
  }
}

class SectionsModel {
  late String sId;
  late String title;

  SectionsModel({required this.sId, required this.title});

  SectionsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    title = json['title'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    return data;
  }
}

class TablesModel {
  late String sId;
  late String section;
  late String title;

  TablesModel({required this.sId, required this.section, required this.title});

  TablesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    section = json['section'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['section'] = section;
    data['title'] = title;
    return data;
  }
}

class OptionsModel {
  late String sId;
  late bool? isForcedChoice;
  late bool unlimitedChoice;
  late List<Item> items;
  late int state;
  late int chooseLimit;
  late int type;
  late String specialName;
  late String name;
  late String branch;

  OptionsModel(
      {required this.sId,
      required this.isForcedChoice,
      required this.unlimitedChoice,
      required this.items,
      required this.state,
      required this.chooseLimit,
      required this.type,
      required this.specialName,
      required this.name,
      required this.branch});

  OptionsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    isForcedChoice = json['is_forced_choice'];
    unlimitedChoice = json['unlimitedChoice'] ?? false;
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items.add(Item.fromJson(v));
      });
    }
    state = json['state'];
    chooseLimit = json['choose_limit'];
    type = json['type'];
    specialName = json['special_name'].toString();
    name = json['name'].toString();
    branch = json['branch'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['is_forced_choice'] = isForcedChoice;
    data['unlimitedChoice'] = unlimitedChoice;
    data['items'] = items.map((item) => item.toJson()).toList();
    data['state'] = state;
    data['choose_limit'] = chooseLimit;
    data['type'] = type;
    data['special_name'] = specialName;
    data['name'] = name;
    data['branch'] = branch;
    return data;
  }
}

class CurrencySettingsModel {
  String? defaultCurrency;
  String? currencies;

  CurrencySettingsModel({this.defaultCurrency, this.currencies});

  CurrencySettingsModel.fromJson(Map<String, dynamic> json) {
    defaultCurrency = json['defaultCurrency'];
    currencies = json['currencies']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['defaultCurrency'] = defaultCurrency;
    data['currencies'] = currencies;
    return data;
  }
}

CurrencySettingsModel currencySettingsFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return (CurrencySettingsModel.fromJson(jsonData));
}

List<CategoriesModel> categoriesFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return List<CategoriesModel>.from(jsonData.map((item) => CategoriesModel.fromJson(item)));
}

List<TablesModel> tablesFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return List<TablesModel>.from(jsonData.map((item) => TablesModel.fromJson(item)));
}

List<SectionsModel> sectionsFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return List<SectionsModel>.from(jsonData.map((item) => SectionsModel.fromJson(item)));
}

List<Prices> pricesFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return List<Prices>.from(jsonData.map((item) => Prices.fromJson(item)));
}

List<ProductsModel> productsFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return List<ProductsModel>.from(jsonData.map((item) => ProductsModel.fromJson(item)));
}

List<OptionsModel> optionsFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return List<OptionsModel>.from(jsonData.map((item) => OptionsModel.fromJson(item)));
}
