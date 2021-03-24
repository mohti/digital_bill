import 'dart:typed_data';

import 'package:digitalbillbook/models/invoicemodel.dart';
import 'package:digitalbillbook/pdf/pdfviewer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Eachrow extends StatelessWidget {
  final TextEditingController controller1, controller2;
  final String s1, s2;
  Eachrow(this.controller1, this.s1, this.controller2, this.s2);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Card(
            elevation: 4,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 50,
              child: TextFormField(
                controller: controller1,
                decoration: InputDecoration(
                  labelText: s1,
                  fillColor: Colors.white,
                ),
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
              height: 50,
              child: TextFormField(
                controller: controller2,
                decoration: InputDecoration(
                  labelText: s2,
                  fillColor: Colors.white,
                ),
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
    );
  }
}

class InvoiceMain extends StatefulWidget {
  final String uid;
  InvoiceMain(this.uid);

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
}

class _InvoiceMainState extends State<InvoiceMain> {
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
  final tdate = TextEditingController();
  final vehiclemode = TextEditingController();
  final vehicleno = TextEditingController();
  final from = TextEditingController();

  List<Customtexteditingcontroller> t = List<Customtexteditingcontroller>();

  var date = DateTime.now();
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
      null);
  final _keyForm = GlobalKey<FormState>();
  bool generalInvoiceornot = true;

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
    List<InvoiceProduct> listOfProducts = [];
    void addproducts(int j) {
      for (var i = 0; i < j; i++) {
        setState(() {
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
        });
        listOfProducts.add(newProduct);
      }
    }

    final db = FirebaseFirestore.instance;
    // ignore: unused_local_variable
    List<InvoiceProduct> l2 = List<InvoiceProduct>();

    Future<void> generateInvoice() {
      /* t.forEach((element) {
        newProduct.productCode = element.productCode.text;
        newProduct.productName = element.productName.text;
        newProduct.hsncode = element.hsncode.text;
        newProduct.quantity = element.quantity.text;
        newProduct.sellingrate = element.sellingrate.text;
        newProduct.taxamount = element.taxamount.text;
        newProduct.taxrate = element.taxrate.text;
        newProduct.unit = element.unit.text;
        newProduct.totalamount = element.totalamount.text;
        l2.add(newProduct);
      });
      l2.forEach((element) {
        listOfProducts.add(element);
        print(element.productCode);
      });*/
      addproducts(noofproducts);
      newInvoice.invoiceno = invoiceno.text;
      newInvoice.bname = bname.text;
      newInvoice.bphone = bphone.text;
      newInvoice.bgstn = bgstn.text;
      newInvoice.bdate = bdate.text;
      newInvoice.listOfProducts = listOfProducts;
      newInvoice.bcity = bcity.text;
      newInvoice.bstate = bstate.text;
      newInvoice.bcountry = bcountry.text;
      newInvoice.bpin = bpin.text;
      newInvoice.sname = sname.text;
      newInvoice.sphone = sphone.text;
      newInvoice.sgstn = sgstn.text;
      newInvoice.sdate = sdate.text;
      newInvoice.scity = scity.text;
      newInvoice.sstate = sstate.text;
      newInvoice.scountry = scountry.text;
      newInvoice.spin = spin.text;
      newInvoice.from = from.text;
      newInvoice.transporterid = transporterid.text;
      newInvoice.transportername = transportername.text;
      newInvoice.tracnsportdocno = tracnsportdocno.text;
      newInvoice.tdate = tdate.text;
      newInvoice.vehiclemode = vehiclemode.text;
      newInvoice.vehicleno = vehicleno.text;

      // Call the user's CollectionReference to add a new user
      return db
          .collection("userData")
          .doc(widget.uid)
          .collection("Invoice")
          .doc(invoiceno.text)
          .set(newInvoice.toJson());
    }

    Future<Null> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          initialDatePickerMode: DatePickerMode.day,
          firstDate: DateTime(2015),
          lastDate: DateTime(2101));
      if (picked != null)
        setState(() {
          date = picked;
        });
    }

    return Scaffold(
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
                                decoration: InputDecoration(
                                  labelText: 'General Invoice',
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                ),
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
                                decoration: InputDecoration(
                                  labelText: 'Bill to Ship Invoice',
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                ),
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
                          controller: invoiceno,
                          decoration: InputDecoration(
                            labelText: "Invoice No",
                            fillColor: Colors.white,
                          ),
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
                            sname, "Name/Company Name", sphone, 'Phone Number'),
                        SizedBox(
                          height: 10,
                        ),
                        Eachrow(sgstn, "GSTN", sdate, 'Date'),
                        SizedBox(
                          height: 10,
                        ),
                        Eachrow(scity, "City", sstate, 'State'),
                        SizedBox(
                          height: 10,
                        ),
                        Eachrow(scountry, "Country", spin, 'Pin Code'),
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
                        Eachrow(
                            bname, "Name/Company Name", bphone, 'Phone Number'),
                        SizedBox(
                          height: 10,
                        ),
                        Eachrow(bgstn, "GSTN", bdate, 'Date'),
                        SizedBox(
                          height: 10,
                        ),
                        Eachrow(bcity, "City", bstate, 'State'),
                        SizedBox(
                          height: 10,
                        ),
                        Eachrow(bcountry, "Country", bpin, 'Pin Code'),
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
                            sname, "Name/Company Name", sphone, 'Phone Number'),
                        SizedBox(
                          height: 10,
                        ),
                        Eachrow(sgstn, "GSTN", sdate, 'Date'),
                        SizedBox(
                          height: 10,
                        ),
                        Eachrow(scity, "City", sstate, 'State'),
                        SizedBox(
                          height: 10,
                        ),
                        Eachrow(scountry, "Country", spin, 'Pin Code'),
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
                                height: 50,
                                child: TextFormField(
                                  onChanged: (value) {
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
                                      });
                                    });
                                  },
                                  controller: t[index].productCode,
                                  decoration: InputDecoration(
                                    labelText: "Product Code",
                                    fillColor: Colors.white,
                                  ),
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
                                height: 50,
                                child: TextFormField(
                                  enabled: false,
                                  controller: t[index].productName,
                                  decoration: InputDecoration(
                                    labelText: 'Product Name',
                                    fillColor: Colors.white,
                                  ),
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
                                child: TextFormField(
                                  controller: t[index].hsncode,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: "HSN Code",
                                    fillColor: Colors.white,
                                  ),
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
                                height: 50,
                                child: TextFormField(
                                  controller: t[index].taxrate,
                                  decoration: InputDecoration(
                                    labelText: 'tax Rate',
                                    fillColor: Colors.white,
                                  ),
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
                                height: 50,
                                child: TextFormField(
                                  controller: t[index].quantity,

                                  decoration: InputDecoration(
                                    labelText: "Quantity",
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      FirebaseFirestore.instance
                                          .collection("userData")
                                          .doc(widget.uid)
                                          .collection("Product")
                                          .doc(productCode.text)
                                          .get()
                                          .then((valuee) {
                                        setState(() {
                                          FirebaseFirestore.instance
                                              .collection("userData")
                                              .doc(widget.uid)
                                              .collection("Product")
                                              .doc(productCode.text)
                                              .update({
                                            'quantity': (double.parse(valuee
                                                        .data()['quantity']
                                                        .toString()) -
                                                    double.parse(value))
                                                .toString()
                                          });
                                        });
                                      });
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
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Card(
                              elevation: 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: 50,
                                child: TextFormField(
                                  controller: t[index].unit,

                                  decoration: InputDecoration(
                                    labelText: "Unit",
                                    fillColor: Colors.white,
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return null;
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
                      Eachrow(t[index].sellingrate, 'Selling Rate',
                          t[index].taxamount, "TAX Amount"),
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
                                  controller: t[index].totalamount,
                                  decoration: InputDecoration(
                                    labelText: "Total Amount",
                                    fillColor: Colors.white,
                                  ),
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
              Eachrow(transporterid, "Transporter id", transportername,
                  'Transporter Name'),
              SizedBox(
                height: 10,
              ),
              Eachrow(
                  tracnsportdocno, "Transporter Doc/Bilty No", tdate, 'Date'),
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
              Eachrow(vehiclemode, "Mode", vehicleno, 'Vehicle no'),
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
                          decoration: InputDecoration(
                            labelText: "from",
                            fillColor: Colors.white,
                          ),
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

                      Future.delayed(new Duration(milliseconds: 100), () {
                        Navigator.push(
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
