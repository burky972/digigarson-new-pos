import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class IReopenService {
  BaseResponseData<BaseResponseModel> getAllCheck(
      {required UserModel userModel, int page, int per, required String orderType});
  BaseResponseData<BaseResponseModel> putOldCheck(
      {required UserModel userModel, required String id, required MapStringDynamic data});
}
