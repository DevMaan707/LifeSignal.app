import 'dart:convert';
import 'package:cc_essentials/helpers/logging/logger.dart';
import 'package:cc_essentials/services/shared_preferences/shared_preference_service.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_doc/config/constants.dart';
import 'package:pocket_doc/models/medical-history.dart';

import '../../models/user.dart';

class UserService {
  Future<User> getUser(String userId) async {
    final String baseUrl = AppConstants.baseUrl;
    final response = await http.get(
      Uri.parse('$baseUrl/v1/get-user/$userId'),
      headers: {
        'Authorization': 'Bearer ${SharedPreferencesService().getToken()}'
      },
    );
    logger.i(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['user'];
      return User.fromJson(data);
    }

    throw Exception('Failed to fetch user');
  }

  Future<MedicalHistory> getUserMedicalHistory(String userId) async {
    final String baseUrl = AppConstants.baseUrl;
    final response = await http.get(
      Uri.parse('$baseUrl/v1/get-medical-history/$userId'),
      headers: {
        'Authorization': 'Bearer ${SharedPreferencesService().getToken()}'
      },
    );
    logger.i(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(response.body)['medical_history'];
      return MedicalHistory.fromJson(data);
    }

    throw Exception('Failed to fetch user');
  }
}
