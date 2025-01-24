import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/constants.dart';
import '../../../pages/signin_page.dart';

class SignInView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstants.primaryColor),
      body: Stack(
        children: [
          _buildHeader(),
          _buildSignInForm(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 50,
      left: Get.width * 0.25,
      child: Image.asset(
        'assets/images/signin_img.png',
        width: 200,
        height: 200,
      ),
    );
  }

  Widget _buildSignInForm() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 0.7,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: Column(
          children: [
            Text('Sign in to continue',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            _buildPhoneInput(),
            SizedBox(height: 20),
            _buildOtpSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneInput() {
    return TextField(
      controller: controller.phoneController,
      decoration: InputDecoration(
        labelText: 'Mobile Number',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildOtpSection() {
    return Obx(() => controller.showOtpField.value
        ? _buildOtpInput()
        : _buildSendOtpButton());
  }
}
