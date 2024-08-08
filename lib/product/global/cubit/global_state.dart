// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:core/base/cubit/base_cubit.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';

class GlobalState extends BaseState {
  const GlobalState({required this.states, required this.user, required this.selectedTableName});
  final GlobalStates states;

  final UserModel? user;
  final String? selectedTableName;

  factory GlobalState.initial() {
    return const GlobalState(states: GlobalStates.initial, user: null, selectedTableName: null);
  }

  @override
  List<Object?> get props => [states, user, selectedTableName];

  GlobalState copyWith({
    GlobalStates? states,
    UserModel? user,
    String? selectedTableName,
  }) {
    return GlobalState(
      states: states ?? this.states,
      user: user ?? this.user,
      selectedTableName: selectedTableName ?? this.selectedTableName,
    );
  }
}

enum GlobalStates { initial, loading, completed, error }
