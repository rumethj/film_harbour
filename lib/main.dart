import 'package:film_harbour/home_page/home_page.dart';
import 'package:film_harbour/login_page.dart';
import 'package:film_harbour/sign_up_page.dart';
import 'package:film_harbour/user_lists_page/user_lists_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(
        brightness:Brightness.dark,
        useMaterial3: true,
      ),
      
      debugShowCheckedModeBanner: false,
      title: "Film Harbour",
      //home: HomePage(),
      //home: LogInPage(),
      home: SignUpPage(),
      //home: UserListsPage(),
    );
  }
}