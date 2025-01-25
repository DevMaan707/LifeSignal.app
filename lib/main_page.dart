import 'package:cc_essentials/helpers/logging/logger.dart';
import 'package:cc_essentials/services/shared_preferences/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cc_essentials/chat/chat_screen.dart';
import 'controllers/doctor_controller.dart';
import 'controllers/user_controller.dart';
import 'features/auth/views/signin_page.dart';
import 'features/dashboard/views/dashboard_page.dart';
import 'features/hospital/views/hospital_locations.dart';
import 'features/medicalhistory/views/user_medical_history.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<MainPage> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final UserController userController = Get.put(UserController());
    final DoctorController doctorController = Get.put(DoctorController());
    await userController.fetchUser();
    await doctorController.fetchDoctors();
    await userController.fetchUserMedicalHistory();

    logger.i("Fetched Data");
  }

  Future<void> _logout(BuildContext context) async {
    final confirmLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
    if (confirmLogout == true) {
      await SharedPreferencesService().setToken("");
      await SharedPreferencesService().setString('userID', '');
      await SharedPreferencesService().setLoggedIn(false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
    logger.i(userController.user.value?.toJson() ?? "");
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: (_selectedIndex == 1)
          ? null
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage('lib/images/profile.png') as ImageProvider,
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Day',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    userController.user.value?.lastName ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.logout, color: Colors.black),
                  onPressed: () => _logout(context),
                ),
                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          DashboardPage(),
          ChatScreen(),
          HospitalLocations(),
          UserMedicalHistory()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: '',
            activeIcon: _buildActiveTabIcon(Icons.home, 'Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.adb, color: Colors.grey),
            label: '',
            activeIcon: _buildActiveTabIcon(Icons.adb, 'Chatbot'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on, color: Colors.grey),
            label: '',
            activeIcon: _buildActiveTabIcon(Icons.location_on, 'Track'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, color: Colors.grey),
            label: '',
            activeIcon: _buildActiveTabIcon(Icons.history, 'History'),
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        showSelectedLabels: false,
      ),
    );
  }

  Widget _buildActiveTabIcon(IconData icon, String label) {
    return SizedBox(
      width: 128,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(height: 1),
            Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
