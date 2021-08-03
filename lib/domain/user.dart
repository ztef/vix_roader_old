class User {
  String? userId;
  String? name;
  String? email;
  String? phone;
  String? type;
  String? token;
  String? renewalToken;
  int? expires;

  User(
      {this.userId = "",
      this.name = "",
      this.email = "",
      this.phone = "",
      this.type = "",
      this.token = "",
      this.renewalToken = "",
      this.expires = 0});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['localId'],
        name: responseData['email'],
        email: responseData['email'],
        phone: '',
        type: responseData['user'],
        token: responseData['idToken'],
        renewalToken: responseData['refreshToken'],
        expires: 3600);
  }
}
