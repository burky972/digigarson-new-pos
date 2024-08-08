import 'package:core/logger/a_pos_logger.dart';
import 'package:dio/dio.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharactersPerLine = 400;

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    APosLogger.instance!.info('onRequest: ',
        'method: ${options.method}, baseUrl:${options.baseUrl.toString()}, path:${options.path}');
    APosLogger.instance!.info('Headers: ', options.headers.toString());
    APosLogger.instance!.info('data: ', options.data.toString());
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    APosLogger.instance!.info('onResponse: ',
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
        APosLogger.instance!.info('response data SHORT:',
            responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      // print(response.data);
      APosLogger.instance!.info('response data:', responseAsString);
    }

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    APosLogger.instance!.error('response onError ERROR MESSAGE :', err.message.toString());
    APosLogger.instance!.error('response onError:',
        'errorResponseData: ${err.response?.data}, statusMessage: ${err.response?.statusMessage} => PATH: ${err.requestOptions.path}');
    if (err.response?.statusCode == 401) {
      APosLogger.instance?.error('ON ERROR', 'UNAUTHORIZED-> ${err.response?.statusCode}');
    }
    return super.onError(err, handler);
  }
}
