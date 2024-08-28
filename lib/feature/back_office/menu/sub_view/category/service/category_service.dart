import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/model/category_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/service/i_category_service.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';

class CategoryService extends ICategoryService {
  /// GET CATEGORIES
  @override
  BaseResponseData<BaseResponseModel> getCategories() async {
    BaseResponseModel responseModel = await DioClient.instance.get(NetworkConstants.category);
    return ApiResponseHandler.handleResponse(responseModel);
  }

  /// POST CATEGORIES
  @override
  BaseResponseData<BaseResponseModel> postCategories(
      {required CategoryModel categoriesModel}) async {
    BaseResponseModel responseModel = await DioClient.instance.post(
      NetworkConstants.category,
      data: categoriesModel.toJson(),
    );

    return ApiResponseHandler.handleResponse(responseModel);
  }

  /// PATCH CATEGORIES
  @override
  BaseResponseData<BaseResponseModel> patchCategories({required String categoryId}) async {
    BaseResponseModel responseModel = await DioClient.instance.patch(
      '${NetworkConstants.category}$categoryId',
    );
    return ApiResponseHandler.handleResponse(responseModel);
  }

  /// PUT CATEGORIES
  @override
  BaseResponseData<BaseResponseModel> putCategories(
      {required String categoryId, required CategoryModel categoriesModel}) async {
    BaseResponseModel responseModel = await DioClient.instance.put(
      '${NetworkConstants.category}$categoryId',
      data: categoriesModel.toJson(),
    );

    return ApiResponseHandler.handleResponse(responseModel);
  }
}
