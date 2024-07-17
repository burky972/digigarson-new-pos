import 'package:a_pos_flutter/feature/auth/login/cubit/login_state.dart';
import 'package:a_pos_flutter/feature/auth/login/model/login_model.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:core/base/cubit/base_cubit.dart';

abstract class ILoginCubit extends BaseCubit<LoginState> {
  ILoginCubit(super.initialState);
  UserModel get userGetModel;
  updateSelectedIndex(int index);
  void updateIsLoading(bool value);
  Future authToken(String authToken);
  void updateFocus(int value);
  Future login(LoginModel loginModel);
  String getUserToken();
  String getAuthToken();
  bool isLoggedIn();
  Future<bool> clearSharedData();
  void saveUserEmail(String email);
  String getUserEmail();
  Future<bool> clearUserEmailAndPassword();
}
