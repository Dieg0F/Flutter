class LoginResponse {
  Object data;
  bool hasError;
  String errorMessage;
  String errorCode;
  bool isLoading = false;

  LoginResponse(this.data,
      {this.hasError, this.errorMessage, this.errorCode, this.isLoading});
}
