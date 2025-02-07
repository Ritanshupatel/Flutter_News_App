import 'package:flutter/material.dart';
import 'package:newser/pages/home.dart';
import 'package:newser/pages/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News App',
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
