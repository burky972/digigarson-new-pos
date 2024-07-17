import 'package:a_pos_flutter/feature/auth/login/cubit/i_login_cubit.dart';
import 'package:a_pos_flutter/feature/auth/login/cubit/login_state.dart';
import 'package:a_pos_flutter/feature/auth/login/model/login_model.dart';
import 'package:a_pos_flutter/feature/auth/login/service/i_login_service.dart';
import 'package:a_pos_flutter/feature/auth/login/service/login_service.dart';
import 'package:a_pos_flutter/product/enums/country_code/enum.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:core/cache/shared_manager.dart';
import 'package:core/network/dio_client.dart';

class LoginCubit extends ILoginCubit {
  LoginCubit() : super(LoginState.initial()) {
    init();
  }
  late ILoginService _loginService;

  /// initialize func
  @override
  Future<void> init() async {
    _loginService = LoginService();
  }

  /// Login function
  @override
  Future login(LoginModel loginModel) async {
    emit(state.copyWith(states: LoginStates.loading));
    final response = await _loginService.login(loginModel: loginModel);
    response.fold((l) {
      emit(state.copyWith(states: LoginStates.error));
    }, (r) async {
      final token = r.data['accessToken'];
      DioClient.instance.updateHeader(token, CountryCodeEnum.US.name);
      UserModel user = UserModel().fromJson(r.data);
      await SharedManager.instance.setStringValue(CacheKeys.token, user.accessToken!);
      // await SharedManager.instance.removeValue(CacheKeys.token);
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