import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/service/i_note_service.dart';
import 'package:a_pos_flutter/product/constant/string/query_params.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';

class NoteServePaymentCancelReasonService extends INoteServePaymentCancelReasonService {
  @override
  BaseResponseData<BaseResponseModel> getNote({required UserModel userModel}) async {
    BaseResponseModel response = await DioClient.instance.get(
      NetworkConstants.notes,
      queryParameters: QueryParams.dioQueryParams(userModel),
    );
    appLogger.info('NoteServePaymentCancelReason Service', response.data.toString());

    return ApiResponseHandler.handleResponse(response);
  }

  /// GET CANCEL REASONS
  @override
  BaseResponseData<BaseResponseModel> getCancelReason() async {
    BaseResponseModel response = await DioClient.instance.get(NetworkConstants.cancelReasons);
    appLogger.info('NoteServePaymentCancelReason SERVICE', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  @override
  BaseResponseData<BaseResponseModel> getPaymentMethod({required UserModel userModel}) async {
    BaseResponseModel response = await DioClient.instance.get(
      NetworkConstants.paymentMethod,
      queryParameters: QueryParams.dioQueryParams(userModel),
    );
    appLogger.info('NoteServePaymentCancelReason SERVICE', response.data.toString());

    return ApiResponseHandler.handleResponse(response);
  }

  @override
  BaseResponseData<BaseResponseModel> getServe({required UserModel userModel}) async {
    BaseResponseModel response = await DioClient.instance.get(
      NetworkConstants.serves,
      queryParameters: QueryParams.dioQueryParams(userModel),
    );
    appLogger.info('NoteServePaymentCancelReason SERVICE', response.data.toString());

    return ApiResponseHandler.handleResponse(response);
  }
}
