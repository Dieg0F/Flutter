import 'package:dio/dio.dart';
import 'package:dio_resquests/model/user/user-response.dart';

class DioProvider {
  Dio _dio;

  DioProvider() {
    BaseOptions options = BaseOptions(
        receiveTimeout: 30000,
        connectTimeout: 25000,
        baseUrl: "https://randomuser.me/api/");
    _dio = Dio(options);
    _setupLoggingInterceptor();
  }

  Future<UserResponse> getUser(endpoint) async {
    print("DioProvider: getUser");
    try {
      Response response = await _dio.get(endpoint);
      return UserResponse.fromJson(response.data);
    } catch (error) {
      print("Exception occured: $error");
      return UserResponse.withError(_handleError(error));
    }
  }

  void _setupLoggingInterceptor() {
    int maxCharactersPerLine = 200;
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        print("--> ${options.method} ${options.path}");
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

  String _handleError(DioError error) {
    String errorDescription = "";
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
          errorDescription =
              "Received invalid status code: ${error.response.statusCode}";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}
