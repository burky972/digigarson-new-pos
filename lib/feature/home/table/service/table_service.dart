import 'package:a_pos_flutter/feature/home/table/service/i_table_service.dart';
import 'package:a_pos_flutter/product/constant/string/query_params.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/exception/exception.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/logger/a_pos_logger.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';
import 'package:fpdart/fpdart.dart';

class TableService extends ITableService {
  @override
  BaseResponseData<BaseResponseModel> getTable({required UserModel userModel}) async {
    BaseResponseModel response = await DioClient.instance.get(
      NetworkConstants.tables,
      queryParameters: QueryParams.dioQueryParams(userModel),
    );
    APosLogger.instance!.info('Table SERVICE', response.data.toString());
    if (response.serverException != null) {
      return Left(ServerException(
          message: response.serverException!.message,
          statusCode: response.serverException!.statusCode));
    } else {
      return Right(BaseResponseModel(data: response.data));
    }
  }
}
