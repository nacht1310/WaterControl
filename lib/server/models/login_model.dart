class LoginResponse {
  // ignore: prefer_typing_uninitialized_variables
  late final token;
  LoginResponse({this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token']['authToken'] ?? "",
    );
  }
}

class LoginRequest {
  String userName;
  String password;
  LoginRequest({required this.userName, required this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {"userName": userName, "password": password};
    return map;
  }
}
