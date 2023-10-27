import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_client/StartPage.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid){
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    }
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: StartPage()),
    );
  }
}
