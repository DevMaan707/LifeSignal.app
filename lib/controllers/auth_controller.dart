import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/dashboard_page.dart';
import '../core/services/auth_service.dart';

class AuthController extends GetxController {
  final _authService = AuthService();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final showOtpField = false.obs;

  Future<void> sendOtp() async {
    try {
      final success = await _authService.sendOtp(phoneController.text);
      if (success) {
        showOtpField.value = true;
        Get.snackbar("Success", "OTP sent successfully");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to send OTP");
    }
  }

  Future<void> signIn() async {
    try {
      final response = await _authService.signIn(phoneController.text);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response['token']);
      await prefs.setString('userID', response['userID']);
      Get.offAll(() => DashboardPage());
    } catch (e) {
      Get.snackbar("Error", "Sign-in failed");
    }
  }
}
