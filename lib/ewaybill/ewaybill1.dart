import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:digitalbillbook/models/invoicemodel.dart';
import 'package:digitalbillbook/models/items.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class Access_token {
// ignore: non_constant_identifier_names
  final String access_token;
// ignore: non_constant_identifier_names
  final expires_in;
// ignore: non_constant_identifier_names
  final String token_type;

  // ignore: non_constant_identifier_names
  Access_token({this.access_token, this.expires_in, this.token_type});

  factory Access_token.fromJson(Map<String, dynamic> json) {
    return Access_token(
        access_token: json['access_token'],
        expires_in: json['expires_in'],
        token_type: json['token_type']);
  }
}

class GetUrl {
// ignore: non_constant_identifier_names
  final String url;

  // ignore: non_constant_identifier_names
  GetUrl({this.url});

  factory GetUrl.fromJson(Map<String, dynamic> json) {
    return GetUrl(url: json['results']['message']['url']);
  }
}

class GetEwayBIllno {
// ignore: non_constant_identifier_names
  final int ewaybillno;

  // ignore: non_constant_identifier_names
  GetEwayBIllno({this.ewaybillno});

  factory GetEwayBIllno.fromJson(Map<String, dynamic> json) {
    return GetEwayBIllno(ewaybillno: json['results']['message']["ewayBillNo"]);
  }
}

class Ewaybill1 extends StatefulWidget {
  final String uid;
  Ewaybill1(this.uid);

  @override
  _Ewaybill1State createState() => _Ewaybill1State();
}

class Accesstoken {
  final String accesstoken;
  final String expiresin;
  final String tokentype;
  Accesstoken({this.accesstoken, this.expiresin, this.tokentype});

  factory Accesstoken.fromJson(Map<String, dynamic> json) {
    return Accesstoken(
        accesstoken: json["access_token"],
        expiresin: json["expires_in"],
        tokentype: json["token_type"]);
  }
}

Access_token responsedecode;

class _Ewaybill1State extends State<Ewaybill1> {
  final ewaybillController = TextEditingController();
  Future<Null> createAccessToken() async {
    try {
      final response = await http.post(
        Uri.parse('https://clientbasic.mastersindia.co/oauth/access_token'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<dynamic, dynamic>{
          "username": "testeway@mastersindia.co",
          "password": "!@#Demo!@#123",
          "client_id": "fIXefFyxGNfDWOcCWnj",
          "client_secret": "QFd6dZvCGqckabKxTapfZgJc",
          "grant_type": "password"
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        responsedecode = Access_token.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    createAccessToken();

    super.initState();
  }

  Future<Null> createFile(String url1, String fileName) async {
    try {
      /// setting filename
      final filename = fileName;

      /// getting application doc directory's path in dir variable
      String dir = (await getApplicationDocumentsDirectory()).path;

      /// if `filename` File exists in local system then return that file.
      /// This is the fastest among all.
      if (await File('$dir/$filename').exists()) return File('$dir/$filename');

      ///if file not present in local system then fetch it from server

      String url = url1 + '.pdf';

      /// requesting http to get url
      var request = await HttpClient().getUrl(Uri.parse(url));

      /// closing request and getting response
      var response = await request.close();

      /// getting response data in bytes
      var bytes = await consolidateHttpClientResponseBytes(response);

      /// generating a local system file with name as 'filename' and path as '$dir/$filename'
      File file = new File('$dir/$filename');

      /// writing bytes data of response in the file.
      await file.writeAsBytes(bytes);

      /// returning file.

    }

    /// on catching Exception return null
    catch (err) {
      print(err);
      return null;
    }
  }

  Future<Accesstoken> _accestoken;
  @override
  Widget build(BuildContext context) {
    String _businessNameController;
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final gstNumberController = TextEditingController();
    final businesAddressController = TextEditingController();
    final bankNameController = TextEditingController();
    final ifscCodeController = TextEditingController();
    final accountNumberController = TextEditingController();
    final branchNameController = TextEditingController();
    final invoiceno1 = TextEditingController();
    final bname = TextEditingController();
    final bphone = TextEditingController();
    final bgstn = TextEditingController();
    final bcity = TextEditingController();
    final bstate = TextEditingController();
    final bcountry = TextEditingController();
    final bpin = TextEditingController();
    final sname = TextEditingController();
    final sphone = TextEditingController();
    final sgstn = TextEditingController();
    DateTime sdate;
    final scity = TextEditingController();
    final sstate = TextEditingController();
    final scountry = TextEditingController();
    final spin = TextEditingController();
    final productCode = TextEditingController();
    final productName = TextEditingController();
    final hsncode = TextEditingController();
    final taxrate = TextEditingController();
    final quantity = TextEditingController();
    final unit = TextEditingController();
    final sellingrate = TextEditingController();
    final taxamount = TextEditingController();
    final transporterid = TextEditingController();
    final transportername = TextEditingController();
    final tracnsportdocno = TextEditingController();
    final tdate = TextEditingController();
    final vehiclemode = TextEditingController();
    final vehicleno = TextEditingController();
    final from = TextEditingController();
    final invoicedetails = new InvoiceModel(
        '',
        '',
        ' ',
        ' ',
        ' ',
        DateTime.now(),
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        DateTime.now(),
        ' ',
        ' ',
        ' ',
        ' ',
        null,
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        null,
        null,
        null,
        null,
        null);

    List<Map<String, dynamic>> l = [];

    final db = FirebaseFirestore.instance;
    Future<Null> _getBusinessDetails(String uid) async {
      await db
          .collection("userData")
          .doc(uid)
          .collection("BusinessInfo")
          .doc('businessName')
          .get()
          .then((valuee) {
        setState(() {
          bankNameController.text = valuee.data()['bankName'] == null
              ? ''
              : valuee.data()['bankName'];
          accountNumberController.text = valuee.data()['accountNumber'] == null
              ? ''
              : valuee.data()['accountNumber'];
          ifscCodeController.text = valuee.data()['ifscCode'] == null
              ? ''
              : valuee.data()['ifscCode'];

          branchNameController.text = valuee.data()['branchName'] == null
              ? ''
              : valuee.data()['branchName'];
          _businessNameController = valuee.data()['businessName'] == null
              ? ''
              : valuee.data()['businessName'];
          businesAddressController.text =
              valuee.data()['businessAddress'] == null
                  ? ''
                  : valuee.data()['businessAddress'];
          gstNumberController.text = valuee.data()['gstNumber'] == null
              ? ''
              : valuee.data()['gstNumber'];
          emailController.text =
              valuee.data()['email'] == null ? '' : valuee.data()['email'];
          phoneController.text =
              valuee.data()['phone'] == null ? '' : valuee.data()['phone'];
        });
      });
    }

    Timestamp timestamp;
    Future<Null> downloadFile(String url, String fileName, String dir) async {
      HttpClient httpClient = new HttpClient();
      File file;
      String filePath = '';
      String myUrl = '';
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      try {
        myUrl = url + '.pdf';
        var request = await httpClient.getUrl(Uri.parse(myUrl));
        var response = await request.close();
        if (response.statusCode == 200) {
          var bytes = await consolidateHttpClientResponseBytes(response);
          filePath = '$appDocPath/$fileName.pdf';
          file = File(filePath);
          await file.writeAsBytes(bytes);
        } else
          filePath = 'Error code: ' + response.statusCode.toString();
      } catch (ex) {
        filePath = 'Can not fetch url';
      }
      print(filePath);
    }

    double totalquantity = 0, totalamount = 0;
    List<Items> items1 = [];
    int ewaybillno;
    Future<Null> _tocanceWaylBill() async {
      await db
          .collection("userData")
          .doc(widget.uid)
          .collection("Invoice")
          .doc(ewaybillController.text.toString())
          .get()
          .then((valuee) {
        setState(() {
          invoiceno1.text = valuee.data()['invoiceno'] == null
              ? ''
              : valuee.data()['invoiceno'];

          bname.text =
              valuee.data()['bname'] == null ? '' : valuee.data()['bname'];
          bphone.text =
              valuee.data()['bphone'] == null ? '' : valuee.data()['bphone'];
          bcity.text =
              valuee.data()['bcity'] == null ? '' : valuee.data()['bcity'];
          bstate.text =
              valuee.data()['bstate'] == null ? '' : valuee.data()['bstate'];
          scity.text =
              valuee.data()['scity;'] == null ? '' : valuee.data()['scity;'];
          sstate.text =
              valuee.data()['sstate'] == null ? '' : valuee.data()['sstate'];
          bpin.text =
              valuee.data()['bpin'] == null ? '' : valuee.data()['bpin'];
          bgstn.text =
              valuee.data()['bgstn'] == null ? '' : valuee.data()['bgstn'];
          sname.text =
              valuee.data()['sname'] == null ? '' : valuee.data()['sname'];
          sphone.text =
              valuee.data()['sphone'] == null ? '' : valuee.data()['sphone'];
          transportername.text = valuee.data()['transportername'] == null
              ? ''
              : valuee.data()['transportername'];
          spin.text =
              valuee.data()['spin'] == null ? '' : valuee.data()['spin'];
          transporterid.text = valuee.data()['transporterid'] == null
              ? ''
              : valuee.data()['transporterid'];
          tracnsportdocno.text = valuee.data()['transporterdocno'] == null
              ? ''
              : valuee.data()['transporterdocno'];
          tdate.text = valuee.data()['tdate'];
          sgstn.text =
              valuee.data()['sgstn'] == null ? '' : valuee.data()['sgstn'];
          timestamp = (valuee.data()['sdate']) as Timestamp;
          sdate = timestamp.toDate();

          vehiclemode.text = valuee.data()['vehiclemode'] == null
              ? ''
              : valuee.data()['vehiclemode'];
          vehicleno.text = valuee.data()['vehicleno'] == null
              ? ''
              : valuee.data()['vehicleno'];
          l = List.castFrom(valuee.data()['listOfProducts']);
        });
      });

      l.forEach((element) {
        setState(() {
          totalquantity =
              totalquantity + double.parse(element['quantity'].toString());
          totalamount =
              totalamount + double.parse(element['totalamount'].toString());
        });
      });
      db
          .collection("userData")
          .doc(widget.uid)
          .collection("BusinessInfo")
          .doc('businessName')
          .get()
          .then((valuee) {
        setState(() {
          bankNameController.text = valuee.data()['bankName'] == null
              ? ''
              : valuee.data()['bankName'];
          accountNumberController.text = valuee.data()['accountNumber'] == null
              ? ''
              : valuee.data()['accountNumber'];
          ifscCodeController.text = valuee.data()['ifscCode'] == null
              ? ''
              : valuee.data()['ifscCode'];

          branchNameController.text = valuee.data()['branchName'] == null
              ? ''
              : valuee.data()['branchName'];
          _businessNameController = valuee.data()['businessName'] == null
              ? ''
              : valuee.data()['businessName'];
          businesAddressController.text =
              valuee.data()['businessAddress'] == null
                  ? ''
                  : valuee.data()['businessAddress'];
          gstNumberController.text = valuee.data()['gstNumber'] == null
              ? ''
              : valuee.data()['gstNumber'];
          emailController.text =
              valuee.data()['email'] == null ? '' : valuee.data()['email'];
          phoneController.text =
              valuee.data()['phone'] == null ? '' : valuee.data()['phone'];
        });
      });

      List items = [];

      l.forEach((element) {
        setState(() {
          items.add({
            "product_name": element['productName'],
            "product_description": element['productCode'],
            "hsn_code": '1001', // element['hsncode'],
            "unit_of_product": 'BOX', //element['unit'],
            "cgst_rate": 9,
            "sgst_rate": 9,
            "igst_rate": 0,
            "cess_rate": 0,
            "quantity": 9, //int.tryParse(element['quantity']),
            "cessNonAdvol": 0,
            "taxable_amount": 9, // int.tryParse(element['totalamount'])*/
          });
        });
      });
      try {
        (int.parse(spin.text));
      } on FormatException {
        Fluttertoast.showToast(msg: 'Invalid Pincode', timeInSecForIosWeb: 4);
      }
      try {
        final response = await http.post(
          Uri.parse('https://clientbasic.mastersindia.co/ewayBillsGenerate'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<dynamic, dynamic>{
            "access_token": responsedecode.access_token,
            "userGstin": gstNumberController.text,
            "supply_type": "outward",
            "sub_supply_type": "Others",
            "sub_supply_description": "sales from other country",
            "document_type": "tax invoice",
            "document_number": invoiceno1.text,
            "document_date": DateFormat('dd/MM/yyyy').format(sdate).toString(),
            "gstin_of_consignor": "05AAABB0639G1Z8 ", //sgstn.text,
            "legal_name_of_consignor": bname.text.toString() == ''
                ? _businessNameController.toString()
                : bname.text.toString(),
            "address1_of_consignor": bcity.text.toString() == ''
                ? businesAddressController.text.toString()
                : bcity.text.toString(),
            "address2_of_consignor": '',
            "place_of_consignor": bcity.text.toString() == ''
                ? businesAddressController.text.toString()
                : bcity.text.toString(),
            "pincode_of_consignor": bpin.text == ''
                ? int.parse(spin.text)
                : int.tryParse(bpin.text),
            "state_of_consignor": bstate.text == '' ? sstate.text : sstate.text,
            "actual_from_state_name":
                bstate.text == '' ? sstate.text : sstate.text,
            "gstin_of_consignee":
                "05AAABC0181E1ZE ", //  bgstn.text == '' ? gstNumberController.text : bgstn.text,
            "legal_name_of_consignee": sname.text.toString(),
            "address1_of_consignee": scity.text.toString(),
            "address2_of_consignee": scity.text.toString(),
            "place_of_consignee": scity.text.toString(),
            "pincode_of_consignee": int.parse(spin.text),
            "state_of_supply": sstate.text,
            "actual_to_state_name": sstate.text,
            "transaction_type": 1,
            "other_value": 0.00,
            "total_invoice_value": (totalamount * 118 / 100),
            "taxable_amount": totalamount.toInt(),
            "cgst_amount": 0.00,
            "sgst_amount": 0.00,
            "igst_amount": 0,
            "cess_amount": 0,
            "cess_nonadvol_value": 0,
            "transporter_id": transporterid.text,
            "transporter_name": transportername.text,
            "transporter_document_number": tracnsportdocno.text,
            "transporter_document_date": tdate.text,
            "transportation_mode": 'road',
            "transportation_distance": '0',

            "vehicle_number": vehicleno.text,
            "vehicle_type": "Regular",
            "generate_status": 1,
            "data_source": "erp",
            "user_ref": "1232435466sdsf234",
            "location_code": "XYZ",
            "eway_bill_status": "ABC",
            "auto_print": "Y",
            "email": emailController.text,
            "itemList": items
          }),
        );
        print(response.statusCode);

        print(bname.text.toString());
        if (response.statusCode == 201 || response.statusCode == 200) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          print(response.body);
          Fluttertoast.showToast(
              msg: response.statusCode.toString() + " - " + response.body,
              timeInSecForIosWeb: 4);
          print(response.statusCode);
          GetEwayBIllno g;
          g = GetEwayBIllno.fromJson(jsonDecode(response.body));
          print(g.ewaybillno);

          if (g.ewaybillno != null) {
            setState(() {
              ewaybillno = g.ewaybillno;
            });

            //   downloadFile(g.url, 'ewaybill' + invoiceno1.text, null);
            // createFile(g.url, 'ewaybill' + invoiceno1.text);

            /*      Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TestViewEwayBill(g.url)));
      */
          }
          //print(jsonDecode(response.body).cast<Map<String, dynamic>>().map<Photo>((json) => Photo.fromJson(json)));
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          throw Exception('Failed to load album');
        }
      } catch (e) {
        print(e);
        print('error');
      }
    }

    Future<Null> _cancelEwayBill() async {
      await db
          .collection("userData")
          .doc(widget.uid)
          .collection("Invoice")
          .doc(ewaybillController.text.toString())
          .get()
          .then((valuee) {
        setState(() {
          invoiceno1.text = valuee.data()['invoiceno'] == null
              ? ''
              : valuee.data()['invoiceno'];

          bname.text =
              valuee.data()['bname'] == null ? '' : valuee.data()['bname'];
          bphone.text =
              valuee.data()['bphone'] == null ? '' : valuee.data()['bphone'];
          bcity.text =
              valuee.data()['bcity'] == null ? '' : valuee.data()['bcity'];
          bstate.text =
              valuee.data()['bstate'] == null ? '' : valuee.data()['bstate'];
          scity.text =
              valuee.data()['scity;'] == null ? '' : valuee.data()['scity;'];
          sstate.text =
              valuee.data()['sstate'] == null ? '' : valuee.data()['sstate'];
          bpin.text =
              valuee.data()['bpin'] == null ? '' : valuee.data()['bpin'];
          bgstn.text =
              valuee.data()['bgstn'] == null ? '' : valuee.data()['bgstn'];
          sname.text =
              valuee.data()['sname'] == null ? '' : valuee.data()['sname'];
          sphone.text =
              valuee.data()['sphone'] == null ? '' : valuee.data()['sphone'];
          transportername.text = valuee.data()['transportername'] == null
              ? ''
              : valuee.data()['transportername'];
          spin.text =
              valuee.data()['spin'] == null ? '' : valuee.data()['spin'];
          transporterid.text = valuee.data()['transporterid'] == null
              ? ''
              : valuee.data()['transporterid'];
          tracnsportdocno.text = valuee.data()['transporterdocno'] == null
              ? ''
              : valuee.data()['transporterdocno'];
          tdate.text = valuee.data()['tdate'];
          sgstn.text =
              valuee.data()['sgstn'] == null ? '' : valuee.data()['sgstn'];
          timestamp = (valuee.data()['sdate']) as Timestamp;
          sdate = timestamp.toDate();

          vehiclemode.text = valuee.data()['vehiclemode'] == null
              ? ''
              : valuee.data()['vehiclemode'];
          vehicleno.text = valuee.data()['vehicleno'] == null
              ? ''
              : valuee.data()['vehicleno'];
          l = List.castFrom(valuee.data()['listOfProducts']);
        });
      });

      l.forEach((element) {
        setState(() {
          totalquantity =
              totalquantity + double.parse(element['quantity'].toString());
          totalamount =
              totalamount + double.parse(element['totalamount'].toString());
        });
      });
      db
          .collection("userData")
          .doc(widget.uid)
          .collection("BusinessInfo")
          .doc('businessName')
          .get()
          .then((valuee) {
        setState(() {
          bankNameController.text = valuee.data()['bankName'] == null
              ? ''
              : valuee.data()['bankName'];
          accountNumberController.text = valuee.data()['accountNumber'] == null
              ? ''
              : valuee.data()['accountNumber'];
          ifscCodeController.text = valuee.data()['ifscCode'] == null
              ? ''
              : valuee.data()['ifscCode'];

          branchNameController.text = valuee.data()['branchName'] == null
              ? ''
              : valuee.data()['branchName'];
          _businessNameController = valuee.data()['businessName'] == null
              ? ''
              : valuee.data()['businessName'];
          businesAddressController.text =
              valuee.data()['businessAddress'] == null
                  ? ''
                  : valuee.data()['businessAddress'];
          gstNumberController.text = valuee.data()['gstNumber'] == null
              ? ''
              : valuee.data()['gstNumber'];
          emailController.text =
              valuee.data()['email'] == null ? '' : valuee.data()['email'];
          phoneController.text =
              valuee.data()['phone'] == null ? '' : valuee.data()['phone'];
        });
      });

      List items = [];

      l.forEach((element) {
        setState(() {
          items.add({
            "product_name": element['productName'],
            "product_description": element['productCode'],
            "hsn_code": '1001', // element['hsncode'],
            "unit_of_product": 'BOX', //element['unit'],
            "cgst_rate": 9,
            "sgst_rate": 9,
            "igst_rate": 0,
            "cess_rate": 0,
            "quantity": 9, //int.tryParse(element['quantity']),
            "cessNonAdvol": 0,
            "taxable_amount": 9, // int.tryParse(element['totalamount'])*/
          });
        });
      });
      try {
        (int.parse(spin.text));
      } on FormatException {
        Fluttertoast.showToast(msg: 'Invalid Pincode', timeInSecForIosWeb: 4);
      }
      try {
        final response = await http.post(
          Uri.parse('https://clientbasic.mastersindia.co/ewayBillCancel'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<dynamic, dynamic>{
            "access_token": responsedecode.access_token,
            "userGstin": gstNumberController.text,
            "eway_bill_number": ewaybillno,
            "reason_of_cancel": "Others",
            "cancel_remark": "Cancelled the order",
            "data_source": "erp"
          }),
        );
        print(response.statusCode);

        print(bname.text.toString());
        if (response.statusCode == 201 || response.statusCode == 200) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          print(response.body);
          Fluttertoast.showToast(
              msg: response.statusCode.toString() + " - " + response.body,
              timeInSecForIosWeb: 4);
          Fluttertoast.showToast(
              msg: "Eway Bill Cancel Generate again within 48 hrs",
              timeInSecForIosWeb: 4);

          //print(jsonDecode(response.body).cast<Map<String, dynamic>>().map<Photo>((json) => Photo.fromJson(json)));
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          throw Exception('Failed to load album');
        }
      } catch (e) {
        print(e);
        print('error');
      }
    }

    Future<Null> _invoicedetails() async {
      await db
          .collection("userData")
          .doc(widget.uid)
          .collection("Invoice")
          .doc(ewaybillController.text.toString())
          .get()
          .then((valuee) {
        setState(() {
          invoiceno1.text = valuee.data()['invoiceno'] == null
              ? ''
              : valuee.data()['invoiceno'];

          bname.text =
              valuee.data()['bname'] == null ? '' : valuee.data()['bname'];
          bphone.text =
              valuee.data()['bphone'] == null ? '' : valuee.data()['bphone'];
          bcity.text =
              valuee.data()['bcity'] == null ? '' : valuee.data()['bcity'];
          bstate.text =
              valuee.data()['bstate'] == null ? '' : valuee.data()['bstate'];
          scity.text =
              valuee.data()['scity;'] == null ? '' : valuee.data()['scity;'];
          sstate.text =
              valuee.data()['sstate'] == null ? '' : valuee.data()['sstate'];
          bpin.text =
              valuee.data()['bpin'] == null ? '' : valuee.data()['bpin'];
          bgstn.text =
              valuee.data()['bgstn'] == null ? '' : valuee.data()['bgstn'];
          sname.text =
              valuee.data()['sname'] == null ? '' : valuee.data()['sname'];
          sphone.text =
              valuee.data()['sphone'] == null ? '' : valuee.data()['sphone'];
          transportername.text = valuee.data()['transportername'] == null
              ? ''
              : valuee.data()['transportername'];
          spin.text =
              valuee.data()['spin'] == null ? '' : valuee.data()['spin'];
          transporterid.text = valuee.data()['transporterid'] == null
              ? ''
              : valuee.data()['transporterid'];
          tracnsportdocno.text = valuee.data()['transporterdocno'] == null
              ? ''
              : valuee.data()['transporterdocno'];
          tdate.text = valuee.data()['tdate'];
          sgstn.text =
              valuee.data()['sgstn'] == null ? '' : valuee.data()['sgstn'];
          timestamp = (valuee.data()['sdate']) as Timestamp;
          sdate = timestamp.toDate();

          vehiclemode.text = valuee.data()['vehiclemode'] == null
              ? ''
              : valuee.data()['vehiclemode'];
          vehicleno.text = valuee.data()['vehicleno'] == null
              ? ''
              : valuee.data()['vehicleno'];
          l = List.castFrom(valuee.data()['listOfProducts']);
        });
      });

      l.forEach((element) {
        setState(() {
          totalquantity =
              totalquantity + double.parse(element['quantity'].toString());
          totalamount =
              totalamount + double.parse(element['totalamount'].toString());
        });
      });
      db
          .collection("userData")
          .doc(widget.uid)
          .collection("BusinessInfo")
          .doc('businessName')
          .get()
          .then((valuee) {
        setState(() {
          bankNameController.text = valuee.data()['bankName'] == null
              ? ''
              : valuee.data()['bankName'];
          accountNumberController.text = valuee.data()['accountNumber'] == null
              ? ''
              : valuee.data()['accountNumber'];
          ifscCodeController.text = valuee.data()['ifscCode'] == null
              ? ''
              : valuee.data()['ifscCode'];

          branchNameController.text = valuee.data()['branchName'] == null
              ? ''
              : valuee.data()['branchName'];
          _businessNameController = valuee.data()['businessName'] == null
              ? ''
              : valuee.data()['businessName'];
          businesAddressController.text =
              valuee.data()['businessAddress'] == null
                  ? ''
                  : valuee.data()['businessAddress'];
          gstNumberController.text = valuee.data()['gstNumber'] == null
              ? ''
              : valuee.data()['gstNumber'];
          emailController.text =
              valuee.data()['email'] == null ? '' : valuee.data()['email'];
          phoneController.text =
              valuee.data()['phone'] == null ? '' : valuee.data()['phone'];
        });
      });

      List items = [];

      l.forEach((element) {
        setState(() {
          items.add({
            "product_name": element['productName'],
            "product_description": element['productCode'],
            "hsn_code": '1001', // element['hsncode'],
            "unit_of_product": 'BOX', //element['unit'],
            "cgst_rate": 9,
            "sgst_rate": 9,
            "igst_rate": 0,
            "cess_rate": 0,
            "quantity": 9, //int.tryParse(element['quantity']),
            "cessNonAdvol": 0,
            "taxable_amount": 9, // int.tryParse(element['totalamount'])*/
          });
        });
      });
      try {
        (int.parse(spin.text));
      } on FormatException {
        Fluttertoast.showToast(msg: 'Invalid Pincode', timeInSecForIosWeb: 4);
      }
      try {
        final response = await http.post(
          Uri.parse('https://clientbasic.mastersindia.co/ewayBillsGenerate'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<dynamic, dynamic>{
            "access_token": responsedecode.access_token,
            "userGstin": gstNumberController.text,
            "supply_type": "outward",
            "sub_supply_type": "Others",
            "sub_supply_description": "sales from other country",
            "document_type": "tax invoice",
            "document_number": invoiceno1.text,
            "document_date": DateFormat('dd/MM/yyyy').format(sdate).toString(),
            "gstin_of_consignor": "05AAABB0639G1Z8 ", //sgstn.text,
            "legal_name_of_consignor": bname.text.toString() == ''
                ? _businessNameController.toString()
                : bname.text.toString(),
            "address1_of_consignor": bcity.text.toString() == ''
                ? businesAddressController.text.toString()
                : bcity.text.toString(),
            "address2_of_consignor": '',
            "place_of_consignor": bcity.text.toString() == ''
                ? businesAddressController.text.toString()
                : bcity.text.toString(),
            "pincode_of_consignor": bpin.text == ''
                ? int.parse(spin.text)
                : int.tryParse(bpin.text),
            "state_of_consignor": bstate.text == '' ? sstate.text : sstate.text,
            "actual_from_state_name":
                bstate.text == '' ? sstate.text : sstate.text,
            "gstin_of_consignee":
                "05AAABC0181E1ZE ", //  bgstn.text == '' ? gstNumberController.text : bgstn.text,
            "legal_name_of_consignee": sname.text.toString(),
            "address1_of_consignee": scity.text.toString(),
            "address2_of_consignee": scity.text.toString(),
            "place_of_consignee": scity.text.toString(),
            "pincode_of_consignee": int.parse(spin.text),
            "state_of_supply": sstate.text,
            "actual_to_state_name": sstate.text,
            "transaction_type": 1,
            "other_value": 0.00,
            "total_invoice_value": (totalamount * 118 / 100),
            "taxable_amount": totalamount.toInt(),
            "cgst_amount": 0.00,
            "sgst_amount": 0.00,
            "igst_amount": 0,
            "cess_amount": 0,
            "cess_nonadvol_value": 0,
            "transporter_id": transporterid.text,
            "transporter_name": transportername.text,
            "transporter_document_number": tracnsportdocno.text,
            "transporter_document_date": tdate.text,
            "transportation_mode": 'road',
            "transportation_distance": '0',

            "vehicle_number": vehicleno.text,
            "vehicle_type": "Regular",
            "generate_status": 1,
            "data_source": "erp",
            "user_ref": "1232435466sdsf234",
            "location_code": "XYZ",
            "eway_bill_status": "ABC",
            "auto_print": "Y",
            "email": emailController.text,
            "itemList": items
          }),
        );
        print(response.statusCode);

        print(bname.text.toString());
        if (response.statusCode == 201 || response.statusCode == 200) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          print(response.body);
          Fluttertoast.showToast(
              msg: response.statusCode.toString() + " - " + response.body,
              timeInSecForIosWeb: 4);
          print(response.statusCode);
          GetUrl g;
          g = GetUrl.fromJson(jsonDecode(response.body));
          print(g.url);
          Future<void> _launchInBrowser(String url) async {
            if (await canLaunch(url)) {
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
                headers: <String, String>{'my_header_key': 'my_header_value'},
              );
            } else {
              throw 'Could not launch $url';
            }
          }

          if (g.url != null) {
            //   downloadFile(g.url, 'ewaybill' + invoiceno1.text, null);
            // createFile(g.url, 'ewaybill' + invoiceno1.text);
            _launchInBrowser('http://' + g.url);
            /*      Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TestViewEwayBill(g.url)));
      */
          }
          //print(jsonDecode(response.body).cast<Map<String, dynamic>>().map<Photo>((json) => Photo.fromJson(json)));
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          throw Exception('Failed to load album');
        }
      } catch (e) {
        print(e);
        print('error');
      }
    }

    /*  Future<Null> generateewaybill() async {
      _invoicedetails();
      try {
        final response = await http.post(
          Uri.parse('https://clientbasic.mastersindia.co/ewayBillsGenerate'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<dynamic, dynamic>{
            "access_token": responsedecode.access_token,
            "userGstin": '05AAABB0639G1Z8',
            "supply_type": "outward",
            "sub_supply_type": "Others",
            "sub_supply_description": "sales from other country",
            "document_type": "tax invoice",
            "document_number": '130q30',
            "document_date": sdate.toString(),
            "gstin_of_consignor": "05AAABB0639G1Z8 ", //sgstn.text,
            "legal_name_of_consignor": bname.text.toString() == ''
                ? _businessNameController.toString()
                : bname.text.toString(),
            "address1_of_consignor": bcity.text.toString() == ''
                ? businesAddressController.text.toString()
                : bcity.text.toString(),
            "address2_of_consignor": '',
            "place_of_consignor": bcity.text.toString() == ''
                ? businesAddressController.text.toString()
                : bcity.text.toString(),
            "pincode_of_consignor": 248001,
            "state_of_consignor": "UTTARAKHAND",
            "actual_from_state_name": "UTTARAKHAND",
            "gstin_of_consignee":
                "05AAABC0181E1ZE ", //  bgstn.text == '' ? gstNumberController.text : bgstn.text,
            "legal_name_of_consignee": sname.text.toString(),
            "address1_of_consignee": scity.text.toString(),
            "address2_of_consignee": scity.text.toString(),
            "place_of_consignee": scity.text.toString(),
            "pincode_of_consignee": 248001,
            "state_of_supply": "UTTARAKHAND",
            "actual_to_state_name": "UTTARAKHAND",
            "transaction_type": 1,
            "other_value": 0.00,
            "total_invoice_value": (totalamount * 118 / 100),
            "taxable_amount": totalamount.toInt(),
            "cgst_amount": 0.00,
            "sgst_amount": 0.00,
            "igst_amount": (18 / 100 * totalamount).toInt(),
            "cess_amount": 0,
            "cess_nonadvol_value": 0,
            "transporter_id": transporterid.text,
            "transporter_name": transportername.text,
            "transporter_document_number": tracnsportdocno.text,
            "transporter_document_date": tdate.text,
            "transportation_mode": 'road',
            "transportation_distance": '0',

            "vehicle_number": 'PVC1234', //vehicleno.text,
            "vehicle_type": "Regular",
            "generate_status": 1,
            "data_source": "erp",
            "user_ref": "1232435466sdsf234",
            "location_code": "XYZ",
            "eway_bill_status": "ABC",
            "auto_print": "Y",
            "email": emailController.text,
            "itemList":
                Items("CRCA", "ABC", "1001", "BOX", 9, 9, 0, 0, 9, 0, 40)
          }),
        );
        print(response.statusCode);

        print(bname.text.toString());
        if (response.statusCode == 201 || response.statusCode == 200) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          print(response.body);
          print(response.statusCode);
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          throw Exception('Failed to load album');
        }
      } catch (e) {
        print(e);
        print('error');
      }
    }
 */
    final double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'e-Way bill',
          style: TextStyle(
            fontFamily: 'Bell MT',
            fontSize: 24,
            color: const Color(0xfff2f2f2),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Invoice No.',
                style: TextStyle(
                  fontSize: 18,
                  color: const Color(0xff2f2e41),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                width: w * 0.8,
                color: Colors.white,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Invoice No",
                    fillColor: Colors.white,
                  ),
                  controller: ewaybillController,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => {_tocanceWaylBill(), _cancelEwayBill()},
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: Icon(
                        Icons.edit,
                        color: const Color(0xfff3F3D56),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () => {
                        _getBusinessDetails(widget.uid),
                        print(responsedecode.access_token),
                        _invoicedetails(),

                        //     generateewaybill()
                      },
                      child: Container(
                        color: const Color(0xfff3F3D56),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Generate e-Way Bill',
                            style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 16,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
