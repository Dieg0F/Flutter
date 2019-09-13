class ServerResponse {
  Map<String, dynamic> json;
  String errorStatus;
  int errorCode;

  ServerResponse(this.json, this.errorStatus, this.errorCode);

  ServerResponse.withSuccess(Map<String, dynamic> json)
      : json = json,
        errorStatus = "",
        errorCode = 0;

  ServerResponse.withError(String errorValue, int code)
      : json = null,
        errorStatus = errorValue,
        errorCode = code;
}
