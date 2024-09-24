import 'package:a_pos_flutter/feature/home/order/model/pay_request_model.dart';
import 'package:a_pos_flutter/feature/home/order/service/i_order_service.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/product/global/model/quick_service/quick_service_request_model.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';

class OrderService implements IOrderService {
  final String TAG = 'OrderService';

  /// cancel order's product
  @override
  BaseResponseData<BaseResponseModel> cancelOrderProduct(
      {required CancelProduct cancelProductModel, required String tableId}) async {
    BaseResponseModel responseModel = await DioClient.instance.put(
      '${NetworkConstants.newOrderPos}$tableId/cancel',
      data: cancelProductModel.toJson(),
    );
    return ApiResponseHandler.handleResponse(responseModel);
  }

  /// pay order's product
  @override
  BaseResponseData<BaseResponseModel> payOrderProduct(
      {required PayRequestModel payOrderModel, required String tableId}) async {
    BaseResponseModel responseModel = await DioClient.instance.post(
      'pos/$tableId/pay',
      data: payOrderModel.toJson(),
    );
    return ApiResponseHandler.handleResponse(responseModel);
  }

  /// Move Table Product
  @override
  DefaultServiceResponse moveTableProduct({
    required MoveProduct moveProductModel,
    required String tableId,
    required String targetTableId,
  }) async {
    BaseResponseModel response = await DioClient.instance.post(
      '${NetworkConstants.orders}$tableId/move/$targetTableId',
      data: moveProductModel.toJson(),
    );
    appLogger.info('Table SERVICE PUT Move PRODUCT Table', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// Move Table Order
  @override
  DefaultServiceResponse moveTableOrder({
    required MoveProduct moveProductModel,
    required String tableId,
    required String targetTableId,
  }) async {
    BaseResponseModel response = await DioClient.instance.post(
      '${NetworkConstants.orders}$tableId/transfer/$targetTableId',
      data: moveProductModel.toJson(),
    );
    appLogger.info('Table SERVICE PUT Move-transfer Order Table', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  @override
  DefaultServiceResponse postQuickService(
      {required QuickServiceRequestModel quickServiceModel}) async {
    BaseResponseModel response = await DioClient.instance.post(
      NetworkConstants.quickService,
      data: quickServiceModel.toJson(),
    );
    return ApiResponseHandler.handleResponse(response);
  }
}
