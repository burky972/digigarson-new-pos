import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_request_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class IOptionService {
  BaseResponseData<BaseResponseModel> getOptions();
  BaseResponseData<BaseResponseModel> postOptions({required OptionRequestModel optionModel});
  BaseResponseData<BaseResponseModel> putOptions(
      {required String optionId, required OptionModel optionModel});
  BaseResponseData<BaseResponseModel> patchOptions({required String optionId});
}
