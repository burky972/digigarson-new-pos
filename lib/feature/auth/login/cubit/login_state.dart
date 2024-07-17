import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:core/base/cubit/base_cubit.dart';

class LoginState extends BaseState {
  const LoginState({
    required this.states,
    required this.isLoading,
    required this.selectedFocus,
    required this.userModel,
  });

  factory LoginState.initial() {
    return const LoginState(
      states: LoginStates.initial,
      isLoading: false,
      selectedFocus: 0,
      userModel: null,
    );
  }
  final LoginStates states;
  final bool isLoading;
  final int selectedFocus;
  final UserModel? userModel;

  @override
  List<Object?> get props => [
        states,
        isLoading,
        selectedFocus,
        userModel,
      ];

  LoginState copyWith({
    LoginStates? states,
    bool? isLoading,
    int? selectedFocus,
    UserModel? userModel,
  }) {
    return LoginState(
      states: states ?? this.states,
      isLoading: isLoading ?? this.isLoading,
      selectedFocus: selectedFocus ?? this.selectedFocus,
      userModel: userModel ?? this.userModel,
    );
  }
}

enum LoginStates { initial, loading, completed, error }
