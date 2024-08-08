import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/model/product_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class IProductService {
  BaseResponseData<BaseResponseModel> getProducts();
  BaseResponseData<BaseResponseModel> postProducts({required ProductModel productModel});
  BaseResponseData<BaseResponseModel> putProducts(
      {required String productId, required ProductModel productModel});
  BaseResponseData<BaseResponseModel> patchProducts({required String productId});
}
