import 'package:core/route/i_route_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class RouteManager implements IRouteManager {
  static final RouteManager _instance = RouteManager._init();
  static RouteManager get instance => _instance;

  // ignore: non_constant_identifier_names
  final String TAG = "RouteManager";

  RouteManager._init();

  late GoRouter _router;

  @override
  void init(GoRouter router) {
    _router = router;
  }

  /// Clear the current stack and add a new route
  @override
  void go(
    String path, {
    Map<String, String> queryParameters = const {},
    Object? extra,
  }) {
    _router.go(
      _buildUri(path, queryParameters),
      extra: extra,
    );
  }

  /// Go to the given path with the given query parameters and extra data.
  @override
  Future<void> push(
    String path, {
    Map<String, String> queryParameters = const {},
    Object? extra,
  }) async {
    await _router.push(
      _buildUri(path, queryParameters),
      extra: extra,
    );
  }

  /// Replace the current path with the given path and query parameters
  @override
  void replace(
    String path, {
    Map<String, String> queryParameters = const {},
    Object? extra,
  }) {
    _router.replace(
      _buildUri(path, queryParameters),
      extra: extra,
    );
  }

  /// Helper method to build URI
  String _buildUri(String path, Map<String, String> queryParameters) {
    return Uri(path: path, queryParameters: queryParameters).toString();
  }

  @override
  Future<T?> pushNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, String> queryParameters = const {},
    Object? extra,
  }) {
    return _router.pushNamed<T>(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  @override
  String namedLocation(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, String> queryParameters = const {},
  }) {
    return _router.namedLocation(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
    );
  }

  @override
  void pushReplacement(
    String path, {
    Map<String, String> queryParameters = const {},
    Object? extra,
  }) {
    _router.pushReplacement(
      _buildUri(path, queryParameters),
      extra: extra,
    );
  }

  @override
  void refresh() => _router.refresh();

  @override
  bool canPop() => _router.canPop();

  @override
  void pop() => _router.pop();

  @override
  BuildContext? get context => _router.routerDelegate.navigatorKey.currentContext;
}
