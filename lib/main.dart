//GITBASHTEST
import 'package:flutter/material.dart';
import 'package:elaros/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDlrH9W57G7_yPkbOZxxdJd9q8j069CGus",
      appId: "1:425527274727:android:fdbf7d550180609d0d0642",
      messagingSenderId: "425527274727",
      projectId: "elaros-d97be",
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Elaros',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
