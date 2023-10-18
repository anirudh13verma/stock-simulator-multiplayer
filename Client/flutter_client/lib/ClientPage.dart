import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_client/StartPage.dart';
import 'package:flutter_client/utils.dart';

class MyClient extends StatefulWidget {
  final String ip;

  MyClient({required this.ip, Key? key}) : super(key: key);
  @override
  _MyClientState createState() => _MyClientState();
}

class _MyClientState extends State<MyClient> {
  String serverAddress = ""; // Replace with the actual server IP address
  final serverPort = 12345;
  String receivedData = '';
  bool isConnecting = false;

  Socket? socket;

  @override
  void initState() {
    super.initState();
    _connectToServer();
  }

  void _connectToServer() async {
    isConnecting = true;
    setState(() {});

    try {
      socket = await Socket.connect(serverAddress, serverPort);
      socket!.listen(
        (data) {
          setState(() {
            receivedData = String.fromCharCodes(data).trim();
          });
        },
        onDone: () {
          print('Connection closed by server.');
          socket?.destroy();
          setState(() {
            receivedData = "Disconnected, Attempting to reconnect...";
          });
          // Automatically try to reconnect after a delay
          Future.delayed(Duration(seconds: 2), () {
            _connectToServer();
          });
        },
        onError: (error) {
          print('Error: $error');
          // Automatically try to reconnect after a delay
          Future.delayed(Duration(seconds: 2), () {
            _connectToServer();
          });
        },
      );

      isConnecting = false;
      setState(() {});
    } catch (e) {
      print('Error: $e');
      // Automatically try to reconnect after a delay
      Future.delayed(Duration(seconds: 2), () {
        _connectToServer();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    f(int fs, Color clr, FontWeight fw) {
      return SafeGoogleFont('Raleway',
          fontSize: fs / 768 * height, fontWeight: fw, color: clr);
    }

    serverAddress = widget.ip;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: bg,
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Stock Market Simulator:',
                style: f(42, fg, FontWeight.w800),
              ),
              Text(
                receivedData,
                style: f(26, fg, FontWeight.normal),
              ),
              TextButton(
                  onPressed: () {
                    socket?.close();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Exit',
                    style: f(34, fg, FontWeight.w600),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    socket?.destroy();
    super.dispose();
  }
}
