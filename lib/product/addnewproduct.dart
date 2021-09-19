import 'package:digitalbillbook/customwidgets/CustomInputDecorationWidget.dart';
import 'package:digitalbillbook/customwidgets/EachrowTextfield.dart';
import 'package:digitalbillbook/models/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
  final lowstockreminderat = TextEditingController();
  final purchaserateController = TextEditingController();
  final unitController = TextEditingController();
  final sellingpriceController = TextEditingController();

  final igstController = TextEditingController();
  final cgstController = TextEditingController();
  var date = DateTime.now();
  final totalAmount = TextEditingController();

  Function validation = (value) {
    if (value.isEmpty) {
      return 'Please Enter value';
    }
    return null;
  };

  final newProduct = new AddProduct(
      null, null, null, null, null, null, null, null, null, null, null, null);
  final _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<String> listOfCgst = [
      "14+14",
      "9+9",
      '6+6',
      '4.5+4.5',
      '2.5+2.5',
      '1.5+1.5'
    ];
    final listofIGST = ["28 ", "18", '12', '9', '5', '3'];
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
    String cgst = listOfCgst[0];
    String igst = "28 ";
    
    final db = FirebaseFirestore.instance;
    Future<void> addproduct() {
      newProduct.productCode = productCodeController.text;
      newProduct.productName = productNameController.text;
      newProduct.hsncode = hsncodeController.text;
      newProduct.quantity = int.parse(quantityController.text);
      newProduct.cgst = cgstController.text;
      newProduct.igst = igstController.text;
      newProduct.date = date;

      newProduct.purchaserate = purchaserateController.text;
      newProduct.sellingprice = sellingpriceController.text;
      newProduct.lowstockreminderat = int.parse(lowstockreminderat.text);
      newProduct.unit = unitController.text;
      newProduct.totalAmount = double.parse(totalAmount.text);
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
        leading: IconButton(icon:Icon(Icons.arrow_back_ios),
          onPressed: ()=> Navigator.of(context).pop(),),
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
                    fontSize: 20,
                    color: const Color(0xff2f2e41),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Eachrow(
                  productCodeController,
                  "Product Code",
                  TextInputType.text,
                  validation,
                  productNameController,
                  'Product Name',
                  TextInputType.text,
                  validation,
                  50),
              SizedBox(
                height: 12,
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
                            controller: hsncodeController,
                            decoration: CoustumInputDecorationWidget("HSN code")
                                .decoration(),
                            // The validator receives the text that the user has entered.
                            // validator:
                            //     (value) {
                            //         if (value.isEmpty) {
                            //           return null;
                            //         }
                            //         return null;
                            //       }
                            validator: (value) {
                              if (value.isEmpty) {
                                return null;
                              }
                              if (value.length == 3 ||
                                  value.length == 4 ||
                                  value.length == 6) {
                                return null;
                              } else {
                                return 'enter correct value';
                              }
                            }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Card(
                      elevation: 4,
                      child: Container(
                        //height: 50,
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                            controller: quantityController,
                            decoration: CoustumInputDecorationWidget('Quantity')
                                .decoration(),
                            onChanged: (value) {
                              setState(() {
                                String taxRate = igst;
                                // String result;
                                // result =
                                //     taxRate.substring(0, taxRate.length - 1);
                                var taxammount =
                                    (int.parse(purchaserateController.text) *
                                            int.parse(quantityController.text) *
                                            int.parse(taxRate)) /
                                        100;
                                var tam = (int.parse(
                                            purchaserateController.text) *
                                        int.parse(quantityController.text)) +
                                    taxammount;
                                totalAmount.text = tam.toString();
                              });
                            },
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter value";
                              }
                              return null;
                            }),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Card(
                    elevation: 4,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      //height: 50,
                      child: DropdownButtonFormField(
                        value: cgst,
                        icon: Padding(
                          padding: const EdgeInsets.only(right:10.0),
                          child: Icon(Icons.keyboard_arrow_down_sharp),
                        ),
                        decoration: CoustumInputDecorationWidget("CGST + SGST")
                            .decoration(),
                        items: [
                          "14+14",
                          "9+9",
                          '6+6',
                          '4.5+4.5',
                          '2.5+2.5',
                          '1.5+1.5'
                        ].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value.toString() + " %"),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            cgst = newValue;
                            cgstController.text = newValue;
                            print(cgst + 'MOHIT new value');
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
                      child: DropdownButtonFormField<String>(
                        value: igst,
                        icon: Padding(
                          padding: const EdgeInsets.only(right:10.0),
                          child: Icon(Icons.keyboard_arrow_down_sharp),
                        ),
                        decoration: InputDecoration(
                          labelText: "IGST",
                          contentPadding: const EdgeInsets.only(
                            left: 8.0,
                          ),
                        ),
                        items: listofIGST.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value + " %"),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            igst = newValue;
                            igstController.text = newValue ; 
                            String taxRate = igst;
                            // String result;
                            // result =
                            //     taxRate.substring(0, taxRate.length - 1);
                            var taxammount =
                                (int.parse(purchaserateController.text) *
                                        int.parse(quantityController.text) *
                                        int.parse(taxRate)) /
                                    100;
                            var tam = (int.parse(purchaserateController.text) *
                                    int.parse(quantityController.text)) +
                                taxammount;
                            totalAmount.text = tam.toString();
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
                height: 12,
              ),
              // Eachrow(
              //     purchaserateController,
              //     "Purchase Rate",
              //     TextInputType.numberWithOptions(),
              //     validation,
              //     sellingpriceController,
              //     "Selling price",
              //     TextInputType.numberWithOptions(),
              //     validation,
              //     10),
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
                            onChanged: (value) {
                              setState(() {
                                String taxRate = igst;
                                // String result;
                                // result =
                                //     taxRate.substring(0, taxRate.length - 1);
                                var taxammount =
                                    (int.parse(purchaserateController.text) *
                                            int.parse(quantityController.text) *
                                            int.parse(taxRate)) /
                                        100;
                                var tam = (int.parse(
                                            purchaserateController.text) *
                                        int.parse(quantityController.text)) +
                                    taxammount;
                                totalAmount.text = tam.toString();
                              });
                            },
                            controller: purchaserateController,
                            decoration:
                                CoustumInputDecorationWidget("Purchase Rate")
                                    .decoration(),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value.isEmpty) {
                                return "enter value";
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
                        //height: 50,
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                            //inputFormatters: [new LengthLimitingTextInputFormatter(inputformates)],
                            //  keyboardType: keyboardTypeC2,
                            controller: sellingpriceController,
                            decoration:
                                CoustumInputDecorationWidget("Selling Rate")
                                    .decoration(),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value.isEmpty) {
                                return "enter value";
                              }
                              return null;
                            }),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Card(
                    elevation: 4,
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        //  alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 18, 8, 0),
                          child: Text("Date          " +
                              DateFormat().add_yMd().format(date)),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                        controller: totalAmount,
                        decoration: CoustumInputDecorationWidget("Total Amount")
                            .decoration(),
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
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Card(
                      // elevation: 4,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        // height: 50,
                        child: DropdownButtonFormField<String>(
                          style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Arial',
                            fontSize: 12,
                          ),
                          value: 'OTH-OTHERS',
                          icon: Icon(Icons.keyboard_arrow_down_sharp),
                          decoration: InputDecoration(
                            labelText: "Unit",
                            contentPadding: const EdgeInsets.only(
                                left: 8.0, bottom: 1.0, top: 1, right: 0),
                          ),
                          items: units.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              unitController.text = newValue.substring(0, 3);
                              print(unitController.text);
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
                          controller: lowstockreminderat,
                          decoration: CoustumInputDecorationWidget(
                                  'Remind Low Stock at')
                              .decoration(),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter ' + 'Remind Low Stock at';
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
                height: 60,
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
                      width:200 ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      color: const Color(0xfff3F3D56),
                      ),
                      child: Center(
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
