import 'package:film_harbour/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget ListActionButton(String text, IconData icon, void Function() onPressed) {
  return IconButton(
    onPressed: onPressed,
    icon: Row(
      children: [
        Icon(icon),
        SizedBox(width: 8),
        Text(text),
      ],
    ),
    iconSize: 28,
    color: Colors.white,
  );
}

Future<void> addToWatchList(int itemId, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Read existing watch list from shared preferences
  List<int> watchList = prefs.getStringList('watchList')?.map(int.parse).toList() ?? [];

  // Add the new item ID to the watch list if it's not already present
  if (!watchList.contains(itemId)) {
    watchList.add(itemId);
    prefs.setStringList('watchList', watchList.map((e) => e.toString()).toList()); // Save updated watch list
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: CustomTheme.mainPalletBlue,
        content: Text('Added to list', 
        style: Theme.of(context).textTheme.labelSmall)));
    print("Added $itemId to watchList");
    return;
  }
  // Item is already in list
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: CustomTheme.mainPalletRed,
        content: Text('Item already exists in list', 
        style: Theme.of(context).textTheme.labelSmall))); // Indicate that the item already exists in the list
}

Future<void> addToWatchedList(int itemId, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Read existing watched list from shared preferences
  List<int> watchedList = prefs.getStringList('watchedList')?.map(int.parse).toList() ?? [];

  // Add the new item ID to the watched list if it's not already present
  if (!watchedList.contains(itemId)) {
    watchedList.add(itemId);
    prefs.setStringList('watchedList', watchedList.map((e) => e.toString()).toList()); // Save updated watched list
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: CustomTheme.mainPalletBlue,
        content: Text('Added to list', 
        style: Theme.of(context).textTheme.labelSmall)));

    print("Added $itemId to watchedList");
    return;
  }

  // Item is already in list
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: CustomTheme.mainPalletRed,
        content: Text('Item already exists in list', 
        style: Theme.of(context).textTheme.labelSmall))); 
}

Future<List<int>> readWatchList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Read watch list from shared preferences
  List<int> watchList = prefs.getStringList('watchList')?.map(int.parse).toList() ?? [];
  return watchList;
}

Future<List<int>> readWatchedList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Read watched list from shared preferences
  List<int> watchedList = prefs.getStringList('watchedList')?.map(int.parse).toList() ?? [];
  return watchedList;
}
