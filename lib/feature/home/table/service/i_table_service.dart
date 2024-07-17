import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/product/global/model/change_price/change_price_pay_model.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class ITableService {
  DefaultServiceResponse getTable({required UserModel userModel});
  DefaultServiceResponse postTableNewOrder(
      {required UserModel userModel,
      required String tableId,
      required NewOrderModel newOrderModel});
  DefaultServiceResponse postTableNewService(
      {required UserModel userModel, required String tableId, required NewService newServiceModel});
  DefaultServiceResponse deleteTableService(
      {required UserModel userModel, required String tableId, required String serviceId});

  DefaultServiceResponse postTableDiscount(
      {required UserModel userModel,
      required String tableId,
      required NewDiscount newDiscountModel});
  DefaultServiceResponse deleteTableDiscount(
      {required UserModel userModel,
      required String tableId,
      required DeleteDiscount deleteDiscountModel});

  DefaultServiceResponse closeTable({required UserModel userModel, required String tableId});
  DefaultServiceResponse postTableCover(
      {required UserModel userModel, required NewCover newCoverModel, required String tableId});
  DefaultServiceResponse deleteTableCover(
      {required UserModel userModel, required DeleteCover coverModel, required String tableId});
  DefaultServiceResponse cancelTableProduct(
      {required UserModel userModel,
      required CancelProduct cancelProductModel,
      required String tableId});
  DefaultServiceResponse changeProductPrice({
    required UserModel userModel,
    required int orderNum,
    required List<Product> products,
    required String tableId,
  });

  List<OrderProduct> convertProductsToOrderProducts(List<Product> products);
}

typedef DefaultServiceResponse = BaseResponseData<BaseResponseModel>;
