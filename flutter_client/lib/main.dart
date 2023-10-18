import 'package:flutter/material.dart';
import 'package:flutter_client/ClientPage.dart';
import 'package:flutter_client/StartPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: StartPage()),
    );
  }
}
