import 'package:flutter/material.dart';

// pages
import 'pages/EssentialOils.dart';
import 'pages/Oil.dart';
import 'wid/Themes.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Aromatherapy",
      theme: Themes().brightTheme(),
      home: EssentialOils()
    );
  }
}




