import 'dart:convert';

import 'package:dio/dio.dart';

import 'constants.dart';
import 'server-response.dart';

const baseUrl = "https://graph.facebook.com/v2.12/";

class RequestProvider {
  Dio _dio;

  RequestProvider() {
    BaseOptions options = BaseOptions(
        receiveTimeout: 30000,
        connectTimeout: 25000,
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        baseUrl: baseUrl);
    _dio = Dio(options);
    _setupLoggingInterceptor();
  }

  Future<ServerResponse> get(String endpoint) async {
    print("RequestProvider: Request data by GET");
    try {
      Response response = await _dio.get(endpoint);
      return ServerResponse.withSuccess(response.data);
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
        print("Response: ${response.data}");
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
      var responseData;
      var statusCode;
      if (type is DioErrorType) {
        switch (type) {
          case DioErrorType.CANCEL:
            errorDescription = Constants.cancelledMessage;
            break;
          case DioErrorType.SEND_TIMEOUT:
            errorDescription = Constants.sendTimeoutMessage;
            break;
          case DioErrorType.CONNECT_TIMEOUT:
            errorDescription = Constants.connectionTimeoutMessage;
            break;
          case DioErrorType.DEFAULT:
            errorDescription = Constants.defaultErrorMessage;
            break;
          case DioErrorType.RECEIVE_TIMEOUT:
            errorDescription = Constants.receiveTimeoutMessage;
            break;
          case DioErrorType.RESPONSE:
            errorDescription = Constants.serverResponseError;
            responseData = error.response.data;
            statusCode = error.response.statusCode;
            break;
        }
      } else {
        errorDescription = error.response.statusMessage;
      }
      return ServerResponse.withError(
        responseData,
        errorDescription,
        statusCode,
      );
    } catch (e) {
      print("Error: $e");
      return ServerResponse.withError(null, "Error on parse response", 0);
    }
  }
}
