import 'dart:convert';
import 'package:flutter/material.dart';
import '../../dashboard/views/dashboard_page.dart';
import 'signin_page.dart';

import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

Future<void> sendOtp(
    String name, String email, String mobileno, String city) async {
  final url = Uri.parse('http://localhost:8585/api/register');
  final body = json.encode(
      {"name": name, "email": email, "city": city, "mobileno": mobileno});

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('OTP sent successfully: $responseData');
    } else {
      print('Failed to send OTP: ${response.statusCode}');
      print('Error: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

class _SignUpPageState extends State<SignUpPage> {
  double _bottomPosition = -500;
  bool _showOTPFields = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController mobileno = TextEditingController();
  final TextEditingController otp = TextEditingController();
  final TextEditingController city = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        _bottomPosition = 0;
      });
    });
  }

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
              'lib/images/signup_img.png',
              width: 200,
              height: 200,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: _bottomPosition,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Sign up to continue',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF3254ED),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF3254ED),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: city,
                      decoration: InputDecoration(
                        labelText: 'City',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF3254ED),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: mobileno,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF3254ED),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: !_showOTPFields,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardPage()),
                            );
                          },
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
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: _showOTPFields,
                      child: Column(
                        children: [
                          TextField(
                            obscureText: true,
                            controller: otp,
                            decoration: InputDecoration(
                              labelText: 'OTP',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF3254ED),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 100),
                                backgroundColor: const Color(0xFF3254ED),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text(
                                'SIGN UP',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()),
                            );
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF3254ED),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      color: Color(0xFFB0BEC5),
                      thickness: 1,
                      indent: 100,
                      endIndent: 100,
                    ),
                    const SizedBox(height: 20),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'lib/images/googleicon_img.png',
                        width: 24,
                        height: 24,
                      ),
                      label: const Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF3254ED),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 40),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: const Color(0xFF3254ED),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
