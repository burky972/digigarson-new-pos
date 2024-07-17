import 'package:a_pos_flutter/feature/auth/login/model/login_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/core.dart';

abstract class ILoginService {
  BaseResponseData<BaseResponseModel> login({LoginModel? loginModel});
  Future<void> saveUserToken(String token);
  String getUserToken();
  Future<void> saveAuthToken(String token);
  String getAuthToken();
  bool isLoggedIn();
  Future<bool> clearSharedData();
  // for  Remember Email
  Future<void> saveUserEmailAndPassword(String email);
  String getUserEmail();
  Future<bool> clearUserEmailAndPassword();
}
