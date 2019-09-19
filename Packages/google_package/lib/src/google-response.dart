class GoogleResponse {
  Object data;
  bool hasError;
  String errorMessage;
  String errorCode;
  bool isLoading = false;

  GoogleResponse(this.data,
      {this.hasError, this.errorMessage, this.errorCode, this.isLoading});
}
