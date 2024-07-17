import 'package:a_pos_flutter/product/global/model/user_model.dart';

final class QueryParams {
  static Map<String, String> dioQueryParams(UserModel userModel) {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-refresh': userModel.refreshToken!,
      'Authorization': 'Bearer ${userModel.accessToken}',
    };
  }
}
