import 'dart:convert';
import 'package:cc_essentials/helpers/logging/logger.dart';
import 'package:cc_essentials/services/shared_preferences/shared_preference_service.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_doc/config/constants.dart';
import '../../models/doctor.dart';

class DoctorService {
  Future<List<Doctor>> getDoctors() async {
    final String baseUrl = AppConstants.baseUrl;
    final response = await http.get(
      Uri.parse('$baseUrl/v1/get-doctors'),
      headers: {
        'Authorization': 'Bearer ${SharedPreferencesService().getToken()}'
      },
    );
    logger.i(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['doctors'];
      return Doctor.listFromJson(data);
    }

    throw Exception('Failed to fetch doctors');
  }
}
