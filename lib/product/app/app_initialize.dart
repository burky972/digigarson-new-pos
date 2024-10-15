import 'package:a_pos_flutter/product/app/window_manager_initialize.dart';
import 'package:a_pos_flutter/product/config/app_environment.dart';
import 'package:a_pos_flutter/product/routes/go_routes.dart';
import 'package:a_pos_flutter/product/utils/observer/bloc_observer.dart';
import 'package:core/cache/shared_manager.dart';
import 'package:core/core.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class AppInitialize {
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await WindowManagerInitialize().setup();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    /// Initialize the App Environment items (DEV environment, Prod environment)
    AppEnvironment.general();
    //initialize the shared preferences manager
    await SharedManager.preferencesInit();

    //initialize the Route manager
    RouteManager.instance.init(AppRoute.router);

    //initialize the app logger
    appLogger.init(isCacheLog: false);

    //initialize the network manager
    await DioClient.instance.init(
      baseUrl: AppEnvironmentItems.baseUrl.value,
    );
    // observe bloc changes
    Bloc.observer = const AppBlocObserver();

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }
}
