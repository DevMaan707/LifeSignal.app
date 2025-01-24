import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        _buildNavItem(Icons.home, 'Home'),
        _buildNavItem(Icons.adb, 'Chatbot'),
        _buildNavItem(Icons.location_on, 'Track'),
        _buildNavItem(Icons.history, 'History'),
      ],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: Colors.grey),
      label: '',
      activeIcon: _buildActiveTabIcon(icon, label),
    );
  }
}
