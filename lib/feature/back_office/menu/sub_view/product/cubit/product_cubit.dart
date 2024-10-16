import 'dart:convert';
import 'dart:io';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/service/i_option_service.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/cubit/i_product_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/model/product_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/service/i_product_service.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/global/service/global_service.dart';
import 'package:core/base/cubit/base_cubit.dart';
import 'package:core/base/exception/exception.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

part 'product_state.dart';

class ProductCubit extends IProductCubit {
  ProductCubit({required IProductService productService, required IOptionService optionService})
      : _productService = productService,
        _optionService = optionService,
        super(ProductState.initial()) {
    init();
  }
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController? productPriceController = TextEditingController();
  final TextEditingController? taxController = TextEditingController();
  List<ProductModel> originalProducts = [];
  int firstProductsLength = 0;
  Map<String, List<ProductOptionModel>> productOptionsMap = {};
  Map<String, List<ProductModel>>? originalCategorizedProducts = {};

  final IProductService _productService;
  final IOptionService _optionService;
  @override
  Future<void> init() async {
    await Future.wait([getProducts(), getOptions()]);
  }

  @override
  ProductModel? get product => state.product;

  /// GET PRODUCTS FROM PRODUCT SERVICE
  @override
  Future getProducts() async {
    emit(state.copyWith(states: ProductStates.loading));
    final response = await _productService.getProducts();
    response.fold((l) {
      emit(state.copyWith(states: ProductStates.error));
    }, (r) {
      List<ProductModel> productList = (r.data as List)
          .map((product) => ProductModel.fromJson(product as Map<String, dynamic>))
          .toList();
      originalProducts = productList
          .map((pro) => ProductModel(
              id: pro.id,
              title: pro.title,
              image: pro.image,
              category: pro.category,
              prices: (pro.prices?.first.vatRate ?? 0) > 0
                  ? pro.prices?.map((price) {
                      return PriceModel(
                          id: price.id,
                          amount: price.amount,
                          priceName: price.priceName,
                          currency: price.currency,
                          orderType: price.orderType,
                          vatRate: price.vatRate,
                          price: price.price!);
                    }).toList()
                  : pro.prices,
              description: pro.description,
              activeList: pro.activeList,
              options: pro.options,
              favorite: pro.favorite,
              opportunity: pro.opportunity,
              allergen: pro.allergen,
              calorie: pro.calorie,
              branch: pro.branch,
              rank: pro.rank))
          .toList();

      // 2. Ürünlerin optionslarını Map'e ekleme
      for (var product in originalProducts) {
        if (product.options != null && product.options!.isNotEmpty) {
          productOptionsMap[product.id!] = product.options!;
        }
      }

      emit(state.copyWith(
        allProducts: originalProducts,
        productOptions: productOptionsMap,
        states: ProductStates.completed,
      ));
      categorizeProducts();
      state.allProducts.isNotEmpty
          ? setSelectedProduct(
              state.allProducts.first!, product?.prices?.first ?? const PriceModel())
          : setSelectedProduct(ProductModel(), const PriceModel());

      firstProductsLength = originalProducts.length;
    });
  }

  /// POST PRODUCTS TO PRODUCT SERVICE
  @override
  Future postProducts({required ProductModel productModel}) async {
    productModel = productModel.copyWith(
      id: () => null,
    );
    emit(state.copyWith(states: ProductStates.loading));
    BaseResponseCubit response;

    response = await _productService.postProducts(productModel: productModel);
    // }
    response.fold((l) {
      emit(state.copyWith(states: ProductStates.error));
    }, (r) {
      ProductModel product = ProductModel.fromJson(r.data);
      emit(state.copyWith(product: product, states: ProductStates.completed));
    });
  }

  /// PUT PRODUCTS TO PRODUCT SERVICE
  @override
  Future putProducts({required ProductModel productModel, required String productId}) async {
    emit(state.copyWith(states: ProductStates.loading));
    BaseResponseCubit response;
    response = await _productService.putProducts(productId: productId, productModel: productModel);
    response.fold((l) {
      emit(state.copyWith(states: ProductStates.error));
    }, (r) {
      ProductModel product = ProductModel.fromJson(r.data);
      emit(state.copyWith(product: product, states: ProductStates.completed));
    });
  }

  /// PATCH PRODUCTS TO PRODUCT SERVICE
  @override
  Future patchProducts({required String productId}) async {
    emit(state.copyWith(states: ProductStates.loading));
    BaseResponseCubit response;
    response = await _productService.patchProducts(productId: productId);
    response.fold((l) {
      emit(state.copyWith(states: ProductStates.error));
    }, (r) {
      emit(state.copyWith(states: ProductStates.completed));
    });
  }

  /// ADD NEW EMPTY Product
  Future<void> addNewProduct(String categoryId) async {
    final productsInCategory = state.categorizedProducts?[categoryId] ?? [];

    //If there is a selected product or the title of the last product is empty, do not perform the operation.
    if (productsInCategory.isNotEmpty && state.selectedProduct == null) return;
    if (productsInCategory.isNotEmpty && productsInCategory.last.title?.isEmpty == true) return;
    if (productsInCategory.isNotEmpty && (productsInCategory.last.prices?.first.price ?? 0) <= 0) {
      return;
    }

    // Clear text controllers
    productNameController.clear();
    productPriceController?.clear();
    taxController?.clear();

    // Create new product and add
    final newProduct = ProductModel.empty().copyWith(category: categoryId);
    final updatedProducts = List<ProductModel>.from(productsInCategory)..add(newProduct);

    // Update the list of products in `categorizedProducts` with the newly added product
    final updatedCategorizedProducts =
        Map<String, List<ProductModel>>.from(state.categorizedProducts!);
    updatedCategorizedProducts[categoryId] = updatedProducts;

    emit(state.copyWith(
      categorizedProducts: updatedCategorizedProducts,
      allProducts: List.from(state.allProducts)..add(newProduct),
      selectedProduct: () => newProduct,
    ));
  }

  /// UPDATE SELECTED PRODUCT NAME
  void updateSelectedProductName(String title, String categoryId) {
    if (state.selectedProduct == null) return;

    final updatedProduct = state.selectedProduct!.copyWith(
        title: title,
        id: originalProducts.map((e) => e.id).contains(state.selectedProduct!.id)
            ? () => state.selectedProduct!.id
            : () => GlobalService.generateUniqueId());
    appLogger.info('UPDATED PRODUCT: ', updatedProduct.toJson().toString());

    // updated products list
    final updatedAllProducts = state.allProducts
        .map((e) => e?.id == state.selectedProduct!.id ? updatedProduct : e)
        .toList();

    //Update the products for the selected category
    final selectedCategoryId = categoryId;
    final updatedCategorizedProducts =
        Map<String, List<ProductModel>>.from(state.categorizedProducts!);

    final productsInCategory = updatedCategorizedProducts[selectedCategoryId] ?? [];
    updatedCategorizedProducts[selectedCategoryId] = productsInCategory
        .map((e) => e.id == state.selectedProduct!.id ? updatedProduct : e)
        .toList();

    emit(state.copyWith(
      allProducts: updatedAllProducts,
      categorizedProducts: updatedCategorizedProducts,
      selectedProduct: () => updatedProduct,
    ));
  }

  /// UPDATE SELECTED PRODUCT tax
  void updateSelectedProductTax(String tax, String categoryId) {
    if (state.selectedProduct == null) return;

    final updatedProduct = state.selectedProduct!.copyWith(
        prices: state.selectedProduct!.prices
            ?.map((e) => e.copyWith(vatRate: double.parse(tax)))
            .toList());

    // updated products list
    final updatedAllProducts = state.allProducts
        .map((e) => e?.id == state.selectedProduct!.id ? updatedProduct : e)
        .toList();

    //Update the products for the selected category
    final selectedCategoryId = categoryId;
    final updatedCategorizedProducts =
        Map<String, List<ProductModel>>.from(state.categorizedProducts!);

    final productsInCategory = updatedCategorizedProducts[selectedCategoryId] ?? [];
    updatedCategorizedProducts[selectedCategoryId] = productsInCategory
        .map((e) => e.id == state.selectedProduct!.id ? updatedProduct : e)
        .toList();

    emit(state.copyWith(
      allProducts: updatedAllProducts,
      categorizedProducts: updatedCategorizedProducts,
      selectedProduct: () => updatedProduct,
    ));
  }

  /// CATEGORIZE  PRODUCTS BY CATEGORY ID
  void categorizeProducts() {
    Map<String, List<ProductModel>> newCategorizedProducts = {};

    for (var product in state.allProducts) {
      if (product != null) {
        if (!newCategorizedProducts.containsKey(product.category)) {
          newCategorizedProducts[product.category!] = [];
        }
        newCategorizedProducts[product.category]!.add(product);
      }
    }
    emit(state.copyWith(categorizedProducts: newCategorizedProducts));
    originalCategorizedProducts = newCategorizedProducts;
  }

  /// SET SELECTED PRODUCT
  @override
  void setSelectedProduct(ProductModel product, PriceModel price) {
    productNameController.text = product.title ?? '';
    productPriceController?.text = product.prices?.first.price.toString() ?? '0.0';
    taxController?.text = product.prices?.first.vatRate.toString() ?? '0.0';
    emit(state.copyWith(selectedProduct: () => product));
  }

  /// SET SELECTED PRODUCT BY ID calling this func when category is changing from the left category table!
  setSelectedProductById(String categoryId) {
    final isProductsInCategory = state.categorizedProducts?[categoryId];
    final productsInCategory =
        isProductsInCategory?.isNotEmpty == true ? isProductsInCategory!.first : ProductModel();

    emit(state.copyWith(selectedProduct: () => productsInCategory));
    productNameController.text = productsInCategory.title ?? '';
    productPriceController?.text = productsInCategory.prices?.first.price.toString() ?? '';
    taxController?.text = productsInCategory.prices?.first.vatRate.toString() ?? '';
  }

  //TODO: CHECK UPDATE SELECTED PRODUCT PRICE-NAME-TAX FUNCS AND MAKE THESE ALL ONE FUNC !!!
  /// UPDATE SELECTED Product prices
  void updateSelectedProductPrice(double newPrice, String categoryId) {
    if (state.selectedProduct == null) return;

    // Yeni PriceModel oluştur
    final model = PriceModel(
      amount: 1.0,
      priceName: 'REGULAR',
      priceType: 'REGULAR',
      currency: 'USD',
      orderType: const [],
      vatRate: state.selectedProduct?.prices?.first.vatRate ?? 0.0,
      price: newPrice,
    );

    // update selected product
    final updatedProduct = state.selectedProduct!.copyWith(prices: [model]);

    // Update all product list
    final updatedAllProducts = state.allProducts
        .map((product) => product?.id == state.selectedProduct?.id ? updatedProduct : product)
        .toList();

    // Update products by category
    final updatedCategorizedProducts =
        Map<String, List<ProductModel>>.from(state.categorizedProducts!);

    final productsInCategory = updatedCategorizedProducts[categoryId] ?? [];
    updatedCategorizedProducts[categoryId] = productsInCategory
        .map((product) => product.id == state.selectedProduct?.id ? updatedProduct : product)
        .toList();

    emit(state.copyWith(
      allProducts: updatedAllProducts,
      categorizedProducts: updatedCategorizedProducts,
      selectedProduct: () => updatedProduct,
    ));
  }

  /// set selected color
  //TODO: KEEP COLORS IN MAP FOR EACH PRODUCT!
  void setSelectedColor(Color? color) =>
      emit(state.copyWith(productImage: () => null, selectedColor: () => color));

  /// CLOSE TEXT EDITING CONTROLLER
  @override
  Future<void> close() {
    productNameController.dispose();
    productPriceController?.dispose();
    taxController?.dispose();
    return super.close();
  }

  /// GET PRODUCT IMAGE FROM GALLERY
  @override
  Future<void> getProductImage() async {
    final xFileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFileImage == null) return;

    final imageTemporary = File(xFileImage.path);
    final bytes = await imageTemporary.readAsBytes();
    final base64Image = base64Encode(bytes);
    updateSelectedProductImage(base64Image);
    emit(state.copyWith(
      selectedColor: () => null,
      productImage: () => imageTemporary,
    ));
  }

  /// UPDATE SELECTED PRODUCT IMAGE
  void updateSelectedProductImage(String base64Image) {
    if (state.selectedProduct == null) return;

    final updatedProduct = state.selectedProduct!.copyWith(image: () => base64Image);

    // allProducts listesini güncelle
    final updatedAllProducts = state.allProducts.map((product) {
      if (product?.id == state.selectedProduct!.id) {
        return updatedProduct;
      } else {
        return product;
      }
    }).toList();

    // categorizedProducts map'ini güncelle
    final updatedCategorizedProducts =
        Map<String, List<ProductModel>>.from(state.categorizedProducts ?? {});
    final categoryId = updatedProduct.category;
    final updatedCategoryProducts = updatedCategorizedProducts[categoryId]?.map((product) {
          if (product.id == state.selectedProduct!.id) {
            return updatedProduct;
          } else {
            return product;
          }
        }).toList() ??
        [];

    updatedCategorizedProducts[categoryId!] = updatedCategoryProducts;

    emit(state.copyWith(
      allProducts: updatedAllProducts,
      categorizedProducts: updatedCategorizedProducts,
      selectedProduct: () => updatedProduct,
    ));
  }

  Future<void> saveChanges() async {
    for (var entry
        in state.categorizedProducts?.entries ?? <MapEntry<String, List<ProductModel>>>[]) {
      String categoryId = entry.key;
      List<ProductModel> products = entry.value;
      List<ProductModel>? originalProducts = originalCategorizedProducts?[categoryId];

      for (var product in products) {
        // Yeni ürün: originalProducts içinde yoksa
        if (originalProducts == null || !originalProducts.any((p) => p.id == product.id)) {
          await postProducts(productModel: product.copyWith(category: categoryId));
          appLogger.info('POST PRODUCT: ', product.toJson().toString());
        }
      }
    }

    // Mevcut ürünlerdeki değişiklikleri bulma ve put isteği gönderme
    for (var entry
        in originalCategorizedProducts?.entries ?? <MapEntry<String, List<ProductModel>>>[]) {
      String categoryId = entry.key;
      List<ProductModel> originalProducts = entry.value;
      List<ProductModel>? updatedProducts = state.categorizedProducts?[categoryId];

      if (updatedProducts == null) continue;

      for (var originalProduct in originalProducts) {
        ProductModel? updatedProduct = updatedProducts.firstWhere(
          (product) => product.id == originalProduct.id,
          orElse: () => ProductModel.empty(),
        );

        bool areOptionsDifferent =
            _areOptionsDifferent(originalProduct.options, updatedProduct.options);

        // Mevcut ürün güncelleme: originalProduct ve updatedProduct aynı değilse
        if ((updatedProduct != originalProduct) || areOptionsDifferent) {
          if (state.selectedProduct?.image != null &&
              (state.selectedProduct!.image!.length < 500)) {
            ProductModel newProductModel = updatedProduct.copyWith(image: () => null);

            await putProducts(productModel: newProductModel, productId: originalProduct.id ?? '');
          } else {
            await putProducts(productModel: updatedProduct, productId: originalProduct.id ?? '');
          }
        }
      }

      originalCategorizedProducts = Map.from(state.categorizedProducts!);
    }
  }

  // Options listesinin farklı olup olmadığını kontrol eden fonksiyon
  bool _areOptionsDifferent(
      List<ProductOptionModel>? originalOptions, List<ProductOptionModel>? updatedOptions) {
    if (originalOptions == null || updatedOptions == null) {
      return originalOptions?.isNotEmpty == true || updatedOptions?.isNotEmpty == true;
    }

    if (originalOptions.map((option) => option.id) != updatedOptions.map((e) => e.id)) {
      return true;
    }

    for (int i = 0; i < originalOptions.length; i++) {
      if (originalOptions[i] != updatedOptions[i]) {
        return true;
      }
    }

    return false;
  }

  void getProductOptions(ProductModel product) async {
    await getOptions().then((value) {
      //TODO CHECK HERE IF THERE IS ERROR OPEN THIS COMMENT!
      List<OptionModel?> optionList = state.allOptions
          .where(
              (option) => product.options!.any((productOption) => productOption.id == option!.id))
          .toList();

      emit(state.copyWith(
          productOptionList: optionList,
          selectedOption: () => optionList.isNotEmpty ? optionList.first : null));
    });
  }

  void getExistProductOptions(String productId) async {
    ProductModel product =
        state.allProducts.firstWhere((product) => product?.id == productId) ?? ProductModel.empty();
    await getOptions().then((value) {
      //TODO: DONT CALL GET OPTIONS FUNC FOR ALL TIME
      List<OptionModel?> optionList = state.allOptions
          .where(
              (option) => product.options!.any((productOption) => productOption.id == option!.id))
          .toList();

      emit(state.copyWith(
          productOptionList: optionList,
          selectedOption: () => optionList.isNotEmpty ? optionList.first : null));
    });
  }

  void toggleOptionToProduct(String productId, ProductOptionModel option, String categoryId) {
    // Create a new map to avoid directly mutating the state
    final updatedProductOptions = Map<String, List<ProductOptionModel>>.from(state.productOptions);

    if (!updatedProductOptions.containsKey(productId)) {
      updatedProductOptions[productId] = [];
    }

    final currentOptions = updatedProductOptions[productId] ?? [];

    // Toggle option
    if (currentOptions.contains(option)) {
      currentOptions.remove(option);
    } else {
      currentOptions.add(option);
    }

    // Update the product options in the new map
    updatedProductOptions[productId] = currentOptions;

    final updatedProduct = state.selectedProduct!.copyWith(
      options: [...currentOptions],
    );

    final updatedAllProducts = state.allProducts
        .map((product) => product?.id == state.selectedProduct!.id ? updatedProduct : product)
        .toList();

    final updatedCategorizedProducts =
        Map<String, List<ProductModel>>.from(state.categorizedProducts!);

    final productsInCategory = updatedCategorizedProducts[categoryId] ?? [];
    updatedCategorizedProducts[categoryId] = productsInCategory
        .map((product) => product.id == state.selectedProduct!.id ? updatedProduct : product)
        .toList();
    productOptionsMap = updatedProductOptions;

    // Emit the new state with a completely new map for product options
    emit(state.copyWith(
      allProducts: updatedAllProducts,
      categorizedProducts: updatedCategorizedProducts,
      productOptions: updatedProductOptions, // Updated map for product options
      selectedProduct: () => updatedProduct,
    ));
  }

  // Helper method to get selected options for a specific product
  List<ProductOptionModel> getSelectedOptionsForProduct(String productId) {
    return productOptionsMap[productId] ?? [];
  }

  void updateProductMaxOptions(int maxOptions) {
    if (state.selectedProduct == null) return;

    final updatedProduct = state.selectedProduct!.copyWith();

    final updatedProducts = state.allProducts.map((product) {
      return product?.id == updatedProduct.id ? updatedProduct : product;
    }).toList();

    emit(state.copyWith(
      selectedProduct: () => updatedProduct,
      allProducts: updatedProducts,
    ));
  }

//*----------GET OPTIONS FOR PRODUCT VIEW--------*-
  /// getOptions
  Future getOptions() async {
    final response = await _optionService.getOptions();
    response.fold((l) {}, (r) {
      List<OptionModel?> options = (r.data as List).map((e) => OptionModel.fromJson(e)).toList();
      emit(state.copyWith(allOptions: options, states: ProductStates.completed));
      options.isNotEmpty ? setSelectedOption(options.first ?? OptionModel.empty()) : null;
    });
  }

  List<Item> _initialItems = [];

  void initializeItems(List<Item> items) {
    _initialItems = List.from(items);
    emit(state.copyWith(selectedItems: _initialItems));
  }

  /// SET SELECTED OPTION
  void setSelectedOption(OptionModel option) {
    emit(state.copyWith(selectedOption: () => option));
  }

  /// set multi items

  void toggleItem(Item item) {
    final selectedItems = List<Item>.from(state.selectedItems);
    if (selectedItems.map((i) => i.id).contains(item.id)) {
      selectedItems.removeWhere((i) => i.id == item.id);
    } else {
      selectedItems.add(item);
    }
    emit(state.copyWith(selectedItems: selectedItems));
  }

  void resetSelectedItems() {
    _initialItems = [];
    emit(state.copyWith(selectedItems: []));
  }

  void setSelectedItems(List<Item> items) {
    emit(state.copyWith(selectedItems: items));
  }

  void setSelectedProductQuantity(int? digit) {
    int? currentQuantity = state.selectedProductQuantity;
    int? newQuantity;

    if (currentQuantity == null || currentQuantity == 0) {
      newQuantity = digit ?? 0;
    } else if (digit == null) {
      currentQuantity = null;
    } else {
      String combined = '$currentQuantity$digit';
      newQuantity = int.parse(combined).clamp(0, 99);

      if (int.parse(combined) > 99) {
        newQuantity = digit;
      }
    }

    emit(state.copyWith(
      selectedProductQuantity: () => newQuantity,
      remainingQuantity: () => newQuantity,
    ));
  }

  void decrementRemainingQuantity() {
    if ((state.remainingQuantity ?? -1) > 0) {
      emit(state.copyWith(remainingQuantity: () => (state.remainingQuantity ?? -1) - 1));
    }
    if ((state.remainingQuantity ?? -1) == 0) {
      emit(state.copyWith(remainingQuantity: () => null, selectedProductQuantity: () => null));
    }
  }

  bool get hasRemainingQuantity => (state.remainingQuantity ?? -1) > 0;
}

typedef BaseResponseCubit = Either<ServerException, BaseResponseModel<dynamic>>;
