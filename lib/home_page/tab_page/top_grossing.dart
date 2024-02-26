import 'package:flutter/material.dart';

class TopGrossing extends StatefulWidget {
  final String uSelection; // Declare the String variable

  const TopGrossing({Key? key, required this.uSelection}) : super(key: key);

  @override
  State<TopGrossing> createState() => _TopGrossingState();
}

class _TopGrossingState extends State<TopGrossing> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}