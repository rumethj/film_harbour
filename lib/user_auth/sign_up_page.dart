import 'package:film_harbour/user_auth/login_page.dart';
import 'package:film_harbour/home_page/home_page.dart';
import 'package:film_harbour/utils/network/network_utils.dart';
import 'package:film_harbour/utils/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String email = "";
  String password = "";
  String name = "";
  TextEditingController nameTextController = new TextEditingController();
  TextEditingController passwordTextController = new TextEditingController();
  TextEditingController emailTextController = new TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Used for validation

  RegisterUser() async {
    if (password != null && nameTextController.text!=""&& emailTextController.text!="") 
    {
      try 
      {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: CustomTheme.mainPalletBlue,
            content: Text(
          "Registered Successfully",
          style: Theme.of(context).textTheme.labelSmall,
        )));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } 
      on FirebaseAuthException catch (e) 
      {
        if (e.code == 'weak-password') 
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0),
              )));
        } 
        else if (e.code == "email-already-in-use") 
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: CustomTheme.mainPalletDarkRed,
              content: Text(
                "Account Already exists",
                style: Theme.of(context).textTheme.labelSmall,
              )));
        }
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
                                    return 'Please Enter Name';
                                  }
                                  return null;
                                },
                                controller: nameTextController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Name",
                                    hintStyle: Theme.of(context).textTheme.labelLarge,
                                    prefixIcon: Icon(
                                    Icons.person,
                                    size: 30.0,
                                  ),
                                ),
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
                                  ),
                                    ),
                              )
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
                                    
                                  ),
                              ),
                                obscureText: true,

                              )
                            ),
                            SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    name= nameTextController.text;
                                    email = emailTextController.text;
                                    password = passwordTextController.text;
                                  });
                                }
                                RegisterUser();
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
                                    "Sign Up",
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
                  "Already have an account?",
                  style: Theme.of(context).textTheme.headlineLarge
                ),
                SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogInPage()));
                  },
                  child: Text(
                    "Log In",
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