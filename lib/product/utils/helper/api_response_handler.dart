import 'package:core/base/exception/exception.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/logger/a_pos_logger.dart';
import 'package:fpdart/fpdart.dart';

class ApiResponseHandler {
  static Either<ServerException, BaseResponseModel<T>> handleResponse<T>(
      BaseResponseModel response) {
    if (response.serverException != null) {
      APosLogger.instance!.warning('API RESPONSE HANDLER', 'RESPONSE IS LEFT');
      return Left(ServerException(
          message: response.serverException!.message,
          statusCode: response.serverException!.statusCode));
    } else {
      APosLogger.instance!.warning('API RESPONSE HANDLER', 'RESPONSE IS RIGHT');
      return Right(BaseResponseModel(data: response.data));
    }
  }
}
