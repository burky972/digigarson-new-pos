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
    APosLogger.instance.info('response data:', responseAsString);

    handler.next(response); // Continue the response
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    APosLogger.instance.error('response onError: -> ${err.message.toString()} ',
        'errorResponseData: ${err.response?.data}, statusMessage: ${err.response?.statusMessage} => PATH: ${err.requestOptions.path}');

    handler.next(err); // Pass other errors as they are.
  }
}
