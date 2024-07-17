import 'dart:ui';

import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class IBranchService {
  BaseResponseData<BaseResponseModel> getBranch(
      {required UserModel userModel, required Locale languageModel});
}
