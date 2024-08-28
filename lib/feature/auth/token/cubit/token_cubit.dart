import 'dart:async';
import 'package:a_pos_flutter/feature/auth/token/cubit/i_token_cubit.dart';
import 'package:a_pos_flutter/feature/auth/token/cubit/token_state.dart';
import 'package:a_pos_flutter/feature/auth/token/model/token_model.dart';
import 'package:a_pos_flutter/feature/auth/token/service/i_token_service.dart';
import 'package:a_pos_flutter/feature/auth/token/service/token_service.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/global/service/global_service.dart';

class TokenCubit extends ITokenCubit {
  TokenCubit() : super(const TokenState.initial());
  final ITokenService _tokenService = TokenService();
  final String TAG = 'TokenCubit';
  Timer? _timer;

  /// initial Function
  @override
  void init() {
    appLogger.info(TAG, 'TOKEN CUBIT initialized!');
    startTokenRefresh();
  }

  // Function to start token refreshing
  void startTokenRefresh() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 14), (_) async => await postRefreshToken());
  }

  /// post refresh token
  @override
  Future postRefreshToken() async {
    final response = await _tokenService.postRefreshToken(
        refreshToken: TokenModel(
      refreshToken: GlobalService.getRefreshToken(),
    ));

    response.fold((l) => {emit(state.copyWith(states: TokenStates.error))}, (r) async {
      final token = r.data['accessToken'];
      await GlobalService.saveAccessToken(token);
      emit(state.copyWith(accessToken: token, states: TokenStates.completed));
    });
  }

// Cancel the timer
  void stopTokenRefresh() {
    _timer?.cancel();
  }

  /// close function
  @override
  Future<void> close() {
    stopTokenRefresh();
    return super.close();
  }
}
