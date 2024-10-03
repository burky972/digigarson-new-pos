import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_request_model.dart';
import 'package:a_pos_flutter/feature/home/table/service/i_table_service.dart';
import 'package:a_pos_flutter/product/constant/string/query_params.dart';
import 'package:a_pos_flutter/product/enums/customer_count/customer_count_type.dart';
import 'package:a_pos_flutter/product/global/model/catering/catering_cancel_model.dart';
import 'package:a_pos_flutter/product/global/model/catering/catering_model.dart';
import 'package:a_pos_flutter/product/global/model/change_price/change_product_price_model.dart';
import 'package:a_pos_flutter/product/global/model/customer_count/customer_count_model.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:a_pos_flutter/product/global/model/service_fee/service_fee_request_model.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:core/base/exception/exception.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';
import 'package:fpdart/fpdart.dart';

class TableService implements ITableService {
  /// GET TABLE
  @override
  DefaultServiceResponse getTable() async {
    BaseResponseModel response = await DioClient.instance.get(NetworkConstants.tables);
    appLogger.info('Table SERVICE GET TABLE', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// GET TABLE
  @override
  DefaultServiceResponse postTable({required TableRequestModel tableModel}) async {
    BaseResponseModel response = await DioClient.instance.post(
      NetworkConstants.tables,
      data: tableModel.toJson(),
    );
    appLogger.info('Table SERVICE POST TABLE', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// post TABLE NEW ORDER
  @override
  DefaultServiceResponse postTableNewOrder(
      {required String tableId, required NewOrderModel newOrderModel}) async {
    appLogger.info('Table SERVICE POST NEW ORDER json', newOrderModel.toJson().toString());
    BaseResponseModel response = await DioClient.instance.post(
      '${NetworkConstants.newOrderPos}$tableId',
      data: newOrderModel.toJson(),
    );
    return ApiResponseHandler.handleResponse(response);
  }

  /// post TABLE NEW SERVICE
  @override
  DefaultServiceResponse postTableNewService(
      {required UserModel userModel,
      required String tableId,
      required NewService newServiceModel}) async {
    BaseResponseModel response = await DioClient.instance.post(
      '${NetworkConstants.newServicePost}$tableId',
      queryParameters: QueryParams.dioQueryParams(userModel),
      data: newServiceModel.toJson(),
    );
    appLogger.info('Table SERVICE POST NEW SERVICE', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// DELETE TABLE
  @override
  DefaultServiceResponse deleteTable({required String tableId}) async {
    BaseResponseModel response = await DioClient.instance.delete(
      '${NetworkConstants.tables}/$tableId',
    );
    appLogger.info('Table SERVICE DELETE TABLE', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// DELETE TABLE SERVICE
  @override
  DefaultServiceResponse deleteTableService(
      {required UserModel userModel, required String tableId, required String serviceId}) async {
    BaseResponseModel response = await DioClient.instance.delete(
      '${NetworkConstants.newServicePost}$tableId/$serviceId',
      queryParameters: QueryParams.dioQueryParams(userModel),
    );
    appLogger.info('Table SERVICE DELETE SERVICE', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// POST TABLE DISCOUNT
  @override
  DefaultServiceResponse postTableDiscount(
      {required UserModel userModel,
      required String tableId,
      required NewDiscount newDiscountModel}) async {
    BaseResponseModel response = await DioClient.instance.post(
      '${NetworkConstants.newDiscountPost}$tableId',
      queryParameters: QueryParams.dioQueryParams(userModel),
      data: newDiscountModel.toJson(),
    );
    appLogger.info('Table SERVICE POST DISCOUNT', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// DELETE TABLE DISCOUNT
  @override
  DefaultServiceResponse deleteTableDiscount(
      {required UserModel userModel,
      required String tableId,
      required DeleteDiscount deleteDiscountModel}) async {
    BaseResponseModel response = await DioClient.instance.delete(
      '${NetworkConstants.newDiscountPost}$tableId',
      queryParameters: QueryParams.dioQueryParams(userModel),
      data: deleteDiscountModel.toJson(),
    );
    appLogger.info('Table SERVICE DELETE DISCOUNT', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// GET CLOSE TABLE
  @override
  DefaultServiceResponse closeTable({required String tableId}) async {
    BaseResponseModel response = await DioClient.instance.put(
      '${NetworkConstants.tables}/$tableId/close',
    );
    appLogger.info('Table SERVICE CLOSE TABLE', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// post TABLE COVER
  @override
  DefaultServiceResponse postTableCover(
      {required String tableId, required CoverRequestModel coverModel}) async {
    BaseResponseModel response = await DioClient.instance.post(
      '${NetworkConstants.cover}/$tableId/cover',
      data: coverModel.toJson(),
    );
    appLogger.info('Table SERVICE POST TABLE COVER', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// DELETE TABLE COVER
  @override
  DefaultServiceResponse deleteTableCover(
      {required String tableId, required String coverId}) async {
    BaseResponseModel response = await DioClient.instance.delete(
      '${NetworkConstants.cover}/$tableId/$coverId',
    );
    appLogger.info('Table SERVICE DELETE COVER', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  ///convert Product model to Order Product Model
  @override
  List<OrderProductModel> convertProductsToOrderProducts(List<Product> products) {
    List<OrderProductModel> orderProducts = [];
    for (var product in products) {
      OrderProductModel orderProduct = OrderProductModel(
          isFirst: product.isFirst!,
          note: product.note!,
          cancelStatus: CancelStatus.empty(),
          id: product.id!,
          product: product.product!,
          productName: product.productName!,
          categoryId: '', //! check here later,
          quantity: double.tryParse(product.quantity!.toString()) ?? 1.0,
          priceId: product.priceId!,
          options: product.options.map((e) => Options.fromJson(e.toJson())).toList(),
          priceName: 'REGULAR',
          priceType: 'REGULAR',
          priceAfterTax: product.priceAfterTax!,
          tax: product.tax!,
          price: product.price!,
          // createdAt: product.createdAt!.toString(),
          serveInfo: product.serveInfo ?? ServeInfoModel.empty());
      orderProducts.add(orderProduct);
    }
    return orderProducts;
  }

  /// put Change product's price
  @override
  DefaultServiceResponse changeProductPrice(
      {required UserModel userModel,
      required int orderNum,
      required List<Product> products,
      required String tableId}) async {
    try {
      // List<OrderProductModel> orderProducts = convertProductsToOrderProducts(products);//! open it later!
      ChangeProductPriceModel newBody = ChangeProductPriceModel(
        tableId: tableId,
        // orders: [OrderPay(orderNum: orderNum, products: orderProducts)],
      );
      BaseResponseModel response = await DioClient.instance.put(
        '${NetworkConstants.newOrderPos}$tableId',
        queryParameters: QueryParams.dioQueryParams(userModel),
        data: newBody.toJson(),
      );
      appLogger.info('Table SERVICE put change price', response.data.toString());
      return ApiResponseHandler.handleResponse(response);
    } catch (e) {
      return Left(ServerException(message: e.toString(), statusCode: '505'));
    }
  }

  /// PUT Table Qr Order Approve
  @override
  DefaultServiceResponse tableQrOrderApprove(
      {required UserModel userModel, required QrProduct qrProductModel}) async {
    BaseResponseModel response = await DioClient.instance.put(
      '${NetworkConstants.qrOrderPut}${qrProductModel.tableId}/approve',
      queryParameters: QueryParams.dioQueryParams(userModel),
      data: qrProductModel.toJson(),
    );
    appLogger.info('Table SERVICE PUT Table Qr Order Approve', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// PUT Cancel Table Qr Order Approve
  @override
  DefaultServiceResponse tableQrOrderCancel(
      {required UserModel userModel, required QrProduct qrProductModel}) async {
    BaseResponseModel response = await DioClient.instance.put(
      '${NetworkConstants.qrOrderPut}${qrProductModel.tableId}/cancel',
      queryParameters: QueryParams.dioQueryParams(userModel),
      data: qrProductModel.toJson(),
    );
    appLogger.info('Table SERVICE PUT CANCEL Table Qr Order Approve', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// Delete All Tables
  @override
  DefaultServiceResponse deleteAllTables() async {
    BaseResponseModel response = await DioClient.instance.delete(
      NetworkConstants.deleteAllTables,
    );
    appLogger.info('Table SERVICE Delete All Table', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// PATCH (edit) Customer Count
  @override
  DefaultServiceResponse patchCustomerCount({
    required String tableId,
    required CustomerCountType type,
    required CustomerCountModel customerCountModel,
  }) async {
    BaseResponseModel response = await DioClient.instance.patch(
      NetworkConstants.editCustomerCount(tableId: tableId, type: type.name),
      data: customerCountModel.toJson(),
    );
    appLogger.info('Table SERVICE patch customer count', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// Post catering cancel
  @override
  DefaultServiceResponse cancelCatering({required CateringCancelModel cateringCancelModel}) async {
    BaseResponseModel response = await DioClient.instance.post(
      NetworkConstants.cancelCatering(
        tableId: cateringCancelModel.tableId,
      ),
      data: {
        "products": [cateringCancelModel.id]
      },
    );
    return ApiResponseHandler.handleResponse(response);
  }

  ///Post catering
  @override
  DefaultServiceResponse postCatering({required CateringModel cateringModel}) async {
    BaseResponseModel response = await DioClient.instance.post(
      NetworkConstants.postCatering(
          tableId: cateringModel.tableId!,
          orderNum: cateringModel.orderNum.toString(),
          productId: cateringModel.productId!),
      data: {"serveId": cateringModel.serveId, "quantity": cateringModel.quantity},
    );
    return ApiResponseHandler.handleResponse(response);
  }

  ///Post service fee
  @override
  DefaultServiceResponse postServiceFee(
      {required String tableId, required ServiceFeeRequestModel serviceFeeRequestModel}) async {
    BaseResponseModel response = await DioClient.instance.post(
      NetworkConstants.postServiceFee(tableId: tableId, type: serviceFeeRequestModel.type!),
      data: serviceFeeRequestModel.toJson(),
    );
    return ApiResponseHandler.handleResponse(response);
  }

  /// Delete service fee
  @override
  DefaultServiceResponse deleteServiceFee(
      {required String tableId, required String serviceId}) async {
    BaseResponseModel response = await DioClient.instance.delete(
      NetworkConstants.delServiceFee(tableId: tableId, serviceId: serviceId),
    );
    return ApiResponseHandler.handleResponse(response);
  }
}
