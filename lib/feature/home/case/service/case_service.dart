import 'package:a_pos_flutter/product/constant/string/query_params.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';
import 'package:a_pos_flutter/feature/home/case/model/case_model.dart';
import 'package:a_pos_flutter/feature/home/case/service/i_case_service.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';

class CaseService extends ICaseService {
  @override
  BaseResponseData<BaseResponseModel> getCases(
      {required UserModel userModel, int page = 1, int per = 100}) async {
    DioClient.instance.updateHeader(userModel.accessToken!);
    BaseResponseModel response = await DioClient.instance.get(
      NetworkConstants.cases,
      queryParameters: QueryParams.getCasesQueries(page: page, per: per),
    );
    appLogger.info('CASE SERVICE', response.data.toString());

    return ApiResponseHandler.handleResponse(response);
  }

  @override
  BaseResponseData<BaseResponseModel> getOpenCases() async {
    // DioClient.instance.updateHeader(userModel.accessToken!);
    BaseResponseModel response = await DioClient.instance.get(NetworkConstants.openCases);
    appLogger.info('CASE SERVICE', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  @override
  BaseResponseData<BaseResponseModel> postCases({required BalanceModel balanceModel}) async {
    BaseResponseModel response = await DioClient.instance.post(
      NetworkConstants.cases,
      data: {'start_balance': balanceModel.toJson()},
    );
    return ApiResponseHandler.handleResponse(response);
  }
}
