import 'package:chatify/services/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controller/theme_controller.dart';
import 'Screens/auth_gate.dart';
import 'Screens/chat_screen.dart';
import 'Screens/home_screen.dart';
import 'Screens/register_screen.dart';
import 'Screens/sign_in_screen.dart';
import 'Screens/sign_up_screen.dart';
import 'Screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest_all.dart' as tz;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalNotificationService.notificationService.initNotificationService();
  // await FirebaseMessagingService.fm.requestPermission();
  // await FirebaseMessagingService.fm.getDeviceToken();
  tz.initializeTimeZones();
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return Obx(
          ()=>GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeController.currentTheme,
        darkTheme: ThemeData.dark(),


        themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        //
        // theme: ThemeData.light(),
        // darkTheme: ThemeData.dark(),
        // themeMode: themeController.isDark ? ThemeMode.dark : ThemeMode.light,
        getPages: [
          GetPage(name: '/', page:()=>const SplashScreen(),transition: Transition.rightToLeft),
          GetPage(name: '/start', page:()=>const GetStartScreeen(),transition: Transition.rightToLeft),
          GetPage(name: '/auth', page:()=>const AuthManger(),transition: Transition.rightToLeft),
          GetPage(name: '/singIn', page:()=>const SingIn(),transition: Transition.rightToLeft),
          GetPage(name: '/singUp', page:()=>const SignUp(),transition: Transition.rightToLeft),
          GetPage(name: '/home', page:()=> const HomeScreen(),transition: Transition.rightToLeft),
          GetPage(name: '/chat', page:()=>const ChatScreen(),transition: Transition.rightToLeft),
        ],
      ),
    );
  }
}
