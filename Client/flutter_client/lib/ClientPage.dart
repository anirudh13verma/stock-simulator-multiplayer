import 'package:flutter/material.dart';
import 'dart:io';

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
    serverAddress = widget.ip;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Socket Client App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Received Data:'),
            Text(
              receivedData,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: () {
                  socket?.close();
                  Navigator.pop(context);
                },
                child: Text('Exit'))
          ],
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
