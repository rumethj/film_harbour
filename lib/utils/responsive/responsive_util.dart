import 'package:flutter/material.dart';

// For finding device width and returning specific widget

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveWidget({super.key, required this.mobile,  required this.desktop});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints)
      {
        if (constraints.maxWidth < 768)
        {
          return mobile;
        }
        else
        {
          return desktop;
        }
      }
    );
  }
}