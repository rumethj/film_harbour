import 'package:flutter/material.dart';

class Upcoming extends StatefulWidget {
  final String uSelection; // Declare the String variable

  const Upcoming({Key? key, required this.uSelection}) : super(key: key);

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}