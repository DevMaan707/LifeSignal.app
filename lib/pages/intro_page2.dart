import 'package:flutter/material.dart';
import 'signin_page.dart';
import 'signup_page.dart';
import 'dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return const DashboardPage(mobilenopref: ''); // Redirect to Dashboard if logged in
        } else {
          return Scaffold(
            body: Stack(
              children: [
                // Background Image
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/images/intro2_img.png'), // Ensure the image path is correct
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Buttons
                Container(
            margin: const EdgeInsets.only(top: 687), // Add top margin
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start, // Align the buttons to the left
                children: [
                  // Sign In Button with left margin
                  Container(
                    margin: const EdgeInsets.only(left: 20), // Add left margin
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle Sign In action
                         Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignInPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // Transparent color
                        foregroundColor: Colors.black, // Text color
                        elevation: 0, // Removes shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50), // Rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24), // Padding for button
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 24), // Increase font size
                          ),
                          const SizedBox(width: 10), // Space between button and circle
                          CircleAvatar(
                            radius: 20, // Circle size
                            backgroundColor: Colors.white, // Circle color
                            child: const Icon(
                              Icons.arrow_forward, // Icon for Sign In
                              color: Colors.black, // Icon color
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 9), // Space between the buttons

                  // Sign Up Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle Sign Up action
                       Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()),
                        );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, // Transparent color
                      foregroundColor: Colors.black, // Text color
                      elevation: 0, // Removes shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 19), // Padding for button
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 24), // Increase font size
                        ),
                        const SizedBox(width: 10), // Space between button and circle
                        CircleAvatar(
                          radius: 20, // Circle size
                          backgroundColor: Colors.white, // Circle color
                          child: const Icon(
                            Icons.person_add, // Icon for Sign Up
                            color: Colors.black, // Icon color
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
              ],
            ),
          );
        }
      },
    );
  }
}
