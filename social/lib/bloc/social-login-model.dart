class LoginResponse {
  Object data;
  String errorMessage;
  String errorCode;

  LoginResponse(this.data, {this.errorMessage, this.errorCode});
}
