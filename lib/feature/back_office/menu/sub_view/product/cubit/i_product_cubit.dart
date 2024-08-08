import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/cubit/product_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/model/product_model.dart';
import 'package:core/base/cubit/base_cubit.dart';

abstract class IProductCubit extends BaseCubit<ProductState> {
  IProductCubit(super.initialState);
  ProductModel? get product;
  Future getProducts();
  Future postProducts({required ProductModel productModel});
  Future putProducts({required ProductModel productModel, required String productId});
  void setSelectedProduct(ProductModel product, PriceModel price);
  Future<void> getProductImage();
  Future patchProducts({required String productId});
}
