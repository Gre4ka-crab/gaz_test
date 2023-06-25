import 'package:dio/dio.dart';
import 'package:gaz_test/core/api/loger.dart';

enum _Types {
  post,
  get,
  delete,
}

class Api {
  static String? deviceId;
  final Map<String, String>? urls;
  final Dio dio = Dio();
  static const bool testMode = true;
  static const bool printMode = false;

  Api({this.urls});

  Future<Response> post({required String query, Map<String, dynamic>? data, String? urlsNane}) async {
    return await _request(query: query, data: data, type: _Types.post, urlsNane: urlsNane);
  }

  Future<Response> get({required String query, Map<String, dynamic>? data, String? urlsNane}) async {
    return await _request(query: query, queries: data, type: _Types.get, urlsNane: urlsNane);
  }

  Future<dynamic> _request({
    required String query,
    Map<String, dynamic>? data,
    String? urlsNane,
    required _Types type,
    Map<String, String>? headers,
    Map<String, dynamic>? queries,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    Logger.log(data.toString(), name: 'API TEST ${type.name}: Query List', printMode: printMode);

    String url = (urls?[urlsNane ?? urls?.keys.first] ?? '') + query;

    try {
      headers ??= {};
      if (testMode) {
        Logger.log(headers.toString(), name: 'API TEST ${type.name}: Headers', printMode: printMode);
      }

      Response response = await dio.request(
        url,
        queryParameters: queries,
        data: !(type == _Types.get || type == _Types.delete) ? data : null,
        options: Options(headers: headers, method: type.name, contentType: Headers.jsonContentType),
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
      );

      if (testMode) {
        Logger.log(response.realUri.toString(), name: 'API TEST ${type.name}: URL', printMode: printMode);
        Logger.log(response.statusCode.toString(), name: 'API TEST ${type.name}: Response Code', printMode: printMode);
        if (response.data != null) {
          Logger.log(response.data.toString(), name: 'API TEST $type: Response Body', printMode: printMode);
        }
      }

      return response;
    } on DioError catch (error) {
      if (testMode) {
        if (error.response != null) {
          Logger.log(error.response!.realUri.toString(), name: 'API TEST ${type.name}: URL', printMode: printMode);
          Logger.log(error.response!.statusCode.toString(), name: 'API TEST ${type.name}: Response Code', printMode: printMode);
          if (error.response!.data != null) {
            Logger.log(error.response!.data.toString(), name: 'API TEST ${type.name}: Response Body', printMode: printMode);
          }
        }
      }
      rethrow;
    }
  }
}
