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
  String? refreshToken;
  String? countryCode;

  // Initialize
  Future<void> init({
    required String baseUrl,
  }) async {
    token = SharedManager.instance.getStringValue(CacheKeys.token.name) ?? "";
    refreshToken = SharedManager.instance.getStringValue(CacheKeys.refreshToken.name) ?? "";
    countryCode = SharedManager.instance.getStringValue(CacheKeys.country_code.name);
    APosLogger.instance.info('dio Client TOKEN', '$token ');
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(minutes: 1)
      ..options.receiveTimeout = const Duration(minutes: 1)
      ..options.headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token', //!NEW
        // 'lang': countryCode == 'US' ? 'en' : countryCode?.toLowerCase() ?? 'en',
      };

    dio.interceptors.add(LoggingInterceptor(dio, refreshToken));
  }

  void updateHeader(String token) {
    token = token;

    this.token = token;
    countryCode = countryCode;
    dio.options.headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token', //!NEW COMMENTED
    };
  }

  Future<BaseResponseModel> refreshTokenService() async {
    APosLogger.instance.info('$tag- refreshToken:', ' $refreshToken');
    try {
      var response = await dio.post('pos/refresh-token', data: {
        'refreshToken': '$refreshToken',
      });

      if (response.statusCode == 200) {
        APosLogger.instance.info('refreshToken: ', 'refreshToken: ${response.data}');
        final newAccessToken = response.data['accessToken'];
        SharedManager.instance.setStringValue(CacheKeys.token, newAccessToken);
        updateHeader(newAccessToken);
        return BaseResponseModel();
      } else {
        // Handle unsuccessful refresh (e.g., logout user)
        throw Exception('Refresh token failed');
      }
    } catch (e) {
      return BaseResponseModel(
          serverException:
              ServerException(message: 'Unknown error: ${e.toString()}', statusCode: '505'));
    }
  }

  Future<BaseResponseModel> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      APosLogger.instance.info(tag, 'GET request uri: $uri');
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      APosLogger.instance.info(tag, 'response: ${response.data}');

      return BaseResponseModel(data: response.data);
    } on SocketException catch (e) {
      APosLogger.instance.error(tag, e.message.toString());
      return BaseResponseModel(
          serverException:
              ServerException(message: 'SocketException: ${e.message}', statusCode: e.toString()));
    } on FormatException catch (e) {
      APosLogger.instance.error(tag, e.message.toString());
      return BaseResponseModel(
          serverException:
              ServerException(message: 'FormatException: ${e.message}', statusCode: e.toString()));
    } on DioException catch (dioError) {
      APosLogger.instance.error('GET RESPONSE DATA:', '${dioError.response?.data.toString()}');
      if (dioError.response?.statusCode == 401) {
        await refreshTokenService();
        return await get(
          uri,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );
      } else {
        // We are adding error message and status code to BaseResponseModel.
        return BaseResponseModel(
          serverException: ServerException(
            message: dioError.response?.data.toString() ?? dioError.message.toString(),
            statusCode: dioError.response?.statusCode.toString() ?? 'unknown',
          ),
        );
      }
    } catch (e) {
      APosLogger.instance.error(tag, e.toString());
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
    APosLogger.instance.info(tag, 'POST request');
    APosLogger.instance.info(tag, 'uri: $uri');
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
    } on DioException catch (dioError) {
      APosLogger.instance.error('POST RESPONSE DATA:', '${dioError.response?.data.toString()}');
      if (dioError.response?.statusCode == 401) {
        await refreshTokenService();
        return await post(
          uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
      } else {
        // We are adding error message and status code to BaseResponseModel.
        return BaseResponseModel(
          serverException: ServerException(
            message: dioError.response?.data?.toString() ?? dioError.message ?? 'Unknown Error',
            statusCode: dioError.response?.statusCode.toString() ?? 'unknown',
          ),
        );
      }
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
      APosLogger.instance.info(tag, 'PUT request');
      APosLogger.instance.info(tag, 'uri: $uri');
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
    } on DioException catch (dioError) {
      APosLogger.instance.error('put RESPONSE DATA:', '${dioError.response?.data.toString()}');
      if (dioError.response?.statusCode == 401) {
        await refreshTokenService();
        return await put(
          uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
      } else {
        // We are adding error message and status code to BaseResponseModel.
        return BaseResponseModel(
          serverException: ServerException(
            message: dioError.response?.data?['error'] ?? dioError.message,
            statusCode: dioError.response?.statusCode.toString() ?? 'unknown',
          ),
        );
      }
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
    APosLogger.instance.info(tag, 'DELETE request');
    APosLogger.instance.info(tag, 'uri: $uri');
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
    } on DioException catch (dioError) {
      APosLogger.instance.error('DELETE CATCH', dioError.toString());
      APosLogger.instance.error('DELETE RESPONSE DATA:', '${dioError.response?.data.toString()}');
      if (dioError.response?.statusCode == 401) {
        await refreshTokenService();
        return await delete(
          uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );
      } else {
        // We are adding error message and status code to BaseResponseModel.
        return BaseResponseModel(
          serverException: ServerException(
            message: dioError.response?.data?['error'] ?? dioError.message.toString(),
            statusCode: dioError.response?.statusCode.toString() ?? 'unknown',
          ),
        );
      }
    } catch (e) {
      return BaseResponseModel(serverException: ServerException(message: '$e', statusCode: '505'));
    }
  }

  Future<BaseResponseModel> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    APosLogger.instance.info(tag, 'PATH request');
    APosLogger.instance.info(tag, 'uri: $uri');
    try {
      var response = await dio.patch(
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
    } on DioException catch (dioError) {
      APosLogger.instance.error('patch RESPONSE DATA:', '${dioError.response?.data.toString()}');
      if (dioError.response?.statusCode == 401) {
        await refreshTokenService();
        return await patch(
          uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );
      } else {
        // We are adding error message and status code to BaseResponseModel.
        return BaseResponseModel(
          serverException: ServerException(
            message: dioError.response?.data?['error'] ?? dioError.message,
            statusCode: dioError.response?.statusCode.toString() ?? 'unknown',
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
