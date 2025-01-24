import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_doc/pages/signin_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/hospital.dart';

class DashboardController extends GetxController {
  final user = Rxn<User>();
  final hospitals = <Hospital>[].obs;
  final selectedIndex = 0.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    fetchHospitals();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      user.value = User.fromJson(json.decode(userData));
    }
  }

  Future<void> fetchHospitals() async {
    try {
      isLoading.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text('Confirm Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Get.offAll(SignInPage());
    }
  }
}
