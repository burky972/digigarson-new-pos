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
    );
  }

  final ProductStates states;
  final ProductModel? product;
  final ProductModel? selectedProduct;
  final List<ProductModel?> allProducts;
  final File? productImage;
  final Color? selectedColor;
  final Map<String, List<ProductModel>>? categorizedProducts;

  @override
  List<Object?> get props => [
        states,
        product,
        allProducts,
        selectedProduct,
        productImage,
        selectedColor,
        categorizedProducts
      ];

  ProductState copyWith({
    ProductStates? states,
    ProductModel? product,
    List<ProductModel?>? allProducts,
    ProductModel? Function()? selectedProduct,
    File? Function()? productImage,
    Color? Function()? selectedColor,
    Map<String, List<ProductModel>>? categorizedProducts,
  }) {
    return ProductState(
      states: states ?? this.states,
      product: product ?? this.product,
      allProducts: allProducts ?? this.allProducts,
      selectedProduct: selectedProduct != null ? selectedProduct() : this.selectedProduct,
      productImage: productImage != null ? productImage() : this.productImage,
      selectedColor: selectedColor != null ? selectedColor() : this.selectedColor,
      categorizedProducts: categorizedProducts ?? this.categorizedProducts,
    );
  }
}

enum ProductStates { initial, loading, completed, error }
