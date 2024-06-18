import 'package:flutter/material.dart';
import 'package:gemini_getx/core/services/auth_service.dart';
import 'package:gemini_getx/core/services/log_service.dart';
import 'package:gemini_getx/presentation/controllers/starter_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

import '../../core/constants/constants.dart';
import 'home_page.dart';

class StarterPage extends StatefulWidget {
  static const String id = 'starter_page';
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  final starterController = Get.find<StarterController>();

  @override
  void initState() {
    super.initState();

    starterController.speakTTS(welcomingMessage);
    starterController.initVideoPlayer();
    // LogService.i(AuthService.currentUser().displayName!);
    // LogService.i(AuthService.currentUser().phoneNumber!);
    // LogService.i(AuthService.currentUser().photoURL!);

  }

  @override
  void dispose() {
    starterController.stopVideoPlayer();
    starterController.stopTTS();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<StarterController>(
        builder: (_) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  Container(
                    width: 150,
                    child: Lottie.asset('assets/animations/gemini_logo.json'),
                  ),
                  Expanded(
                    child: starterController
                            .videoPlayerController.value.isInitialized
                        ? VideoPlayer(starterController.videoPlayerController)
                        : Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthService.isLoggedIn()? GestureDetector(
                        onTap: () {
                          starterController.callHomePage(context);
                          // Get.offNamed();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Chat with Gemini ',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 18),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ):GestureDetector(
                        onTap: () {
                          starterController.callGoogleSignIn();
                          // Get.offNamed();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Image(
                                height: 30,
                                width: 30,
                                image: AssetImage('assets/images/google_logo.png'),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'Sign in with Google',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
