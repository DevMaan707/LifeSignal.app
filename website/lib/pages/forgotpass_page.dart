import 'package:flutter/material.dart';
import 'docterlogin_page.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  bool isMobileNumberVisible = true;
  bool isOtpVisible = false;
  bool isVerifyButtonVisible = false;
  bool isChangePasswordVisible = false;
  bool hasSentOtp = false; // Added flag to control SEND OTP button visibility

  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4A8EFF),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Change Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                if (isMobileNumberVisible)
                  _buildTextField('Mobile Number', controller: mobileNumberController),
                if (isOtpVisible) _buildTextField('OTP', controller: otpController),
                if (isChangePasswordVisible)
                  _buildTextField('Enter New Password', controller: newPasswordController, obscureText: true),
                SizedBox(height: 20),
                if (!hasSentOtp) // Ensuring SEND OTP is only visible before being clicked
                  _buildButton('SEND OTP', onPressed: _handleSendOtp),
                if (isVerifyButtonVisible)
                  _buildButton('VERIFY OTP', onPressed: _handleVerifyOtp),
                if (isChangePasswordVisible)
                  _buildButton('CHANGE PASSWORD', onPressed: _handleChangePassword),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, {TextEditingController? controller, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: 250, // Setting the width of the TextField
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.blue.shade700),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.blue.shade700),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String label, {required Function() onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF4A8EFF),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  void _handleSendOtp() {
    setState(() {
      isMobileNumberVisible = false;
      isOtpVisible = true;
      isVerifyButtonVisible = true;
      hasSentOtp = true; // Set to true to hide the SEND OTP button
    });
  }

  void _handleVerifyOtp() {
    if (otpController.text == '123456') {
      setState(() {
        isOtpVisible = false;
        isVerifyButtonVisible = false;
        isChangePasswordVisible = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    }
  }

  void _handleChangePassword() {
    // Logic to change password can be implemented here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password changed successfully!')),
    );

    // Optionally, navigate back to the login page after password change
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DocterLoginPage()),
    );
  }
}
