import 'dart:async';

import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/logger/a_pos_logger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

final class NetworkInfo {
  late StreamSubscription<List<ConnectivityResult>> _onConnectivityChanged;
  StreamSubscription<List<ConnectivityResult>> get connectivityChanged => _onConnectivityChanged;
  void listen(BuildContext context) {
    APosLogger.instance!.info('Network Info', 'listen func called');
    _onConnectivityChanged =
        Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      bool isNotConnected = results.every(
          (result) => result != ConnectivityResult.wifi && result != ConnectivityResult.mobile);
      isNotConnected ? const SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: isNotConnected ? Colors.red : Colors.green,
        duration: Duration(seconds: isNotConnected ? 6000 : 3),
        content: Text(
          isNotConnected ? LocaleKeys.no_connection : LocaleKeys.connected,
          textAlign: TextAlign.center,
        ).tr(),
      ));
    });
  }
}
