import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gemini_getx/presentation/pages/home_page.dart';
import 'package:gemini_getx/presentation/pages/starter_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core/config/root_binding.dart';
import 'data/models/message_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyDHKIeXDDcHqcc1Ye6ZSVnRnnKLnc2Uldg',
        appId: '1:223432338855:android:6cfa24c0dddb2660865a82',
        messagingSenderId: '223432338855',
        projectId: 'gemini-ai-d4df6',
      )
  );
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDirectory.path)
    ..registerAdapter(MessageModelAdapter());
  await Hive.openBox("my_nosql");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StarterPage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        StarterPage.id: (context) => StarterPage(),
      },
      initialBinding: RootBinding(),
    );
  }
}
