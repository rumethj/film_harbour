// ignore_for_file: use_build_context_synchronously

import 'package:film_harbour/user_auth/forgot_password_page.dart';
//import 'package:film_harbour/service/auth.dart';
import 'package:film_harbour/home_page/home_page.dart';
import 'package:film_harbour/utils/network/network_utils.dart';
import 'package:film_harbour/utils/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:film_harbour/user_auth/sign_up_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String email = "";
  String password = "";

  TextEditingController emailTextController = new TextEditingController();
  TextEditingController passwordTextController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  LoginUser() async {
    try 
    {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    } 
    on FirebaseAuthException catch (e) 
    {
      if (e.code == 'user-not-found') 
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CustomTheme.mainPalletDarkRed,
            content: Text(
              "No User Found for that Email",
              style: Theme.of(context).textTheme.labelSmall,
            )));
      } 
      else if (e.code == 'wrong-password') 
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CustomTheme.mainPalletDarkRed,
            content: Text(
              "Wrong Password Provided by User",
              style: Theme.of(context).textTheme.labelSmall,
            )));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity(context); // Call checkConnectivity when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Image.asset(
                        "assets/images/film_harbour_logo_dark.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 30.0),
                              decoration: BoxDecoration(
                                  color: CustomTheme.mainPalletBlue,
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Email';
                                  }
                                  return null;
                                },
                                controller: emailTextController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle: Theme.of(context).textTheme.labelLarge,
                                    prefixIcon: Icon(
                                    Icons.email,
                                    size: 30.0,
                                  ),)
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 30.0),
                              decoration: BoxDecoration(
                                  color: CustomTheme.mainPalletBlue,
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextFormField(
                                controller: passwordTextController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: Theme.of(context).textTheme.labelLarge,
                                    prefixIcon: Icon(
                                    Icons.password,
                                    size: 30.0,
                                  ),),
                                    
                                obscureText: true,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    email = emailTextController.text;
                                    password = passwordTextController.text;
                                  });
                                }
                                LoginUser();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    vertical: 13.0, horizontal: 30.0),
                                decoration: BoxDecoration(
                                    color: CustomTheme.mainPalletRed,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                  child: Text(
                                    "Log In",
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ForgotPasswordPage()));
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Color(0xFF8c8e98),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 80.0),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Don't have an account?",
                  style: Theme.of(context).textTheme.headlineLarge
                ),
                SizedBox(width: 5.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text(
                    "Sign Up",
                    style: Theme.of(context).textTheme.headlineMedium
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}