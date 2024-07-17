import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class INoteServePaymentCancelReasonService {
  BaseResponseData<BaseResponseModel> getNote({required UserModel userModel});
  BaseResponseData<BaseResponseModel> getServe({required UserModel userModel});
  BaseResponseData<BaseResponseModel> getCancelReason({required UserModel userModel});
  BaseResponseData<BaseResponseModel> getPaymentMethod({required UserModel userModel});
}
