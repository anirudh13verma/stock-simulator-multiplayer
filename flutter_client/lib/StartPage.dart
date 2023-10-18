import 'package:flutter/material.dart';
import 'package:flutter_client/ClientPage.dart';
import 'utils.dart';

const Color bg = Color(0xff042a2b);
const Color fg = Color(0xffbbd686);

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  TextEditingController ipEntry = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(color: bg),
      child: Padding(
        padding: EdgeInsets.all(height * 0.05),
        child: Center(
          child: Column(
            children: [
              Text(
                'Stock Market Simulator',
                style: SafeGoogleFont(
                  'Raleway',
                  fontSize: 46 / 768 * height,
                  fontWeight: FontWeight.w800,
                  color: fg,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 1 / 5),
                child: Container(
                  decoration: const BoxDecoration(
                    color: fg,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  width: width * 3 / 5,
                  height: height * 2 / 5,
                  child: Padding(
                    padding: EdgeInsets.all(height / 20),
                    child: Column(
                      children: [
                        Text(
                          'Server Details',
                          style: SafeGoogleFont(
                            'Raleway',
                            fontSize: 38 / 768 * height,
                            fontWeight: FontWeight.w800,
                            color: bg,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(height / 25),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Server IP
                                Text(
                                  'Server IP: ',
                                  style: SafeGoogleFont(
                                    'Raleway',
                                    fontSize: 26 / 768 * height,
                                    fontWeight: FontWeight.w800,
                                    color: bg,
                                  ),
                                ),
                                Container(
                                  height: 44 /
                                      768 *
                                      height, // Specify a fixed height
                                  width: width * 0.2, // Specify a fixed width
                                  decoration: const BoxDecoration(
                                    color: bg,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(height * 0.006),
                                    child: TextField(
                                      controller: ipEntry,
                                      style: SafeGoogleFont(
                                        'Raleway',
                                        fontSize: 24 / 768 * height,
                                        fontWeight: FontWeight.w600,
                                        color: fg,
                                      ),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: "Enter Server IP",
                                        hintStyle: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 24 / 768 * height,
                                          fontWeight: FontWeight.w600,
                                          color: fg.withOpacity(0.7),
                                        ),
                                      ),
                                      showCursor: false,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: height / 15,
                          width: width * 0.15,
                          decoration: const BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyClient(
                                    ip: ipEntry.text,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "Connect",
                              style: SafeGoogleFont(
                                'Raleway',
                                fontSize: 24 / 768 * height,
                                fontWeight: FontWeight.w800,
                                color: fg,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
