class AuthUrl {
  static const String liveBaseURL = "https://identitytoolkit.googleapis.com";
  static const String liveV3BaseURL = "https://www.googleapis.com";
  static const String k1 = "AIzaSyDtiX4mShlnJVUC";
  static const String k2 = "kzmtDH8-XBMrL9DdM3k";

  static const String baseURL = liveBaseURL;
  static const String login =
      baseURL + "/v1/accounts:signInWithPassword?key=" + k1 + k2;
  static const String register = liveV3BaseURL +
      "/identitytoolkit/v3/relyingparty/signupNewUser?key=" +
      k1 +
      k2;
  static const String forgotPassword = baseURL + "/forgot-password";
}
