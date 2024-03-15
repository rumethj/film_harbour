import 'package:film_harbour/user_auth/login_page.dart';
import 'package:film_harbour/utils/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  String email = "";
  TextEditingController emailTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Call to reset user password
  resetUserPassword() async { // (shivam22rkl. 2023)
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CustomTheme.mainPalletDarkRed,
          content: Text(
        "Password Reset Email has been sent !",
        style: Theme.of(context).textTheme.labelSmall,
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CustomTheme.mainPalletDarkRed,
            content: Text(
          "No user found for that email.",
          style: Theme.of(context).textTheme.labelSmall,
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
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
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Recover Your Password",
                        style: Theme.of(context).textTheme.bodyLarge
                      ),
                    ),
                    
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                            padding: EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white70, width: 2.0),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Email';
                                }
                                return null;
                              },
                              controller: emailTextController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: Theme.of(context).textTheme.labelLarge,
                                  prefixIcon: Icon(
                                    Icons.email,
                                    size: 30.0,
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                            
                            SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    email = emailTextController.text;
                                  });
                                }
                                resetUserPassword();
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
                                    "Send Email",
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                ),
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
                                "Done reseting your password?",
                                style: Theme.of(context).textTheme.headlineLarge,),
                              SizedBox(
                                width: 5.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LogInPage()));
                                },
                                child: Text(
                                  "Log In",
                                  style: Theme.of(context).textTheme.headlineMedium)
                              )
                            ],
                          )
                    ),
                    SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}