import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/*
class Access_token {
 
final username;
final password;
final client_id;
final client_secret;
final grant_type;

  Access_token({this.username,this.password,this.client_id,this.client_secret,this.grant_type});

  factory Access_token.fromJson(Map<String, dynamic> json) {
    return Access_token(
      id: json['id'],
      title: json['title'],
      
"username": "testeway@mastersindia.co",
"password" : "Test@1234",
"client_id":"fIXefFyxGNfDWOcCWn",
"client_secret":"QFd6dZvCGqckabKxTapfZgJc",
"grant_type":"password"

    );
  }
}*/
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

class _Ewaybill1State extends State<Ewaybill1> {
  Future<Null> createAccessToken() async {
    try {
      final response = await http.post(
        Uri.parse('https://clientbasic.mastersindia.co/oauth/access_token'),
        headers: {'Content-Type': 'application/json'},
        encoding: Encoding.getByName('utf-8'),
        body: jsonEncode(<dynamic, dynamic>{
          "username": "testeway@mastersindia.co",
          "password": "Test@1234",
          "client_id": "fIXefFyxGNfDWOcCWn",
          "client_secret": "QFd6dZvCGqckabKxTapfZgJc",
          "grant_type": "password"
        }),
      );

      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        print(response.body);
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

  Future<Accesstoken> _accestoken;
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final ewaybillController = TextEditingController();
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
            InkWell(
              onTap: () => {
                _accestoken = createAccessToken(),
                print(_accestoken.then((value) => print(value.accesstoken)))
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
          ],
        ),
      ),
    );
  }
}
