import 'package:a_pos_flutter/feature/home/checks/model/single_check_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class ICheckService {
  BaseResponseData<BaseResponseModel> getAllCheck({int page, int per, required String orderType});
  BaseResponseData<BaseResponseModel> getSingleCheck({required String checkId});
  BaseResponseData<BaseResponseModel> updateCheck(
      {required String checkId, required SingleCheckModel checkModel});
}
