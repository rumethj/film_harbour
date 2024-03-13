import 'package:film_harbour/home_page/home_page.dart';
import 'package:film_harbour/login_page.dart';
import 'package:film_harbour/user_lists_page/user_lists_page.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final String currentState;

  const CustomNavigationBar({super.key, required this.currentState});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            
            IconButton(
              icon: Icon(Icons.list),
              color: currentState == 'UserListsPage'
              ? Colors.amber
              :Colors.white,
              onPressed: currentState != 'UserListsPage'
              ? () {
                Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => UserListsPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
              }
              : (){}
            ),
            IconButton(
              icon: Icon(Icons.home),
              color: currentState == 'HomePage'
              ? Colors.amber
              :Colors.white,
              onPressed: currentState != 'HomePage'
              ? () {
                Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.0, 1.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
              }
              :() {
              }
            ),
            IconButton(
              icon: Icon(Icons.logout),
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => LogInPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
              }
            ),
          ]
        )
    );
  }
}