import 'package:a_pos_flutter/product/app/app_container_items.dart';
import 'package:a_pos_flutter/product/routes/go_routes.dart';
import 'package:core/logger/a_pos_logger.dart';
import 'package:core/route/route_manager.dart';
import 'package:flutter/material.dart';

/// getter for custom search keyboard
APosLogger get appLogger => AppContainerItems.logger;

/// getter for ROUTE manager
RouteManager get _routeManager => AppContainerItems.routeManager;
final routeManager = _routeManager;

/// getter for navigator key
BuildContext get _routeContext => AppRoute.navigatorKey.currentContext!;
final routeContext = _routeContext;
