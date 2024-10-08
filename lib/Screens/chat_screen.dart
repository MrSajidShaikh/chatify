import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/auth_controller.dart';
import '../Controller/chat_controller.dart';
import '../Models/chat_model.dart';
import '../services/auth_service.dart';
import '../services/cloud_firestore_service.dart';
import '../services/local_notification_service.dart';
import '../services/storage_service.dart';

var chatController = Get.put(ChatController());
var controller = Get.put(Authcontroller());

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWsEECmjStc8GA2m4E8kHMiOPEDzdxLbH_Jg&s"),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                controller.PhoneLuncher();
              },
              icon: const Icon(Icons.phone)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: 800,
              width: 402,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: StreamBuilder(
                        stream: CloudFireStoreService.cloudFireStoreService
                            .readChatFromFireStore(
                            chatController.receiverEmail.value),
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
                          List<ChatModel> chatList = [];
                          List<String> docIdList = [];
                          for (QueryDocumentSnapshot snap in data) {
                            docIdList.add(snap.id);
                            chatList.add(ChatModel.fromMap(snap.data() as Map));
                          }
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: List.generate(
                                chatList.length,
                                    (index) => GestureDetector(
                                  onLongPress: () {
                                    if (chatList[index].sender ==
                                        AuthService.authService
                                            .getCurrentUser()!
                                            .email!) {
                                      chatController.txtUpdateMessage =
                                          TextEditingController(
                                              text: chatList[index].message);
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('update'),
                                            content: TextField(
                                              controller:
                                              chatController.txtUpdateMessage,
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    String dcId = docIdList[index];
                                                    CloudFireStoreService
                                                        .cloudFireStoreService
                                                        .updateChat(
                                                        chatController
                                                            .receiverEmail
                                                            .value,
                                                        chatController
                                                            .txtUpdateMessage
                                                            .text,
                                                        dcId);
                                                    Get.back();
                                                  },
                                                  child: const Text('Update')),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  onDoubleTap: () {
                                    CloudFireStoreService.cloudFireStoreService
                                        .removeChat(docIdList[index],
                                        chatController.receiverEmail.value);
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8, right: 14, left: 14),
                                      child: Container(
                                        alignment: (chatList[index].sender ==
                                            AuthService.authService
                                                .getCurrentUser()!
                                                .email!)
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: (chatList[index].sender ==
                                                AuthService.authService
                                                    .getCurrentUser()!
                                                    .email!)
                                                ? const Color(0xff41B3A2)
                                                : const Color(0xffA594F9),
                                            borderRadius: (chatList[index].sender ==
                                                AuthService.authService
                                                    .getCurrentUser()!
                                                    .email!)
                                                ? const BorderRadius.only(
                                              topLeft: Radius.circular(13),
                                              bottomLeft: Radius.circular(13),
                                              bottomRight:
                                              Radius.circular(13),
                                            )
                                                : const BorderRadius.only(
                                              topRight: Radius.circular(13),
                                              bottomLeft: Radius.circular(13),
                                              bottomRight:
                                              Radius.circular(13),
                                            ),
                                          ),
                                          // child:Image.network( chatList[index].image!),

                                          child: (chatList[index].image!.isEmpty &&
                                              chatList[index].image == "")
                                              ? Text(
                                            chatList[index]
                                                .message!
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                              : Container(
                                            height: 300,
                                            child: Image.network(
                                                chatList[index].image!),
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 300,
                        child: TextField(
                          onChanged: (value) {
                            chatController.txtMessage.text = value;
                            CloudFireStoreService.cloudFireStoreService
                                .toggleTypingStatus(true);
                          },
                          onTapOutside: (event) {
                            CloudFireStoreService.cloudFireStoreService
                                .toggleTypingStatus(
                              false,
                            );
                          },
                          controller: chatController.txtMessage,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.emoji_emotions_outlined),
                            hintText: "Message",
                            border: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  String url = await StorageService.service
                                      .uploadImage();
                                  chatController.getImage(url);
                                },
                                icon: const Icon(Icons.image)),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 29,
                        backgroundColor: Colors.blue,
                        child: IconButton(
                            onPressed: () async {
                              // String message = chatController.txtMessage.text.trim();
                              ChatModel chat = ChatModel(
                                  image: chatController.image.value,
                                  sender: AuthService.authService
                                      .getCurrentUser()!
                                      .email,
                                  receiver: chatController.receiverEmail.value,
                                  message: chatController.txtMessage.text,
                                  time: Timestamp.now());

                              // if (message.isNotEmpty) {

                              await CloudFireStoreService.cloudFireStoreService
                                  .addChatInFireStore(chat);
                              await LocalNotificationService.notificationService
                                  .showNotification(
                                  AuthService.authService
                                      .getCurrentUser()!
                                      .email!,
                                  chatController.txtMessage.text);
                              chatController.txtMessage.clear();
                              chatController.getImage("");
                            },
                            // },
                            icon: const Icon(Icons.send)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}