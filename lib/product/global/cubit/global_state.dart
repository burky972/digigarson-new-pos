// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:core/base/cubit/base_cubit.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';

class GlobalState extends BaseState {
  const GlobalState({required this.states, required this.user});
  final GlobalStates states;

  final UserModel? user;

  factory GlobalState.initial() {
    return const GlobalState(states: GlobalStates.initial, user: null);
  }

  @override
  List<Object?> get props => [states, user];

  GlobalState copyWith({
    GlobalStates? states,
    UserModel? user,
  }) {
    return GlobalState(
      states: states ?? this.states,
      user: user ?? this.user,
    );
  }
}

enum GlobalStates { initial, loading, completed, error }
