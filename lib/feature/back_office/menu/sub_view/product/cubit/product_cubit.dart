import 'dart:convert';
import 'dart:io';

import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/cubit/i_product_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/model/product_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/service/i_product_service.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/service/product_service.dart';
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
  ProductCubit() : super(ProductState.initial());
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController? productPriceController = TextEditingController();
  final TextEditingController? taxController = TextEditingController();
  List<ProductModel> originalProducts = [];
  int firstProductsLength = 0;
  Map<String, List<ProductModel>>? originalCategorizedProducts = {};

  final IProductService _productService = ProductService();
  @override
  void init() {}

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

      emit(state.copyWith(allProducts: originalProducts, states: ProductStates.completed));
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
    appLogger.info('POST PRODUCT CALLED: ', productModel.toJson().toString());
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
    appLogger.info('UPDATE PRODUCT CALLED: ', productModel.toJson().toString());
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
    appLogger.info('UPDATED PRODUCT TAX: ', updatedProduct.toJson().toString());

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
    appLogger.info('SELECTED PRODUCT: ', '$categoryId ${productsInCategory.toJson()}');

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
    appLogger.info('updateSelectedProductImage', 'updatedProduct categoryId: $categoryId');
    final updatedCategoryProducts = updatedCategorizedProducts[categoryId]?.map((product) {
          if (product.id == state.selectedProduct!.id) {
            appLogger.info('updateSelectedProductImage',
                'updatedProduct if: ${updatedProduct.toJson().toString()}');
            return updatedProduct;
          } else {
            appLogger.info('updateSelectedProductImage',
                'updatedProduct else: ${updatedProduct.toJson().toString()}');
            return product;
          }
        }).toList() ??
        [];

    updatedCategorizedProducts[categoryId!] = updatedCategoryProducts;
    // setSelectedProduct(updatedCategorizedProducts[categoryId]?.first ?? ProductModel.empty(),
    //     updatedCategorizedProducts[categoryId]?.first.prices?.first ?? PriceModel.empty());

    emit(state.copyWith(
      allProducts: updatedAllProducts,
      categorizedProducts: updatedCategorizedProducts,
      selectedProduct: () => updatedProduct,
    ));
  }

  Future<void> saveChanges() async {
    // Yeni ürünleri bulma ve post isteği gönderme
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

        // Mevcut ürün güncelleme: originalProduct ve updatedProduct aynı değilse
        if (updatedProduct != originalProduct) {
          if (state.selectedProduct?.image != null &&
              (state.selectedProduct!.image!.length < 500)) {
            ProductModel newProductModel = updatedProduct.copyWith(image: () => null);

            await putProducts(productModel: newProductModel, productId: originalProduct.id ?? '');
          } else {
            await putProducts(productModel: updatedProduct, productId: originalProduct.id ?? '');
          }
        }
      }

      // İstekler başarılı olduktan sonra originalCategorizedProducts'ı güncelle
      originalCategorizedProducts = Map.from(state.categorizedProducts!);
    }
  }
}

typedef BaseResponseCubit = Either<ServerException, BaseResponseModel<dynamic>>;
