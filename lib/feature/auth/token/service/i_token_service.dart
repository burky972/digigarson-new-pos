import 'package:a_pos_flutter/feature/auth/token/model/token_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class ITokenService {
  BaseResponseData<BaseResponseModel> postRefreshToken({required TokenModel refreshToken});
}
