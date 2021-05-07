import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalbillbook/models/paymentdetails.dart';
import 'package:digitalbillbook/models/plandetails.dart';
import 'package:flutter/material.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class RazorPayHandler extends StatefulWidget {
  final int amount;
  final Duration duration;
  final String planName;
  final String uid;
  final int ewaybillno;
  RazorPayHandler(
      this.amount, this.duration, this.planName, this.uid, this.ewaybillno);
  @override
  _RazorPayHandlerState createState() => _RazorPayHandlerState();
}

class Order {
// ignore: non_constant_identifier_names
  final id;
  final entity;
  final amount;
  // ignore: non_constant_identifier_names
  final amount_paid;
  // ignore: non_constant_identifier_names
  final amount_due;
  final currency;
  final receipt;
  final status;
  final attempts;
  final notes;
  // ignore: non_constant_identifier_names
  final created_at;
  // ignore: non_constant_identifier_names
  Order({
    this.id,
    this.entity,
    this.amount,
    // ignore: non_constant_identifier_names
    this.amount_paid,
    // ignore: non_constant_identifier_names
    this.amount_due,
    this.currency,
    this.receipt,
    this.status,
    this.attempts,
    this.notes,
    // ignore: non_constant_identifier_names
    this.created_at,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json["id"],
        entity: json["id"],
        amount: json["id"],
        amount_paid: json["id"],
        amount_due: json["id"],
        currency: json["id"],
        receipt: json["id"],
        status: json["id"],
        attempts: json["id"],
        notes: json["id"],
        created_at: json["id"]);
  }
}

class _RazorPayHandlerState extends State<RazorPayHandler> {
  Razorpay _razorpay;
  Order responsecode;
  Future<Null> createorder() async {
    var uname = 'GTyl9nfonM0SWB';
    var pword = 'rzp_test_1LoeDlDiKL242P';
    var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));

    var headers = {
      'content-type': 'application/json',
      'Authorization': authn,
    };

    var data = jsonEncode(
        {"amount": widget.amount, "currency": "INR", "receipt": "rcptid_11"});

    var res = await http.post('https://api.razorpay.com/v1/orders',
        headers: headers, body: data);
    print(res.body);
    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    responsecode = Order.fromJson(jsonDecode(res.body));
    print(res.body);
  }

  PlanDetails _plandetails = PlanDetails(null, null, null, null, null);
  PaymentDetails _paymentDetails = PaymentDetails(null, null, null);
  final db = FirebaseFirestore.instance;
  Future<void> uploadInfoTofirebase() {
    _plandetails.d = DateTime.now().add(widget.duration);
    _plandetails.planName = widget.planName;
    _plandetails.remainingewaybill = widget.ewaybillno;
    _plandetails.remaininginvoices = widget.ewaybillno;
    _plandetails.sdate = DateTime.now();
    // Call the user's CollectionReference to add a new user
    return db
        .collection("userData")
        .doc(widget.uid)
        .collection("planDetails")
        .doc('plan')
        .set(_plandetails.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[])),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    //createorder();
    openCheckout();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_1LoeDlDiKL242P',
      'amount': widget.amount,
      'name': widget.planName,
      // 'order_id': responsecode.id,
      'description': '',
      'prefill': {},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
    uploadInfoTofirebase();

    _paymentDetails.razorpay_order_id = response.orderId;
    _paymentDetails.razorpay_payment_id = response.paymentId;
    _paymentDetails.razorpay_signature = response.signature;
    // Call the user's CollectionReference to add a new user
    db
        .collection("userData")
        .doc(widget.uid)
        .collection("plan")
        .doc("paymentDetails")
        .set(_paymentDetails.toJson());
    Navigator.pop(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
    Navigator.pop(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
    Navigator.pop(context);
  }
}
