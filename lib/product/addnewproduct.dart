import 'package:digitalbillbook/models/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
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
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
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

class Addproduct extends StatefulWidget {
  final String uid;
  Addproduct(this.uid);

  @override
  _AddproductState createState() => _AddproductState();
}

/*  String productCode;
  String productName;
  String hsncode;
  int quantity;
  String cgst;
  String igst;
  String purchaserate;
  String sellingprice;
  DateTime date;
  int totalAmount;
*/
class _AddproductState extends State<Addproduct> {
  final productCodeController = TextEditingController();
  final productNameController = TextEditingController();
  final hsncodeController = TextEditingController();
  final quantityController = TextEditingController();

  final purchaserateController = TextEditingController();
  final sellingpriceController = TextEditingController();
  var date = DateTime.now();
  final totalAmount = TextEditingController();

  final newProduct = new AddProduct(
      null, null, null, null, null, null, null, null, null, null);
  final _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<String> listOfCgst = [
      "14+14%",
      "9+9%",
      '6+6%',
      '4.5+4.5%',
      '2.5+2.5%',
      '1.5+1.5%'
    ];
    final listofIGST = ["28 %", "18%", '12%', '9%', '5%', '3%'];

    String cgst = listOfCgst[0];
    String igst = "28 %";
    final db = FirebaseFirestore.instance;
    Future<void> addproduct() {
      newProduct.productCode = productCodeController.text;
      newProduct.productName = productNameController.text;
      newProduct.hsncode = hsncodeController.text;
      newProduct.quantity = int.parse(quantityController.text);
      newProduct.cgst = cgst;
      newProduct.igst = igst;
      newProduct.date = date;
      newProduct.purchaserate = purchaserateController.text;
      newProduct.sellingprice = sellingpriceController.text;
      print(widget.uid.toString());
      newProduct.totalAmount = int.parse(totalAmount.text);
      // Call the user's CollectionReference to add a new user
      return db
          .collection("userData")
          .doc(widget.uid)
          .collection("Product")
          .doc(productCodeController.text)
          .set(newProduct.toJson());
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
          'Add Product',
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Add Product',
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
              Eachrow(productCodeController, "Product Code",
                  productNameController, 'Product Name'),
              SizedBox(
                height: 30,
              ),
              Eachrow(hsncodeController, "HSN Code", quantityController,
                  'Quantity'),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Card(
                    elevation: 4,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 60,
                      child: DropdownButtonFormField(
                        value: cgst,
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
                        onChanged: (String newValue) {
                          setState(() {
                            cgst = newValue;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Pease select CGST + SGST';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 60,
                      child: DropdownButtonFormField<String>(
                        value: igst,
                        icon: Icon(Icons.arrow_downward),
                        decoration: InputDecoration(
                          labelText: "IGST",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        items: listofIGST.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            igst = newValue;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Pease select IGST';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Eachrow(purchaserateController, "Purchase Rate",
                  sellingpriceController, "Selling price"),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Card(
                    elevation: 4,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 50,
                      child: TextField(
                        onTap: () => _selectDate(context),
                        readOnly: true,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            labelText:
                                "Date " + DateFormat().add_yMd().format(date)),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 50,
                      child: TextFormField(
                        controller: totalAmount,
                        decoration: InputDecoration(
                          labelText: "Total Amount",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Total Amount';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
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
