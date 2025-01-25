import 'package:cc_essentials/helpers/logging/logger.dart';
import 'package:cc_essentials/services/shared_preferences/shared_preference_service.dart';
import 'package:get/get.dart';

import '../core/services/user_service.dart';
import '../models/user.dart';

class UserController extends GetxController {
  final _userService = UserService();

  Rx<User?> user = Rx<User?>(null);
  RxBool isLoading = false.obs;

  Future<void> fetchUser() async {
    try {
      isLoading.value = true;

      final userId = SharedPreferencesService().getString('userID') ?? '';
      if (userId.isEmpty)
        throw Exception('User ID not found in SharedPreferences');

      final fetchedUser = await _userService.getUser(userId);
      user.value = fetchedUser;
    } catch (e) {
      logger.e(e);
      Get.snackbar('Error', 'Failed to fetch user: \$e');
    } finally {
      isLoading.value = false;
    }
  }
}
