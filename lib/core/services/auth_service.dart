import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  static const baseUrl = 'http://192.168.0.108:8080/auth';

  Future<bool> sendOtp(String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/getOtp'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"phone": phone}),
    );
    return response.statusCode == 200;
  }

  Future<Map<String, dynamic>> signIn(String phoneNumber) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"phone_number": phoneNumber}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Sign in failed');
  }
}
