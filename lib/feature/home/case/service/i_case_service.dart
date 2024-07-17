import 'package:a_pos_flutter/feature/home/case/model/case_model.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class ICaseService {
  BaseResponseData<BaseResponseModel> getCases({required UserModel userModel});
  BaseResponseData<BaseResponseModel> postCases(
      {required UserModel userModel, required BalanceModel balanceModel});
}
