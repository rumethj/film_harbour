import 'package:film_harbour/home_page/home_page.dart';
import 'package:film_harbour/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(
        brightness:Brightness.dark,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: "flutter Demo",
      home: HomePage(),
      //home: SignUp(),
    );
  }
}