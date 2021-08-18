import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalbillbook/models/invoicesettingsmodel.dart';
import 'package:digitalbillbook/settings/invoicesettings/prefix.dart';
import 'package:digitalbillbook/settings/invoicesettings/termsandconditions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Tab extends StatefulWidget {
  final String title;
  final Function f;
  final double w;
  final Widget ic;
  Tab(this.ic, this.title, this.f, this.w);

  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<Tab> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.f,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: widget.w * 1,
          height: 50,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: widget.ic,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 12,
                      color: const Color(0xff2f2e41),
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

class InvoiceSettings extends StatefulWidget {
  final String uid;
  InvoiceSettings(this.uid);

  @override
  _InvoiceSettingsState createState() => _InvoiceSettingsState();
}

class _InvoiceSettingsState extends State<InvoiceSettings> {
  final db = FirebaseFirestore.instance;

  Future<void> termsAndCondition() async {
    // Call the user's CollectionReference to add a new user
    return await db
        .collection("userData")
        .doc(widget.uid)
        .collection("termsAndConditiononInvoice")
        .doc('termsAndConditiononInvoice')
        .set({'termsAndCondition': termsAndConditionController.text});
  }

  Future<void> invoicebutton() {
    settings.invoiceprefix = invoicePrefixController.text;
    settings.startingserialno = startingserialnoController.text;
    // Call the user's CollectionReference to add a new user
    return db
        .collection("userData")
        .doc(widget.uid)
        .collection("invoiceSettings")
        .doc('invoiceSettings')
        .set(settings.toJson());
  }

  Future<void> getInvoicedata() {
    settings.invoiceprefix = invoicePrefixController.text;
    settings.startingserialno = startingserialnoController.text;
    // Call the user's CollectionReference to add a new user
    return db
        .collection("userData")
        .doc(widget.uid)
        .collection("invoiceSettings")
        .doc('invoiceSettings')
        .get()
        .then(
          (value) => setState(() => {
                invoicePrefixController.text = value["invoiceprefix"] == null
                    ? ''
                    : value["invoiceprefix"],
                startingserialnoController.text =
                    value["startingserialno"] == null
                        ? ''
                        : value["startingserialno"]
              }),
        );
  }

  void initState() {
    //assert(_debugLifecycleState == _StateLifecycle.created);
    _gettermsandcondition(widget.uid);
    getInvoicedata();
  }

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

  final termsAndConditionController = TextEditingController();
  final invoicePrefixController = TextEditingController();
  final startingserialnoController = TextEditingController();
  final settings = new InvoiceSettingsmodel(null, null);
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      
      appBar: AppBar(
         leading: IconButton(icon:Icon(Icons.arrow_back_ios),
          onPressed: ()=> Navigator.of(context).pop(),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Customize Invoice',
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
                'Invoice Settings',
                style: TextStyle(
                  fontFamily: 'Bell MT',
                  fontSize: 18,
                  color: const Color(0xff2f2e41),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            //Tab(null, 'Change Invoice Style', , w),
            Tab(
                null,
                'Invoice Prefix & Sequence No.',
                () => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                    ),
                   
                    builder: (BuildContext context) {
                      return SafeArea(
                            child: Form(
                              key: _keyForm,
                              child: Container(
                                height: MediaQuery.of(context).size.height/1.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     // crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'Edit Invoice Prefix & Starting \nSerial Number',
                                          style: TextStyle(
                                            fontFamily: 'Arial',
                                            fontSize: 24,
                                            color: const Color(0xfff1f3f6),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Icon(
                                                            Icons
                                                                .close_outlined,
                                                            color:
                                                                Colors.white),
                                                      )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                                              Container(
                                               alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Invoice Prefix',
                                                  style: TextStyle(
                                                    fontFamily: 'Arial',
                                                    fontSize: 12,
                                                    color:
                                                        const Color(0xfff1f3f6),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              SizedBox(width:MediaQuery.of(context).size.width*0.16,),
                                              Text(
                                                'Starting Serial No.',
                                                style: TextStyle(
                                                  fontFamily: 'Arial',
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xfff1f3f6),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                      
                                    ],),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              
                                              SizedBox(height: 10),
                                              Container(
                                                decoration: BoxDecoration( color: Colors.white,
                                               borderRadius: BorderRadius.circular(5)),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left:8.0),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      
                                                        fillColor: Colors.white),
                                                    controller:
                                                        invoicePrefixController,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              
                                              SizedBox(height: 10,),
                                              Container(
                                                   decoration: BoxDecoration( color: Colors.white,
                                               borderRadius: BorderRadius.circular(5)),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left:8.0),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller:
                                                        startingserialnoController,
                                                  ),
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
                                        onPressed: () => {
                                              if (invoicePrefixController
                                                      .text.isNotEmpty &&
                                                  startingserialnoController
                                                      .text.isNotEmpty)
                                                {
                                                  invoicebutton(),
                                                  Navigator.pop(context)
                                                }
                                              else
                                                {
                                                  Fluttertoast.showToast(
                                                      msg: 'Enter values')
                                                }
                                            },
                                        child: Container(
                                          width: 100,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10)),
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
                            ),
                          );
                    }),
                //  Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SetPrefix(uid))),

                w),
            Tab(
                null,
                'Terms and Conditions ',
                () => showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                    ),
                    // shape: RoundedRectangleBorder(
                    builder: (BuildContext context) {
                      return Container(
                           padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
                        height: MediaQuery.of(context).size.height / 1.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            colors: <Color>[
                              Color(0xff573666),
                              Color(0xff1B1B2A)
                            ], // red to yellow
                          ),
                        ),
                        child: SafeArea(
                            child: Form(
                          key: _keyForm,
                          child: Container(
                            height: 500,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0)),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Terms & Condition on Invoice',
                                      style: TextStyle(
                                        fontFamily: 'Arial',
                                        fontSize: 24,
                                        color: const Color(0xfff1f3f6),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Icon(
                                                            Icons
                                                                .close_outlined,
                                                            color:
                                                                Colors.white),
                                                      )
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: 
                                      Column(
                                   //     mainAxisAlignment: MainAxisAlignment,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left:28.0),
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Terms & Condition on Invoice',
                                                style: TextStyle(
                                                  fontFamily: 'Arial',
                                                  fontSize: 12,
                                                  color: const Color(0xfff1f3f6),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                           
                                            decoration: BoxDecoration(
                                               color: Colors.white,
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: 100,
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: TextFormField(
                                                maxLines: 5,
                                                controller:
                                                    termsAndConditionController,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                   
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FlatButton(
                                    onPressed: () => {
                                          termsAndCondition(),
                                          Navigator.pop(context)
                                        },
                                    child: Center(
                                   //   padding: const EdgeInsets.only(left:150.0),
                                      child: Container(
                                        width: 100,
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration:
                                            BoxDecoration(color: Colors.white
                                            ,
                                            borderRadius: BorderRadius.circular(10)),
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
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        )),
                      );
                    }),
                //  Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => TermsAndCondition(widget.uid))),
                w),
            //     Tab(null, 'Free Quantity', null, w),
          ],
        ),
      ),
    );
  }
}
