import 'package:a_pos_flutter/feature/home/order/cubit/order_cubit.dart';
import 'package:a_pos_flutter/feature/home/order/model/pay_request_model.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:core/core.dart';

abstract class IOrderCubit extends BaseCubit<OrderState> {
  IOrderCubit(super.initialState);

  Future<bool> cancelOrderProduct(
      {required CancelProduct cancelProductModel, required String tableId});
  Future<bool> payOrderProduct({required PayRequestModel payOrderModel, required String tableId});
  Future<bool> transferTable(
      {required MoveProduct moveTable, required String tableId, required String targetTableId});
  Future moveProducts(
      {required MoveProduct moveProduct, required String tableId, required String targetTableId});
}
