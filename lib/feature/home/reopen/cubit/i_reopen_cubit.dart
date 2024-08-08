import 'package:a_pos_flutter/feature/home/reopen/cubit/reopen_state.dart';
import 'package:a_pos_flutter/feature/home/reopen/model/chek_old_model.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:core/core.dart';

abstract class IReopenCubit extends BaseCubit<ReopenState> {
  IReopenCubit(super.initialState);
  Future getAllCheck({required UserModel userModel, required String id});
  Future<void> setReOpen(List<OldCheckModel> old);
  Future<bool> oldCheckPut(
      {required UserModel userModel, required String id, required PutPaymentModel paymentPut});

  void setSelectedOrder(
      {required String id, required List<OldProducts> listProduct, required String table});
}
