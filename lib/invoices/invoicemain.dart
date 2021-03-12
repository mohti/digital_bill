import 'package:digitalbillbook/models/invoicemodel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                    return 'Please Enter ' + s1;
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
                    return 'Please Enter ' + s2;
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
class _InvoiceMainState extends State<InvoiceMain> {
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
  var date = DateTime.now();

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
      null,
      null);
  final _keyForm = GlobalKey<FormState>();
  bool generalInvoiceornot = true;
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    Future<void> addproduct() {
      newInvoice.bname = bname.text;
      newInvoice.bphone = bphone.text;
      newInvoice.bgstn = bgstn.text;
      newInvoice.bdate = bdate.text;
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
      newInvoice.productCode = productCode.text;
      newInvoice.productName = productName.text;
      newInvoice.hsncode = hsncode.text;
      newInvoice.taxrate = taxrate.text;
      newInvoice.quantity = quantity.text;
      newInvoice.sellingrate = sellingrate.text;
      newInvoice.taxamount = taxamount.text;
      newInvoice.totalamount = totalamount.text;
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
          .doc('')
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
              SizedBox(
                height: 20,
              ),
              Eachrow(bname, "Name/Company Name", bphone, 'Phone Number'),
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
                                .then((value) {
                              setState(() {
                                productName.text = value.data()['productName'];

                                hsncode.text = value.data()['hsncode'];

                                sellingrate.text = value.data()['sellingprice'];
                              });
                            });
                          },
                          controller: productCode,
                          decoration: InputDecoration(
                            labelText: "Product Code",
                            fillColor: Colors.white,
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter ' + "Product Code";
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
                          controller: productName,
                          decoration: InputDecoration(
                            labelText: 'Product Name',
                            fillColor: Colors.white,
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter ' + 'Product Name';
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
                          controller: hsncode,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: "HSN Code",
                            fillColor: Colors.white,
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter ' + "Product Code";
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
                          controller: taxrate,
                          decoration: InputDecoration(
                            labelText: 'tax Rate',
                            fillColor: Colors.white,
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter ' + 'Product Name';
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
              Eachrow(quantity, "Quantity", sellingrate, 'Selling Rate'),
              SizedBox(
                height: 10,
              ),
              Eachrow(taxamount, "TAX Amount", totalamount, 'Total Amount'),
              SizedBox(
                height: 10,
              ),
              Eachrow(taxamount, "TAX Amount", totalamount, 'Total Amount'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: null,
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
                              return 'Please Enter ' + 'from';
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
                        addproduct();
                        Navigator.pop(context);
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('')));
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
                          'Add Product',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 16,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
