import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

void checkConnectivity(BuildContext context) async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    showNoConnectionSnackbar(context);
  }
}

void showNoConnectionSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text('No internet connection'),
      duration: Duration(seconds: 3),
    ),
  );
}