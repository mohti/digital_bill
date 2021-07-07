import 'dart:typed_data';

import 'package:gst_verification/gst_verification.dart';
import 'package:digitalbillbook/Invoicestyle.dart';
import 'package:digitalbillbook/customwidgets/CustomInputDecorationWidget.dart';
import 'package:digitalbillbook/customwidgets/EachrowTextfield.dart';
import 'package:digitalbillbook/models/invoicemodel.dart';
import 'package:digitalbillbook/pdf/pdfviewer.dart';
import 'package:digitalbillbook/pdf/pdfviewer2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

/*
  #$%$############### READ FOR BETTER UNDERSTANDING ######################
search  after cntrl+f 
generalInvoiceornot == false
to see the ternary operator code  
*/

class InvoiceMain extends StatefulWidget {
  final String uid;
  final bool i;
  InvoiceMain(this.uid, this.i);

  @override
  _InvoiceMainState createState() => _InvoiceMainState();
}

/* 
  String bname;
  String bphone;
  String bgstn;
  String bdate;
  String bcity;
  String bstate;
  String bcountry;
  String productCode;
  String productName;
  String hsncode;
  String taxrate;
  String quantity;
  String sellingrate;
  String taxamount;
  String totalamount;
  String transporterid;
  String transportername;
  String tracnsportdocno;
  String tdate;
  String vehiclemode;
  String vehicleno;
  String from;
*/
class Customtexteditingcontroller {
  final productCode = TextEditingController();
  final productName = TextEditingController();
  final hsncode = TextEditingController();
  final taxrate = TextEditingController();
  final quantity = TextEditingController();
  final unit = TextEditingController();
  final sellingrate = TextEditingController();
  final taxamount = TextEditingController();
  final totalamount = TextEditingController();
  String focornot = 'None';
}

class _InvoiceMainState extends State<InvoiceMain> {
  final invoiceno = TextEditingController();
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
  final totalamount = TextEditingController();
  final transporterid = TextEditingController();
  final transportername = TextEditingController();
  final tracnsportdocno = TextEditingController();
  // final tdate = TextEditingController();
  final vehiclemode = TextEditingController();
  final vehicleno = TextEditingController();
  final chargename = TextEditingController();
  final chargevalue = TextEditingController();
  final discountrate = TextEditingController();
  final roundoffamount = TextEditingController();
  final tcs = TextEditingController();
  final from = TextEditingController();
  final taxtype = TextEditingController();
  var bdate = DateTime.now();
  var sdate = DateTime.now();
  var tdate = DateTime.now();

  List<Customtexteditingcontroller> t = List<Customtexteditingcontroller>();
  List<OtherCharges> othercharges = List<OtherCharges>();
  var date = DateTime.now();
  int noofproducts = 1;
  final newInvoice = new InvoiceModel(
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null);
  final _keyForm = GlobalKey<FormState>();
  bool generalInvoiceornot = true;

  String numberOfInvoies;
  String invoiceStyle;

  int productCount = 0;

  //use this funtion when u need  to call field empty validation
  Function ifemptyvalidation = (value) {
    if (value.isEmpty) {
      return 'Please Enter value';
    }
    return null;
  };

  bool isvalueIdentified = false;
  String gstNo, response = '';
  String key_secret = '7EvQzBkCZINgbme1YHPFKiuFk6d2';

  Future<Null> numberOfInvoices(String uid) async {
    QuerySnapshot productCollection = await FirebaseFirestore.instance
        .collection("userData")
        .doc(uid)
        .collection('Invoice')
        .get();
    setState(() {
      if (productCollection.size == null) {
        productCount = 1;
      } else {
        productCount = productCollection.size;
      }
    });
  }

  bool verifyGSTNumber(String gst) {
    gstNo = gst;
    GstVerification.verifyGST(gstNo, key_secret).then((result) {
      //package link here
      //https://pub.dev/packages/gst_verification/versions/1.0.1/example
      //json results
      // String Result = result.toString();
      // print(Result + "gstverification RESULT");
      String gstn = result["taxpayerInfo"]["gstin"];
      String businessName = result["taxpayerInfo"]["tradeNam"];
      print("mohit gstn === " + gstn);
      String pincode = result["taxpayerInfo"]["pradr"]["addr"]["pncd"];
      String bnm = result["taxpayerInfo"]["pradr"]["addr"]["bnm"];
      String streat = result["taxpayerInfo"]["pradr"]["addr"]["st"];
      String loc = result["taxpayerInfo"]["pradr"]["addr"]["loc"];
      String typeOfBusiness = result["taxpayerInfo"]["nba"][0];
      String typeOfIndustry = result["taxpayerInfo"]["pradr"]["ntr"];
      print(typeOfIndustry + "mohit");
      var address = bnm + " ," + streat + " ," + loc + " ," + pincode;
      // String industryType =result[]
      print("mohit address ==>" + address.toString());
      setState(() {
        isvalueIdentified = true;
      });
    }).catchError((error) {
      isvalueIdentified = false;
      //  setState(() {
      //   isvalueIdentified = false;
      // });
      print(error + "error mohit ");
      // Fluttertoast.showToast(msg: "Please enter Correct Values");
    });
    return isvalueIdentified;
  }

  Future<Null> invoiceNumDetails(String uid) async {
    print("invoiceNumdetails is called mohit");
    final db = FirebaseFirestore.instance;
    {
      await db
          .collection("userData")
          .doc(uid)
          .collection("invoiceSettings")
          .doc("invoiceSettings")
          .get()
          .then((valuee) {
        setState(() {
          String invoiceprefix = valuee.data()['invoiceprefix'] == null
              ? ''
              : valuee.data()['invoiceprefix'];
          String invoiceStartingSerialNum =
              valuee.data()['invoiceprefix'] == null
                  ? ''
                  : valuee.data()['startingserialno'];
          int numberofInvoice =
              int.parse(invoiceStartingSerialNum) + productCount;
          invoiceno.text = invoiceprefix + numberofInvoice.toString();
        });
      });
    }
  }

  Uint8List logo, sign, stamp;
  Future<void> downloadURLExamplesign() async {
    await firebase_storage.FirebaseStorage.instance
        .ref(widget.uid + '/business/sign.png')
        .getData()
        .then((value) => setState(() {
              sign = value;
            }))
        .catchError((e) => setState(() {}));
    // Within your widgets:
    // Image.network(downloadURL);
  }

  Future<void> downloadURLExamplestamp() async {
    await firebase_storage.FirebaseStorage.instance
        .ref(widget.uid + '/business/stamp.png')
        .getData()
        .then((value) => setState(() {
              stamp = value;
            }))
        .catchError((e) => setState(() {}));
    // Within your widgets:
    // Image.network(downloadURL);
  }

  Future<void> downloadURLExample() async {
    await firebase_storage.FirebaseStorage.instance
        .ref(widget.uid + '/business/logo.png')
        .getData()
        .then((value) => setState(() {
              logo = value;
            }))
        .catchError((e) => setState(() {}));

    // Within your widgets:
    // Image.network(downloadURL);
  }

  int v;
  Future<void> changeQuantity1(int index, String value) async {
    print(t[index].productCode.text);
    await FirebaseFirestore.instance
        .collection("userData")
        .doc(widget.uid)
        .collection("Product")
        .doc(t[index].productCode.text)
        .get()
        .then((valuee) {
      setState(() {
        print(valuee.data()['quantity']);
        v = (valuee.data()['quantity']);
      });
    });
  }

  Future<void> changeQuantity2(int index, String value) async {
    await FirebaseFirestore.instance
        .collection("userData")
        .doc(widget.uid)
        .collection("Product")
        .doc(t[index].productCode.text)
        .update({
      'quantity': (v - int.parse(value)),
    });
  }

  @override
  void initState() {
    super.initState();
    // ignore: todo
    // TODO: implement initState
    numberOfInvoices(widget.uid);
    invoiceNumDetails(widget.uid);
    downloadURLExample();
    downloadURLExamplesign();
    downloadURLExamplestamp();
  }

  @override
  Widget build(BuildContext context) {
    List<InvoiceProduct> listOfProducts = [];
    void addproducts(int j) {
      var newProduct =
          new InvoiceProduct('', '', '', '', '', '', '', '', '', '');
      for (var i = 0; i < j; i++) {
        setState(() {
          newProduct =
              new InvoiceProduct('', '', '', '', '', '', '', '', '', '');
          print(t[i].productCode.text);
          newProduct.productCode = t[i].productCode.text;
          newProduct.productName = t[i].productName.text;
          newProduct.hsncode = t[i].hsncode.text;
          newProduct.quantity = t[i].quantity.text;
          newProduct.sellingrate = t[i].sellingrate.text;
          newProduct.taxamount = t[i].taxamount.text;
          newProduct.taxrate = t[i].taxrate.text;
          newProduct.unit = t[i].unit.text;
          newProduct.totalamount = t[i].totalamount.text;
          newProduct.focornot = t[i].focornot;
          listOfProducts.insert(i, newProduct);
        });

        print(newProduct.productCode);
        print(listOfProducts.first);
      }
    }

    // ignore: unused_local_variable
    List<InvoiceProduct> l2 = List<InvoiceProduct>();

    Future<Null> invoiceStyleDetails(String uid) async {
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
            invoiceStyle = valuee.data()['invoiceStyle'] == null
                ? ''
                : valuee.data()['invoiceStyle'];
          });
        });
      }
    }

    Future<void> generateInvoice() async {
      final db = FirebaseFirestore.instance;
      //mohit genrate invoice
      print('genrate Invoice Triggred ');
      //final db = FirebaseFirestore.instance;
      /*    var newProduct =
          new InvoiceProduct('', '', '', '', '', '', '', '', '', '');
      t.forEach((element) {
        newProduct.productCode = element.productCode.text;
        newProduct.productName = element.productName.text;
        newProduct.hsncode = element.hsncode.text;
        newProduct.quantity = element.quantity.text;
        newProduct.sellingrate = element.sellingrate.text;
        newProduct.taxamount = element.taxamount.text;
        newProduct.taxrate = element.taxrate.text;
        newProduct.unit = element.unit.text;
        newProduct.totalamount = element.totalamount.text;
        newProduct.focornot = element.focornot;
        l2.add(newProduct);
      });
      l2.forEach((element) {
        listOfProducts.add(element);
        print(element.productCode);
      });*/

      //addproducts(noofproducts);

      print(widget.uid.toString() + 'here the uid in genrate fun');
      print(newInvoice.toString() + 'here the invoice text');

      newInvoice.invoiceno = invoiceno.text;
      newInvoice.bname = bname.text;
      newInvoice.bphone = bphone.text;
      newInvoice.taxtype = taxtype.text;
      newInvoice.bgstn = bgstn.text;
      newInvoice.bdate = bdate;
      newInvoice.listOfProducts = listOfProducts;
      newInvoice.bcity = bcity.text;
      newInvoice.bstate = bstate.text;
      newInvoice.bcountry = bcountry.text;
      newInvoice.bpin = bpin.text;
      newInvoice.sname = sname.text;
      newInvoice.sphone = sphone.text;
      newInvoice.sgstn = sgstn.text;
      newInvoice.sdate = sdate;
      newInvoice.scity = scity.text;
      newInvoice.sstate = sstate.text;
      newInvoice.scountry = scountry.text;
      newInvoice.spin = spin.text;
      newInvoice.from = from.text;
      newInvoice.transporterid = transporterid.text;
      newInvoice.transportername = transportername.text;
      newInvoice.tracnsportdocno = tracnsportdocno.text;
      newInvoice.tdate = tdate;
      newInvoice.vehiclemode = vehiclemode.text;
      newInvoice.vehicleno = vehicleno.text;
      newInvoice.othercharges = othercharges;
      newInvoice.discount = discountrate.text;

      newInvoice.tcs = tcs.text;
      newInvoice.roundoff = //double.parse(
          roundoffamount.text;
      //'g');
      // Call the user's CollectionReference to add a new user
      //mohit here invoice not genrating
      // return db
      //     .collection("userData")
      //     .doc(widget.uid)
      //     .collection("Invoice")
      //     .doc(invoiceno.text)
      //     .set(newInvoice.toJson());

      return db
          .collection("userData")
          .doc(widget.uid)
          .collection("Invoice")
          .doc(invoiceno.text)
          .set(newInvoice.toJson());
    }

    Future<Null> _selectDate(BuildContext context, DateTime dateTime) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          initialDatePickerMode: DatePickerMode.day,
          firstDate: DateTime(2015),
          lastDate: DateTime(2101));
      if (picked != null)
        setState(() {
          sdate = picked;
        });
    }

    Future<Null> _selectDate1(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          initialDatePickerMode: DatePickerMode.day,
          firstDate: DateTime(2015),
          lastDate: DateTime(2101));
      if (picked != null)
        setState(() {
          bdate = picked;
        });
    }

    final foc = ['None', "Gift", "Free of Cost", 'Free Sample'];
    final taxtypes = ['IGST', "CGST+SGST"];
    final units = [
      'BAG-BAGS',
      'BAL-BALE',
      'BDL-BUNDLES',
      'BKL-BUCKLES',
      'BOU-BILLIONS OF UNITS',
      'BOX-BOX',
      'BTL-BOTTLES',
      'BUN-BUNCHES',
      'CAN-CANS',
      'CBM-CUBIC METER',
      'CCM-CUBIC CENTIMETER',
      'CMS-CENTIMETER',
      'CTN-CARTONS',
      'DOZ-DOZEN',
      'DRM-DRUM',
      'GGR-GREAT GROSS',
      'GMS-GRAMS',
      'GRS-GROSS',
      'GYD-GROSS YARDS',
      'KGS-KILOGRAMS',
      'KLR-KILOLITER',
      'KME-KILOMETRE',
      'MLT-MILLILITRE',
      'MTR-METERS',
      'NOS-NUMBERS',
      'PAC-PACKS',
      'PCS-PIECES',
      'PRS-PAIRS',
      'QTL-QUINTAL',
      'ROL-ROLLS',
      'SET-SETS',
      'SQF-SQUARE FEET',
      'SQM-SQUARE METERS',
      'SQY-SQUARE YARDS',
      'TBS-TABLETS',
      'TGM-TEN GROSS',
      'THD-THOUSANDS',
      'TON-TONNES',
      'TUB-TUBES',
      'UGS-US GALLONS',
      'UNT-UNITS',
      'YDS-YARDS',
      'OTH-OTHERS'
    ];
    final vehiclemodes = ['Road', 'Train', 'Ship', 'Air'];
    final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Generate Invoice',
          style: TextStyle(
            fontFamily: 'Bell MT',
            fontSize: 24,
            color: const Color(0xfff2f2f2),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: Form(
        key: _keyForm,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Invoice Type",
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 14,
                    color: const Color(0xff2f2e41),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Card(
                      elevation: 4,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextField(
                                enabled: false,
                                decoration: CoustumInputDecorationWidget(
                                        "General Invoice")
                                    .decoration(),
                                // InputDecoration(
                                //   labelText: 'General Invoice',
                                //   fillColor: Colors.white,
                                //   enabledBorder: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(2.0),
                                //   ),
                                // ),
                                // The validator receives the text that the user has entered.
                              ),
                            ),
                            Checkbox(
                              activeColor: Color(0xff05A20A),
                              value: generalInvoiceornot,
                              onChanged: (bool newvalue) {
                                setState(() {
                                  generalInvoiceornot = newvalue;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Card(
                      elevation: 4,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 50,
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextFormField(
                                enabled: false,
                                decoration: CoustumInputDecorationWidget(
                                        'Bill to Ship Invoice')
                                    .decoration(),

                                // The validator receives the text that the user has entered.
                              ),
                            ),
                            Checkbox(
                              activeColor: Color(0xff05A20A),
                              value: !generalInvoiceornot,
                              onChanged: (bool newvalue) {
                                setState(() {
                                  generalInvoiceornot = !newvalue;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Card(
                      elevation: 4,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          controller: invoiceno,
                          decoration: CoustumInputDecorationWidget('Invoice No')
                              .decoration(),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter value';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 4,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Arial',
                            fontSize: 12,
                          ),
                          value: 'IGST',
                          icon: Icon(Icons.arrow_downward),
                          decoration: CoustumInputDecorationWidget("Tax Type")
                              .decoration(),
                          //  InputDecoration(
                          //   labelText: "Tax Type",
                          // ),
                          items: taxtypes.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              taxtype.text = newValue;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Pease select taxtype';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              generalInvoiceornot == false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "Consignee Details(Ship To)",
                            style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 14,
                              color: const Color(0xff2f2e41),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Eachrow(
                            sname,
                            "Name/Company Name",
                            TextInputType.text,
                            ifemptyvalidation,
                            sphone,
                            'Phone Number',
                            TextInputType.number, (value) {
                          if (value.isEmpty || value.length != 10) {
                            return 'Please Enter ';
                          }
                          return null;
                        }, 10),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Card(
                              elevation: 4,
                              child: InkWell(
                                onTap: () => _selectDate(context, sdate),
                                child: Container(
                                  //alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height: 50,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 15, 1, 1),
                                    child: Text("Date       " +
                                        DateFormat('dd/MM/yyyy').format(sdate)),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                //height: 60,
                                child: TextFormField(
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  controller: sgstn,
                                  //maxLength: 15,
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(15)
                                  ],
                                  decoration:
                                      CoustumInputDecorationWidget("GSTN")
                                          .decoration(),
                                  onChanged: (value) {
                                    if (value.length > 14) {
                                      setState(() {
                                        gstNo = sgstn.text;
                                      });
                                      verifyGSTNumber(sgstn.text);
                                    }
                                  },

                                  validator: (value) {
                                    if (value.isEmpty || value.length != 15) {
                                      return 'Enter Correct Gstn ';
                                    } else {
                                      verifyGSTNumber(sgstn.text);
                                      bool v = verifyGSTNumber(sgstn.text);
                                      print(v.toString() + "mohit bool value");
                                      if (v == true) {
                                        return null;
                                      } else {
                                        return "something is wrong";
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Eachrow(scity, "City", TextInputType.text, null, sstate,
                            'State', TextInputType.text, null, 40),
                        SizedBox(
                          height: 10,
                        ),
                        Eachrow(scountry, "Country", TextInputType.text, null,
                            spin, 'Pin Code', TextInputType.number, ((value) {
                          if (value.isEmpty && value.length != 6) {
                            return 'Please Enter ' + 'Pincode';
                          }
                          return null;
                        }), 6),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "Consignor Details(Bill To)",
                            style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 14,
                              color: const Color(0xff2f2e41),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Card(
                                elevation: 4,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: TextFormField(
                                      controller: bname,
                                      decoration: CoustumInputDecorationWidget(
                                              "Name/Company Name")
                                          .decoration(),
                                      // The validator receives the text that the user has entered.

                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return null;
                                        }
                                        return null;
                                      }),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Card(
                                elevation: 4,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: TextFormField(
                                      inputFormatters: [
                                        new LengthLimitingTextInputFormatter(10)
                                      ],
                                      keyboardType: TextInputType.phone,
                                      controller: bphone,
                                      decoration: CoustumInputDecorationWidget(
                                              'Phone No')
                                          .decoration(),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value.isEmpty ||
                                            value.length != 10) {
                                          return 'Please Enter ';
                                        }
                                        return null;
                                      }),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Card(
                              elevation: 4,
                              child: InkWell(
                                onTap: () => _selectDate1(context),
                                child: Container(
                                  // alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 15, 1, 2),
                                    child: Text("Date    " +
                                        DateFormat().add_yMd().format(bdate)),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: 50,
                                child: TextFormField(
                                  controller: bgstn,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  //inputFormatters: [],
                                  maxLength: 15,
                                  decoration: InputDecoration(
                                      labelText: "GSTN", counterText: ''),
                                  // The validator receives the text that the user has entered.
                                  onChanged: (value) {
                                    if (value.length > 14) {
                                      setState(() {
                                        gstNo = bgstn.text;
                                        verifyGSTNumber(bgstn.text);
                                      });
                                    }
                                  },
                                  validator: (value) {
                                    if (value.isEmpty || value.length != 15) {
                                      return 'Enter Correct Gstn ';
                                    } else {
                                      verifyGSTNumber(bgstn.text);
                                      bool v = verifyGSTNumber(bgstn.text);
                                      print(v.toString() + "mohit bool value");
                                      if (v == true) {
                                        return null;
                                      } else {
                                        return "something is wrong";
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Eachrow(bcity, "City", TextInputType.text, null, bstate,
                            'State', TextInputType.text, null, 50),
                        SizedBox(
                          height: 10,
                        ),
                        Eachrow(bcountry, "Country", TextInputType.text, null,
                            bpin, 'Pin Code', TextInputType.number, (value) {
                          if (value.isEmpty && value.length != 6) {
                            return 'Pease enter Pincode';
                          }
                          return null;
                        }, 6),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "Buyer's Details",
                            style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 14,
                              color: const Color(0xff2f2e41),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Eachrow(
                            sname,
                            "Name/Company Name",
                            TextInputType.text,
                            null,
                            sphone,
                            'Phone Number',
                            TextInputType.phone, (value) {
                          if (value.isEmpty || value.length != 10) {
                            return 'Please Enter ';
                          }
                          return null;
                        }, 10),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Card(
                              elevation: 4,
                              child: InkWell(
                                onTap: () => _selectDate(context, sdate),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    width: MediaQuery.of(context).size.width *
                                        0.44,
                                    height: 50,
                                    child: Text("Date    " +
                                        DateFormat('dd/MM/yyyy').format(sdate)),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: TextFormField(
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  controller: sgstn,
                                  keyboardType: TextInputType.text,
                                  // maxLength:15,
                                  // maxLengthEnforced: true,
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(16),
                                  ],
                                  decoration:
                                      CoustumInputDecorationWidget("GSTN")
                                          .decoration(),
                                  onChanged: (value) {
                                    setState(() {
                                      gstNo = sgstn.text;
                                      verifyGSTNumber(sgstn.text);
                                    });
                                  },

                                  validator: (value) {
                                    if (value.isEmpty || value.length != 15) {
                                      return 'Enter Correct Gstn ';
                                    } else {
                                      bool v = verifyGSTNumber(sgstn.text);
                                      print(v.toString() + "mohit bool value");
                                      if (v == true) {
                                        return null;
                                      } else {
                                        return "something is wrong";
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Eachrow(
                            scity,
                            "City",
                            TextInputType.text,
                            (value) {
                              if (value.isEmpty) {
                                return null;
                              }
                              return null;
                            },
                            sstate,
                            'State',
                            TextInputType.text,
                            (value) {
                              if (value.isEmpty) {
                                return null;
                              }
                              return null;
                            },
                            50),
                        SizedBox(
                          height: 10,
                        ),
                        Eachrow(scountry, "Country", TextInputType.text, null,
                            spin, 'Pincoode', TextInputType.number, (value) {
                          if (value.isEmpty && value.length != 6) {
                            return 'Pease enter Pincode';
                          }
                          return null;
                        }, 6),
                      ],
                    ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Product Details",
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 14,
                    color: const Color(0xff2f2e41),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: noofproducts,
                itemBuilder: (context, index) {
                  t.add(new Customtexteditingcontroller());
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Card(
                              elevation: 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                //height: 60,
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (value.length > 3)
                                      changeQuantity1(index, value);

                                    FirebaseFirestore.instance
                                        .collection("userData")
                                        .doc(widget.uid)
                                        .collection("Product")
                                        .doc(value)
                                        .get()
                                        .then((valuee) {
                                      setState(() {
                                        t[index].productName.text =
                                            valuee.data()['productName'];
                                        t[index].hsncode.text =
                                            valuee.data()['hsncode'];
                                        t[index].sellingrate.text =
                                            valuee.data()['sellingprice'];
                                        t[index].taxrate.text =
                                            valuee.data()['igst;'];
                                      });
                                    });
                                  },
                                  controller: t[index].productCode,
                                  decoration: CoustumInputDecorationWidget(
                                          "Product Code")
                                      .decoration(),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter productCode';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Card(
                              elevation: 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: TextFormField(
                                  enabled: false,
                                  controller: t[index].productName,
                                  decoration: CoustumInputDecorationWidget(
                                          'Product Name')
                                      .decoration(),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return null;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Card(
                              elevation: 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: TextFormField(
                                  controller: t[index].hsncode,
                                  enabled: false,
                                  decoration:
                                      CoustumInputDecorationWidget("HSN Code")
                                          .decoration(),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return null;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Card(
                              elevation: 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                //height: 60,
                                child: TextFormField(
                                  controller: t[index].taxrate,
                                  decoration:
                                      CoustumInputDecorationWidget("Tax Rate")
                                          .decoration(),
                                  // The validator receives the text that the user has entered.
                                  onChanged: (value) {
                                    setState(() {
                                      String taxRate = t[index].taxrate.text;
                                      String result;
                                      result = taxRate.substring(
                                          0, taxRate.length - 1);
                                      var quanitity = t[index].quantity.text;
                                      var sellingRate =
                                          t[index].sellingrate.text;
                                      var totalTaxam = (int.parse(quanitity) *
                                              int.parse(sellingRate) *
                                              int.parse(result)) /
                                          100;
                                      var totalam = int.parse(quanitity) *
                                              int.parse(sellingRate) +
                                          totalTaxam;
                                      // //mohit
                                      t[index].taxamount.text =
                                          totalTaxam.toString();
                                      t[index].totalamount.text =
                                          totalam.toString();
                                      print(t[index].totalamount.text +
                                          "mohit tax amount");
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return null;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Card(
                              elevation: 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                //height: 60,
                                child: TextFormField(
                                  controller: t[index].quantity,
                                  decoration:
                                      CoustumInputDecorationWidget("Quantity")
                                          .decoration(),

                                  onChanged: (value) {
                                    changeQuantity2(index, value);
                                    setState(() {
                                      String taxRate = t[index].taxrate.text;
                                      String result;
                                      result = taxRate.substring(
                                          0, taxRate.length - 1);
                                      var quanitity = t[index].quantity.text;
                                      var sellingRate =
                                          t[index].sellingrate.text;
                                      var totalTaxam = (int.parse(quanitity) *
                                              int.parse(sellingRate) *
                                              int.parse(result)) /
                                          100;
                                      var totalam = int.parse(quanitity) *
                                              int.parse(sellingRate) +
                                          totalTaxam;
                                      // //mohit
                                      t[index].taxamount.text =
                                          totalTaxam.toString();
                                      t[index].totalamount.text =
                                          totalam.toString();
                                      print(t[index].totalamount.text +
                                          "mohit tax amount");
                                    });
                                  },
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'enter Quantity';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Card(
                              elevation: 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                // height: 60,
                                child: DropdownButtonFormField<String>(
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'Arial',
                                    fontSize: 12,
                                  ),
                                  value: 'OTH-OTHERS',
                                  icon: Icon(Icons.arrow_downward),
                                  decoration:
                                      CoustumInputDecorationWidget("Unit ")
                                          .decoration(),
                                  //  InputDecoration(
                                  //   labelText: "Unit",
                                  // ),
                                  items: units.map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      t[index].unit.text =
                                          newValue.substring(0, 3);
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Pease select unit';
                                    }
                                    return null;
                                  },
                                ),
                                /*DropdownButtonFormField(
                          value: unit.text,
                          icon: Icon(Icons.arrow_downward),
                          decoration: InputDecoration(
                            labelText: "CGST + SGST",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          items: [
                            "14+14%",
                            "9+9%",
                            '6+6%',
                            '4.5+4.5%',
                            '2.5+2.5%',
                            '1.5+1.5%'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value.toString()),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              unit.text = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Pease select CGST + SGST';
                            }
                            return null;
                          },
                        ),*/
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Card(
                              elevation: 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: TextFormField(
                                  controller: t[index].sellingrate,
                                  decoration: CoustumInputDecorationWidget(
                                          'Selling Rate')
                                      .decoration(),
                                  onChanged: (value) {
                                    setState(() {
                                      String taxRate = t[index].taxrate.text;
                                      String result;
                                      result = taxRate.substring(
                                          0, taxRate.length - 1);
                                      var quanitity = t[index].quantity.text;
                                      var sellingRate =
                                          t[index].sellingrate.text;
                                      var totalTaxam = (int.parse(quanitity) *
                                              int.parse(sellingRate) *
                                              int.parse(result)) /
                                          100;
                                      var totalam = int.parse(quanitity) *
                                              int.parse(sellingRate) +
                                          totalTaxam;
                                      // //mohit
                                      t[index].taxamount.text =
                                          totalTaxam.toString();
                                      t[index].totalamount.text =
                                          totalam.toString();
                                      print(t[index].totalamount.text +
                                          "mohit tax amount");
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return null;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Card(
                              elevation: 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: TextFormField(
                                  controller: t[index].taxamount,
                                  enabled: false,
                                  decoration:
                                      CoustumInputDecorationWidget("TAX Amount")
                                          .decoration(),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return null;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Eachrow(t[index].sellingrate, 'Selling Rate',
                      //     TextInputType.text, (value) {
                      //   if (value.isEmpty) {
                      //     return 'Enter Correct SR';
                      //   }
                      //   return null;
                      // }, t[index].taxamount, "TAX Amount", TextInputType.text,
                      //     null, 20),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Card(
                              elevation: 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                // height: 60,
                                child: TextFormField(
                                  controller: t[index].totalamount,

                                  decoration: CoustumInputDecorationWidget(
                                          'Total Amount')
                                      .decoration(),

                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter Amount';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 4,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              //height: 60,
                              child: DropdownButtonFormField<String>(
                                value: 'None',
                                icon: Icon(Icons.arrow_downward),
                                decoration: CoustumInputDecorationWidget("Foc")
                                    .decoration(),
                                items: foc.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (String newValue) {
                                  setState(() {
                                    t[index].focornot = newValue;
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Pease select foc';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () => {
                      setState(() {
                        noofproducts = noofproducts + 1;
                      })
                    },
                    child: Container(
                      width: 60,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xff3f3d56),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(9, 9),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: Text(
                        'Add New',
                        style: TextStyle(
                          fontFamily: 'Bell MT',
                          fontSize: 12,
                          color: const Color(0xfff1f3f6),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    //   decoration: BoxDecoration( borderRadius: BorderRadius. only(topLeft: Radius. circular(25.0), topRight: Radius. circular(25.0)),
                    //  ),

                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0)),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
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
                                  child: Column(children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Add Other Charges',
                                            style: TextStyle(
                                              fontFamily: 'Arial',
                                              fontSize: 24,
                                              color: const Color(0xffffffff),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Icon(Icons.add,
                                                color: Colors.green)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Charge Name',
                                              style: TextStyle(
                                                fontFamily: 'Arial',
                                                fontSize: 12,
                                                color: const Color(0xffffffff),
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            Container(
                                              color: Colors.white,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: 50,
                                              child: TextFormField(
                                                  controller: chargename),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Charge Value',
                                              style: TextStyle(
                                                fontFamily: 'Arial',
                                                fontSize: 12,
                                                color: const Color(0xffffffff),
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            Container(
                                              color: Colors.white,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              height: 50,
                                              child: TextFormField(
                                                  controller: chargevalue),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        othercharges.add(OtherCharges(
                                            chargename.text.toString(),
                                            double.parse(chargevalue.text)));
                                        chargevalue.text = '';
                                        chargename.text = '';
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            'ADD',
                                            style: TextStyle(
                                              fontFamily: 'Arial',
                                              fontSize: 16,
                                              color: const Color(0xff3f3d56),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: []),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Other Charges',
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 14,
                                    color: const Color(0xff2f2e41),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Icon(
                                  Icons.add,
                                  color: Colors.green,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0)),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(15.0)),
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
                                ),
                                //                            shape: RoundedRectangleBorder(
                                builder: (BuildContext context) {
                                  return Container(
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
                                      child: Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            'Discount',
                                            style: TextStyle(
                                              fontFamily: 'Arial',
                                              fontSize: 24,
                                              color: const Color(0xffffffff),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Discount Rate',
                                          style: TextStyle(
                                            fontFamily: 'Arial',
                                            fontSize: 12,
                                            color: const Color(0xffffffff),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: 50,
                                              child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: discountrate),
                                            ),
                                            Container(
                                              color: Colors.white,
                                              height: 50,
                                              child: Text('%'),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (discountrate.text.isNotEmpty)
                                              Navigator.pop(context);
                                            else
                                              Fluttertoast.showToast(
                                                msg: 'Enter Value',
                                                toastLength: Toast.LENGTH_SHORT,
                                                backgroundColor:
                                                    const Color(0xff3f3d56),
                                              );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                'ADD',
                                                style: TextStyle(
                                                  fontFamily: 'Arial',
                                                  fontSize: 16,
                                                  color:
                                                      const Color(0xff3f3d56),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                        )
                                      ]));
                                },
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: []),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Discount',
                                    style: TextStyle(
                                      fontFamily: 'Arial',
                                      fontSize: 14,
                                      color: const Color(0xff2f2e41),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Icon(
                                    Icons.add,
                                    color: Colors.green,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0)),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(15.0),
                                          topRight:
                                              const Radius.circular(15.0)),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        colors: <Color>[
                                          Color(0xff573666),
                                          Color(0xff1B1B2A)
                                        ], // red to yellow
                                        // repeats the gradient over the canvas
                                      ),
                                    ),
                                    child: Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          'TCS (Tax Collected at Service)',
                                          style: TextStyle(
                                            fontFamily: 'Arial',
                                            fontSize: 24,
                                            color: const Color(0xffffffff),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Text(
                                        'TCS Rate',
                                        style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontSize: 12,
                                          color: const Color(0xffffffff),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            color: Colors.white,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            height: 50,
                                            child:
                                                TextFormField(controller: tcs),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            height: 50,
                                            child: Text('%'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (tcs.text.isNotEmpty)
                                            Navigator.pop(context);
                                          else
                                            Fluttertoast.showToast(
                                                msg: 'Enter Value',
                                                toastLength: Toast.LENGTH_SHORT,
                                                backgroundColor: Colors.black12,
                                                textColor:
                                                    const Color(0xff3f3d56));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              'ADD',
                                              style: TextStyle(
                                                fontFamily: 'Arial',
                                                fontSize: 16,
                                                color: const Color(0xff3f3d56),
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      )
                                    ]));
                              },
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: []),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'TCS',
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 14,
                                    color: const Color(0xff2f2e41),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Icon(
                                  Icons.add,
                                  color: Colors.green,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        InkWell(
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(15.0),
                              topRight: const Radius.circular(15.0)),
                          onTap: () {
                            showModalBottomSheet<void>(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0)),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(15.0),
                                          topRight:
                                              const Radius.circular(15.0)),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        colors: <Color>[
                                          Color(0xff573666),
                                          Color(0xff1B1B2A)
                                        ], // red to yellow
                                        // repeats the gradient over the canvas
                                      ),
                                    ),
                                    child: Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          'Round Off',
                                          style: TextStyle(
                                            fontFamily: 'Arial',
                                            fontSize: 24,
                                            color: const Color(0xffffffff),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Text(
                                        'Amount',
                                        style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontSize: 12,
                                          color: const Color(0xffffffff),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            color: Colors.white,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            height: 50,
                                            child: TextFormField(
                                                controller: roundoffamount),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (roundoffamount.text.isNotEmpty)
                                            Navigator.pop(context);
                                          else
                                            Fluttertoast.showToast(
                                                msg: 'Enter Value',
                                                toastLength: Toast.LENGTH_SHORT,
                                                backgroundColor: Colors.black12,
                                                textColor:
                                                    const Color(0xff3f3d56));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              'ADD',
                                              style: TextStyle(
                                                fontFamily: 'Arial',
                                                fontSize: 16,
                                                color: const Color(0xff3f3d56),
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      )
                                    ]));
                              },
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 30,
                            //  color: Colors.transparent,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.transparent,
                                boxShadow: []),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Round Off',
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 14,
                                    color: const Color(0xff2f2e41),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Icon(
                                  Icons.add,
                                  color: Colors.green,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: othercharges.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    othercharges[index].otherchargename +
                                        "                 " +
                                        othercharges[index]
                                            .otherchargevalue
                                            .toString(),
                                    style: TextStyle(
                                      fontFamily: 'Arial',
                                      fontSize: 12,
                                      color: const Color(0xcc2f2e41),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Discount' + "           " + discountrate.text,
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 12,
                                color: const Color(0xcc2f2e41),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'TCS' + "                   " + tcs.text,
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 12,
                                color: const Color(0xcc2f2e41),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Round Off' + "         " + roundoffamount.text,
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 12,
                                color: const Color(0xcc2f2e41),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Transport Details",
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 14,
                    color: const Color(0xff2f2e41),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Eachrow(
                  transporterid,
                  "Transporter id",
                  TextInputType.text,
                  null,
                  transportername,
                  'Transporter Name',
                  TextInputType.text,
                  null,
                  30),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Card(
                      elevation: 4,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: tracnsportdocno,
                            decoration: CoustumInputDecorationWidget(
                                    "Transporter Doc/Bilty No")
                                .decoration(),
                            validator: (value) {
                              if (value.isEmpty) {
                                return null;
                              }
                              return null;
                            }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Card(
                      elevation: 4,
                      child: InkWell(
                        onTap: () => _selectDate(context, tdate),
                        child: Container(
                          // alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 15, 2, 1),
                            child: Text("Date    " +
                                DateFormat('dd/MM/yyyy').format(sdate)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Eachrow(
              //     tracnsportdocno,
              //     "Transporter Doc/Bilty No",
              //     TextInputType.text,
              //     null,
              //     tdate,
              //     'Date',
              //     TextInputType.datetime,
              //     null),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Vehicle Details",
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 14,
                    color: const Color(0xff2f2e41),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Card(
                      elevation: 4,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Arial',
                            fontSize: 12,
                          ),
                          value: 'Road',
                          icon: Icon(Icons.arrow_downward),
                          decoration:
                              CoustumInputDecorationWidget("Mode").decoration(),
                          // InputDecoration(
                          //   labelText: "Mode",
                          // ),
                          items: vehiclemodes.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              vehiclemode.text = newValue;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Pease select vehicle mode';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Card(
                      elevation: 4,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          textCapitalization: TextCapitalization.characters,
                          controller: vehicleno,
                          decoration: CoustumInputDecorationWidget('Vehicle no')
                              .decoration(),
                          // InputDecoration(
                          //   labelText: 'Vehicle no',
                          //   fillColor: Colors.white,
                          // ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty && value.length != 15) {
                              return 'Please Enter correct ' + 'Vehicle no';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 4,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 50,
                        child: TextFormField(
                          controller: from,
                          decoration:
                              CoustumInputDecorationWidget("From").decoration(),
                          //  InputDecoration(
                          //   labelText: "from",
                          //   fillColor: Colors.white,
                          // ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return null;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                  /*       if (_formKey.currentState.validate()) {
                                          // If the form is valid, display a Snackbar.
                                          addproduct(),
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Signupotp(
                                                          _controller.text)));
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text('')));
                                        } else {
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                  content: Text('Please fill all the fields'
                                               )));
                                        }
                                      },*/
                  onPressed: () {
                    if (_keyForm.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      generateInvoice();

                      //mohit here have  to work
                      invoiceStyleDetails(widget.uid);
                      print(invoiceStyle + '============================here');

                      Future.delayed(new Duration(milliseconds: 10), () {
                        if (widget.i == null) {
                          FocusScope.of(context).unfocus();
                          _scaffoldkey.currentState.showSnackBar(SnackBar(
                              content: Text('Please select invoice style')));
                        }
                        if (sign == null || stamp == null || logo == null) {
                          FocusScope.of(context).unfocus();
                          _scaffoldkey.currentState.showSnackBar(SnackBar(
                              content: Text('Please upload sign/stamp/logo')));
                        }

                        // widget.i == true
                        invoiceStyle == 'pdf2'
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PdfViewer2(
                                        widget.uid,
                                        generalInvoiceornot,
                                        invoiceno.text,
                                        sign,
                                        stamp,
                                        logo)))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PdfViewer(
                                        widget.uid,
                                        generalInvoiceornot,
                                        invoiceno.text,
                                        sign,
                                        stamp,
                                        logo)));
                      });
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Please fill all the fields')));
                    }
                  },
                  child: Container(
                    color: const Color(0xfff3F3D56),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Generate Invoice',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
