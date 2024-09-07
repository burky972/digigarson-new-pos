import 'package:core/logger/a_pos_logger.dart';
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  int maxCharactersPerLine = 400;
  bool isRefreshing = false;
  List<Function> requestQueue = [];

  final Dio dio;
  final String? refreshToken;

  LoggingInterceptor(this.dio, this.refreshToken);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    APosLogger.instance.info('onRequest: ',
        'method: ${options.method}, baseUrl:${options.baseUrl.toString()}, path:${options.path}');
    APosLogger.instance.info('Headers: ', options.headers.toString());
    APosLogger.instance.info('onRequest data: ', options.data.toString());
    handler.next(options); // Continue the request
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    APosLogger.instance.info('onResponse: ',
        'statusCode: ${response.statusCode}, method: ${response.requestOptions.method}, path: ${response.requestOptions.path}');

    String responseAsString = response.data.toString();

    /// If response data is too long, split it into multiple lines
    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        APosLogger.instance.info('response data SHORT:',
            responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      APosLogger.instance.info('response data:', responseAsString);
    }

    handler.next(response); // Continue the response
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    APosLogger.instance.error('response onError: -> ${err.message.toString()} ',
        'errorResponseData: ${err.response?.data}, statusMessage: ${err.response?.statusMessage} => PATH: ${err.requestOptions.path}');

    // if (err.response?.statusCode == 401) {
    //   APosLogger.instance.error('ON ERROR', 'UNAUTHORIZED-> ${err.response?.statusCode}');

    //   if (!isRefreshing) {
    //     isRefreshing = true;

    //     try {
    //       // Send a request to refresh the token
    //       final refreshTokenResponse = await dio.post('pos/refresh-token', data: {
    //         'refreshToken': '$refreshToken',
    //       });

    //       if (refreshTokenResponse.statusCode == 200) {
    //         APosLogger.instance
    //             .info('refreshTokenz: ', 'refreshTokenz: ${refreshTokenResponse.data}');
    //         // Get the new access token
    //         final newAccessToken = refreshTokenResponse.data['accessToken'];
    //         SharedManager.instance.setStringValue(CacheKeys.token, newAccessToken);

    //         // Set the new token to the header
    //         DioClient.instance.updateHeader(newAccessToken);

    //         // Re-send the requests in the queue
    //         for (var callback in requestQueue) {
    //           callback();
    //         }
    //         requestQueue.clear();
    //       } else {
    //         // If the refresh token request fails, send all requests in the queue as error
    //         for (var callback in requestQueue) {
    //           callback();
    //         }
    //         requestQueue.clear();
    //       }
    //     } catch (e) {
    //       handler.next(err); // If the refresh token request fails, send the error.
    //     } finally {
    //       isRefreshing = false;
    //     }
    //   } else {
    //     // Put 401 errors during the refresh process into the queue.
    //     requestQueue.add(() {
    //       dio.fetch(err.requestOptions).then(
    //             (response) => handler.resolve(response),
    //             onError: (e) => handler.reject(e),
    //           );
    //     });
    //   }

    // } else {
    handler.next(err); // Pass other errors as they are.
    // }
  }
}
