import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/model/product_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/service/i_product_service.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';

class ProductService implements IProductService {
  /// GET Products
  @override
  BaseResponseData<BaseResponseModel> getProducts() async {
    BaseResponseModel responseModel = await DioClient.instance.get(NetworkConstants.product);
    return ApiResponseHandler.handleResponse(responseModel);
  }

  /// POST Products
  @override
  BaseResponseData<BaseResponseModel> postProducts({required ProductModel productModel}) async {
    BaseResponseModel responseModel = await DioClient.instance.post(
      NetworkConstants.product,
      data: productModel.toJson(),
    );
    return ApiResponseHandler.handleResponse(responseModel);
  }

  /// PATCH Products
  @override
  BaseResponseData<BaseResponseModel> patchProducts({required String productId}) async {
    BaseResponseModel responseModel =
        await DioClient.instance.patch('${NetworkConstants.product}$productId');
    return ApiResponseHandler.handleResponse(responseModel);
  }

  /// PUT Products
  @override
  BaseResponseData<BaseResponseModel> putProducts(
      {required String productId, required ProductModel productModel}) async {
    BaseResponseModel responseModel = await DioClient.instance.put(
      '${NetworkConstants.product}$productId',
      data: productModel.toJson(),
    );

    return ApiResponseHandler.handleResponse(responseModel);
  }
}
