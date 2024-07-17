import 'package:core/logger/a_pos_logger.dart';
import 'package:dio/dio.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    APosLogger.instance!.info('onRequest: ', 'method: ${options.method}, path: ${options.path}');
    APosLogger.instance!.info('Headers: ', options.headers.toString());
    APosLogger.instance!.info('data: ', options.data.toString());
    APosLogger.instance!.info('extra: ', options.extra.toString());
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    APosLogger.instance!.info('onResponse: ',
        'statusCode: ${response.statusCode}, method: ${response.requestOptions.method}, path: ${response.requestOptions.path}');

    String responseAsString = response.data.toString();
    APosLogger.instance!.info('response data:', responseAsString);

    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        // print(responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      // print(response.data);
    }

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    APosLogger.instance!.error('response onError ERROR MESSAGE :', err.message.toString());
    APosLogger.instance!.error('response onError:',
        'errorResponseData: ${err.response?.data}, statusMessage: ${err.response?.statusMessage} => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}
