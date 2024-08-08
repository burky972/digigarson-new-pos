import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/service/i_option_service.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';

final class OptionService implements IOptionService {
  /// GET Options
  @override
  BaseResponseData<BaseResponseModel> getOptions() async {
    BaseResponseModel responseModel = await DioClient.instance.get(NetworkConstants.option);
    return ApiResponseHandler.handleResponse(responseModel);
  }

  /// POST Options
  @override
  BaseResponseData<BaseResponseModel> postOptions({required OptionModel optionModel}) async {
    BaseResponseModel responseModel = await DioClient.instance.post(
      NetworkConstants.option,
      data: optionModel.toJson(),
    );
    return ApiResponseHandler.handleResponse(responseModel);
  }

  /// PUT Options
  @override
  BaseResponseData<BaseResponseModel> putOptions(
      {required String optionId, required OptionModel optionModel}) async {
    BaseResponseModel responseModel = await DioClient.instance
        .put('${NetworkConstants.option}$optionId', data: optionModel.toJson());

    return ApiResponseHandler.handleResponse(responseModel);
  }

  /// PATCH Options
  @override
  BaseResponseData<BaseResponseModel> patchOptions({required String optionId}) async {
    BaseResponseModel responseModel =
        await DioClient.instance.patch('${NetworkConstants.option}$optionId');
    return ApiResponseHandler.handleResponse(responseModel);
  }
}
