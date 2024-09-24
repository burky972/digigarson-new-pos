import 'package:a_pos_flutter/feature/home/checks/cubit/check_state.dart';
import 'package:a_pos_flutter/feature/home/checks/model/single_check_model.dart';
import 'package:core/core.dart';

abstract class ICheckCubit extends BaseCubit<CheckState> {
  ICheckCubit(super.initialState);
  Future getAllCheck({required String caseId});
  Future getSingleCheck({required String checkId});
  void setSelectedCheck(SingleCheckModel? checkModel);
  Future<bool> updateCheck({required String checkId, required SingleCheckModel checkModel});
}
