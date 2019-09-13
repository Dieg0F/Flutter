import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:social/model/server-response.dart';

class RequestProvider {
  Dio _dio;

  RequestProvider() {
    BaseOptions options = BaseOptions(
        receiveTimeout: 30000, connectTimeout: 25000, baseUrl: "dsa");
    _dio = Dio(options);
    _setupLoggingInterceptor();
  }

  Future<ServerResponse> get(endpoint) async {
    print("RequestProvider: Request data by GET");
    try {
      Response response = await _dio.get(endpoint);
      return ServerResponse.withSuccess(json.decode(response.data));
    } catch (error) {
      print("RequestProvider: Exception $error");
      return _handleError(error);
    }
  }

  Future<ServerResponse> post(endpoint, object) async {
    print("RequestProvider: Request data by POST");
    try {
      Response response = await _dio.post(endpoint, data: object);
      return ServerResponse.withSuccess(response.data as Map);
    } catch (error) {
      print("RequestProvider: Exception $error");
      return _handleError(error);
    }
  }

  void _setupLoggingInterceptor() {
    int maxCharactersPerLine = 200;
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        print("--> ${options.method} ${options.uri}");
        print("Content type: ${options.contentType}");
        print("<-- END HTTP");

        return options;
      },
      onResponse: (Response response) {
        print(
            "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
        String responseAsString = response.data.toString();
        if (responseAsString.length > maxCharactersPerLine) {
          int iterations =
              (responseAsString.length / maxCharactersPerLine).floor();
          for (int i = 0; i <= iterations; i++) {
            int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
            if (endingIndex > responseAsString.length) {
              endingIndex = responseAsString.length;
            }
            print(responseAsString.substring(
                i * maxCharactersPerLine, endingIndex));
          }
        } else {
          print(response.data);
        }
        print("<-- END HTTP");
        return response;
      },
      onError: (DioError e) {
        return e;
      },
    ));
  }

  ServerResponse _handleError(error) {
    String errorDescription = "";
    try {
      var type = error.type;
      if (type is DioErrorType) {
        switch (type) {
          case DioErrorType.CANCEL:
            errorDescription = "Request to API server was cancelled";
            break;
          case DioErrorType.SEND_TIMEOUT:
            errorDescription = "Request timeout with API server";
            break;
          case DioErrorType.CONNECT_TIMEOUT:
            errorDescription = "Connection timeout with API server";
            break;
          case DioErrorType.DEFAULT:
            errorDescription =
                "Connection to API server failed due to internet connection";
            break;
          case DioErrorType.RECEIVE_TIMEOUT:
            errorDescription = "Receive timeout in connection with API server";
            break;
          case DioErrorType.RESPONSE:
            errorDescription = "Received invalid status!";
            break;
        }
      } else {
        errorDescription = error.response.statusMessage;
      }
      return ServerResponse.withError(
          errorDescription, error.response.statusCode);
    } catch (e) {
      print(e);
      return ServerResponse.withError("Parse Error", -1);
    }
  }
}
