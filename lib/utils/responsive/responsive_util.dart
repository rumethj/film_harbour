import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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