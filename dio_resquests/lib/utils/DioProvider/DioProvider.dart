import 'package:dio/dio.dart';
import 'package:dio_resquests/model/user/user-response.dart';

class DioProvider {
  final Dio _dio = Dio();

  DioProvider() {
    // Set default configs
    _dio.options.baseUrl = "https://randomuser.me/api/";
    _dio.options.connectTimeout = 5000; //5s
    _dio.options.receiveTimeout = 3000;
  }

  Future<UserResponse> getUser(endpoint) async {
    print("DioProvider: getUser");
    try {
      Response response = await _dio.get(endpoint);
      //print("DioProvider: Response > " + response.data.toString());
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }
}
