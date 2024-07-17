import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class IReopenService {
  BaseResponseData<BaseResponseModel> getOldCheck({required UserModel userModel});
  BaseResponseData<BaseResponseModel> putOldCheck(
      {required UserModel userModel, required String id, required MapStringDynamic data});
}
