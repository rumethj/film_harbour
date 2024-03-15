import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:film_harbour/utils/theme/theme.dart';
import 'package:flutter/material.dart';

// network connected chcker
void checkConnectivity(BuildContext context) async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    showNoConnectionSnackbar(context);
  }
}

// error message for network
void showNoConnectionSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: CustomTheme.mainPalletDarkRed,
      content: Text('No internet connection.', style: Theme.of(context).textTheme.labelSmall),
      duration: Duration(seconds: 3),
    ),
  );
}