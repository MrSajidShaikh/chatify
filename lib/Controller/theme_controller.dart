import 'package:flutter/material.dart';
import 'package:get/get.dart';



// class ThemeController extends GetxController {
//   // Using a reactive variable
//   final Rx<ThemeData> _themeData = lightTheme.obs;
//
//   // Getter for themeData
//   ThemeData get themeData => _themeData.value;
//
//   // Getter for isdark
//   bool get isDark => _themeData.value == darkTheme;
//
//   // Method to set the themeData
//   void setTheme(ThemeData themeData)
//   {
//     _themeData.value = themeData;
//   }
//
//   // Method to toggle the theme
//   void toggleTheme() {
//     if (_themeData.value == lightTheme) {
//       _themeData.value = darkTheme;
//     }
//     else {
//       _themeData.value = lightTheme;
//     }
//   }
// }

class ThemeController extends GetxController
{
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  ThemeData get currentTheme {
    return isDarkMode.value ? ThemeData.dark() : ThemeData.light();
  }
}
