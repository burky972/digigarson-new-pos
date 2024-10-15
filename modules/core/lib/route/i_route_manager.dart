import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class IRouteManager {
  void init(GoRouter router);
  void go(String path, {Map<String, String> queryParameters, Object? extra});
  Future<void> push(String path, {Map<String, String> queryParameters, Object? extra});
  void replace(String path, {Map<String, String> queryParameters, Object? extra});
  void pushReplacement(String path,
      {Map<String, String> queryParameters = const {}, Object? extra});
  String namedLocation(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, String> queryParameters = const {},
  });
  Future<T?> pushNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, String> queryParameters = const {},
    Object? extra,
  });
  bool canPop();
  void pop();
  BuildContext? get context;
  void refresh();
}
