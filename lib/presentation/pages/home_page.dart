import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gemini_getx/presentation/controllers/home_controller.dart';
import 'package:gemini_getx/presentation/widgets/item_gemini_message.dart';
import 'package:get/get.dart';
import '../widgets/item_user_message.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController=Get.find<HomeController>();


  @override
  void dispose() {
    super.dispose();
    homeController.textController.dispose();
    homeController.textFieldFocusNode.dispose();
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.initSTT();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GetBuilder<HomeController>(
          builder: (_) {
            return Container(
              padding: const EdgeInsets.only(bottom: 20, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 45,
                    child: Image(
                      image: AssetImage('assets/images/gemini_logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      child: homeController.messages.isEmpty
                          ? Center(
                        child: SizedBox(
                          width: 70,
                          child: Image.asset(
                              'assets/images/gemini_icon.png'),
                        ),
                      )
                          : ListView.builder(
                        itemCount: homeController.messages.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var message = homeController.messages[index];
                          if (message.isMine!) {
                            return itemOfUserMessage(message);
                          } else {
                            return itemOfGeminiMessage(
                                message, homeController);
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20, left: 20),
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey, width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        homeController.pickedImage != null
                            ? Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  base64Decode(
                                      homeController.pickedImage!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              padding: EdgeInsets.only(top: 5, right: 5),
                              height: 100,
                              width: 100,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    child: Icon(Icons.cancel),
                                    onTap: () {
                                      homeController.onRemovedImage();
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                            : SizedBox.shrink(),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: homeController.textController,
                                focusNode: homeController.textFieldFocusNode,
                                maxLines: null,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Message',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Add some space between TextField and Icons
                            // if (homeController.textController.text
                            //     .isEmpty) // Show icons only if text is empty
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                homeController.onSelectedImage();
                              },
                              icon: const Icon(
                                Icons.attach_file,
                                color: Colors.grey,
                              ),
                            ),
                            // if (homeController.textController.text
                            //     .isEmpty) // Show icons only if text is empty
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                homeController.speechToText.isNotListening
                                    ? homeController.startSTT()
                                    : homeController.stopSTT();
                              },
                              icon: const Icon(
                                Icons.mic,
                                color: Colors.grey,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                var text = homeController.textController.text
                                    .toString()
                                    .trim();
                                homeController.onSendPressed(text);
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}