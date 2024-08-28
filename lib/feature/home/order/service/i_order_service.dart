import 'package:a_pos_flutter/feature/home/order/model/pay_request_model.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class IOrderService {
  DefaultServiceResponse cancelOrderProduct(
      {required CancelProduct cancelProductModel, required String tableId});
  DefaultServiceResponse payOrderProduct(
      {required PayRequestModel payOrderModel, required String tableId});

  DefaultServiceResponse moveTableProduct({
    required MoveProduct moveProductModel,
    required String tableId,
    required String targetTableId,
  });
  DefaultServiceResponse moveTableOrder({
    required MoveProduct moveProductModel,
    required String tableId,
    required String targetTableId,
  });
}

typedef DefaultServiceResponse = BaseResponseData<BaseResponseModel>;
