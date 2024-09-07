import 'package:a_pos_flutter/feature/home/checks/service/i_check_service.dart';
import 'package:a_pos_flutter/product/constant/string/query_params.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';

class CheckService implements ICheckService {
  @override
  BaseResponseData<BaseResponseModel> getAllCheck(
      {int page = 1, int per = 100, required String orderType}) async {
    BaseResponseModel response = await DioClient.instance.get(
      NetworkConstants.check,
      queryParameters: QueryParams.getAllCheckQueries(page: page, per: per, orderType: orderType),
    );
    appLogger.info('Check SERVICE=> getAllCheck', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  @override
  BaseResponseData<BaseResponseModel> getSingleCheck({required String checkId}) async {
    BaseResponseModel response = await DioClient.instance.get('${NetworkConstants.check}$checkId');
    appLogger.info('Check SERVICE=> getSingleCheck', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }
}
