import 'package:film_harbour/home_page/home_page.dart';
import 'package:film_harbour/user_auth/login_page.dart';
import 'package:film_harbour/user_lists_page/user_lists_page.dart';
import 'package:film_harbour/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final String currentState;

  const CustomNavigationBar({super.key, required this.currentState});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: CustomTheme.mainPalletBlack,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.list),
              iconSize: 30,
              color: currentState == 'UserListsPage'
              ? CustomTheme.mainPalletRed
              :CustomTheme.mainPalletOffWhite,
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
              icon: Icon(Icons.home_filled),
              iconSize: 35,
              color: currentState == 'HomePage'
              ? CustomTheme.mainPalletRed
              :CustomTheme.mainPalletOffWhite,
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
              icon: const Icon(Icons.logout),
              iconSize: 25,
              color: CustomTheme.mainPalletOffWhite,
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