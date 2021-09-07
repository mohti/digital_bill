import 'dart:async';

import 'package:digitalbillbook/signup_and_loginpages/signup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartingScreeen extends StatefulWidget {
  StartingScreeen({Key key}) : super(key: key);

  @override
  _StartingScreeenState createState() => _StartingScreeenState();
}

class _StartingScreeenState extends State<StartingScreeen> {
  Timer timer;
  var buttonIndex = 1;
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
      timer = Timer.periodic(Duration(seconds: 2), (Timer t) => setState(() => {
                        buttonIndex = buttonIndex + 1,
                        if (buttonIndex > 4)
                          {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()),
                                (route) => false)
                          }
                      }));

    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: 20,
              child: Container(
                child: Row(
                  children: [
                    Container(
                        width: 8,
                        height: 8,
                        child: Icon(buttonIndex == 1
                            ? Icons.lens_rounded
                            : Icons.radio_button_off)),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 8,
                        height: 8,
                        child: Icon(buttonIndex == 2
                            ? Icons.lens_rounded
                            : Icons.radio_button_off)),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 8,
                        height: 8,
                        child: Icon(buttonIndex == 3
                            ? Icons.lens_rounded
                            : Icons.radio_button_off)),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 8,
                        height: 8,
                        child: Icon(buttonIndex == 4
                            ? Icons.lens_rounded
                            : Icons.radio_button_off)),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: buttonIndex == 1
                  ? Image.asset('assets/images/screen1.png')
                  : buttonIndex == 2
                      ? Image.asset('assets/images/screen2.png')
                      : buttonIndex == 3
                          ? Image.asset('assets/images/screen3.png')
                          : Image.asset('assets/images/screen4.png'),
            ),
              Positioned(
              top: 20,
              right: 30,
              child: InkWell(
                onTap: () => {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                      (route) => false),
                },
              
                child: Container(
                  width: 50,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  //  color: Colors.white70,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text('Skip'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 20,
              child: InkWell(
                onTap: () => {
                  setState(() => {
                        buttonIndex = buttonIndex + 1,
                        if (buttonIndex > 4)
                          {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()),
                                (route) => false)
                          }
                      })
                },
                child: Container(
                  width: 184,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text('GET STARTED'),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Icon(Icons.arrow_forward_rounded)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
