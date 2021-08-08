import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalbillbook/models/userCredantial%20.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Tab extends StatelessWidget {
  final String title;
  final Function f;
  final double w;
  final Widget ic;

  Tab(this.ic, this.title, this.f, this.w);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: f,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: w * 1,
          height: 50,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ic,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Bell MT',
                      fontSize: 18,
                      color: const Color(0xff2f2e41),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}

class InvoiceStyle extends StatefulWidget {
  @override
  _InvoiceStyleState createState() => _InvoiceStyleState();
}

class _InvoiceStyleState extends State<InvoiceStyle> {
  bool iselected = false;
  bool issecondelected = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  getuid() async {
    final prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('UID');
    return uid;
  }

  String _selectedImage;
  Map<String, dynamic> invoiceStyle;
  String invoiceStyleSelected;
  final db = FirebaseFirestore.instance;

  Future<Null> invoiceStyleDetails() async {
    final User user = auth.currentUser;
    String uid = user.uid;

    final db = FirebaseFirestore.instance;
    {
      await db
          .collection("userData")
          .doc(uid)
          .collection("invoiceStyle")
          .doc("invoiceStyle")
          .get()
          .then((valuee) {
        setState(() {
          invoiceStyleSelected = valuee.data()['invoiceStyle'] == null
              ? ''
              : valuee.data()['invoiceStyle'];
        });
      });
    }
    if (invoiceStyleSelected == 'pdf1') {
      setState(() {
        issecondelected = false;
        iselected = true;
      });
    } else {
      setState(() {
        issecondelected = true;
        iselected = false;
      });
    }
  }

  Future<void> addInvoiceStyle() async {
    final User user = auth.currentUser;
    String uid = user.uid;

    return db
        .collection("userData")
        .doc(uid)
        .collection("invoiceStyle")
        .doc("invoiceStyle")
        .set(invoiceStyle);
  }

  @override
  void initState() {
    invoiceStyleDetails();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(icon:Icon(Icons.arrow_back_ios),
          onPressed: ()=> Navigator.of(context).pop(),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Invoice Style',
          style: TextStyle(
            fontFamily: 'Bell MT',
            fontSize: 24,
            color: const Color(0xfff2f2f2),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           //   crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             // SizedBox(height: 50,),
              Stack(children: <Widget>[
                InkWell(
                    // onTap: () => Navigator.pop(context, false),
                    onTap: () async {
                      invoiceStyle = {'invoiceStyle': 'pdf1'};
                      await addInvoiceStyle();
                      Fluttertoast.showToast(msg: 'Updated',
                      toastLength: Toast.LENGTH_SHORT);

                      setState(() {
                        iselected = true;
                        issecondelected = false;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2.5,
                      //alignment: Alignment.center,
                      child: Image(
                        image: AssetImage('assets/invoice1.jpeg'),
                        height: 300,
                      ),
                    )),
                iselected
                    ? 
                    Positioned(
                      top:15,
                      //right: MediaQuery.of(context).size.width/1.5 ,
                      child: IconButton(
                        icon: Icon(
                          Icons.check_box,
                          color: Colors.red,
                        ),
                        onPressed: null))
                    
                    : Container(),
              ]),
              SizedBox(
                height: 10,
              ),
              Stack(children: <Widget>[
                InkWell(
                  //onTap: () => Navigator.pop(context, true),
                  onTap: () async {
                    invoiceStyle = {'invoiceStyle': 'pdf2'};
                    await addInvoiceStyle();
                      Fluttertoast.showToast(msg: 'Updated',
                      toastLength: Toast.LENGTH_SHORT);
                      setState(() {
                      issecondelected = true;
                      iselected = false;
                      });
                  },

                  child: Container(

                      width: MediaQuery.of(context).size.width/2.5,
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage('assets/invoice2.jpeg'),
                        height: 300,
                      )),
                ),
                issecondelected
                    ? 
                    Positioned(
                      top:15,
                    //right: MediaQuery.of(context).size.width/2.7 ,                                        
                      child: IconButton(
                        icon: Icon(
                          Icons.check_box,
                          color: Colors.red,
                        ),
                        onPressed: null))
                   
                    : Container(),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
