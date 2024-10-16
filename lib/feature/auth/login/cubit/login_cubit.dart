import 'package:a_pos_flutter/feature/auth/login/cubit/i_login_cubit.dart';
import 'package:a_pos_flutter/feature/auth/login/cubit/login_state.dart';
import 'package:a_pos_flutter/feature/auth/login/model/login_model.dart';
import 'package:a_pos_flutter/feature/auth/login/service/i_login_service.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/global/service/global_service.dart';
import 'package:core/network/dio_client.dart';

class LoginCubit extends ILoginCubit {
  LoginCubit(this._loginService) : super(LoginState.initial()) {
    init();
  }
  final ILoginService _loginService;

  /// initialize func
  @override
  Future<void> init() async {}

  /// Login function
  @override
  Future login(LoginModel loginModel) async {
    emit(state.copyWith(states: LoginStates.loading, isLoading: true));
    final response = await _loginService.login(loginModel: loginModel);
    response.fold((l) {
      emit(state.copyWith(states: LoginStates.error, isLoading: false));
    }, (r) async {
      final token = r.data[
          'accessToken']; //todo: check if no problem inside Global Service saveAccessToken function delete here!
      DioClient.instance.updateHeader(token);
      UserModel user = UserModel().fromJson(r.data);
      await GlobalService.setLoginFunc(user);
      emit(state.copyWith(userModel: user, states: LoginStates.completed));
    });
  }

  @override
  Future authToken(String authToken) async {
    _loginService.saveAuthToken(authToken);
  }

  @override
  void updateFocus(int value) {
    emit(state.copyWith(selectedFocus: value));
  }

  @override
  void updateIsLoading(bool value) {
    emit(state.copyWith(isLoading: value));
  }

  @override
  updateSelectedIndex(int index) {}

  @override
  String getUserToken() {
    return _loginService.getUserToken();
  }

  @override
  String getAuthToken() {
    return _loginService.getAuthToken();
  }

  @override
  bool isLoggedIn() {
    return _loginService.isLoggedIn();
  }

  @override
  Future<bool> clearSharedData() async {
    return await _loginService.clearSharedData();
  }

  @override
  void saveUserEmail(String email) {
    _loginService.saveUserEmailAndPassword(email);
  }

  @override
  String getUserEmail() {
    return _loginService.getUserEmail();
  }

  @override
  Future<bool> clearUserEmailAndPassword() async {
    return _loginService.clearUserEmailAndPassword();
  }

  @override
  UserModel get userGetModel => state.userModel ?? UserModel();
}
