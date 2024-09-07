import 'package:a_pos_flutter/feature/home/checks/cubit/check_state.dart';
import 'package:core/core.dart';

abstract class ICheckCubit extends BaseCubit<CheckState> {
  ICheckCubit(super.initialState);
  Future getAllCheck({required String caseId});
  Future getSingleCheck({required String checkId});

  // void setSelectedOrder(
  //     {required String id, required List<OldProducts> listProduct, required String table});
}
