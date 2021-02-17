import 'package:digitalbillbook/home.dart';
import 'package:digitalbillbook/settings/aboutus.dart';
import 'package:digitalbillbook/settings/acceptableusepolicy.dart';
import 'package:digitalbillbook/settings/invoicesettings.dart';
import 'package:digitalbillbook/settings/privacypolicy.dart';
import 'package:digitalbillbook/settings/settings.dart';
import 'package:digitalbillbook/settings/termsofservice.dart';
import 'package:flutter/material.dart';
import 'signup_and_loginpages/signup.dart';
import 'signup_and_loginpages/signup_otp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (BuildContext context) => MyHomePage(),
        '/signupotp': (BuildContext context) => Signupotp(),
        '/home': (BuildContext context) => Home(),
        './settings': (BuildContext context) => Settings(),
        './invoicesettings': (BuildContext context) => InvoiceSettings(),
        './AboutUs': (BuildContext context) => AboutUs(),
        './termsofservice': (BuildContext context) => TermsOfService(),
        './privacypolicy': (BuildContext context) => PrivacyPolicy(),
        './acceptableusepolicy.dart': (BuildContext context) =>
            AcceptableUsePolicy(),
      },
    );
  }
}
