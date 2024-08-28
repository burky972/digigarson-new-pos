// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';

class TokenState extends BaseState {
  const TokenState({
    required this.accessToken,
    required this.refreshToken,
    required this.states,
  });

  const TokenState.initial()
      : this(accessToken: null, refreshToken: null, states: TokenStates.initial);

  final String? accessToken;
  final String? refreshToken;
  final TokenStates states;

  @override
  List<Object?> get props => [accessToken, refreshToken, states];

  TokenState copyWith({
    String? accessToken,
    String? refreshToken,
    TokenStates? states,
  }) {
    return TokenState(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      states: states ?? this.states,
    );
  }
}

enum TokenStates { initial, loading, error, completed }
