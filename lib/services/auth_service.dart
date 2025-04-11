// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    const String apiUrl = 'https://your-api.com/signup'; // Replace with your real API URL

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Signup failed: ${response.body}');
      return false;
    }
  }
}
