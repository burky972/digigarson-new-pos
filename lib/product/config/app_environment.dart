import 'dart:developer';

import 'package:a_pos_flutter/product/config/dev_env.dart';
import 'package:a_pos_flutter/product/config/i_app_env.dart';
import 'package:a_pos_flutter/product/config/prod_env.dart';
import 'package:flutter/foundation.dart';

final class AppEnvironment {
  /// set up the app environment
  AppEnvironment.setup({required AppEnvConfigure config}) {
    _config = config;
  }

  AppEnvironment.general() {
    _config = kDebugMode ? DevEnv() : ProdEnv();
  }

  static late final AppEnvConfigure _config;
}

/// GET app environment items
enum AppEnvironmentItems {
  /// network base url
  baseUrl,

  /// network socket url
  socketUrl;

  String get value {
    try {
      switch (this) {
        case AppEnvironmentItems.baseUrl:
          return AppEnvironment._config.BASE_URL;
        case AppEnvironmentItems.socketUrl:
          return AppEnvironment._config.SOCKET_URL;
      }
    } catch (e) {
      log(e.toString());
      throw Exception('AppEnvironmentItems is not initialized!');
    }
  }
}
