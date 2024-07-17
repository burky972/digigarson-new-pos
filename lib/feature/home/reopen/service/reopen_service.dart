import 'dart:convert';

import 'package:a_pos_flutter/feature/home/reopen/service/i_reopen_service.dart';
import 'package:a_pos_flutter/product/constant/string/query_params.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/logger/a_pos_logger.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';

class ReopenService extends IReopenService {
  @override
  BaseResponseData<BaseResponseModel> getOldCheck({required UserModel userModel}) async {
    BaseResponseModel response = await DioClient.instance.get(
      NetworkConstants.old,
      queryParameters: QueryParams.dioQueryParams(userModel),
    );
    APosLogger.instance!.info('Reopen SERVICE', response.data.toString());

    return ApiResponseHandler.handleResponse(response);
  }

  @override
  BaseResponseData<BaseResponseModel> putOldCheck(
      {required UserModel userModel, required String id, required MapStringDynamic data}) async {
    BaseResponseModel response = await DioClient.instance.put(
      '${NetworkConstants.oldUpdate}$id',
      queryParameters: QueryParams.dioQueryParams(userModel),
      data: jsonEncode(data),
    );
    return ApiResponseHandler.handleResponse(response);
  }
}
