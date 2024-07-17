import 'dart:ui';

import 'package:a_pos_flutter/feature/home/branch/service/i_branch_service.dart';
import 'package:a_pos_flutter/product/constant/string/query_params.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/exception/exception.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/logger/a_pos_logger.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';
import 'package:fpdart/fpdart.dart';

class BranchService extends IBranchService {
  @override
  BaseResponseData<BaseResponseModel> getBranch(
      {required UserModel userModel, required Locale languageModel}) async {
    BaseResponseModel response = await DioClient.instance.get(
      '${NetworkConstants.myBranch}/${languageModel.countryCode}',
      queryParameters: QueryParams.dioQueryParams(userModel),
    );
    APosLogger.instance!.info('Branch SERVICE', response.data.toString());
    if (response.serverException != null) {
      return Left(ServerException(
          message: response.serverException!.message,
          statusCode: response.serverException!.statusCode));
    } else {
      return Right(BaseResponseModel(data: response.data));
    }
  }
}
