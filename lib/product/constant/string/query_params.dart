import 'package:a_pos_flutter/product/global/model/user_model.dart';

final class QueryParams {
  static Map<String, String> dioQueryParams(UserModel userModel) {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-refresh': userModel.refreshToken!,
      'Authorization': 'Bearer ${userModel.accessToken}',
    };
  }

  /// get cases
  static Map<String, int> getCasesQueries({int page = 1, int per = 100}) {
    return <String, int>{
      'page': page,
      'per': per,
    };
  }

  /// get all check
  static Map<String, dynamic> getAllCheckQueries(
      {int page = 1, int per = 100, String orderType = ''}) {
    return <String, dynamic>{
      'per': per,
      'page': page,
      'order_type': orderType,
    };
  }
}
