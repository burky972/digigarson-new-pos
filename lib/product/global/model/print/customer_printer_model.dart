class CustomPrinterModel {
  final String url;
  final String name;
  final String showName;
  final String? model;
  final String? location;
  late String? comment;
  final bool isDefault;
  final bool isAvailable;
  final String customField;
  late double titleFontSize;
  late double productFontSize;
  late double optionFontSize;
  late double noteFontSize;
  late double priceFontSize;
  late double subFontSize;
  late double totalFontSize;
  late double fontSize;
  late double pdfPageSize;
  final bool isGeneralPrinter;
  final List<String> categoryIdList;
  final List<String> productIdList;
  final List<String> tableIdList;

  CustomPrinterModel({
    required this.url,
    required this.name,
    required this.showName,
    this.model,
    this.location,
    this.comment,
    this.isDefault = false,
    this.isAvailable = true,
    required this.noteFontSize,
    required this.optionFontSize,
    required this.priceFontSize,
    required this.fontSize,
    required this.productFontSize,
    required this.subFontSize,
    required this.titleFontSize,
    required this.totalFontSize,
    required this.pdfPageSize,
    required this.isGeneralPrinter,
    required this.customField,
    required this.categoryIdList,
    required this.productIdList,
    required this.tableIdList,
  });

  factory CustomPrinterModel.fromJson(Map<String, dynamic> json) {
    return CustomPrinterModel(
      url: json['url']!,
      name: json['name']!,
      showName: json['showName']!,
      model: json['model'],
      location: json['location'],
      comment: json['comment'],
      isDefault: json['default'] ?? false,
      isAvailable: json['available'] ?? true,
      fontSize: json['fontSize'] ?? 18,
      noteFontSize: json['noteFontSize'] ?? 18,
      optionFontSize: json['optionFontSize'] ?? 18,
      priceFontSize: json['priceFontSize'] ?? 18,
      productFontSize: json['productFontSize'] ?? 18,
      subFontSize: json['subFontSize'] ?? 18,
      titleFontSize: json['titleFontSize'] ?? 18,
      totalFontSize: json['totalFontSize'] ?? 18,
      pdfPageSize: json['pdfPageSize'] ?? 71.9,
      isGeneralPrinter: json['isGeneralPrinter'] ?? false,
      customField: json['customField'] ?? '',
      categoryIdList: List<String>.from(json['categoryIdList'] ?? []),
      productIdList: List<String>.from(json['productIdList'] ?? []),
      tableIdList: List<String>.from(json['tableIdList'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'showName': showName,
      'model': model,
      'location': location,
      'comment': comment,
      'default': isDefault,
      'available': isAvailable,
      'isGeneralPrinter': isGeneralPrinter,
      'fontSize': fontSize,
      'noteFontSize': noteFontSize,
      'pdfPageSize': pdfPageSize,
      'optionFontSize': optionFontSize,
      'priceFontSize': priceFontSize,
      'productFontSize': productFontSize,
      'subFontSize': subFontSize,
      'titleFontSize': titleFontSize,
      'totalFontSize': totalFontSize,
      'customField': customField,
      'categoryIdList': categoryIdList,
      'productIdList': productIdList,
      'tableIdList': tableIdList,
    };
  }
}
