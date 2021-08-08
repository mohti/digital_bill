import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class TermsAndCondition extends StatefulWidget {
  final String uid;
  TermsAndCondition(this.uid);

  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  final termsAndConditionController = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    _gettermsandcondition(widget.uid);
    // TODO: implement initState
    super.initState();
  }

  final db = FirebaseFirestore.instance;
  Future<Null> _gettermsandcondition(String uid) async {
    await db
        .collection("userData")
        .doc(uid)
        .collection("termsAndConditiononInvoice")
        .doc('termsAndConditiononInvoice')
        .get()
        .then((valuee) {
      setState(() {
        termsAndConditionController.text =
            valuee.data()['termsAndCondition'] == null
                ? ''
                : valuee.data()['termsAndCondition'];
      });
    });
  }

  Future<void> invoicebutton() async{
    // Call the user's CollectionReference to add a new user
    return await db
        .collection("userData")
        .doc(widget.uid)
        .collection("termsAndConditiononInvoice")
        .doc('termsAndConditiononInvoice')
        .set({'termsAndCondition': termsAndConditionController.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _keyForm,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: <Color>[
                Color(0xff573666),
                Color(0xff1B1B2A)
              ], // red to yellow
              // repeats the gradient over the canvas
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'Terms & Condition on Invoice',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 24,
                  color: const Color(0xfff1f3f6),
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Terms & Condition on Invoice',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 12,
                            color: const Color(0xfff1f3f6),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 100,
                          child: TextFormField(
                            controller: termsAndConditionController,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                  onPressed: () => {invoicebutton(), Navigator.pop(context)},
                  child: Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text(
                      'SET',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 16,
                        color: const Color(0xff2f2e41),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ))
            ],
          ),
        ),
      )),
 
 
    );
  }
}
