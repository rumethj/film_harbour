import 'package:film_harbour/home_page/home_page.dart';
import 'package:film_harbour/user_auth/forgot_password_page.dart';
import 'package:film_harbour/user_auth/login_page.dart';
import 'package:film_harbour/user_auth/sign_up_page.dart';
import 'package:film_harbour/user_lists_page/user_lists_page.dart';
import 'package:film_harbour/utils/network/network_utils.dart';
import 'package:film_harbour/utils/theme/theme.dart';
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
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.dark,
      
      debugShowCheckedModeBanner: false,
      title: "Film Harbour",
      // home: Builder(
      //   builder: (context) {
      //     checkConnectivity(context); // Call checkConnectivity here
      //     return SignUpPage(); // Or any other page you want to show initially
      //   },
      // ), 
      //home: HomePage(),
      home: ForgotPasswordPage(),
      //home: LogInPage(),
      //home: SignUpPage(),
      //home: UserListsPage(),
    );
  }
}