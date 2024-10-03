// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_cubit.dart';

class ProductState extends BaseState {
  const ProductState({
    required this.states,
    required this.product,
    required this.allProducts,
    required this.selectedProduct,
    required this.productImage,
    required this.selectedColor,
    required this.categorizedProducts,
    required this.productOptions,
    required this.allOptions,
    required this.selectedOption,
    required this.productOptionList,
    required this.selectedItems,
    required this.selectedProductQuantity,
    required this.remainingQuantity,
  });

  factory ProductState.initial() {
    return const ProductState(
      states: ProductStates.initial,
      product: null,
      allProducts: [],
      selectedProduct: null,
      productImage: null,
      selectedColor: null,
      categorizedProducts: {},
      productOptions: {},
      allOptions: [],
      selectedOption: null,
      productOptionList: [],
      selectedItems: [],
      selectedProductQuantity: null,
      remainingQuantity: null,
    );
  }

  final ProductStates states;
  final ProductModel? product;
  final ProductModel? selectedProduct;
  final List<ProductModel?> allProducts;
  final File? productImage;
  final Color? selectedColor;
  final Map<String, List<ProductModel>>? categorizedProducts;
  final Map<String, List<ProductOptionModel>> productOptions;
  final List<OptionModel?> allOptions;
  final List<OptionModel?> productOptionList; // product's option list
  final OptionModel? selectedOption;
  final List<Item> selectedItems;
  final int? selectedProductQuantity;
  final int? remainingQuantity;

  @override
  List<Object?> get props => [
        states,
        product,
        allProducts,
        selectedProduct,
        productImage,
        selectedColor,
        categorizedProducts,
        productOptions,
        allOptions,
        selectedOption,
        productOptionList,
        selectedItems,
        selectedProductQuantity,
        remainingQuantity,
      ];

  ProductState copyWith({
    ProductStates? states,
    ProductModel? product,
    List<ProductModel?>? allProducts,
    ProductModel? Function()? selectedProduct,
    File? Function()? productImage,
    Color? Function()? selectedColor,
    Map<String, List<ProductModel>>? categorizedProducts,
    Map<String, List<ProductOptionModel>>? productOptions,
    List<OptionModel?>? allOptions,
    OptionModel? Function()? selectedOption,
    List<OptionModel?>? productOptionList,
    List<Item>? selectedItems,
    int? Function()? selectedProductQuantity,
    int? Function()? remainingQuantity,
  }) {
    return ProductState(
      states: states ?? this.states,
      product: product ?? this.product,
      allProducts: allProducts ?? this.allProducts,
      selectedProduct: selectedProduct != null ? selectedProduct() : this.selectedProduct,
      productImage: productImage != null ? productImage() : this.productImage,
      selectedColor: selectedColor != null ? selectedColor() : this.selectedColor,
      categorizedProducts: categorizedProducts ?? this.categorizedProducts,
      productOptions: productOptions ?? this.productOptions,
      allOptions: allOptions ?? this.allOptions,
      selectedOption: selectedOption != null ? selectedOption() : this.selectedOption,
      productOptionList: productOptionList ?? this.productOptionList,
      selectedItems: selectedItems ?? this.selectedItems,
      selectedProductQuantity: selectedProductQuantity != null
          ? selectedProductQuantity()
          : this.selectedProductQuantity,
      remainingQuantity: remainingQuantity != null ? remainingQuantity() : this.remainingQuantity,
    );
  }
}

enum ProductStates { initial, loading, completed, error }
