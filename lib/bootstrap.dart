import 'dart:async';
import 'dart:developer';
import 'package:a_pos_flutter/product/app/app_container.dart';
import 'package:a_pos_flutter/product/app/app_initialize.dart';
import 'package:a_pos_flutter/product/routes/go_routes.dart';
import 'package:flutter/material.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
) async {
  //For flutter errors (widget errors etc.)
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(() => _onInit(builder), _onError);
}

///initial func
Future<void> _onInit(
  FutureOr<Widget> Function() builder,
) async {
  await AppInitialize().init();

  /// call locator go manager service
  AppContainer.initializeRouteManager(AppRoute.router);

  runApp(await builder());
}

///Handles zone error
void _onError(Object error, StackTrace stack) {
  log(error.toString(), stackTrace: stack);
}
