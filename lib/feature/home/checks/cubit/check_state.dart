import 'package:a_pos_flutter/feature/home/checks/model/check_response_model.dart';
import 'package:a_pos_flutter/feature/home/checks/model/single_check_model.dart';
import 'package:core/core.dart';

class CheckState extends BaseState {
  const CheckState({
    required this.states,
    required this.selectedCheck,
    required this.checkModelList,
  });

  factory CheckState.initial() {
    return const CheckState(
      states: CheckStates.initial,
      selectedCheck: null,
      checkModelList: [],
    );
  }

  final CheckStates states;
  final SingleCheckModel? selectedCheck;
  final List<CheckModel>? checkModelList;

  CheckState copyWith({
    CheckStates? states,
    SingleCheckModel? selectedCheck,
    List<CheckModel>? checkModelList,
  }) {
    return CheckState(
      states: states ?? this.states,
      selectedCheck: selectedCheck ?? this.selectedCheck,
      checkModelList: checkModelList ?? this.checkModelList,
    );
  }

  @override
  List<Object?> get props => [states, selectedCheck, checkModelList];
}

enum CheckStates { initial, loading, completed, error }
