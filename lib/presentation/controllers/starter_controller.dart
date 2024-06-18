import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gemini_getx/core/services/auth_service.dart';
import 'package:gemini_getx/core/services/log_service.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../pages/home_page.dart';

class StarterController extends GetxController {

  late VideoPlayerController videoPlayerController;
  FlutterTts flutterTts = FlutterTts();
  initVideoPlayer() async{
    videoPlayerController =
    VideoPlayerController.asset("assets/videos/gemini_video.mp4")
      ..initialize().then((_) {
        update();
      });

    videoPlayerController.play();
    videoPlayerController.setLooping(true);
  }

  callHomePage(BuildContext context){
    Navigator.pushReplacementNamed(context, HomePage.id);
  }
  callGoogleSignIn() async {
    var result=await AuthService.signInWithGoogle();
    // LogService.i(result);
  }

  stopVideoPlayer(){
    videoPlayerController.dispose();

  }
  Future speakTTS(String text) async {
    var result = await flutterTts.speak(text);
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future stopTTS() async {
    var result = await flutterTts.stop();
    // if (result == 1) setState(() => ttsState = TtsState.stopped);
  }
}