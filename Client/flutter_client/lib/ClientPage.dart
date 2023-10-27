import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_client/StartPage.dart';
import 'dart:io';

import 'package:flutter_client/utils.dart';

class Stock {
  final String name;
  final int price;

  Stock({required this.name, required this.price});
}

class MyClient extends StatefulWidget {
  final String ip;

  MyClient({required this.ip, Key? key}) : super(key: key);
  @override
  _MyClientState createState() => _MyClientState(serverAddress: ip);
}

class _MyClientState extends State<MyClient> {
  final String serverAddress;

  _MyClientState({required this.serverAddress});

  final serverPort = 12345;
  dynamic receivedData = '{}';
  bool isConnecting = false;

  dynamic stockData;

  List<Widget> stockItems = [];
  Stock? selectedStock;

  Socket? socket;

  void _onStockTapped(Stock stock) {
    setState(() {
      selectedStock = stock;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    void _connectToServer() async {
      try {
        socket = await Socket.connect(serverAddress, serverPort);
        socket!.listen(
          (data) {
            setState(() {
              receivedData = String.fromCharCodes(data).trim();
              stockData = jsonDecode(receivedData);

              stockItems = stockData.entries.map<Widget>((entry) {
                return GestureDetector(
                  onTap: () {
                    final stock = Stock(name: entry.key, price: entry.value);
                    _onStockTapped(stock);
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          entry.key,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 22 / 768 * height,
                            fontWeight: FontWeight.w600,
                            color: fg,
                          ),
                        ),
                        Text(
                          '   ₹${entry.value}',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 22 / 768 * height,
                            fontWeight: FontWeight.w600,
                            color: fg,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList();
            });
          },
          onDone: () {
            print('Connection closed by server.');
            socket?.destroy();
            setState(() {
              receivedData = "Disconnected, Attempting to reconnect.";
            });
            Future.delayed(const Duration(seconds: 2), () {
              _connectToServer();
            });
          },
          onError: (error) {
            print('Error: $error');
            Future.delayed(const Duration(seconds: 2), () {
              _connectToServer();
            });
          },
        );

        isConnecting = false;
        setState(() {});
      } catch (e) {
        print('Error: $e');
        Future.delayed(const Duration(seconds: 2), () {
          _connectToServer();
        });
      }
    }

    f(int fs, Color clr, FontWeight fw) {
      return SafeGoogleFont('Raleway',
          fontSize: fs / 768 * height, fontWeight: fw, color: clr);
    }

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: bg,
        child: Center(
          child: Column(
            children: <Widget>[
              const Text(
                'Stock Market Simulator:',
                style: TextStyle(fontSize: 42.0, fontWeight: FontWeight.w800),
              ),
              Column(
                children: stockItems,
              ),
              if (selectedStock != null)
                Text(
                  'Selected Stock: ${selectedStock!.name} - Price: ${selectedStock!.price}',
                  style: const TextStyle(
                      fontSize: 26.0, fontWeight: FontWeight.normal),
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
