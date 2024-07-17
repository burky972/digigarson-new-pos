import 'package:a_pos_flutter/feature/home/case/cubit/case_state.dart';
import 'package:a_pos_flutter/feature/home/case/model/case_model.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:core/base/cubit/base_cubit.dart';

abstract class ICaseCubit extends BaseCubit<CaseState> {
  ICaseCubit(super.initialState);
  CaseModel? get cases;
  Future<void> setNewCase(CaseModel? cases);
  Future getCase(UserModel userModel);
  Future postCase(
      {required UserModel userModel,
      required BalanceModel balanceModel,
      required Function callback});
}
