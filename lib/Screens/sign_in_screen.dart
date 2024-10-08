import 'package:chatify/Screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../Controller/auth_controller.dart';
import '../services/auth_service.dart';
import '../services/google_auth_service.dart';
import 'home_screen.dart';

var controller = Get.put(Authcontroller());

class SingIn extends StatelessWidget {
  const SingIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('SignIn'),
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image/img2.png'),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: 620,
              width: 360,
              decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Colors.blue.shade100,
                  //   width: 1,
                  // ),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(height: 10,),

                    const Text(
                      "SignIn",
                      style: TextStyle(
                          // color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Remember to get up & stretch once",
                      style: TextStyle(
                          // color: Colors.black,
                          ),
                    ),
                    const Text(
                      "in a  while-your friends at chat",
                      style: TextStyle(
                          // color: Colors.black,
                          ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: controller.txtEmail,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Email',
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                          )),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      obscureText: true,
                      controller: controller.txtPassword,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                          ),
                          suffixIcon:
                              const Icon(Icons.remove_red_eye_outlined)),
                    ),

                    const SizedBox(
                      height: 18,
                    ),
                    GestureDetector(
                      onTap: () async {
                        String response = await AuthService.authService
                            .signInwithEmailAndPassword(
                                controller.txtEmail.text,
                                controller.txtPassword.text);
                        User? user = AuthService.authService.getCurrentUser();
                        if (user != null) {
                          Get.offAndToNamed('/home');
                          controller.txtEmail.clear();
                          controller.txtPassword.clear();
                        } else {
                          Get.snackbar('signIn in failed', response);
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                        ),
                        child: const Center(
                            child: Text(
                          'SignIn',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text('OR'),
                    const SizedBox(
                      height: 8,
                    ),
                    SignInButton(Buttons.google, onPressed: () async {
                      await GoogleAuthService.googleAuthService
                          .signInWithGoogle();
                      User? user = AuthService.authService.getCurrentUser();
                      if (user != null) {
                        Get.offAll(const HomeScreen());
                      }
                    }),
                    const SizedBox(
                      height: 8,
                    ),
                    // signup button
                    GestureDetector(
                      onTap: () {
                        Get.off(const SignUp());
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have account ?',
                            style: TextStyle(
                                // color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'signUp',
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
