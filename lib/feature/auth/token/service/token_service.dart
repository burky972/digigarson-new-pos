import 'package:a_pos_flutter/feature/auth/token/model/token_model.dart';
import 'package:a_pos_flutter/feature/auth/token/service/i_token_service.dart';
import 'package:a_pos_flutter/product/utils/helper/api_response_handler.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/core.dart';

class TokenService implements ITokenService {
  @override
  BaseResponseData<BaseResponseModel> postRefreshToken({required TokenModel refreshToken}) async {
    final response = await DioClient.instance.post(
      NetworkConstants.refreshToken,
      data: refreshToken.toJson(),
    );

    return ApiResponseHandler.handleResponse(response);
  }
}
