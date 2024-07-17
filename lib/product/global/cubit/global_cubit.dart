import 'package:a_pos_flutter/product/global/cubit/global_state.dart';
import 'package:a_pos_flutter/product/global/cubit/i_global_cubit.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';

class GlobalCubit extends IGlobalCubit {
  GlobalCubit() : super(GlobalState.initial()) {
    init();
  }

  /// initial func
  @override
  void init() {}

  /// setter for user
  @override
  void setUser(UserModel user) {
    emit(state.copyWith(user: user));
  }

  /// getter for user
  @override
  UserModel get user => state.user ?? UserModel(accessToken: '', refreshToken: '', user: User());
}
