// ignore_for_file: non_constant_identifier_names

import 'package:core/logger/interface_a_pos_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class APosLogger implements IAPosLogger {
  late Logger _logger;
  bool _isCacheLog = false;
  static APosLogger? _instance;
  static APosLogger? get instance {
    _instance ??= APosLogger._init();
    return _instance!;
  }

  APosLogger._init();
  init({required bool isCacheLog}) {
    _logger = Logger();
    _isCacheLog = isCacheLog;
  }

  @override
  error(String TAG, String error) {
    if (kDebugMode) {
      _logger.e('$TAG: $error');
    }
    if (_isCacheLog) {
      //TODO: cache log
    }
  }

  @override
  info(String TAG, String info) {
    if (kDebugMode) {
      _logger.i('$TAG: $info');
    }

    if (_isCacheLog) {
      //TODO: cache log
    }
  }

  @override
  warning(String TAG, String warning) {
    if (kDebugMode) {
      _logger.w('$TAG: $warning');
    }

    if (_isCacheLog) {
      //TODO: cache log
    }
  }
}
