import 'package:cc_essentials/cc_essentials.dart';
import 'package:cc_essentials/chat/controller/chat_controller.dart';
import 'package:cc_essentials/chat/models/chat_config.dart';
import 'package:cc_essentials/services/shared_preferences/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'features/auth/views/intro_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CCEssentials.initialize(
    primaryColor: Colors.blueAccent,
    accentColor: Colors.teal,
    navigatorKey: navigatorKey,
  );

  final chatConfig = await ChatConfig(
    primaryColor: Colors.blue,
    secondaryColor: Colors.grey,
    saveToLocal: true,
    messagesPerPage: 20,
    isConversationEnd: (response) => response['isEnd'] == true,
  );
  Get.put(ChatController(config: chatConfig));
  final sharedPreferencesService = SharedPreferencesService();
  await sharedPreferencesService.init();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: const IntroPage(),
        );
      },
    );
  }
}
