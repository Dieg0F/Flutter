import 'package:dio_resquests/model/user/user-response.dart';
import 'package:dio_resquests/utils/DioProvider/DioProvider.dart';

class UserRepository {
  DioProvider _dioProvider = DioProvider();

  Future<UserResponse> getUser() {
    return _dioProvider.getUser("");
  }
}
