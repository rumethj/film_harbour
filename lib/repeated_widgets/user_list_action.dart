import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


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

void addToWatchList(int itemId) async
{
  // Get the documents directory
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String filePath = '${documentsDirectory.path}/watch_list.json';

  // Read existing data from the file
  List<int> watchList = [];
  try {
    String jsonData = File(filePath).readAsStringSync();
    watchList = List<int>.from(json.decode(jsonData));
  } catch (e) {
    // if file is not found. Create new
    File(filePath).createSync(recursive: true);
  }

  // Add the new item ID to the watch list
  if (!watchList.contains(itemId)) {
    watchList.add(itemId);

    try {
      // Write the updated list back to the file
      File(filePath).writeAsStringSync(json.encode(watchList));
      print("Added $itemId to watch_list");
    } catch (e) {
      print("Error writing file: $e");
    }
  }
}

void addToWatchedList(int itemId) async
{
  // Get the documents directory
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String filePath = '${documentsDirectory.path}/watched_list.json';

  // Read existing data from the file
  List<int> watchedList = [];
  try {
    String jsonData = File(filePath).readAsStringSync();
    watchedList = List<int>.from(json.decode(jsonData));
  } catch (e) {
    // if file is not found. Create new
    File(filePath).createSync(recursive: true);
  }

  // Add the new item ID to the watch list
  if (!watchedList.contains(itemId)) {
    watchedList.add(itemId);

    try {
      // Write the updated list back to the file
      File(filePath).writeAsStringSync(json.encode(watchedList));
      print("Added $itemId to watched_list");
    } catch (e) {
      print("Error writing file: $e");
    }
  }
}

Future<List<int>> readWatchList() async {
  try {
    // Get the documents directory
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${documentsDirectory.path}/watch_list.json';

    // Read the content of the file
    String jsonData = File(filePath).readAsStringSync();

    // Parse the JSON data into a list of integers
    List<int> watchList = json.decode(jsonData).cast<int>();
    return watchList;
  } catch (e) {
    // Handle any potential errors (e.g., file not found, JSON parsing error)
    print("Error reading watchlist: $e");
    return [];
  }
}

Future<List<int>> readWatchedList() async {
  try {
    // Get the documents directory
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${documentsDirectory.path}/watched_list.json';

    // Read the content of the file
    String jsonData = File(filePath).readAsStringSync();

    // Parse the JSON data into a list of integers
    List<int> watchedList = json.decode(jsonData).cast<int>();
    return watchedList;
  } catch (e) {
    // Handle any potential errors (e.g., file not found, JSON parsing error)
    print("Error reading watchlist: $e");
    return [];
  }
}