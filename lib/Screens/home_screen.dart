import 'package:chatify/Screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/chat_controller.dart';
import '../Controller/theme_controller.dart';
import '../Models/user_model.dart';
import '../services/auth_service.dart';
import '../services/cloud_firestore_service.dart';
import '../services/google_auth_service.dart';
import '../services/local_notification_service.dart';

var chatController = Get.put(ChatController());
var themeController = Get.put(ThemeController());

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomepageState();
}

class _HomepageState extends State<HomeScreen> with WidgetsBindingObserver {
  String userId = AuthService.authService
      .getCurrentUser()!
      .email!; // Replace with actual user ID

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    CloudFireStoreService.cloudFireStoreService.toggleOnlineStatus(true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      CloudFireStoreService.cloudFireStoreService.toggleOnlineStatus(false);
      CloudFireStoreService.cloudFireStoreService.updateLastSeen();
    } else if (state == AppLifecycleState.resumed) {
      CloudFireStoreService.cloudFireStoreService.toggleOnlineStatus(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: FutureBuilder(
            future: CloudFireStoreService.cloudFireStoreService
                .readCurrentUserFromFireStore(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              Map? data = snapshot.data!.data();
              UserModel userModel = UserModel.fromMap(data!);
              return Center(
                child: Column(
                  children: [
                    DrawerHeader(
                        child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(userModel.image!),
                    )),
                    Text(
                      userModel.name!,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(userModel.email!),
                    Text(userModel.phone!),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Icon(
                          themeController.isDarkMode.value
                              ? Icons.nightlight_round
                              : Icons.sunny,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "Theme",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 120,
                        ),
                        Obx(
                          () => Switch(
                            value: themeController.isDarkMode.value,
                            onChanged: (value) {
                              themeController.toggleTheme();
                            },
                            activeColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () async {
                              await LocalNotificationService.notificationService
                                  .scheduleNotification();
                            },
                            icon: const Icon(Icons.notifications)),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Notification",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.settings,
                          size: 24,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Settings and Privacy',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.comment_outlined,
                          size: 24,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Help Center',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.notifications,
                          size: 24,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Notifications',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "LogOut",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () async {
                              await AuthService.authService.singOutUser();
                              await GoogleAuthService.googleAuthService
                                  .signOutFromGoogle();
                              User? user =
                                  AuthService.authService.getCurrentUser();
                              if (user == null) {
                                Get.off(const SingIn());
                              }
                            },
                            icon: const Icon(Icons.logout)),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chatify"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () async {
                  await AuthService.authService.singOutUser();
                  await GoogleAuthService.googleAuthService.signOutFromGoogle();
                  User? user = AuthService.authService.getCurrentUser();
                  if (user == null) {
                    Get.off(const SingIn());
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('LogOut  '),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(Icons.logout)
                  ],
                ),
              ),
              const PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Settings '),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(Icons.settings),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 50,
                width: 360,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue)),
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search Chat',
                      suffixIcon: const Icon(Icons.contact_mail)),
                )),
          ),
          Expanded(
            child: FutureBuilder(
                future: CloudFireStoreService.cloudFireStoreService
                    .readAllUserFromCloudFireStore(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List data = snapshot.data!.docs;
                  List<UserModel> userList = [];
                  for (var user in data) {
                    userList.add(UserModel.fromMap(user.data()));
                  }
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                onTap: () {
                                  chatController.getReceiver(
                                      userList[index].email!,
                                      userList[index].name!);
                                  Get.toNamed('/chat');
                                },
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(userList[index].image!),
                                ),
                                title: Text(userList[index].name!),
                                subtitle: Text(userList[index].email!),
                              ),
                            ),
                          ]),
                        );
                      });
                }),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}

List SampleItem = [];
