class FacebookResponse {
  Object data;
  bool hasError;
  String errorMessage;
  String errorCode;
  bool isLoading = false;

  FacebookResponse(this.data,
      {this.hasError, this.errorMessage, this.errorCode, this.isLoading});
}
