import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/feature/home/table/service/i_table_service.dart';
import 'package:a_pos_flutter/product/constant/string/query_params.dart';
import 'package:a_pos_flutter/product/global/model/change_price/change_price_pay_model.dart';
import 'package:a_pos_flutter/product/global/model/change_price/change_product_price_model.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:core/base/exception/exception.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/logger/a_pos_logger.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/network/network_constants.dart';
import 'package:fpdart/fpdart.dart';

class TableService extends ITableService {
  /// GET TABLE
  @override
  DefaultServiceResponse getTable({required UserModel userModel}) async {
    BaseResponseModel response = await DioClient.instance.get(
      NetworkConstants.tables,
    );
    APosLogger.instance!.info('Table SERVICE GET TABLE', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// post TABLE NEW ORDER
  @override
  DefaultServiceResponse postTableNewOrder(
      {required UserModel userModel,
      required String tableId,
      required NewOrderModel newOrderModel}) async {
    BaseResponseModel response = await DioClient.instance.post(
      '${NetworkConstants.newOrderPos}$tableId',
      queryParameters: QueryParams.dioQueryParams(userModel),
      data: newOrderModel.toJson(),
    );
    APosLogger.instance!.info('Table SERVICE POST NEW ORDER', response.data.toString());
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
    APosLogger.instance!.info('Table SERVICE POST NEW SERVICE', response.data.toString());
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
    APosLogger.instance!.info('Table SERVICE DELETE SERVICE', response.data.toString());
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
    APosLogger.instance!.info('Table SERVICE POST DISCOUNT', response.data.toString());
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
    APosLogger.instance!.info('Table SERVICE DELETE DISCOUNT', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// GET CLOSE TABLE
  @override
  DefaultServiceResponse closeTable({required UserModel userModel, required String tableId}) async {
    BaseResponseModel response = await DioClient.instance.get(
      '${NetworkConstants.closeTable}$tableId',
      queryParameters: QueryParams.dioQueryParams(userModel),
    );
    APosLogger.instance!.info('Table SERVICE CLOSE TABLE', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// post TABLE COVER
  @override
  DefaultServiceResponse postTableCover(
      {required UserModel userModel,
      required String tableId,
      required NewCover newCoverModel}) async {
    BaseResponseModel response = await DioClient.instance.post(
      '${NetworkConstants.newCoverPost}$tableId',
      queryParameters: QueryParams.dioQueryParams(userModel),
      data: newCoverModel.toJson(),
    );
    APosLogger.instance!.info('Table SERVICE POST TABLE COVER', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// DELETE TABLE COVER
  @override
  DefaultServiceResponse deleteTableCover(
      {required UserModel userModel,
      required String tableId,
      required DeleteCover coverModel}) async {
    BaseResponseModel response = await DioClient.instance.delete(
      '${NetworkConstants.newCoverPost}$tableId',
      queryParameters: QueryParams.dioQueryParams(userModel),
      data: coverModel.toJson(),
    );
    APosLogger.instance!.info('Table SERVICE DELETE COVER', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// PUT TABLE CANCEL PRODUCT
  @override
  DefaultServiceResponse cancelTableProduct(
      {required UserModel userModel,
      required String tableId,
      required CancelProduct cancelProductModel}) async {
    BaseResponseModel response = await DioClient.instance.put(
      '${NetworkConstants.cancelProductPut}$tableId/cancel',
      queryParameters: QueryParams.dioQueryParams(userModel),
      data: cancelProductModel.toJson(),
    );
    APosLogger.instance!.info('Table SERVICE PUT CANCEL PRODUCT', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  ///convert Product model to Order Product Model
  @override
  List<OrderProduct> convertProductsToOrderProducts(List<Product> products) {
    List<OrderProduct> orderProducts = [];
    for (var product in products) {
      OrderProduct orderProduct = OrderProduct(
        isFirst: product.isFirst!,
        isDeleted: product.isDeleted!,
        isPrint: product.isPrint!,
        optionsString: product.optionsString!,
        status: product.status!,
        note: product.note!,
        id: product.id!,
        product: product.product!,
        productName: product.productName!,
        quantity: int.tryParse(product.quantity!.toString()) ?? 1,
        priceId: product.priceId!,
        price: product.price!,
        isServe: product.isServe!,
        serveId: product.serveId!,
        createdAt: product.createdAt!.toString(),
      );
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
      List<OrderProduct> orderProducts = convertProductsToOrderProducts(products);
      ChangeProductPriceModel newBody = ChangeProductPriceModel(
        tableId: tableId,
        orders: [OrderPay(orderNum: orderNum, products: orderProducts)],
      );
      BaseResponseModel response = await DioClient.instance.put(
        '${NetworkConstants.newOrderPos}$tableId',
        queryParameters: QueryParams.dioQueryParams(userModel),
        data: newBody.toJson(),
      );
      APosLogger.instance!.info('Table SERVICE put change price', response.data.toString());
      return ApiResponseHandler.handleResponse(response);
    } catch (e) {
      return Left(ServerException(message: e.toString(), statusCode: '505'));
    }
  }

  /// PUT Table Product Catering
  @override
  DefaultServiceResponse putProductCatering(
      {required UserModel userModel,
      required CateringProduct cateringModel,
      required String tableId}) async {
    BaseResponseModel response = await DioClient.instance.put(
      '${NetworkConstants.cateringProductPut}$tableId/${cateringModel.orderNum}/${cateringModel.orderId}',
      queryParameters: QueryParams.dioQueryParams(userModel),
      data: cateringModel.toJson(),
    );
    APosLogger.instance!.info('Table SERVICE PUT PRODUCT CATERING', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// Cancel  Table Product Catering
  @override
  DefaultServiceResponse cancelProductCatering(
      {required UserModel userModel,
      required CateringProduct cateringModel,
      required String tableId}) async {
    BaseResponseModel response = await DioClient.instance.put(
      '${NetworkConstants.cateringProductPut}$tableId/cancel',
      queryParameters: QueryParams.dioQueryParams(userModel),
      data: cateringModel.toJson(),
    );
    APosLogger.instance!
        .info('Table SERVICE PUT CANCEL PRODUCT CATERING', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// Move Table Product
  @override
  DefaultServiceResponse moveTableProduct(
      {required UserModel userModel, required MoveProduct moveProductModel}) async {
    BaseResponseModel response = await DioClient.instance.put(
      '${NetworkConstants.moveProductPut}${moveProductModel.currentTable}/${moveProductModel.targetTable}',
      queryParameters: QueryParams.dioQueryParams(userModel),
      data: moveProductModel.toJson(),
    );
    APosLogger.instance!.info('Table SERVICE PUT Move PRODUCT Table', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }

  /// Move Table Order
  @override
  DefaultServiceResponse moveTableOrder(
      {required UserModel userModel, required MoveProduct moveProductModel}) async {
    BaseResponseModel response = await DioClient.instance.put(
      '${NetworkConstants.moveOrderPut}${moveProductModel.currentTable}/${moveProductModel.targetTable}',
      queryParameters: QueryParams.dioQueryParams(userModel),
      data: moveProductModel.toJson(),
    );
    APosLogger.instance!.info('Table SERVICE PUT Move Order Table', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
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
    APosLogger.instance!.info('Table SERVICE PUT Table Qr Order Approve', response.data.toString());
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
    APosLogger.instance!
        .info('Table SERVICE PUT CANCEL Table Qr Order Approve', response.data.toString());
    return ApiResponseHandler.handleResponse(response);
  }
}
