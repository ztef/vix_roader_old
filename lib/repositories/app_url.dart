class AppUrl {
  static const String liveBaseURL = "https://identitytoolkit.googleapis.com";
  static const String liveV3BaseURL = "https://www.googleapis.com";
  static const String key = "AIzaSyDtiX4mShlnJVUCkzmtDH8-XBMrL9DdM3k";

  static const String baseURL = liveBaseURL;
  static const String login =
      baseURL + "/v1/accounts:signInWithPassword?key=" + key;
  static const String register = liveV3BaseURL +
      "/identitytoolkit/v3/relyingparty/signupNewUser?key=" +
      key;
  static const String forgotPassword = baseURL + "/forgot-password";
}
