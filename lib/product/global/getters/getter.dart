import 'package:core/logger/a_pos_logger.dart';
import 'package:core/route/route_manager.dart';

/// getter for custom search keyboard
APosLogger get appLogger => APosLogger.instance;

/// getter for ROUTE manager
RouteManager get _routeManager => RouteManager.instance;
final routeManager = _routeManager;
