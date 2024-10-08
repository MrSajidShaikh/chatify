import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds:3), () {
      Get.offAndToNamed('/auth');
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 250,),
          Center(
            child: Container(
              height: 250,
              width: 300,
              decoration: const BoxDecoration(
                // color: Colors.red,
                image: DecorationImage(fit:BoxFit.cover,image: AssetImage('assets/image/logo3.gif')),
              ),

            ),
          ),
          const Column(
            children: [
              // SizedBox(height: 10,),
              Text('Chatify',style: TextStyle(fontSize:36, color: Color(0xFF4379F2),fontWeight: FontWeight.bold ),)
            ],
          ),
        ],
      ),
    );
  }
}
