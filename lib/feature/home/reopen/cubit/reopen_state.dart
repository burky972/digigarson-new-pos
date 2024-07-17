// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:a_pos_flutter/feature/home/reopen/model/chek_old_model.dart';
import 'package:core/core.dart';

import 'package:a_pos_flutter/feature/home/reopen/model/re_open_model.dart';

class ReopenState extends BaseState {
  const ReopenState({
    required this.states,
    required this.selectOrder,
    required this.reOpenModel,
  });

  factory ReopenState.initial() {
    return const ReopenState(
      states: ReopenStates.initial,
      selectOrder: null,
      reOpenModel: [],
    );
  }

  final ReopenStates states;
  final OrderModel? selectOrder;
  final List<OldCheckModel> reOpenModel;

  ReopenState copyWith({
    ReopenStates? states,
    OrderModel? selectOrder,
    List<OldCheckModel>? reOpenModel,
  }) {
    return ReopenState(
      states: states ?? this.states,
      selectOrder: selectOrder ?? this.selectOrder,
      reOpenModel: reOpenModel ?? this.reOpenModel,
    );
  }

  @override
  List<Object?> get props => [states, selectOrder, reOpenModel];
}

enum ReopenStates { initial, loading, completed, error }
