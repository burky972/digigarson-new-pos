import 'package:a_pos_flutter/feature/home/order/cubit/i_order_cubit.dart';
import 'package:a_pos_flutter/feature/home/order/model/pay_request_model.dart';
import 'package:a_pos_flutter/feature/home/order/service/i_order_service.dart';
import 'package:a_pos_flutter/feature/home/order/service/order_service.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:core/core.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';

part 'order_state.dart';

class OrderCubit extends IOrderCubit {
  OrderCubit() : super(OrderState.initial());

  final IOrderService _orderService = OrderService();
  final TAG = 'OrderCubit';
  @override
  void init() {}

  ///cancel order's product
  @override
  Future<bool> cancelOrderProduct(
      {required CancelProduct cancelProductModel, required String tableId}) async {
    appLogger.info(TAG, 'Cancelling...');
    emit(state.copyWith(states: OrderStates.loading));
    final response = await _orderService.cancelOrderProduct(
        cancelProductModel: cancelProductModel, tableId: tableId);
    response.fold((_) {
      emit(state.copyWith(states: OrderStates.error));
    }, (r) {
      emit(state.copyWith(states: OrderStates.success));
    });
    return response.isRight();
  }

  /// pay order's product
  @override
  Future<bool> payOrderProduct(
      {required PayRequestModel payOrderModel, required String tableId}) async {
    for (var payment in payOrderModel.payments) {
      appLogger.warning('onRequest pay: ', '${payment.toJson()}');
    }
    for (var order in payOrderModel.paidOrderModel) {
      appLogger.warning('onRequest order: ', ' ${order.toJson()}');
    }

    emit(state.copyWith(states: OrderStates.loading));
    final response =
        await _orderService.payOrderProduct(payOrderModel: payOrderModel, tableId: tableId);
    response.fold((_) => emit(state.copyWith(states: OrderStates.error)),
        (r) => emit(state.copyWith(states: OrderStates.success)));
    return response.isRight();
  }

  /// Move-Transfer Table
  @override
  Future<bool> transferTable(
      {required MoveProduct moveTable,
      required String tableId,
      required String targetTableId}) async {
    emit(state.copyWith(states: OrderStates.loading));
    final response = await _orderService.moveTableOrder(
        moveProductModel: moveTable, tableId: tableId, targetTableId: targetTableId);
    response.fold(
      (l) => emit(state.copyWith(states: OrderStates.error)),
      (r) => emit(state.copyWith(states: OrderStates.success)),
    );
    return response.isRight();
  }

  /// Move Product to another Table
  @override
  Future<bool> moveProducts(
      {required MoveProduct moveProduct,
      required String tableId,
      required String targetTableId}) async {
    emit(state.copyWith(states: OrderStates.loading));
    final response = await _orderService.moveTableProduct(
        moveProductModel: moveProduct, tableId: tableId, targetTableId: targetTableId);
    response.fold(
      (l) => emit(state.copyWith(states: OrderStates.error)),
      (r) => emit(state.copyWith(states: OrderStates.success)),
    );
    return response.isRight();
  }
}
