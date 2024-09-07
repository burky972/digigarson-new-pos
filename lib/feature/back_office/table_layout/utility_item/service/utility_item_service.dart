import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/model/utility_item_request_model.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/service/i_utility_item_service.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';

class UtilityItemService implements IUtilityItemService {
  /// get all utility items
  @override
  BaseResponseData<BaseResponseModel> getUtilityItem() async {
    BaseResponseModel responseModel = await DioClient.instance.get(NetworkConstants.utilityItem);
    return ApiResponseHandler.handleResponse(responseModel);
  }

  /// post utility items
  @override
  BaseResponseData<BaseResponseModel> postUtilityItem(
      {required UtilityItemRequestModel utilityModel}) async {
    BaseResponseModel responseModel =
        await DioClient.instance.post(NetworkConstants.utilityItem, data: utilityModel.toJson());
    return ApiResponseHandler.handleResponse(responseModel);
  }

  @override
  BaseResponseData<BaseResponseModel> deleteUtilityItem({required String itemId}) async {
    BaseResponseModel responseModel =
        await DioClient.instance.delete('${NetworkConstants.utilityItem}/$itemId');
    return ApiResponseHandler.handleResponse(responseModel);
  }
}
