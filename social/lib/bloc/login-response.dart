class LoginResponse {
  Object data;
  String errorMessage;
  String errorCode;
  bool isLoading = false;

  LoginResponse(this.data, {this.errorMessage, this.errorCode, this.isLoading});
}
