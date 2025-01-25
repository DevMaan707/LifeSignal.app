import 'dart:convert';
import 'package:cc_essentials/services/shared_preferences/shared_preference_service.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:cc_essentials/helpers/logging/logger.dart';

import '../../dashboard/views/dashboard_page.dart';

class AuthController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  RxBool showOtpField = false.obs;

  Future<void> sendOtp() async {
    final url = Uri.parse('http://192.168.0.108:8080/auth/getOtp');
    final body = json.encode({"phone": phoneController.text});

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      print(response.body);
      if (response.statusCode == 200) {
        Get.snackbar("Success", "OTP sent successfully",
            snackPosition: SnackPosition.BOTTOM);
        showOtpField.value = true;
      } else {
        Get.snackbar("Error", "Failed to send OTP: ${response.body}",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signIn() async {
    final url = Uri.parse('http://192.168.0.108:8080/auth/login');
    final body = json.encode({"phone_number": phoneController.text});

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      print(response.body);
      if (response.statusCode == 200) {
        print("YES");
        final responseData = json.decode(response.body);
        SharedPreferencesService().setToken(responseData['token']);
        SharedPreferencesService().setString('userID', responseData['userID']);
        logger.i(SharedPreferencesService().getToken());
        logger.i(SharedPreferencesService().getString('userID'));
        Get.offAll(DashboardPage());
      } else {
        Get.snackbar("Error", "Sign-in failed: ${response.body}",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

class SignInPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3254ED),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: MediaQuery.of(context).size.width * 0.25,
            child: Image.asset(
              'lib/images/signin_img.png',
              width: 200,
              height: 200,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Sign in to continue',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: authController.phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() => authController.showOtpField.value
                      ? Column(
                          children: [
                            TextField(
                              controller: authController.otpController,
                              decoration: const InputDecoration(
                                labelText: 'OTP',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                              ),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: authController.signIn,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 100),
                                backgroundColor: const Color(0xFF3254ED),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text(
                                'SIGN IN',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: authController.sendOtp,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 100),
                            backgroundColor: const Color(0xFF3254ED),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'SEND OTP',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
