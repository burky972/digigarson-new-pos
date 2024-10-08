import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_request_model.dart';
import 'package:a_pos_flutter/product/enums/customer_count/customer_count_type.dart';
import 'package:a_pos_flutter/product/global/model/catering/catering_cancel_model.dart';
import 'package:a_pos_flutter/product/global/model/catering/catering_model.dart';
import 'package:a_pos_flutter/product/global/model/customer_count/customer_count_model.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:a_pos_flutter/product/global/model/service_fee/service_fee_request_model.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class ITableService {
  DefaultServiceResponse getTable();
  DefaultServiceResponse postTable({required TableRequestModel tableModel});
  DefaultServiceResponse putTable({required String tableId, required TableRequestModel tableModel});
  DefaultServiceResponse deleteTable({required String tableId});
  DefaultServiceResponse deleteAllTables();
  DefaultServiceResponse postTableNewOrder(
      {required String tableId, required NewOrderModel newOrderModel});
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

  DefaultServiceResponse closeTable({required String tableId});
  DefaultServiceResponse postTableCover(
      {required CoverRequestModel coverModel, required String tableId});
  DefaultServiceResponse deleteTableCover({required String coverId, required String tableId});

  DefaultServiceResponse changeProductPrice({
    required UserModel userModel,
    required int orderNum,
    required List<Product> products,
    required String tableId,
  });

  DefaultServiceResponse tableQrOrderApprove({
    required UserModel userModel,
    required QrProduct qrProductModel,
  });
  DefaultServiceResponse tableQrOrderCancel({
    required UserModel userModel,
    required QrProduct qrProductModel,
  });

  List<OrderProductModel> convertProductsToOrderProducts(List<Product> products);
  DefaultServiceResponse patchCustomerCount(
      {required String tableId,
      required CustomerCountType type,
      required CustomerCountModel customerCountModel});

  /// post catering
  DefaultServiceResponse postCatering({required CateringModel cateringModel});

  /// cancel catering
  DefaultServiceResponse cancelCatering({required CateringCancelModel cateringCancelModel});

  /// post service fee
  DefaultServiceResponse postServiceFee(
      {required String tableId, required ServiceFeeRequestModel serviceFeeRequestModel});

  /// delete service fee
  DefaultServiceResponse deleteServiceFee({required String tableId, required String serviceId});
}

typedef DefaultServiceResponse = BaseResponseData<BaseResponseModel>;
