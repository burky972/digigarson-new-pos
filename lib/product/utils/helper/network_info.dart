import 'dart:async';

import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NetworkInfo {
  late StreamSubscription<List<ConnectivityResult>> _onConnectivityChanged;

  void listen(BuildContext context) {
    appLogger.info('Network Info', 'listen func called');
    _onConnectivityChanged =
        Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // check if context is mounted
      if (context.mounted) {
        bool isNotConnected = results.every(
            (result) => result != ConnectivityResult.wifi && result != ConnectivityResult.mobile);

        // hide exist snackbar
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        // show snackbar
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? LocaleKeys.no_connection : LocaleKeys.connected,
            textAlign: TextAlign.center,
          ).tr(),
        ));
      }
    });
  }

  void dispose() {
    _onConnectivityChanged.cancel();
  }
}
