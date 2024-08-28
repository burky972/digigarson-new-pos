import 'package:a_pos_flutter/feature/auth/token/cubit/token_state.dart';
import 'package:core/core.dart';

abstract class ITokenCubit extends BaseCubit<TokenState> {
  ITokenCubit(super.initialState);
  Future postRefreshToken();
}
