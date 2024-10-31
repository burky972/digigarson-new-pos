import 'package:a_pos_flutter/product/global/manager/keyboard_manager.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:core/cache/shared_manager.dart';
import 'package:core/network/dio_client.dart';

class GlobalService {
  const GlobalService._();

  /// set login func
  static Future setLoginFunc(UserModel user) async {
    Future.wait([
      GlobalService.saveAccessToken(user.accessToken!),
      GlobalService.saveRefreshToken(user.refreshToken!),
      GlobalService.saveUser(user),
    ]);
  }

  /// get userModel
  static UserModel get userModel => GlobalService.getUser();

  /// get user
  static User get user => GlobalService.getUser().user ?? User.empty();

  /// save userModel to cache
  static Future<void> saveUser(UserModel user) async {
    await SharedManager.instance.setJsonModel<UserModel>(CacheKeys.user, user);
  }

  /// get userModel from cache
  static UserModel getUser() =>
      SharedManager.instance.getJsonModel<UserModel>(CacheKeys.user, UserModel()) ?? UserModel();

  /// save access token to cache
  static Future<void> saveAccessToken(String accessToken) async {
    await SharedManager.instance.setStringValue(CacheKeys.token, accessToken);
    DioClient.instance.updateHeader(accessToken);
  }

  /// save refresh token to cache
  static Future<void> saveRefreshToken(String refreshToken) async {
    await SharedManager.instance.setStringValue(CacheKeys.refreshToken, refreshToken);
  }

  /// get access token from cache
  static String getAccessToken() {
    return SharedManager.instance.getStringValue(CacheKeys.token.name) ?? '';
  }

  /// get refresh token from cache
  static String getRefreshToken() {
    return SharedManager.instance.getStringValue(CacheKeys.refreshToken.name) ?? '';
  }

  /// getter for custom search keyboard
  static CustomKeyboardManager get customKeyboardManager => CustomKeyboardManager();

  /// generate unique id
  static String generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// generate unique id
  static String generateCustomUniqueId() {
    return 'SDT${DateTime.now().millisecondsSinceEpoch}';
  }
}
