// ignore_for_file: non_constant_identifier_names

import 'package:a_pos_flutter/product/config/i_app_env.dart';
import 'package:envied/envied.dart';

part 'dev_env.g.dart';

@Envied(path: 'assets/env/.dev.env', obfuscate: true)
class DevEnv implements AppEnvConfigure {
  @EnviedField(varName: 'BASE_URL')
  static final String _BASE_URL = _DevEnv._BASE_URL;

  @EnviedField(varName: 'SOCKET_URL')
  static final String _SOCKET_URL = _DevEnv._SOCKET_URL;

  @override
  String get BASE_URL => _BASE_URL;

  @override
  String get SOCKET_URL => _SOCKET_URL;
}
