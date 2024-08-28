import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class IReopenService {
  BaseResponseData<BaseResponseModel> getAllCheck({int page, int per, required String orderType});
  BaseResponseData<BaseResponseModel> putOldCheck(
      {required String id, required MapStringDynamic data});
}
