import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Signupotp extends StatefulWidget {
  Signupotp();

  @override
  _SignupotpState createState() => _SignupotpState();
}

class _SignupotpState extends State<Signupotp> {
  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            Container(
              width: w * 1,
              height: h * 1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/bg1.jpg'),
                  fit: BoxFit.fitHeight,
                ),
                //   border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: h * 0.025,
                        ),
                        Text(
                          'Welcome To! Digital Bill Book',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 24,
                            color: const Color(0xff2f2e41),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: h * 0.01,
                        ),
                        Text(
                          'Enter 6 Digit OTP',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 16,
                            color: const Color(0x992f2e41),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Container(
                          width: 300,
                          child: PinCodeTextField(
                            length: 5,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 50,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                            ),
                            animationDuration: Duration(milliseconds: 300),
                            backgroundColor: const Color(0xfff1f3f6),
                            enableActiveFill: true,
                            onCompleted: (v) {
                              print("Completed");
                            },
                            onChanged: (value) {},
                          ),
                        ),
                        SizedBox(
                          height: h * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 12,
                                  color: const Color(0xff8a9ead),
                                  letterSpacing: 0.30000000000000004,
                                  height: 1.5,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Already have an account? \n',
                                  ),
                                  TextSpan(
                                    text: 'SIGN IN',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: const Color(0xff1d1a2f),
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 120.0,
                              height: 50.0,
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: const Color(0xd902020a),
                                      border: Border.all(
                                          width: 1.0,
                                          color: const Color(0xd93f3d56)),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/home');
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'SignUp',
                                          style: TextStyle(
                                            fontFamily: 'Bell MT',
                                            fontSize: 15,
                                            color: const Color(0xe5dde8f8),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                width: w * 1,
                height: h * 375 / 870,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.0),
                    topRight: Radius.circular(45.0),
                  ),
                  color: const Color(0xfff1f3f6),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x66000000),
                      offset: Offset(3, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            )
          ])
        ])),
      ),
    );
  }
}
