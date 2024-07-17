import 'package:a_pos_flutter/product/constant/string/query_params.dart';
import 'package:core/base/exception/exception.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/logger/a_pos_logger.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';
import 'package:fpdart/fpdart.dart';

import 'package:a_pos_flutter/feature/home/case/model/case_model.dart';
import 'package:a_pos_flutter/feature/home/case/service/i_case_service.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';

class CaseService extends ICaseService {
  @override
  BaseResponseData<BaseResponseModel> getCases({required UserModel userModel}) async {
    BaseResponseModel response = await DioClient.instance.get(
      NetworkConstants.cases,
      queryParameters: QueryParams.dioQueryParams(userModel),
    );
    APosLogger.instance!.info('CASE SERVICE', response.data.toString());

    if (response.serverException != null) {
      return Left(ServerException(
          message: response.serverException!.message,
          statusCode: response.serverException!.statusCode));
    } else {
      return Right(BaseResponseModel(data: response.data));
    }
  }

  @override
  BaseResponseData<BaseResponseModel> postCases(
      {required UserModel userModel, required BalanceModel balanceModel}) async {
    BaseResponseModel response = await DioClient.instance.post(
      NetworkConstants.cases,
      queryParameters: QueryParams.dioQueryParams(userModel),
      data: {
        'start_balance': [balanceModel.toJson()]
      },
    );

    if (response.serverException != null) {
      return Left(ServerException(
          message: response.serverException!.message,
          statusCode: response.serverException!.statusCode));
    } else {
      return Right(BaseResponseModel(data: response.data));
    }
  }
}
