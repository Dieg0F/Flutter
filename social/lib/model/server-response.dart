class ServerResponse {
  Map<String, dynamic> response;
  bool hasError;
  String errorStatus;
  int errorCode;

  ServerResponse(
      this.response, this.hasError, this.errorStatus, this.errorCode);

  ServerResponse.withSuccess(Map<String, dynamic> response)
      : response = response,
        hasError = false,
        errorStatus = "",
        errorCode = 0;

  ServerResponse.withError(
      Map<String, dynamic> response, String errorValue, int code)
      : response = response,
        hasError = true,
        errorStatus = errorValue,
        errorCode = code;
}
