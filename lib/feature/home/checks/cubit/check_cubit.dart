import 'package:a_pos_flutter/feature/home/checks/cubit/check_state.dart';
import 'package:a_pos_flutter/feature/home/checks/cubit/i_check_cubit.dart';
import 'package:a_pos_flutter/feature/home/checks/model/check_response_model.dart';
import 'package:a_pos_flutter/feature/home/checks/model/single_check_model.dart';
import 'package:a_pos_flutter/feature/home/checks/service/check_service.dart';
import 'package:a_pos_flutter/feature/home/checks/service/i_check_service.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';

class CheckCubit extends ICheckCubit {
  CheckCubit() : super(CheckState.initial()) {
    init();
  }
  late ICheckService _checkService;

  final TAG = "CheckCubit";

  SingleCheckModel? selectedCheck;
  List<CheckModel> checkModelList = [];

  @override
  Future<void> init() async {
    _checkService = CheckService();
  }

  @override
  Future<void> getAllCheck({required String caseId}) async {
    checkModelList.clear();
    emit(state.copyWith(states: CheckStates.loading, checkModelList: []));

    final response = await _checkService.getAllCheck(orderType: '');
    response.fold(
      (l) {
        emit(state.copyWith(states: CheckStates.error));
      },
      (result) {
        final checks = result.data['checks'] as List;
        for (var check in checks) {
          if (check is Map<String, dynamic>) {
            CheckModel checkModel = CheckModel.fromJson(check);
            if (checkModel.caseId == caseId) {
              checkModelList.add(checkModel);
            } else {
              appLogger.error('Check Cubit', 'CASE ID NOT MATCH');
            }
          }
        }
        // Sort the list
        checkModelList.sort((p1, p2) => p2.createdAt!.compareTo(p1.createdAt!));
        emit(state.copyWith(checkModelList: checkModelList, states: CheckStates.completed));
      },
    );
  }

  @override
  Future getSingleCheck({required String checkId}) async {
    emit(state.copyWith(states: CheckStates.loading));

    final response = await _checkService.getSingleCheck(checkId: checkId);
    response.fold(
      (l) {
        appLogger.error('single Check Cubit', 'error');
        emit(state.copyWith(states: CheckStates.error));
      },
      (result) {
        if (result.data == null) {
          appLogger.info('single Check Cubit', 'null !!!!!!');
        }
        appLogger.info('single Check Cubit', result.data.toString());
        selectedCheck =
            (result.data as List).map((e) => SingleCheckModel.fromJson(e)).toList().first;
        appLogger.info('single Check Cubit', selectedCheck!.toJson().toString());
        emit(state.copyWith(selectedCheck: selectedCheck, states: CheckStates.completed));
      },
    );
  }
}
