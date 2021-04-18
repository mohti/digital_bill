import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../home.dart';

class Signupotp extends StatefulWidget {
  final String phone;
  Signupotp(this.phone);
  @override
  _SignupotpState createState() => _SignupotpState();
}

class _SignupotpState extends State<Signupotp>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  // ignore: unused_field
  Animation _animation;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _verifyPhone();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 300.0, end: 50.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();

  final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(242, 242, 242, 1),
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(
        color: const Color.fromRGBO(108, 99, 255, 1),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 5.0, // soften the shadow
          spreadRadius: 5.0, //extend the shadow
          offset: Offset(
            5.0, // Move to right 10  horizontally
            5.0, // Move to bottom 10 Vertically
          ),
        )
      ]);
  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      key: _scaffoldkey,
      body: Center(
        child: SingleChildScrollView(
            reverse: true,
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
                        reverse: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 2.0,
                                    left: 2,
                                    right: 2,
                                    bottom: bottom),
                                child: PinPut(
                                  onTap: () {},

                                  fieldsCount: 6,
                                  keyboardType: TextInputType.number,
                                  textStyle: const TextStyle(
                                      fontSize: 25.0, color: Colors.black),
                                  eachFieldWidth: 40.0,
                                  eachFieldHeight: 55.0,

                                  controller: _pinPutController,
                                  submittedFieldDecoration: pinPutDecoration,
                                  selectedFieldDecoration: pinPutDecoration,
                                  followingFieldDecoration: pinPutDecoration,
                                  //    eachFieldPadding: EdgeInsets.all(10),
                                  //   eachFieldMargin: EdgeInsets.all(0),
                                  pinAnimationType: PinAnimationType.fade,
                                  onSubmit: (pin) async {
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithCredential(
                                              PhoneAuthProvider.credential(
                                                  verificationId:
                                                      _verificationCode,
                                                  smsCode: pin))
                                          .then((value) async {
                                        if (value.user != null) {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Home(value.user.uid)),
                                              (route) => false);
                                        }
                                      });
                                    } catch (e) {
                                      FocusScope.of(context).unfocus();
                                      _scaffoldkey.currentState.showSnackBar(
                                          SnackBar(
                                              content: Text('invalid OTP')));
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.04,
                            ),
                          ],
                        ),
                      ),
                    ),
                    width: w * 1,
                    height: h * 375 / 870 + bottom,
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

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home(value.user.uid)),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }
}
