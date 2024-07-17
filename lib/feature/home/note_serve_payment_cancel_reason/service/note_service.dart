import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/service/i_note_service.dart';
import 'package:a_pos_flutter/product/constant/string/query_params.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/exception/exception.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/logger/a_pos_logger.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';
import 'package:fpdart/fpdart.dart';

class NoteServePaymentCancelReasonService extends INoteServePaymentCancelReasonService {
  @override
  BaseResponseData<BaseResponseModel> getNote({required UserModel userModel}) async {
    BaseResponseModel response = await DioClient.instance.get(
      NetworkConstants.notes,
      queryParameters: QueryParams.dioQueryParams(userModel),
    );
    APosLogger.instance!.info('NoteServePaymentCancelReason Service', response.data.toString());

    if (response.serverException != null) {
      return Left(ServerException(
          message: response.serverException!.message,
          statusCode: response.serverException!.statusCode));
    } else {
      return Right(BaseResponseModel(data: response.data));
    }
  }

  @override
  BaseResponseData<BaseResponseModel> getCancelReason({required UserModel userModel}) async {
    BaseResponseModel response = await DioClient.instance.get(
      NetworkConstants.cancelReasons,
      queryParameters: QueryParams.dioQueryParams(userModel),
    );
    APosLogger.instance!.info('NoteServePaymentCancelReason SERVICE', response.data.toString());

    if (response.serverException != null) {
      return Left(ServerException(
          message: response.serverException!.message,
          statusCode: response.serverException!.statusCode));
    } else {
      return Right(BaseResponseModel(data: response.data));
    }
  }

  @override
  BaseResponseData<BaseResponseModel> getPaymentMethod({required UserModel userModel}) async {
    BaseResponseModel response = await DioClient.instance.get(
      NetworkConstants.paymentMethod,
      queryParameters: QueryParams.dioQueryParams(userModel),
    );
    APosLogger.instance!.info('NoteServePaymentCancelReason SERVICE', response.data.toString());

    if (response.serverException != null) {
      return Left(ServerException(
          message: response.serverException!.message,
          statusCode: response.serverException!.statusCode));
    } else {
      return Right(BaseResponseModel(data: response.data));
    }
  }

  @override
  BaseResponseData<BaseResponseModel> getServe({required UserModel userModel}) async {
    BaseResponseModel response = await DioClient.instance.get(
      NetworkConstants.serves,
      queryParameters: QueryParams.dioQueryParams(userModel),
    );
    APosLogger.instance!.info('NoteServePaymentCancelReason SERVICE', response.data.toString());

    if (response.serverException != null) {
      return Left(ServerException(
          message: response.serverException!.message,
          statusCode: response.serverException!.statusCode));
    } else {
      return Right(BaseResponseModel(data: response.data));
    }
  }
}
