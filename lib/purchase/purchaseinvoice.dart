import 'dart:typed_data';

import 'package:digitalbillbook/customwidgets/CustomInputDecorationWidget.dart';
import 'package:digitalbillbook/customwidgets/EachrowTextfield.dart';
import 'package:digitalbillbook/models/invoicemodel.dart';
import 'package:digitalbillbook/pdf/pdfviewer2.dart';
import 'package:digitalbillbook/purchase/purchasepdf.dart';
import 'package:digitalbillbook/theme/colors/colors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

// class Eachrow extends StatelessWidget {
//   final TextEditingController controller1, controller2;
//   final String s1, s2;
//   Function validation;
//   Eachrow(this.controller1, this.s1, this.controller2, this.s2);
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.all(0.0),
//           child: Card(
//             elevation: 4,
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.45,
//               child: TextFormField(
//                 controller: controller1,
//                 decoration: CoustumInputDecorationWidget(s1).decoration(),

//                 // The validator receives the text that the user has entered.
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return null;
//                   }
//                   return null;
//                 },
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(0.0),
//           child: Card(
//             elevation: 4,
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.45,
//               child: TextFormField(
//                 controller: controller2,
//                 decoration: CoustumInputDecorationWidget(s2).decoration(),
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return null;
//                   }
//                   return null;
//                 },
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class Eachrows extends StatelessWidget {
//   final TextEditingController controller1, controller2;
//   final String s1, s2;
//   Function validation1, validation2;
//   Eachrows(this.controller1, this.s1, this.validation1, this.controller2,
//       this.s2, this.validation2);
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.all(0.0),
//           child: Card(
//             elevation: 4,
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.45,
//               child: TextFormField(
//                   controller: controller1,
//                   decoration: CoustumInputDecorationWidget(s1).decoration(),

//                   // The validator receives the text that the user has entered.
//                   validator: validation1

//                   // (value) {
//                   //   if (value.isEmpty) {
//                   //     return null;
//                   //   }
//                   //   return null;
//                   // },
//                   ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(0.0),
//           child: Card(
//             elevation: 4,
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.45,
//               child: TextFormField(
//                   controller: controller2,
//                   decoration: CoustumInputDecorationWidget(s2).decoration(),
//                   validator: validation2

//                   // (value) {
//                   //   if (value.isEmpty) {
//                   //     return null;
//                   //   }
//                   //   return null;
//                   // },
//                   ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class PurchaseInvoice extends StatefulWidget {
  final String uid;
  PurchaseInvoice(this.uid);

  @override
  _PurchaseInvoiceState createState() => _PurchaseInvoiceState();
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

class _PurchaseInvoiceState extends State<PurchaseInvoice> {
  final invoiceno = TextEditingController();
  final bname = TextEditingController();
  final bphone = TextEditingController();
  final bgstn = TextEditingController();
  final bdate = TextEditingController();
  final bcity = TextEditingController();
  final bstate = TextEditingController();
  final bcountry = TextEditingController();
  final bpin = TextEditingController();
  final sname = TextEditingController();
  final sphone = TextEditingController();
  final sgstn = TextEditingController();
  final sdate = TextEditingController();
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
  // final tdate = DateTime(year);
  final vehiclemode = TextEditingController();
  final vehicleno = TextEditingController();
  final from = TextEditingController();
  final chargename = TextEditingController();
  final chargevalue = TextEditingController();
  final discountrate = TextEditingController();
  final roundoffamount = TextEditingController();
  final tcs = TextEditingController();
final discountedAmount = TextEditingController();
  double totalAmountforDiscount;
  double totalAmountforTcs;
  
 final tcsAmount = TextEditingController();
 
  final taxtype = TextEditingController();

  List<Customtexteditingcontroller> t = List<Customtexteditingcontroller>();
  List<OtherCharges> othercharges = List<OtherCharges>();
  var date = DateTime.now();
  var tdate = DateTime.now();
  int noofproducts = 1;

  var newProduct = new InvoiceProduct(
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  );

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

  bool generalInvoiceornot = false;
totalForTcs() {
      for (int i = 0; i < noofproducts; i++) {
        print('noofproducts in for loop' + noofproducts.toString());

        totalAmountforTcs =
            totalAmountforTcs + double.tryParse(t[i].totalamount.text);
      }
    }

    totalforDicount() {
      for (int i = 0; i < noofproducts; i++) {
        print('noofproducts in for loop' + noofproducts.toString());

        totalAmountforDiscount =
            totalAmountforDiscount + double.tryParse(t[i].totalamount.text);
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
      'quantity': (v + int.parse(value)),
    });
  }

  @override
  void initState() {
    super.initState();
    // ignore: todo
    // TODO: implement initState
    downloadURLExample();
    downloadURLExamplesign();
    downloadURLExamplestamp();
  }

  @override
  Widget build(BuildContext context) {
    var bdate = DateTime.now();
    var sdate = DateTime.now();
    List<InvoiceProduct> listOfProducts = [];
    void addproducts(int j) {
      var newProduct =
          new InvoiceProduct('', '', '', '', '', '', '', '', '', '','');
      for (var i = 0; i < j; i++) {
        setState(() {
          newProduct =
              new InvoiceProduct('', '', '', '', '', '', '', '', '', '','');
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
          newProduct.baseTotalAmount = (double.tryParse( t[i].sellingrate.text)*double.tryParse( t[i].quantity.text)).toString();
          listOfProducts.insert(i, newProduct);
        });

        print(newProduct.productCode);
        print(listOfProducts.first);
      }
    }

    final db = FirebaseFirestore.instance;
    // ignore: unused_local_variable
    List<InvoiceProduct> l2 = List<InvoiceProduct>();

    Future<void> generateInvoice() {
   
      addproducts(noofproducts);
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
      // newInvoice.discount = double.parse(discountrate.text);
      // newInvoice.tcs = double.parse(tcs.text);
      // newInvoice.roundoff = double.parse(roundoffamount.text);
      newInvoice.discount = discountrate.text;
      newInvoice.tcs = tcs.text;
      newInvoice.roundoff = roundoffamount.text;

      // Call the user's CollectionReference to add a new user
      return db
          .collection("userData")
          .doc(widget.uid)
          .collection("PurchaseInvoice")
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
          dateTime = picked;
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
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(icon:Icon(Icons.arrow_back_ios),
          onPressed: ()=> Navigator.of(context).pop(),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Purchase Receipt',
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
                        child: TextFormField(
                          controller: invoiceno,
                          decoration:
                              CoustumInputDecorationWidget('Receipt No.')
                                  .decoration(),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter invoiceno';
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
                          value: 'IGST',
                          icon: Icon(Icons.keyboard_arrow_down_sharp),
                          decoration: CoustumInputDecorationWidget("Tax Type")
                              .decoration(),
                          //  InputDecoration(
                          //   labelText: ,
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
              SizedBox(
                height: 10,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: <Widget>[
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Card(
              //         elevation: 4,
              //         child: Container(
              //           width: MediaQuery.of(context).size.width * 0.45,
              //           child: TextFormField(
              //             controller: invoiceno,
              //             decoration:
              //                 CoustumInputDecorationWidget('Receipt No.')
              //                     .decoration(),
              //             // The validator receives the text that the user has entered.
              //             validator: (value) {
              //               if (value.isEmpty) {
              //                 return 'Enter invoiceno';
              //               }
              //               return null;
              //             },
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Seller Detail",
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 14,
                        color: const Color(0xff2f2e41),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  // Eachrow(
                  //     sname,
                  //     "Name/Company Name",
                  //     TextInputType.text,
                  //     (value) {
                  //       if (value.isEmpty) {
                  //         return 'enter please';
                  //       }
                  //       return null;
                  //     },
                  //     sphone,
                  //     'Phone Number',
                  //     TextInputType.number,
                  //     (value) {
                  //       if (value.isEmpty || value.length != 10) {
                  //         return 'Please Enter ';
                  //       }
                  //       return null;
                  //     },
                  //    10),
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
                                controller: sname,
                                decoration: CoustumInputDecorationWidget(
                                        "Name/Company Name")
                                    .decoration(),
                                onChanged: (value) {
                                  // setState(() {
                                  //   sphone.text = '';
                                  // });
                                  FirebaseFirestore.instance
                                      .collection("userData")
                                      .doc(widget.uid)
                                      .collection("Party")
                                      .doc(value)
                                      .get()
                                      .then((valuee) {
                                    setState(() {
                                      sphone.text =
                                          valuee.data()['phone'] == null
                                              ? ' '
                                              : valuee.data()['phone'];
                                      sname.text =
                                          valuee.data()['partyName'] == null
                                              ? ' '
                                              : valuee.data()['partyName'];
                                      sgstn.text = valuee.data()['gstn'] == null
                                          ? ''
                                          : valuee.data()['gstn'];
                                      scity.text = valuee.data()['city'] == null
                                          ? ' '
                                          : valuee.data()['city'];
                                      sstate.text =
                                          valuee.data()['state'] == null
                                              ? ' '
                                              : valuee.data()['state'];
                                      scountry.text =
                                          valuee.data()['country'] == null
                                              ? ' '
                                              : valuee.data()['country'];
                                      spin.text =
                                          valuee.data()['pincode'] == null
                                              ? ' '
                                              : valuee.data()['pincode'];
                                    });
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Party Name';
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
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextFormField(
                                controller: sphone,
                                decoration:
                                    CoustumInputDecorationWidget('Phone Number')
                                        .decoration(),
                                inputFormatters: [
                                  new LengthLimitingTextInputFormatter(10)
                                ],
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value.isEmpty || value.length != 10) {
                                    return 'Please Enter ';
                                  }
                                  return null;
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Eachrow(sname, "Name/Company Name", (value) {}, sphone,
                  //     'Phone Number', null),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Card(
                        elevation: 4,
                        child: InkWell(
                          onTap: () => _selectDate(context, date),
                          child: Padding(
                            padding: const EdgeInsets.only(left:0.0),
                            child: Container(
                              height: 50,
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    "Date " + DateFormat().add_yMd().format(date)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextFormField(
                            controller: sgstn,
                            decoration: CoustumInputDecorationWidget('GSTN')
                                .decoration(),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[A-Z,0-9]')),
                            ],
                            textCapitalization: TextCapitalization.characters,
                            validator: (value) {
                              if (value.isEmpty) {
                                return null;
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
                  Eachrow(scity, "City", TextInputType.text, null, sstate,
                      'State', TextInputType.text, null, 40),

                  //              Eachrow(scity, "City", sstate, 'State'),

                  SizedBox(
                    height: 10,
                  ),
                  //                  Eachrow(scountry, "Country", spin, 'Pin Code'),
                  Eachrow(scountry, "Country", TextInputType.text, null, spin,
                      'Pin Code', TextInputType.number, ((value) {
                    if (value.isEmpty && value.length != 6) {
                      return 'Please Enter ' + 'Pincode';
                    }
                    return null;
                  }), 6),
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
                                child: TextFormField(
                                  onChanged: (value) {
                                    print('mohit on changed worked');
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
                                            valuee.data()['productName'] == null
                                                ? ''
                                                : valuee.data()['productName'];
                                        t[index].hsncode.text =
                                            valuee.data()['hsncode'] == null
                                                ? ''
                                                : valuee.data()['hsncode'];
                                        t[index].sellingrate.text =
                                            valuee.data()['sellingprice'] ==
                                                    null
                                                ? ''
                                                : valuee.data()['sellingprice'];
                                        t[index].taxrate.text =
                                            valuee.data()['igst'] == null
                                                ? ''
                                                : valuee.data()['igst'];
                                      });
                                    });
                                  },
                                  controller: t[index].productCode,
                                  decoration: CoustumInputDecorationWidget(
                                          'Product Code')
                                      .decoration(),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter product code';
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
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return null;
                                    } else {
                                      return null;
                                    }
                                    // if(value.length==3||value.length==4||value.length==6){
                                    //   return null;
                                    //      }
                                    //   else
                                    //   {
                                    //     return 'enter correct value';
                                    //   }

                                    ;
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
                                  controller: t[index].taxrate,
                                  decoration:
                                      CoustumInputDecorationWidget("Tax Rate")
                                          .decoration(),
                                  onChanged: (value) {
                                    setState(() {
                                      String taxRate = t[index].taxrate.text;
                                      // String result;
                                      // result = taxRate.substring(
                                      //     0, taxRate.length - 1);
                                      var quanitity = t[index].quantity.text;
                                      var sellingRate =
                                          t[index].sellingrate.text;
                                      var totalTaxam = (int.parse(quanitity) *
                                              int.parse(sellingRate) *
                                              int.parse(taxRate)) /
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
                                child: TextFormField(
                                  controller: t[index].quantity,

                                  decoration:
                                      CoustumInputDecorationWidget("Quantity")
                                          .decoration(),
                            
                                  onChanged: (value) {
                                    print(value);

                                    changeQuantity2(index, value);
                                    setState(() {
                                      String taxRate = t[index].taxrate.text;
                                      // String result;
                                      // result = taxRate.substring(
                                      //     0, taxRate.length - 1);
                                      var quanitity = t[index].quantity.text;
                                      var sellingRate =
                                          t[index].sellingrate.text;
                                      var totalTaxam = (int.parse(quanitity) *
                                              int.parse(sellingRate) *
                                              int.parse(taxRate)) /
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
                                      return 'Enter value';
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
                                height: 50,
                                child: DropdownButtonFormField<String>(
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'Arial',
                                    fontSize: 12,
                                  ),
                                  value: 'OTH-OTHERS',
                                  icon: Padding(
                                    padding:const EdgeInsets.only(right:5.0),
                                    child:Icon(Icons.keyboard_arrow_down_sharp)),
                                  decoration:
                                      CoustumInputDecorationWidget("Unit")
                                          .decoration(),
                                  // InputDecoration(
                                  //   labelText: "Unit",
                                  // ),
                                  items: units.map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value,style: TextStyle(fontSize: 10),),
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
                                //height: 50,
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: TextFormField(
                                    controller: t[index].sellingrate,
                                    decoration: CoustumInputDecorationWidget(
                                            'Selling Rate')
                                        .decoration(),
                                    onChanged: (value) {
                                      setState(() {
                                        String taxRate = t[index].taxrate.text;
                                        // String result;
                                        // result = taxRate.substring(
                                        //     0, taxRate.length - 1);
                                        var quanitity = t[index].quantity.text;
                                        var sellingRate =
                                            t[index].sellingrate.text;
                                        var totalTaxam = (int.parse(quanitity) *
                                                int.parse(sellingRate) *
                                                int.parse(taxRate)) /
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
                                    }),
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
                                    decoration: CoustumInputDecorationWidget(
                                      "TAX Amount",
                                    ).decoration(),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return null;
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
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Card(
                              elevation: 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                             
                                child: TextFormField(
                                  controller: t[index].totalamount,
                                  decoration: CoustumInputDecorationWidget(
                                          "Total Amount")
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
                          Card(
                            elevation: 4,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 50,
                              child: DropdownButtonFormField<String>(
                                value: 'None',
                                icon: Padding(
                                  padding: const EdgeInsets.only(right:5.0),
                                  child: Icon(Icons.keyboard_arrow_down_sharp),
                                ),
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
                                              borderRadius:
                                                  new BorderRadius.only(
                                                      topLeft:
                                                          const Radius.circular(
                                                              15.0),
                                                      topRight:
                                                          const Radius.circular(
                                                              15.0)),
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
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        30, 51, 30, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(children: [
                                                      Text(
                                                        'Add Other Charges',
                                                        style: TextStyle(
                                                          fontFamily: 'Arial',
                                                          fontSize: 20,
                                                          color: const Color(
                                                              0xffffffff),
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100)),
                                                          child: Icon(Icons.add,
                                                              color: Colors
                                                                  .green)),
                                                    ]),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Icon(
                                                          Icons.close_outlined,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 41),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    //color: Colors.white,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    //height: 50,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('Charge Name',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white)),
                                                            SizedBox(
                                                                height: 13),
                                                            Container(
                                                              decoration: new BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                          .all(new Radius
                                                                              .circular(
                                                                          10))),
                                                              height: 40,
                                                              child:
                                                                  TextFormField(
                                                                      decoration:
                                                                          InputDecoration(
                                                                        contentPadding: const EdgeInsets.only(
                                                                            left:
                                                                                8.0,
                                                                            bottom:
                                                                                1.0,
                                                                            top:
                                                                                1.0),
                                                                        fillColor:
                                                                            Colors.white,
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                      ),
                                                                      controller:
                                                                          chargename),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  Container(
                                                    //color: Colors.white,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    //height: 50,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('Charges',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white)),
                                                            SizedBox(
                                                                height: 13),
                                                            Container(
                                                              decoration: new BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                          .all(new Radius
                                                                              .circular(
                                                                          10))),
                                                              height: 40,
                                                              child:
                                                                  TextFormField(
                                                                      autofocus:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        //        floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                        contentPadding: const EdgeInsets.only(
                                                                            left:
                                                                                8.0,
                                                                            bottom:
                                                                                1.0,
                                                                            top:
                                                                                1.0),
                                                                         suffixIcon: Container(
                                                                                width: 20,
                                                                                alignment: Alignment.center,
                                                                                child: FaIcon(FontAwesomeIcons.rupeeSign,color:Colors.green ,size: 21,)),  // Image.asset("assets/images/rupeesign.png",height: 5,width: 5,),
                                                                        
                                                                        // suffixIconConstraints: BoxConstraints(
                                                                          
                                                                        //   minHeight: 21,
                                                                        //   minWidth: 16
                                                                        // ),
                                                                        fillColor:
                                                                            Colors.white,
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                      ),
                                                                      controller:
                                                                          chargevalue),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: () {setState(() {
                                                  
                                                });
                                                  othercharges.add(OtherCharges(
                                                      chargename.text
                                                          .toString(),
                                                      double.parse(
                                                          chargevalue.text)));

                                                  chargevalue.text = '';
                                                  chargename.text = '';
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                      'ADD',
                                                      style: TextStyle(
                                                        fontFamily: 'Arial',
                                                        fontSize: 16,
                                                        color: const Color(
                                                            0xff3f3d56),
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[300],
                                        boxShadow: []),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left:4.0),
                                            child: Text(
                                              'Other Charges',
                                              style: TextStyle(
                                                fontFamily: 'Arial',
                                                fontSize: 14,
                                                color: const Color(0xff2f2e41),
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)),
                                              child: Icon(Icons.add,
                                                  color: Colors.green)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
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
                                                borderRadius: new BorderRadius
                                                        .only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            15.0),
                                                    topRight:
                                                        const Radius.circular(
                                                            15.0)),
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
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          30, 51, 30, 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Discount',
                                                        style: TextStyle(
                                                          fontFamily: 'Arial',
                                                          fontSize: 20,
                                                          color: const Color(
                                                              0xffffffff),
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
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
                                                ),
                                                SizedBox(height: 41),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      //color: Colors.white,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                      //height: 50,
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  'Discount Rate',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white)),
                                                              SizedBox(
                                                                  height: 13),
                                                              Container(
                                                                decoration: new BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: new BorderRadius
                                                                        .all(new Radius
                                                                            .circular(
                                                                        10))),
                                                                height: 40,
                                                                child:
                                                                    TextFormField(
                                                                        decoration:
                                                                            InputDecoration(
                                                                               suffixIcon: Container(
                                                                                width: 20,
                                                                                alignment: Alignment.center,
                                                                                child: FaIcon(FontAwesomeIcons.percent,color:purpleForapp ,size: 21,)),
                                                                         
                                                                          
                                                                          contentPadding: const EdgeInsets.only(
                                                                              left: 8.0,
                                                                              bottom: 1.0,
                                                                              top: 1.0),
                                                                          fillColor:
                                                                              Colors.white,
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            totalAmountforDiscount =
                                                                                0;
                                                                            totalforDicount();
                                                                            print('on changed trigred');

                                                                            discountedAmount.text =
                                                                                (totalAmountforDiscount * int.tryParse(discountrate.text) / 100).toString();
                                                                            print(totalAmountforDiscount.toString());
                                                                          });
                                                                        },
                                                                        controller:
                                                                            discountrate),
                                                              ),
                                                            ],
                                                          )),
                                                    ),
                                                    Container(
                                                      //color: Colors.white,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                      //height: 50,
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  'Discounted Amount',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white)),
                                                              SizedBox(
                                                                  height: 13),
                                                              Container(
                                                                decoration: new BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: new BorderRadius
                                                                        .all(new Radius
                                                                            .circular(
                                                                        10))),
                                                                height: 40,
                                                                child:
                                                                    TextFormField(
                                                                        decoration:
                                                                            InputDecoration(
                                                                              
                                                                              suffixIcon: Container(
                                                                                width: 20,
                                                                                alignment: Alignment.center,
                                                                                child: FaIcon(FontAwesomeIcons.rupeeSign,color:purpleForapp ,size: 21,)),
                                                                          contentPadding: const EdgeInsets.only(
                                                                              left: 8.0,
                                                                              bottom: 1.0,
                                                                              top: 1.0),
                                                                          fillColor:
                                                                              Colors.white,
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                        ),
                                                                        controller:
                                                                            discountedAmount),
                                                              ),
                                                            ],
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                     Navigator.pop(context);
                                                    },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: 110,
                                                    height: 41,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        'ADD',
                                                        style: TextStyle(
                                                          fontFamily: 'Arial',
                                                          fontSize: 16,
                                                          color: const Color(
                                                              0xff3f3d56),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ]));

                                          //  Container(
                                          //     decoration: BoxDecoration(
                                          //       borderRadius: BorderRadius.only(
                                          //           topLeft:
                                          //               Radius.circular(15.0),
                                          //           topRight:
                                          //               Radius.circular(15.0)),
                                          //       gradient: LinearGradient(
                                          //         begin: Alignment.topCenter,
                                          //         colors: <Color>[
                                          //           Color(0xff573666),
                                          //           Color(0xff1B1B2A)
                                          //         ], // red to yellow
                                          //         // repeats the gradient over the canvas
                                          //       ),
                                          //     ),
                                          //     child: Column(children: [
                                          //       Padding(
                                          //         padding: const EdgeInsets.all(
                                          //             10.0),
                                          //         child: Text(
                                          //           'Discount',
                                          //           style: TextStyle(
                                          //             fontFamily: 'Arial',
                                          //             fontSize: 24,
                                          //             color: const Color(
                                          //                 0xffffffff),
                                          //           ),
                                          //           textAlign: TextAlign.left,
                                          //         ),
                                          //       ),
                                          //       SizedBox(
                                          //         height: 10,
                                          //       ),
                                          //       Text(
                                          //         'Discount Rate',
                                          //         style: TextStyle(
                                          //           fontFamily: 'Arial',
                                          //           fontSize: 12,
                                          //           color:
                                          //               const Color(0xffffffff),
                                          //         ),
                                          //         textAlign: TextAlign.left,
                                          //       ),
                                          //       SizedBox(
                                          //         height: 10,
                                          //       ),
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment.center,
                                          //         children: [
                                          //           Container(
                                          //             color: Colors.white,
                                          //             width:
                                          //                 MediaQuery.of(context)
                                          //                         .size
                                          //                         .width *
                                          //                     0.4,
                                          //             height: 50,
                                          //             child: Padding(
                                          //               padding:
                                          //                   const EdgeInsets
                                          //                       .all(8.0),
                                          //               child: TextFormField(
                                          //                   keyboardType:
                                          //                       TextInputType
                                          //                           .number,
                                          //                   controller:
                                          //                       discountrate),
                                          //             ),
                                          //           ),
                                          //           Container(
                                          //             color: Colors.white,
                                          //             height: 50,
                                          //             child: Text('%'),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //       SizedBox(
                                          //         height: 10,
                                          //       ),
                                          //       InkWell(
                                          //         onTap: () {
                                          //           if (discountrate
                                          //               .text.isNotEmpty)
                                          //             Navigator.pop(context);
                                          //           else
                                          //             Fluttertoast.showToast(
                                          //               msg: 'Enter Value',
                                          //               toastLength:
                                          //                   Toast.LENGTH_SHORT,
                                          //               backgroundColor:
                                          //                   const Color(
                                          //                       0xff3f3d56),
                                          //             );
                                          //         },
                                          //         child: Container(
                                          //           alignment: Alignment.center,
                                          //           width: 80,
                                          //           decoration: BoxDecoration(
                                          //             color: Colors.white,
                                          //             borderRadius:
                                          //                 BorderRadius.circular(
                                          //                     4),
                                          //           ),
                                          //           child: Padding(
                                          //             padding:
                                          //                 const EdgeInsets.all(
                                          //                     10.0),
                                          //             child: Text(
                                          //               'ADD',
                                          //               style: TextStyle(
                                          //                 fontFamily: 'Arial',
                                          //                 fontSize: 16,
                                          //                 color: const Color(
                                          //                     0xff3f3d56),
                                          //                 fontWeight:
                                          //                     FontWeight.w700,
                                          //               ),
                                          //               textAlign:
                                          //                   TextAlign.left,
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       )
                                          //     ]));
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey[300],
                                          boxShadow: []),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left:4.0),
                                              child: Text(
                                                'Discount',
                                                style: TextStyle(
                                                  fontFamily: 'Arial',
                                                  fontSize: 14,
                                                  color: const Color(0xff2f2e41),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            90)),
                                                child: Icon(Icons.add,
                                                    color: Colors.green)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
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
                                              borderRadius:
                                                  new BorderRadius.only(
                                                      topLeft:
                                                          const Radius.circular(
                                                              15.0),
                                                      topRight:
                                                          const Radius.circular(
                                                              15.0)),
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
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        25, 44, 25, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'TCS (Tax Collected at Service)',
                                                      style: TextStyle(
                                                        fontFamily: 'Arial',
                                                        fontSize: 20,
                                                        color: const Color(
                                                            0xffffffff),
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Icon(
                                                          Icons.close_outlined,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 42),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    //color: Colors.white,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    //height: 50,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('TCS Rate',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white)),
                                                            SizedBox(
                                                                height: 13),
                                                            Container(
                                                              decoration: new BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                          .all(new Radius
                                                                              .circular(
                                                                          10))),
                                                              height: 40,
                                                              child:
                                                                  TextFormField(
                                                                      decoration:
                                                                          InputDecoration(
                                                                        contentPadding: const EdgeInsets.only(
                                                                            left:
                                                                                8.0,
                                                                            bottom:
                                                                                1.0,
                                                                            top:
                                                                                1.0),
                                                                        fillColor:
                                                                            Colors.white,
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                      ),
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          totalAmountforTcs =
                                                                              0;
                                                                              totalForTcs();
                                                                     
                                                                          tcsAmount.text =
                                                                              (int.tryParse(tcs.text) * totalAmountforTcs / 100).toStringAsFixed(2);
                                                                          print(tcsAmount.toString() +
                                                                              'tcsamount');
                                                                          // totalAmountforDiscount =
                                                                          //     0;
                                                                          //   totalforDicount();
                                                                          //   print('on changed trigred');

                                                                          //   discountedAmount.text =
                                                                          //       (totalAmountforDiscount * int.tryParse(discountrate.text) / 100).toString();
                                                                          //   print(totalAmountforDiscount.toString());
                                                                        });
                                                                      },
                                                                      controller:
                                                                          tcs),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  Container(
                                                    //color: Colors.white,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    //height: 50,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('TCS Amount',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white)),
                                                            SizedBox(
                                                                height: 13),
                                                            Container(
                                                              decoration: new BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                          .all(new Radius
                                                                              .circular(
                                                                          10))),
                                                              height: 40,
                                                              child:
                                                                  TextFormField(
                                                                      decoration:
                                                                          InputDecoration(
                                                                             suffixIcon: Container(
                                                                                width: 20,
                                                                                alignment: Alignment.center,
                                                                                child: FaIcon(FontAwesomeIcons.rupeeSign,color:purpleForapp ,size: 21,)),
                                                                        contentPadding: const EdgeInsets.only(
                                                                            left:
                                                                                8.0,
                                                                            bottom:
                                                                                1.0,
                                                                            top:
                                                                                1.0),
                                                                        fillColor:
                                                                            Colors.white,
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                      ),
                                                                      controller:
                                                                          tcsAmount),
                                                            ),
                                                          ],
                                                        )),
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
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        backgroundColor:
                                                            Colors.black12,
                                                        textColor: const Color(
                                                            0xff3f3d56));
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 110,
                                                  height: 41,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                      'ADD',
                                                      style: TextStyle(
                                                        fontFamily: 'Arial',
                                                        fontSize: 16,
                                                        color: const Color(
                                                            0xff3f3d56),
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[300],
                                        boxShadow: []),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left:4.0),
                                            child: Text(
                                              'TCS',
                                              style: TextStyle(
                                                fontFamily: 'Arial',
                                                fontSize: 14,
                                                color: const Color(0xff2f2e41),
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)),
                                              child: Icon(Icons.add,
                                                  color: Colors.green)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
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
                                              borderRadius:
                                                  new BorderRadius.only(
                                                      topLeft:
                                                          const Radius.circular(
                                                              15.0),
                                                      topRight:
                                                          const Radius.circular(
                                                              15.0)),
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
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        30, 51, 30, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Round Off',
                                                      style: TextStyle(
                                                        fontFamily: 'Arial',
                                                        fontSize: 20,
                                                        color: const Color(
                                                            0xffffffff),
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Icon(
                                                          Icons.close_outlined,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 41),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    //color: Colors.white,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    //height: 50,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('Round off',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white)),
                                                            SizedBox(
                                                                height: 13),
                                                           Row(
                                                        children: [
                                                          Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100)),
                                                              child: InkWell(
                                                                onTap: () {
                                                                 roundoffamount
                                                                      .text = (double.tryParse(roundoffamount
                                                                              .text) +
                                                                          0.1
                                                                      //int.tryParse(gxValues.roundoffamount.text)
                                                                      )
                                                                      .toStringAsFixed(2);
                                                                setState(() {
                                                                  
                                                                });
                                                                },
                                                                child: Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .green),
                                                              )),
                                                          SizedBox(width: 20),
                                                          Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100)),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  roundoffamount
                                                                      .text = (double.tryParse(roundoffamount
                                                                              .text) -
                                                                          0.1
                                                                      //int.tryParse(gxValues.roundoffamount.text) /

                                                                      )
                                                                      .toStringAsFixed(2)
                                                                      ;
                                                                      setState(() {
                                                                        
                                                                      });
                                                                },
                                                                child: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: Colors
                                                                        .red),
                                                              )),
                                                        ],
                                                      )
                                                          ],
                                                        )),
                                                  ),
                                                  Container(
                                                    //color: Colors.white,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    //height: 50,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('Amount',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white)),
                                                            SizedBox(
                                                                height: 13),
                                                            Container(
                                                                decoration: new BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: new BorderRadius
                                                                        .all(new Radius
                                                                            .circular(
                                                                        10))),
                                                                height: 40,
                                                                child:
                                                                    TextFormField(
                                                                  decoration:
                                                                      InputDecoration(
                                                                         suffixIcon: Container(
                                                                                width: 20,
                                                                                alignment: Alignment.center,
                                                                                child: FaIcon(FontAwesomeIcons.rupeeSign,color:purpleForapp ,size: 21,)),
                                                                    contentPadding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0,
                                                                        bottom:
                                                                            1.0,
                                                                        top:
                                                                            1.0),
                                                                    fillColor:
                                                                        Colors
                                                                            .white,
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                  ),
                                                                  controller:
                                                                      roundoffamount,
                                                                )),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 110,
                                                  height: 41,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                      'ADD',
                                                      style: TextStyle(
                                                        fontFamily: 'Arial',
                                                        fontSize: 16,
                                                        color: const Color(
                                                            0xff3f3d56),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ]));

                                        // Container(
                                        //     decoration: BoxDecoration(
                                        //       borderRadius:
                                        //           new BorderRadius.only(
                                        //               topLeft:
                                        //                   const Radius.circular(
                                        //                       15.0),
                                        //               topRight:
                                        //                   const Radius.circular(
                                        //                       15.0)),
                                        //       gradient: LinearGradient(
                                        //         begin: Alignment.topCenter,
                                        //         colors: <Color>[
                                        //           Color(0xff573666),
                                        //           Color(0xff1B1B2A)
                                        //         ], // red to yellow
                                        //         // repeats the gradient over the canvas
                                        //       ),
                                        //     ),
                                        //     child: Column(children: [
                                        //       Padding(
                                        //         padding:
                                        //             const EdgeInsets.all(10.0),
                                        //         child: Text(
                                        //           'Round Off',
                                        //           style: TextStyle(
                                        //             fontFamily: 'Arial',
                                        //             fontSize: 24,
                                        //             color:
                                        //                 const Color(0xffffffff),
                                        //           ),
                                        //           textAlign: TextAlign.left,
                                        //         ),
                                        //       ),
                                        //       Text(
                                        //         'Amount',
                                        //         style: TextStyle(
                                        //           fontFamily: 'Arial',
                                        //           fontSize: 12,
                                        //           color:
                                        //               const Color(0xffffffff),
                                        //         ),
                                        //         textAlign: TextAlign.left,
                                        //       ),
                                        //       Row(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.center,
                                        //         children: [
                                        //           Container(
                                        //             decoration: BoxDecoration(
                                        //                 color: Colors.white,
                                        //                 borderRadius:
                                        //                     BorderRadius
                                        //                         .circular(8)),
                                        //             width:
                                        //                 MediaQuery.of(context)
                                        //                         .size
                                        //                         .width *
                                        //                     0.4,
                                        //             height: 50,
                                        //             child: Padding(
                                        //               padding:
                                        //                   const EdgeInsets.all(
                                        //                       8.0),
                                        //               child: TextFormField(
                                        //                   controller:
                                        //                       roundoffamount),
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //       SizedBox(
                                        //         height: 10,
                                        //       ),
                                        //       InkWell(
                                        //         onTap: () {
                                        //           if (roundoffamount
                                        //               .text.isNotEmpty)
                                        //             Navigator.pop(context);
                                        //           else
                                        //             Fluttertoast.showToast(
                                        //                 msg: 'Enter Value',
                                        //                 toastLength:
                                        //                     Toast.LENGTH_SHORT,
                                        //                 backgroundColor:
                                        //                     Colors.black12,
                                        //                 textColor: const Color(
                                        //                     0xff3f3d56));
                                        //         },
                                        //         child: Container(
                                        //           alignment: Alignment.center,
                                        //           width: 80,
                                        //           decoration: BoxDecoration(
                                        //             color: Colors.white,
                                        //             borderRadius:
                                        //                 BorderRadius.circular(
                                        //                     4),
                                        //           ),
                                        //           child: Padding(
                                        //             padding:
                                        //                 const EdgeInsets.all(
                                        //                     10.0),
                                        //             child: Text(
                                        //               'ADD',
                                        //               style: TextStyle(
                                        //                 fontFamily: 'Arial',
                                        //                 fontSize: 16,
                                        //                 color: const Color(
                                        //                     0xff3f3d56),
                                        //                 fontWeight:
                                        //                     FontWeight.w700,
                                        //               ),
                                        //               textAlign: TextAlign.left,
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       )
                                        //     ]));
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: 30,
                                    //  color: Colors.transparent,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[300],
                                        boxShadow: []),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left:4.0),
                                            child: Text(
                                              'Round Off',
                                              style: TextStyle(
                                                fontFamily: 'Arial',
                                                fontSize: 14,
                                                color: const Color(0xff2f2e41),
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)),
                                              child: Icon(Icons.add,
                                                  color: Colors.green)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                          Column(
                            children: [
                              othercharges.length > 0
                                  ? SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        //  NeverScrollableScrollPhysics(),
                                        itemCount: othercharges.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.42,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                                                                          child: Text(
                                                        othercharges[index]
                                                            .otherchargename
                                                        //+
                                                        // "                 " +
                                                        // othercharges[index]
                                                        //     .otherchargevalue
                                                        //     .toString(),
                                                        ,
                                                        style: TextStyle(
                                                          fontFamily: 'Arial',
                                                          fontSize: 12,
                                                          color: const Color(
                                                              0xcc2f2e41),
                                                        ),
                                                        textAlign: TextAlign.left,
                                                      ),
                                                    ),
                                                         Container(
                                                                                width: 20,
                                                                                alignment: Alignment.center,
                                                                                child: FaIcon(FontAwesomeIcons.rupeeSign,color:Colors.green ,size: 14,)),
                                  
                                       
                                                    Text(
                                                      othercharges[index]
                                                          .otherchargevalue
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontFamily: 'Arial',
                                                        fontSize: 12,
                                                        color: const Color(
                                                            0xcc2f2e41),
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Other Charges ',
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                          Expanded(
                                            flex: 2,
                                                                                      child: Text(
                                            'Discount       '  ,
                                            style: TextStyle(
                                              fontFamily: 'Arial',
                                              fontSize: 12,
                                              color: const Color(0xcc2f2e41),
                                            ),
                                            textAlign: TextAlign.left,
                                        ),
                                          ),
                                              Container(
                                                                                width: 20,
                                                                                alignment: Alignment.center,
                                                                                child: FaIcon(FontAwesomeIcons.rupeeSign,color:Colors.green ,size: 14,)),
                                  
                                        Text(
                                        
                                              discountedAmount.text,
                                          style: TextStyle(
                                            fontFamily: 'Arial',
                                            fontSize: 12,
                                            color: const Color(0xcc2f2e41),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                       ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                                                                  child: Text(
                                            'TCS' ,
                                            style: TextStyle(
                                              fontFamily: 'Arial',
                                              fontSize: 12,
                                              color: const Color(0xcc2f2e41),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                          Container(
                                                                                width: 20,
                                                                                alignment: Alignment.center,
                                                                                child: FaIcon(FontAwesomeIcons.rupeeSign,color:Colors.green ,size: 14,)),
                                  
                                        Text(
                                          tcsAmount.text,
                                          style: TextStyle(
                                            fontFamily: 'Arial',
                                            fontSize: 12,
                                            color: const Color(0xcc2f2e41),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                                                                  child: Text(
                                            'Round Off' ,
                                          style: TextStyle(
                                              fontFamily: 'Arial',
                                              fontSize: 12,
                                              color: const Color(0xcc2f2e41),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                         Container(
                                                                                width: 20,
                                                                                alignment: Alignment.center,
                                                                                child: FaIcon(FontAwesomeIcons.rupeeSign,color:Colors.green ,size: 14,)),
                                  
                                      
                                        Text(
                                          
                                              roundoffamount.text,
                                          style: TextStyle(
                                            fontFamily: 'Arial',
                                            fontSize: 12,
                                            color: const Color(0xcc2f2e41),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
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
                  "Transportation Details",
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
                  40),
              SizedBox(
                height: 10,
              ),

              // mohit have to change here
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
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(left:10),
                            child: Text(
                                "Date " + DateFormat('dd/MM/yyyy').format(sdate)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Eachrow(
              //     tracnsportdocno, "Transporter Doc/Bilty No", tdate, 'Date'),

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
                            fontSize: 13,
                          ),
                          value: 'Road',
                          icon: Padding(
                            padding: const EdgeInsets.only(right:5.0),
                            child: Icon(Icons.keyboard_arrow_down_sharp),
                          ),
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
                              return 'Pease select unit';
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
                          controller: vehicleno,
                          decoration: CoustumInputDecorationWidget('Vehicle no')
                              .decoration(),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[A-Z,0-9]')),
                          ],
                          textCapitalization: TextCapitalization.characters,
                          //  validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please Enter correct ' + 'Vehicle no';
                          //   }
                          //   return null;
                          // },
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
                    padding: const EdgeInsets.only(left:10.0),
                    child: Card(
                      elevation: 4,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          controller: from,
                          decoration:
                              CoustumInputDecorationWidget("Form").decoration(),
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
                  
                  onPressed: () {
                    if (_keyForm.currentState.validate()) {
                      generateInvoice();
                     //    if(stamp!=null)
                      Future.delayed(new Duration(milliseconds: 100), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    // PdfViewer2(widget.uid,
                                    //     false, invoiceno.text, sign, stamp, logo)
                                    PurchasePdf(widget.uid, false,
                                        invoiceno.text, sign, stamp, logo)));
                      });
                    } else {
                      Flushbar(
                        backgroundColor:  Color.fromRGBO(47, 46, 65, 1),
                        message: 'please fill all the fields',
                        icon: Icon(
                          Icons.cancel_outlined,
                          size: 28,
                          color: Colors.green.shade300,
                        ),
                        leftBarIndicatorColor: Colors.blue.shade300,
                        duration: Duration(seconds: 3),
                      )..show(context);

                    }
                  },
                  child: Container(
                  // width: 18\50,
                    decoration: BoxDecoration(
                        color: const Color(0xfff3F3D56),
                      borderRadius: BorderRadius.circular(8),
                    ),
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
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}
