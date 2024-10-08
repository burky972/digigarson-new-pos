import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/model/utility_item_request_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class IUtilityItemService {
  BaseResponseData<BaseResponseModel> postUtilityItem(
      {required UtilityItemRequestModel utilityModel});
  BaseResponseData<BaseResponseModel> getUtilityItem();
  BaseResponseData<BaseResponseModel> putUtilityItem(
      {required String itemId, required UtilityItemUpdateRequestModel utilityModel});
  BaseResponseData<BaseResponseModel> deleteUtilityItem({required String itemId});
}
