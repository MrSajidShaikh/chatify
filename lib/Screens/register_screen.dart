
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetStartScreeen extends StatelessWidget {
  const GetStartScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 120),
            const Center(
                child: Text(
                  "Get Started",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "start your chat SingUp or SingIn",
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              width: 400,
              decoration: const BoxDecoration(
                image:
                DecorationImage(image: AssetImage('assets/image/sp.png')),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.blue,
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/singUp');
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
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                Get.toNamed('/singIn');
              },
              child: Container(
                height: 50,
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  // color: Colors.blue,
                ),
                child: const Center(
                    child: Text(
                      'SignIn',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
