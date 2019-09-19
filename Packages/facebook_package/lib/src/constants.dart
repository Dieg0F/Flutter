class Constants {
  /*
   * Login error messages.
   */
  static String noNetworkConnection = "Check your network connection!";
  static String connectionTimeout = "Connection Timeout!";

  static String canceledByUser = "Login canceled by user";

  static String requestFacebookDataError = "Error on get Facebook Data";
  static String defaultFacebookError = "Error on Facebook login";

  static String defaultGoogleError = "Error on Google login";

  /*
   * Timeout duration.
   */
  static int socialLoginTimeout = 25; // in seconds!

  /*
   * HTTP Request error messages.
   */
  static String cancelledMessage = "Request to API server was cancelled";
  static String sendTimeoutMessage = "Request timeout with API server";
  static String connectionTimeoutMessage = "Connection timeout with API server";
  static String defaultErrorMessage =
      "Connection to API server failed due to internet connection";
  static String receiveTimeoutMessage =
      "Receive timeout in connection with API server";
  static String serverResponseError = "Received invalid status!";
}
