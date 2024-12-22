import 'package:flutter/material.dart';
import 'login_page.dart';
import 'hospitaldash_page.dart';
import 'docterdash_page.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Animated background
                SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF5271FF),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(650),
                        bottomRight: Radius.circular(650),
                      ),
                    ),
                    height: 600,
                    width: double.infinity,
                  ),
                ),

                // Centered content on the blue background
                Positioned(
                  top: 150,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'HEALTH IS WEALTH',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48, // Adjust font size as needed
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Dancing Script',
                          ),
                        ),
                        const SizedBox(height: 130), // Space between text and first button

                        // Login button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF5271FF),
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white, width: 3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 93),
                          ),
                          onPressed: () {
                            // Define Login button action
                                  Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 24, // Large font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20), // Space between buttons

                        // Register button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF5271FF),
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white, width: 3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 50),
                          ),
                          onPressed: () {
                            // Define Register button action
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HospitalDashPage(username: '',)),
                            );
                          },
                          child: const Text(
                            'Register Now',
                            style: TextStyle(
                              fontSize: 24, // Large font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Fixed content (logo, button, hamburger icon)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logo
                        Image.asset(
                          'lib/images/logo_img.png',
                          height: 80,
                          width: 200,
                          fit: BoxFit.contain,
                        ),

                        // Download button and hamburger icon
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.white, width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20),
                              ),
                              onPressed: () {
                                // Define button press action
                              },
                              child: const Text('Download App for Patient'),
                            ),
                            const SizedBox(width: 10), // Space between button and icon

                            // Hamburger icon
                            const Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Features text
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 60),
              child: Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Features',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Features blocks
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(3, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      height: 350,
                      width: 230,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 214, 213, 213),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }),
                ),
              ),
            ),
            // Features blocks
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(3, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      height: 350,
                      width: 230,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 214, 213, 213),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 60),
              child: Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'About App',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text on the left
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'At Lifeline Connect, we believe that healthcare should be accessible, '
                          'efficient, \nand personalized for everyone. Our app is designed to bridge '
                          'the gap between \npatients and providers, ensuring that medical services are '
                          'just a tap away. From \nreal-time ambulance tracking and easy appointment '
                          'scheduling to viewing \nmedical records and checking hospital bed availability, '
                          'Lifeline Connect puts \ncomprehensive health management at your fingertips.',
                          style: TextStyle(fontSize: 18, height: 1.5),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Our platform integrates advanced AI technology to offer personalized health '
                          '\ninsights and proactive care solutions. We are committed to empowering \nindividuals '
                          'to take control of their health journey, providing peace of mind \nand timely support '
                          'when it matters most.\n\nWith Lifeline Connect, your health is more than just a '
                          'priority—it’s our mission.',
                          style: TextStyle(fontSize: 18, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 0),

                  // Image on the right
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'lib/images/aboutapp_img.png', 
                      height: 480,
                      width: 350,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





