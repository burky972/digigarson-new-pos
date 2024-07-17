import 'dart:io';
import 'package:core/cache/shared_manager.dart';
import 'package:core/core.dart';
import 'package:core/logger/a_pos_logger.dart';
import 'package:core/network/logging_interceptor.dart';
import 'package:dio/dio.dart';

class DioClient {
  late final Dio dio;
  static DioClient? _instance;

  static DioClient get instance {
    return _instance ??= DioClient._init();
  }

  DioClient._init() {
    dio = Dio();
  }

  final tag = 'DioClient';

  String? token;
  String? countryCode;

  // Initialize
  Future<void> init({
    required String baseUrl,
  }) async {
    token = SharedManager.instance.getStringValue(CacheKeys.token.name) ?? "";
    countryCode = SharedManager.instance.getStringValue(CacheKeys.country_code.name);
    APosLogger.instance!.info('dio Client TOKEN', '$token ');
    APosLogger.instance!.info('dio Client TOKEN', '$countryCode ');
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(minutes: 1)
      ..options.receiveTimeout = const Duration(minutes: 1)
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        'lang': countryCode == 'US' ? 'en' : countryCode?.toLowerCase() ?? 'en',
      };

    dio.interceptors.add(LoggingInterceptor());
  }

  void updateHeader(String token, String? countryCode) {
    token = token;
    countryCode = countryCode == null
        ? this.countryCode == 'US'
            ? 'en'
            : this.countryCode!.toLowerCase()
        : countryCode == 'US'
            ? 'en'
            : countryCode.toLowerCase();
    this.token = token;
    this.countryCode = countryCode;
    dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'lang': countryCode == 'US' ? 'en' : countryCode.toLowerCase(),
    };
  }

  Future<BaseResponseModel> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      APosLogger.instance!.info(tag, 'GET request');
      APosLogger.instance!.info(tag, 'uri: $uri');
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      APosLogger.instance!.info(tag, 'response: ${response.data}');
      APosLogger.instance!.info(tag, 'response: ${response.statusMessage}');

      return BaseResponseModel(data: response.data);
    } on SocketException catch (e) {
      APosLogger.instance!.error(tag, e.message.toString());
      return BaseResponseModel(
          serverException:
              ServerException(message: 'SocketException: ${e.message}', statusCode: e.toString()));
    } on FormatException catch (e) {
      APosLogger.instance!.error(tag, e.message.toString());
      return BaseResponseModel(
          serverException:
              ServerException(message: 'FormatException: ${e.message}', statusCode: e.toString()));
    } catch (e) {
      APosLogger.instance!.error(tag, e.toString());
      return BaseResponseModel(
        serverException: const ServerException(message: 'Unknown Error', statusCode: '505'),
      );
    }
  }

  Future<BaseResponseModel> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    APosLogger.instance!.info(tag, 'POST request');
    APosLogger.instance!.info(tag, 'uri: $uri');
    try {
      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return BaseResponseModel(data: response.data);
    } on FormatException catch (e) {
      return BaseResponseModel(
          serverException:
              ServerException(message: ' FormatException${e.message}', statusCode: '505'));
    } catch (e) {
      return BaseResponseModel(
          serverException:
              ServerException(message: ' UnKnown error: ${e.toString()}', statusCode: '505'));
    }
  }

  Future<BaseResponseModel> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      APosLogger.instance!.info(tag, 'PUT request');
      APosLogger.instance!.info(tag, 'uri: $uri');
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return BaseResponseModel(data: response.data);
    } on FormatException catch (e) {
      return BaseResponseModel(
          serverException:
              ServerException(message: ' FormatException${e.message}', statusCode: '505'));
    } catch (e) {
      return BaseResponseModel(
          serverException:
              ServerException(message: ' UnKnown error: ${e.toString()}', statusCode: '505'));
    }
  }

  Future<BaseResponseModel> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    APosLogger.instance!.info(tag, 'DELETE request');
    APosLogger.instance!.info(tag, 'uri: $uri');
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return BaseResponseModel(data: response.data);
    } on FormatException catch (e) {
      return BaseResponseModel(
          serverException:
              ServerException(message: ' FormatException${e.message}', statusCode: '505'));
    } catch (e) {
      rethrow;
    }
  }
}
