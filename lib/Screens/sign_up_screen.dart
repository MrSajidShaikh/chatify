import 'package:chatify/Screens/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/auth_controller.dart';
import '../Models/user_model.dart';
import '../services/auth_service.dart';
import '../services/cloud_firestore_service.dart';
import 'home_screen.dart';

var controller = Get.put(Authcontroller());

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('SignUp'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
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
                    image: AssetImage('assets/image/img1.jpg'),
                  ),
                ),
              ),
            ),
            Container(
              // margin: EdgeInsets.all(20),
              height: 628,
              width: 360,
              decoration: BoxDecoration(

                // border: Border.all(
                //   color: Colors.blue.shade100,
                //   width: 1,
                // ),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Register",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "You and your friends always connceted ",
                      style: TextStyle(
                        // color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: controller.txtName,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Name',
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          prefixIcon: const Icon(
                            Icons.account_circle_outlined,
                          )),
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    TextField(
                      controller: controller.txtEmail,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Email',
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                          )),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // TextField(
                    //   controller: controller.txtPhone,
                    //   decoration: InputDecoration(
                    //       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 1),borderRadius: BorderRadius.circular(10)),
                    //       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 2),borderRadius: BorderRadius.circular(10)),
                    //       labelText: 'Phone',
                    //       labelStyle: TextStyle(
                    //           fontWeight: FontWeight.bold, fontSize: 20),
                    //       prefixIcon: Icon(
                    //         Icons.call,
                    //       )),
                    // ),
                    // SizedBox(height: 8,),
                    TextField(
                      obscureText: true,
                      controller: controller.txtPassword,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                          ),
                          suffixIcon: const Icon(Icons.remove_red_eye_outlined)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      obscureText: true,
                      controller: controller.txtConfirmPassword,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'ConfromPassword',
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                          ),
                          suffixIcon: const Icon(Icons.remove_red_eye_outlined)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Obx(
                              () => Checkbox(
                            value: controller.rememberMeCheck.value,
                            onChanged: (value) {
                              (controller.rememberMeCheck.value =
                                  value ?? false);
                            },
                            checkColor: Colors.white,
                            activeColor: Colors.blue,
                          ),
                        ),
                        const Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'I agree with the ',
                                  style: TextStyle(
                                    // color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Terms and condition  ',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              'and the privacy policy  ',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (controller.txtPassword.text ==
                            controller.txtConfirmPassword.text) {
                          await AuthService.authService
                              .createAccountWithEmailAndPassword(
                              controller.txtEmail.text,
                              controller.txtPassword.text);
                          UserModel user = UserModel(
                            name: controller.txtName.text,
                            email: controller.txtEmail.text,
                            image:
                            "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.restauraciaperon.sk%2F%3Fa%3Dwho-are-some-good-anime-characters-for-a-profile-zz-3exvmMtE&psig=AOvVaw2lpRwYm7twQ797eLXm43CZ&ust=1728373369283000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCPjOud7i-4gDFQAAAAAdAAAAABAE",
                            phone: controller.txtPhone.text,
                            token: "--------------------",
                            isOnline: false,
                            isTyping: false,
                            read: false,
                            timestamp: Timestamp.now(),
                          );

                          CloudFireStoreService.cloudFireStoreService
                              .insertUserIntoFireStore(user);
                          Get.offAll(const HomeScreen());
                          controller.txtEmail.clear();
                          controller.txtPassword.clear();
                          controller.txtName.clear();
                          controller.txtPhone.clear();
                          controller.txtConfirmPassword.clear();
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
                              'SignUp',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.off(const SingIn());
                        // Get.back();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have account ?',
                            style: TextStyle(
                              // color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'signIn',
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
