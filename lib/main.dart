import 'package:digitalbillbook/home.dart';
import 'package:digitalbillbook/plan/checkout.dart';
import 'package:digitalbillbook/plan/plandetails.dart';

import 'package:digitalbillbook/reports/report1.dart';
import 'package:digitalbillbook/settings/aboutus.dart';
import 'package:digitalbillbook/settings/acceptableusepolicy.dart';
import 'package:digitalbillbook/settings/invoicesettings.dart';
import 'package:digitalbillbook/settings/privacypolicy.dart';

import 'package:digitalbillbook/settings/termsofservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Invoicestyle.dart';
import 'Support.dart';
import 'signup_and_loginpages/signup.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/': (BuildContext context) => FirebaseAuth.instance.currentUser != null
            ? Home(FirebaseAuth.instance.currentUser.uid)
            : MyHomePage(),
        //   '/signupotp': (BuildContext context) => Signupotp(),

        './invoicesettings': (BuildContext context) => InvoiceSettings(),
        './AboutUs': (BuildContext context) => AboutUs(),
        './termsofservice': (BuildContext context) => TermsOfService(),
        './privacypolicy': (BuildContext context) => PrivacyPolicy(),
        './acceptableusepolicy.dart': (BuildContext context) =>
            AcceptableUsePolicy(),

        './plan.dart': (BuildContext context) => CurrentPlan(),
        './checkout': (BuildContext context) => Checkout(),
        './invoicestyle.dart': (BuildContext context) => InvoiceStyle(),
        './support': (BuildContext context) => Support(),
        './report1': (BuildContext context) => Report1(),
      },
    );
  }
}
