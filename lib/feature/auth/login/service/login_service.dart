import 'package:a_pos_flutter/feature/auth/login/model/login_model.dart';
import 'package:a_pos_flutter/feature/auth/login/service/i_login_service.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/cache/shared_manager.dart';
import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

class LoginService extends ILoginService {
  final SharedManager _sharedManager = SharedManager.instance;

  /// remove token-user-currency from the cache
  @override
  Future<bool> clearSharedData() async {
    _sharedManager.removeValue(CacheKeys.currency.name);
    _sharedManager.removeValue(CacheKeys.token.name);
    _sharedManager.removeValue(CacheKeys.user.name);
    return true;
  }

  @override
  Future<bool> clearUserEmailAndPassword() async {
    return await _sharedManager.removeValue(CacheKeys.user_email.name);
  }

  @override
  String getAuthToken() {
    return _sharedManager.getStringValue(CacheKeys.token.name) ?? "";
  }

  @override
  String getUserEmail() {
    return _sharedManager.getStringValue(CacheKeys.user_email.name) ?? "";
  }

  @override
  String getUserToken() {
    return _sharedManager.getStringValue(CacheKeys.token.name) ?? "";
  }

  @override
  bool isLoggedIn() {
    return _sharedManager.containsKey(CacheKeys.token.name);
  }

  @override
  BaseResponseData<BaseResponseModel> login({LoginModel? loginModel}) async {
    BaseResponseModel response = await DioClient.instance.post(
      NetworkConstants.login,
      data: loginModel?.toJson(),
    );

    if (response.serverException != null) {
      return Left(ServerException(
          message: response.serverException!.message,
          statusCode: response.serverException!.statusCode));
    } else {
      UserModel user = UserModel().fromJson(response.data);
      await SharedManager.instance.setStringValue(CacheKeys.token, user.accessToken!);
      return Right(BaseResponseModel(data: response.data));
    }
  }

  @override
  Future<void> saveAuthToken(String token) async {
    DioClient.instance.token = token;
    DioClient.instance.dio.options.headers = {
      'accept': 'application/json', // new added
      'Content-Type': 'application/json; charset=UTF-8',
      // 'Authorization': 'Bearer $token'
    };

    try {
      await _sharedManager.setStringValue(CacheKeys.token, token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveUserEmailAndPassword(String email) async {
    try {
      await _sharedManager.setStringValue(CacheKeys.user_email, email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveUserToken(String token) async {
    try {
      await _sharedManager.setStringValue(CacheKeys.token, token);
    } catch (e) {
      rethrow;
    }
  }
}
