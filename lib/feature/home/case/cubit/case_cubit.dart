import 'package:a_pos_flutter/feature/home/case/cubit/case_state.dart';
import 'package:a_pos_flutter/feature/home/case/cubit/i_case_cubit.dart';
import 'package:a_pos_flutter/feature/home/case/model/case_model.dart';
import 'package:a_pos_flutter/feature/home/case/service/case_service.dart';
import 'package:a_pos_flutter/feature/home/case/service/i_case_service.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';

class CaseCubit extends ICaseCubit {
  CaseCubit() : super(CaseState.initial()) {
    init();
  }
  final ICaseService _caseService = CaseService();
  final TAG = "CaseCubit";

  /// initialize func
  @override
  Future<void> init() async {}

  @override
  CaseModel? get cases => state.cases;

  @override
  Future<void> setNewCase(CaseModel? cases) async {
    emit(state.copyWith(cases: cases));
  }

  @override
  Future getCase(UserModel userModel) async {
    emit(state.copyWith(states: CaseStates.loading));
    final response =
        await _caseService.getCases(userModel: userModel); //todo:add page and per next to userMODEL
    response.fold((l) {
      emit(state.copyWith(states: CaseStates.error));
    }, (r) {
      CaseModel cases = CaseModel().fromJson(r.data);
      emit(state.copyWith(cases: cases, states: CaseStates.completed));
    });
  }

  @override
  Future<bool> getOpenCase() async {
    emit(state.copyWith(states: CaseStates.loading));
    final response = await _caseService.getOpenCases();
    response.fold((l) {
      emit(state.copyWith(states: CaseStates.error));
    }, (r) {
      CaseModel cases = CaseModel.fromJson(r.data);
      emit(state.copyWith(cases: cases, states: CaseStates.completed));
    });

    return response.isRight();
  }

  @override
  Future<bool> postCase({
    required BalanceModel balanceModel,
  }) async {
    final response = await _caseService.postCases(balanceModel: balanceModel);

    response.fold((l) {
      emit(state.copyWith(states: CaseStates.error));
      return false;
    }, (r) {
      CaseModel cases = CaseModel().fromJson(r.data);
      emit(state.copyWith(cases: cases, states: CaseStates.completed));
      return true;
    });
    return false;
  }
}
