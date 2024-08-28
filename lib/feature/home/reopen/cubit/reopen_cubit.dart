import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/feature/home/reopen/cubit/i_reopen_cubit.dart';
import 'package:a_pos_flutter/feature/home/reopen/cubit/reopen_state.dart';
import 'package:a_pos_flutter/feature/home/reopen/model/chek_old_model.dart';
import 'package:a_pos_flutter/feature/home/reopen/model/re_open_model.dart';
import 'package:a_pos_flutter/feature/home/reopen/service/i_reopen_service.dart';
import 'package:a_pos_flutter/feature/home/reopen/service/reopen_service.dart';

class ReopenCubit extends IReopenCubit {
  ReopenCubit() : super(ReopenState.initial()) {
    init();
  }
  late IReopenService _reopenService;

  final TAG = "ReopenCubit";

  OrderModel? selectOrder;
  List<OldCheckModel> reOpenModel = [];

  @override
  void init() {
    _reopenService = ReopenService();
  }

  @override
  Future getAllCheck({
    required String id,
  }) async {
    reOpenModel.clear();
    emit(state.copyWith(states: ReopenStates.loading, reOpenModel: reOpenModel));
    final response = await _reopenService.getAllCheck(orderType: '');
    response.fold((l) {
      emit(state.copyWith(states: ReopenStates.error));
    }, (r) {
      //TODO: CHECK LATER!!
      // r.data.forEach((reOpen) {
      //   OldCheckModel oldCheckModel_ = OldCheckModel.fromJson(reOpen);
      //   oldCheckModel_.caseId != id ? reOpenModel.add(oldCheckModel_) : null;
      // });
      // reOpenModel.sort((p1, p2) {
      //   return p2.updatedAt!.compareTo(p1.updatedAt!);
      // });

      emit(state.copyWith(reOpenModel: reOpenModel, states: ReopenStates.completed));
    });
  }

  @override
  Future<bool> oldCheckPut({required String id, required PutPaymentModel paymentPut}) async {
    emit(state.copyWith(states: ReopenStates.loading));
    final response = await _reopenService.putOldCheck(id: id, data: paymentPut.toJson());
    response.fold((_) {
      emit(state.copyWith(states: ReopenStates.error));
    }, (r) {
      emit(state.copyWith(states: ReopenStates.completed));
    });
    return response.isRight();
  }

  @override
  Future<void> setReOpen(List<OldCheckModel> old) async {
    reOpenModel.clear();
    emit(state.copyWith(reOpenModel: []));
    reOpenModel = old;
    reOpenModel.sort((p1, p2) {
      return p2.updatedAt!.compareTo(p1.updatedAt!);
    });
    emit(state.copyWith(reOpenModel: reOpenModel));
  }

  @override
  void setSelectedOrder(
      {required String id, required List<OldProducts> listProduct, required String table}) {
    List<Item> list = [];
    for (var pro in listProduct) {
      list.add(Item(
          // statusType: pro.isServe! ? 99 : pro.status!,
          itemName: pro.productName.toString(),
          price: pro.price!,
          amount: pro.quantity?.toInt()));
    }
    Iterable<OldCheckModel> order = reOpenModel.where((element) => element.sId == id);
    if (order.isNotEmpty) {
      selectOrder = OrderModel(
          orderId: order.first.sId.toString(),
          table: table,
          gratuity: order.first.payments!.fold<double>(
              0,
              (previousValue, payment) =>
                  payment.type == 2 ? previousValue + payment.amount! : previousValue),
          gst: 1,
          item: list,
          cash: order.first.payments!.fold<double>(
              0,
              (previousValue, payment) =>
                  payment.type == 2 ? previousValue + payment.amount! : previousValue),
          card: order.first.payments!.fold<double>(
              0,
              (previousValue, payment) =>
                  payment.type != 2 ? previousValue + payment.amount! : previousValue),
          total: order.first.payments!
              .fold<double>(0, (previousValue, payment) => previousValue + payment.amount!),
          closedBy: "${order.first.user!.name} ${order.first.user!.lastname}",
          openDate: order.first.createdAt!,
          closedDate: order.first.updatedAt!,
          discount: order.first.discounts!
              .fold<double>(0, (previousValue, payment) => previousValue + payment.amount!),
          service: order.first.serviceFee!
              .fold<double>(0, (previousValue, payment) => previousValue + payment.amount!),
          cover: order.first.covers!
              .fold<double>(0, (previousValue, payment) => previousValue + payment.price!),
          tax: 0);

      emit(state.copyWith(selectOrder: selectOrder));
    }
  }
}
