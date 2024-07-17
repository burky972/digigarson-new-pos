import 'package:a_pos_flutter/feature/home/case/model/case_model.dart';
import 'package:core/base/cubit/base_cubit.dart';

class CaseState extends BaseState {
  const CaseState({
    required this.states,
    required this.cases,
  });

  factory CaseState.initial() {
    return const CaseState(
      states: CaseStates.initial,
      cases: null,
    );
  }
  final CaseStates states;
  final CaseModel? cases;

  @override
  List<Object?> get props => [states, cases];

  CaseState copyWith({
    CaseStates? states,
    bool? isLoading,
    CaseModel? cases,
  }) {
    return CaseState(
      states: states ?? this.states,
      cases: cases ?? this.cases,
    );
  }
}

enum CaseStates { initial, loading, completed, error }
