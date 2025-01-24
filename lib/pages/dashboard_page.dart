import 'package:flutter/material.dart';
import 'package:pocket_doc/features/common/views/webView.dart';
import 'signin_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _loadStoredData();
    _fetchDashboardData();
  }

  Future<void> _loadStoredData() async {
    _fetchDashboardData();
  }

  Future<void> _fetchDashboardData() async {}
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
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
            Text('Good Day',
                style: TextStyle(color: Colors.black, fontSize: 16)),
            Text('',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
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
          _buildDashboardContent(),
          Center(child: Text("Appointments Content")),
          Center(child: Text("Nearby Content")),
          Center(child: Text("History Content")),
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

  Widget _buildDashboardContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          Text(
            'How Are You\nFeeling Today?',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text('Services',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildEmergencyButton('Book\nAmbulance', Icons.local_hospital),
            ],
          ),
          SizedBox(height: 16),
          Text('Our Doctors',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Future<void> launchurl({required String url}) async {
    try {
      Uri url_parsed = Uri.parse(url);
      if (await canLaunchUrl(url_parsed)) {
        await launchUrl(url_parsed);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Url is not valid'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _buildEmergencyButton(String title, IconData icon) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          if (title == "Book\nAmbulance") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebView(
                      url:
                          "https://0dc2-2401-4900-889d-b700-c1a5-f8ce-2e1a-376f.ngrok-free.app"),
                ));
          }
        },
        splashColor: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 100,
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.blue),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
