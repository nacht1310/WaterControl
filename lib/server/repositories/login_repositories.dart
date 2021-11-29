import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uitest/server/models/login_model.dart';

class LoginRepository {
  Future<LoginResponse> getToken(LoginRequest loginRequest) async {
    var response = await http.post(
      Uri.parse('https://sampleapiproject.azurewebsites.net/api/auth'),
      body: jsonEncode({
        "userName": loginRequest.userName,
        "password": loginRequest.password
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 400) {
      final jsonData = jsonDecode(response.body);
      return LoginResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
