import 'dart:io';

import 'package:digitalbillbook/models/invoicemodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:typed_data';
import 'package:number_to_words/number_to_words.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalbillbook/models/businessprofile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PurchasePdf extends StatefulWidget {
  final String uid;
  final bool generalreportornot;
  final invoiceid;
  final Uint8List sign, stamp, logo;
  PurchasePdf(this.uid, this.generalreportornot, this.invoiceid, this.sign,
      this.stamp, this.logo);
  @override
  _PurchasePdfState createState() => _PurchasePdfState();
}

class _PurchasePdfState extends State<PurchasePdf> {
  List<LayoutCallback> _tabGen;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _gettermsandcondition(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _tabGen = <LayoutCallback>[generateInvoice];
    return Scaffold(
        body: PdfPreview(
      allowPrinting: false,
      initialPageFormat: PdfPageFormat.a4,
      pdfFileName: 'Invoice ' + widget.invoiceid,
      canChangePageFormat: false,
      actions: [
        PdfPreviewAction(
            icon: Icon(
              Icons.edit,
            ),
            onPressed: (
              BuildContext context,
              LayoutCallback build,
              PdfPageFormat pageFormat,
            ) async {
              Navigator.pop(context);
            })
      ],
      build: _tabGen[0],
    ));
  }

  final db = FirebaseFirestore.instance;
  final businessNameController = TextEditingController();
  final phoneController = TextEditingController();
  final authorisedSignatureController = TextEditingController();
  final iconController = TextEditingController();
  final signatureController = TextEditingController();
  final termsandcondition = TextEditingController();
  final businessStampController = TextEditingController();
  final emailController = TextEditingController();
  final gstNumberController = TextEditingController();
  final businesAddressController = TextEditingController();
  final industryTypeController = TextEditingController();
  final businessTypeController = TextEditingController();
  final bankNameController = TextEditingController();
  final ifscCodeController = TextEditingController();
  final accountNumberController = TextEditingController();
  final branchNameController = TextEditingController();
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
  var taxamount = TextEditingController();
  final totalamount = TextEditingController();
  final transporterid = TextEditingController();
  final transportername = TextEditingController();
  final transportdocno = TextEditingController();
  final tdate = TextEditingController();
  final vehiclemode = TextEditingController();
  final vehicleno = TextEditingController();
  final from = TextEditingController();
  final taxtype = TextEditingController();
  String discountStr;
  String roundoffStr;
  String tcsStr;
  String totaltaxStr;
  double discount = 0;
  double roundoff = 0.0;
  double tcs = 0;
  double totaltax = 0;
  final businessInfo = new BusinessProfile(
      '', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',' ');
  final invoicedetails = new InvoiceModel(
      '',
      ' ',
      ' ',
      '',
      ' ',
      DateTime.now(),
      ' ',
      ' ',
      ' ',
      ' ',
      ' ',
      ' ',
      ' ',
      DateTime.now(),
      ' ',
      ' ',
      ' ',
      ' ',
      null,
      ' ',
      ' ',
      ' ',
      DateTime.now(),
      ' ',
      ' ',
      null,
      null,
      null,
      null,
      null);
  Future<Null> _getBusinessDetails(String uid) async {
    await db
        .collection("userData")
        .doc(uid)
        .collection("BusinessInfo")
        .doc('businessName')
        .get()
        .then((valuee) {
      setState(() {
        bankNameController.text =
            valuee.data()['bankName'] == null ? '' : valuee.data()['bankName'];
        accountNumberController.text = valuee.data()['accountNumber'] == null
            ? ''
            : valuee.data()['accountNumber'];
        ifscCodeController.text =
            valuee.data()['ifscCode'] == null ? '' : valuee.data()['ifscCode'];
        branchNameController.text = valuee.data()['branchName'] == null
            ? ''
            : valuee.data()['branchName'];
        businessNameController.text = valuee.data()['businessName'] == null
            ? ''
            : valuee.data()['businessName'];
        businesAddressController.text = valuee.data()['businessAddress'] == null
            ? ''
            : valuee.data()['businessAddress'];
        gstNumberController.text = valuee.data()['gstNumber'] == null
            ? ''
            : valuee.data()['gstNumber'];
        emailController.text =
            valuee.data()['email'] == null ? '' : valuee.data()['email'];
        phoneController.text =
            valuee.data()['phone'] == null ? '' : valuee.data()['phone'];
      });
    });
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
        termsandcondition.text = valuee.data()['termsAndCondition'] == null
            ? ''
            : valuee.data()['termsAndCondition'];
      });
    });
  }

  Map<String, dynamic> m;
  List<Map<String, dynamic>> l = [];
  List<Map<String, dynamic>> l2 = [];
  var taxes = new Map();
  Future<Null> _invoicedetails(String uid) async {
    await db
        .collection("userData")
        .doc(uid)
        .collection("PurchaseInvoice")
        .doc(widget.invoiceid)
        .get()
        .then((valuee) {
      setState(() {
        invoiceno.text = valuee.data()['invoiceno'] == null
            ? ''
            : valuee.data()['invoiceno'];
        bname.text =
            valuee.data()['bname'] == null ? '' : valuee.data()
            
            ['bname'];
        bphone.text =
            valuee.data()['bphone'] == null ? '' : valuee.data()['bphone'];
        bcity.text =
            valuee.data()['bcity;'] == null ? '' : valuee.data()['bcity;'];
        bgstn.text =
            valuee.data()['bgstn'] == null ? '' : valuee.data()['bgstn'];
        sname.text =
            valuee.data()['sname'] == null ? '' : valuee.data()['sname'];
        bstate.text =
            valuee.data()['bstate'] == null ? '' : valuee.data()['bstate'];
        scity.text =
            valuee.data()['scity;'] == null ? '' : valuee.data()['scity;'];
        sstate.text =
            valuee.data()['sstate'] == null ? '' : valuee.data()['sstate'];
        sphone.text =
            valuee.data()['sphone'] == null ? '' : valuee.data()['sphone'];
        sgstn.text =
            valuee.data()['sgstn'] == null ? '' : valuee.data()['sgstn'];
        vehiclemode.text = valuee.data()['vehiclemode'] == null
            ? ''
            : valuee.data()['vehiclemode'];
        vehicleno.text = valuee.data()['vehicleno'] == null
            ? ''
            : valuee.data()['vehicleno'];
        transportdocno.text = valuee.data()['tracnsportdocno'] == null
            ? ''
            : valuee.data()['tracnsportdocno'];
        taxtype.text =
            valuee.data()['taxtype'] == null ? '' : valuee.data()['taxtype'];
        discountStr =
            valuee.data()['discount'] == null ? '' : valuee.data()['discount'];
        tcsStr = valuee.data()['tcs'] == null ? '' : valuee.data()['tcs'];
        if (tcsStr.isNotEmpty) {
          tcs = double.tryParse(tcsStr);
        }
        roundoffStr =
            valuee.data()['roundoff'] == null ? '' : valuee.data()['roundoff'];
        if (roundoffStr.isNotEmpty) {
          roundoff = double.tryParse(roundoffStr);
        }

        if (discountStr.isNotEmpty) {
          discount = double.tryParse(discountStr);
        }

        l = List.castFrom(valuee.data()['listOfProducts']);
        l2 = List.castFrom(valuee.data()['othercharges']);
        print(l);
      });
    });
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    yield* FirebaseFirestore.instance
        .collection("userData")
        .doc(widget.uid)
        .collection("PurchaseInvoice")
        .snapshots();
  }

  Future<Uint8List> generateInvoice(PdfPageFormat pageFormat) async {
    await _getBusinessDetails(widget.uid);
    await _invoicedetails(widget.uid);

    double totalquantity = 0, totalamount = 0, finalamount = 0;
    l.forEach((element) {
      setState(() {
        taxes[element['taxrate']] = 0.00;
        totalquantity =
            totalquantity + double.tryParse(element['quantity'].toString());
        totalamount =
            totalamount + double.tryParse(element['baseTotalAmount'].toString());
      });
    });
    setState(() {
      finalamount = totalamount;
    });
    l.forEach((element) {
      setState(() {
        taxes[element['taxrate']] =
            taxes[element['taxrate']] + double.tryParse(element['baseTotalAmount']);
        print(taxes[element['taxrate']]);
      });
    });
    taxes.forEach((key, value) {
      setState(() {
        finalamount = finalamount +
            (double.tryParse(key.toString()) *
                    double.tryParse(value.toString()) /
                    100.0)
                .toDouble();
      });
    });
    l2.forEach((element) {
      setState(() {
        finalamount = finalamount + (element['otherchargevalue']);
      });
    });
    setState(() {
      finalamount = finalamount - (discount * totalamount / 100)+(tcs*totalamount/100) + roundoff;
    });

    final pdf = pw.Document();
    Future<void> uploadtostorage() async {
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/" + widget.invoiceid + "example.pdf");
      file.writeAsBytes(await pdf.save());
      await firebase_storage.FirebaseStorage.instance
          .ref(widget.uid + '/PurchaseInvoice/' + widget.invoiceid + '.pdf')
          .putFile(file)
          .catchError((onerror) {
        print(onerror);
      });
    }

    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.standard,
          margin: pw.EdgeInsets.only(top: 10, right: 30, left: 30, bottom: 10),
          header: (pw.Context context) {
            return widget.generalreportornot == false
                ? pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                        pw.Align(
                          alignment: pw.Alignment.topRight,
                          child: pw.SizedBox(
                            width: 120.0, 
                            child: pw.Text(
                              'Duplicate  for Buyer',
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColor.fromInt(0xff2f2e41),
                              ),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                        ),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                            children: [
                              pw.SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: widget.logo == null
                                      ? pw.Container()
                                      : pw.Image(pw.MemoryImage(widget.logo))
                                  //  child: null,
                                  ),
                              pw.Column(children: [
                                pw.Text(
                                  sname.text,
                                  style: pw.TextStyle(
                                    fontSize: 25,
                                    color: PdfColor.fromInt(0xff2f2e41),
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 242.0,
                                  child: pw.Text(
                                    businesAddressController.text,
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColor.fromInt(0xff2f2e41),
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                )
                              ]),
                              pw.SizedBox(width: 50.0, height: 50.0, child: null
                                  //  child: null,
                                  ),
                            ]),
                                  pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child:pw.Container(
                                width: 91.0,
                                child: pw.Row(

                                  children:[pw.Text(
                                  'GSTN : ' ,
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    color: PdfColor.fromInt(0xff2f2e41),
                                  ),
                                  textAlign: pw.TextAlign.center,
                                ),
                                pw.Text(
                                   sgstn.text,
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    color: PdfColor.fromInt(0xff2f2e41),
                                  ),
                                  textAlign: pw.TextAlign.center,
                                ),])
                              ), ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                            width: 122,
                             child: pw.Row(
                                  children:[
                             pw.Text(
                              'Email : ',
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColor.fromInt(0xff2f2e41),
                              ),
                              textAlign: pw.TextAlign.center,
                            ), pw.Text(
                            emailController.text,
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColor.fromInt(0xff2f2e41),
                              ),
                              textAlign: pw.TextAlign.center,
                            )]),
                          ),),
                            pw.Expanded(
                            flex: 1,
                            child:
                          pw.Container(
                            width: 89.0,
                            child:
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.end,
                              children: [pw.Text(
                              'Phone No.: ',
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColor.fromInt(0xff2f2e41),
                              ),
                              textAlign: pw.TextAlign.center,
                            ),pw.Text(
                            sphone.text,
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColor.fromInt(0xff2f2e41),
                              ),
                              textAlign: pw.TextAlign.center,
                            ),]), 
                          ), )
                          
                        ]),
                        // pw.Row(
                        //     mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       pw.SizedBox(
                        //         width: 96.0,
                        //         child: pw.Text(
                        //           'GSTN : ' + sgstn.text,
                        //           style: pw.TextStyle(
                        //             fontSize: 13,
                        //             color: PdfColor.fromInt(0xff2f2e41),
                        //           ),
                        //           textAlign: pw.TextAlign.center,
                        //         ),
                        //       ),
                        //       pw.SizedBox(
                        //         width: 96.0,
                        //         child: pw.Text(
                        //           'Email : ' + 
                        //           emailController.text,
                        //           style: pw.TextStyle(
                        //             fontSize: 13,
                        //             color: PdfColor.fromInt(0xff2f2e41),
                        //           ),
                        //           textAlign: pw.TextAlign.center,
                        //         ),
                        //       ),
                        //       pw.SizedBox(
                        //         width: 96.0,
                        //         child: pw.Text(
                        //           'Phone No. : ' +sphone.text,
                        //           style: pw.TextStyle(
                        //             fontSize: 13,
                        //             color: PdfColor.fromInt(0xff2f2e41),
                        //           ),
                        //           textAlign: pw.TextAlign.center,
                        //         ),
                        //       ),
                        //     ]),
                      
                        pw.SizedBox(height: 10),
                        pw.Container(height: 2, color: PdfColors.black),
                        pw.SizedBox(height: 10),
                        pw.Container(
                            padding: pw.EdgeInsets.all(10),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Row(children: [
                              pw.SizedBox(width: 20),
                              pw.Container(
                                width: 100,
                                child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        'Invoice No :',
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                      pw.Text(
                                        'Date of Invoice : ',
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                      pw.Text(
                                        'State  :',
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                      pw.Text(
                                        'Reverse Charge : ',
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                       pw.Text(
                                        'Date of Shipment',
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    
                                    ]),
                              ),
                               pw.Container(
                                width: 162,
                                child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                         invoiceno.text,
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                      pw.Text(
                                            DateFormat('dd-MM-yyyy')
                                                .format(DateTime.now())
                                                .toString(),
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                      pw.Text(
                                         bstate.text,
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                      pw.Text(
                                        '    N',
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                     pw.Text(
                                        '    N',
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    
                                    ]),
                              ),
                              pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      'Transport :          ' +
                                          vehiclemode.text,
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        color: PdfColor.fromInt(0xff2f2e41),
                                      ),
                                      textAlign: pw.TextAlign.left,
                                    ),
                                    pw.Text(
                                      'Vehicle No :         ' + vehicleno.text,
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        color: PdfColor.fromInt(0xff2f2e41),
                                      ),
                                      textAlign: pw.TextAlign.left,
                                    ),
                                    pw.Text(
                                      'Place of Supply :    ' + scity.text,
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        color: PdfColor.fromInt(0xff2f2e41),
                                      ),
                                      textAlign: pw.TextAlign.left,
                                    ),
                                    pw.Text(
                                      'GR No :              ' +
                                          transportdocno.text,
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        color: PdfColor.fromInt(0xff2f2e41),
                                      ),
                                      textAlign: pw.TextAlign.left,
                                    ),
                                  ])
                            ])),
                        pw.Row(children: [
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Padding(
                                  padding:
                                      pw.EdgeInsets.only(top: 10, bottom: 10),
                                  child: pw.Text(
                                    'Billed to :  ',
                                    style: pw.TextStyle(
                                      fontSize: 15,
                                      color: PdfColor.fromInt(0xff2f2e41),
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                    textAlign: pw.TextAlign.left,
                                  ),
                                ),
                                pw.Container(
                                  padding: pw.EdgeInsets.all(10),
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  width: 530,
                                  child: pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                                    children: [
                                    pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Container(
                                            height: 20,
                                            child: pw.Row(children: [
                                              pw.Container(
                                                  width: 100,
                                                  alignment:
                                                      pw.Alignment.topLeft,
                                                  child: pw.Text(
                                                    'Name :',
                                                    style: pw.TextStyle(
                                                      fontSize: 13,
                                                      color: PdfColor.fromInt(
                                                          0xff2f2e41),
                                                    ),
                                                    textAlign:
                                                        pw.TextAlign.left,
                                                  )),
                                              pw.Container(
                                                  alignment:
                                                      pw.Alignment.topLeft,
                                                  width: 150,
                                                  child: pw.Text(
                                                    businessNameController.text,
                                                    style: pw.TextStyle(
                                                      fontSize: 13,
                                                      color: PdfColor.fromInt(
                                                          0xff2f2e41),
                                                    ),
                                                  )),
                                            ]),
                                          ),
                                          pw.SizedBox(height: 5),
                                          pw.Container(
                                              height: 50,
                                              child: pw.Row(children: [
                                                pw.Container(
                                                    width: 100,
                                                    alignment:
                                                        pw.Alignment.topLeft,
                                                    child: pw.Text(
                                                      'Address :',
                                                      style: pw.TextStyle(
                                                        fontSize: 13,
                                                        color: PdfColor.fromInt(
                                                            0xff2f2e41),
                                                      ),
                                                      textAlign:
                                                          pw.TextAlign.left,
                                                    )),
                                                pw.Container(
                                                    alignment:
                                                        pw.Alignment.topLeft,
                                                    width: 150,
                                                    child: pw.Text(
                                                      businesAddressController
                                                          .text,
                                                      style: pw.TextStyle(
                                                        fontSize: 13,
                                                        color: PdfColor.fromInt(
                                                            0xff2f2e41),
                                                      ),
                                                      //    textAlign: pw.TextAlign.center,
                                                    )),
                                              ])),
                                        ]),
                                    pw.Column(
                                      crossAxisAlignment:
                                            pw.CrossAxisAlignment.start, 
                                      children: [
                                      pw.Container(
                                        height: 20,
                                        child: pw.Row(children: [
                                          pw.Container(
                                              width: 100,
                                              alignment: pw.Alignment.topLeft,
                                              child: pw.Text(
                                                'Mobile No. :',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                  color: PdfColor.fromInt(
                                                      0xff2f2e41),
                                                ),
                                                textAlign: pw.TextAlign.left,
                                              )),
                                          pw.Container(
                                              alignment: pw.Alignment.topLeft,
                                              width: 150,
                                              child: pw.Text(
                                                phoneController.text,
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                  color: PdfColor.fromInt(
                                                      0xff2f2e41),
                                                ),
                                              )),
                                        ]),
                                      ),
                                       pw.SizedBox(height: 5),
                                          pw.Container(
                                              height: 20,
                                              child: pw.Row(children: [
                                                pw.Container(
                                                    width: 100,
                                                    alignment:
                                                        pw.Alignment.topLeft,
                                                    child: pw.Text(
                                                      'Email : ',
                                                      style: pw.TextStyle(
                                                        fontSize: 13,
                                                        color: PdfColor.fromInt(
                                                            0xff2f2e41),
                                                      ),
                                                      textAlign:
                                                          pw.TextAlign.left,
                                                    )),
                                                pw.Container(
                                                    alignment:
                                                        pw.Alignment.topLeft,
                                                    width: 150,
                                                    child: pw.Text(
                                                      //mohit todo 
                                                      emailController.text.toString().length>19? emailController.text.toString().substring(0,emailController.text.toString().lastIndexOf("@")) : emailController.text,
                                                      style: pw.TextStyle(
                                                        fontSize: 13,
                                                        color: PdfColor.fromInt(
                                                            0xff2f2e41),
                                                      ),
                                                      //    textAlign: pw.TextAlign.center,
                                                    )),
                                              ])),
                                      pw.SizedBox(height: 5),
                                          pw.Container(
                                              height: 30,
                                              child: pw.Row(children: [
                                                pw.Container(
                                                    width: 100,
                                                    alignment:
                                                        pw.Alignment.topLeft,
                                                    child: pw.Text(
                                                      'GSTN : ',
                                                      style: pw.TextStyle(
                                                        fontSize: 13,
                                                        color: PdfColor.fromInt(
                                                            0xff2f2e41),
                                                      ),
                                                      textAlign:
                                                          pw.TextAlign.left,
                                                    )),
                                                pw.Container(
                                                    alignment:
                                                        pw.Alignment.topLeft,
                                                    width: 150,
                                                    child: pw.Text(
                                                      gstNumberController.text,
                                                      style: pw.TextStyle(
                                                        fontSize: 13,
                                                        color: PdfColor.fromInt(
                                                            0xff2f2e41),
                                                      ),
                                                      //    textAlign: pw.TextAlign.center,
                                                    )),
                                              ])),
                                    ]),
                                  ]),
                                )
                              ]),
                          pw.SizedBox(width: 10),
                          // pw.Container(
                          //         padding: pw.EdgeInsets.all(10),
                          //         decoration: pw.BoxDecoration(
                          //             border: pw.Border.all()),
                          //   child: pw.Text('here new one'),
                          //             )
                          // pw.Column(
                          //     crossAxisAlignment: pw.CrossAxisAlignment.start,
                          //     children: [
                          //       pw.Padding(
                          //         padding:
                          //             pw.EdgeInsets.only(top: 10, bottom: 10),
                          //         child: pw.Text(
                          //           'Shipped to :',
                          //           style: pw.TextStyle(
                          //             fontSize: 15,
                          //             color: PdfColor.fromInt(0xff2f2e41),
                          //             fontWeight: pw.FontWeight.bold,
                          //           ),
                          //           textAlign: pw.TextAlign.left,
                          //         ),
                          //       ),
                          //       pw.Container(
                          //           padding: pw.EdgeInsets.all(10),
                          //           decoration: pw.BoxDecoration(
                          //               border: pw.Border.all()),
                          //           width: 262,
                          //           child: pw.Column(
                          //               crossAxisAlignment:
                          //                   pw.CrossAxisAlignment.start,
                          //               children: [
                          //                 pw.Text(
                          //                   'Name :       ' + sname.text,
                          //                   style: pw.TextStyle(
                          //                     fontSize: 13,
                          //                     color:
                          //                         PdfColor.fromInt(0xff2f2e41),
                          //                   ),
                          //                   textAlign: pw.TextAlign.left,
                          //                 ),
                          //                 pw.Text(
                          //                   'Address :    ' +
                          //                       scity.text +
                          //                       ', ' +
                          //                       sstate.text +
                          //                       ', ' +
                          //                       scountry.text,
                          //                   style: pw.TextStyle(
                          //                     fontSize: 13,
                          //                     color:
                          //                         PdfColor.fromInt(0xff2f2e41),
                          //                   ),
                          //                   textAlign: pw.TextAlign.left,
                          //                 ),
                          //                 pw.Text(
                          //                   'Mobile No. :  ' + sphone.text,
                          //                   style: pw.TextStyle(
                          //                     fontSize: 13,
                          //                     color:
                          //                         PdfColor.fromInt(0xff2f2e41),
                          //                   ),
                          //                   textAlign: pw.TextAlign.left,
                          //                 ),
                          //                 pw.Text(
                          //                   'GSTN :        ' + sgstn.text,
                          //                   style: pw.TextStyle(
                          //                     fontSize: 13,
                          //                     color:
                          //                         PdfColor.fromInt(0xff2f2e41),
                          //                   ),
                          //                   textAlign: pw.TextAlign.left,
                          //                 ),
                          //               ])),
                          //     ])
                        ]),
                        pw.SizedBox(height: 20),
                        
        //     pw.Column(
        //       crossAxisAlignment: pw.CrossAxisAlignment.start,
        //       mainAxisAlignment: pw.MainAxisAlignment.start,
        //       children: [
        //         pw.Row(
        //           mainAxisAlignment: pw.MainAxisAlignment.start,
        //           crossAxisAlignment: pw.CrossAxisAlignment.start,
        //           children: [
        //             pw.Container(
        //                 height: 100,
        //                 width: 250,
        //                 child: pw.Padding(
        //                   padding: const pw.EdgeInsets.all(8.0),
        //                   child: pw.Column(
        //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
        //                       mainAxisAlignment: pw.MainAxisAlignment.start,
        //                       children: [
        //                         pw.Text(

        //                           'Company Bank A/C Details',
        //                           style: pw.TextStyle(
        //                             fontSize: 14,
        //                             color: PdfColor.fromInt(0xff2f2e41),
        //                             fontWeight: pw.FontWeight.bold,
        //                           ),
        //                           textAlign: pw.TextAlign.left,
        //                         ),
        //                         pw.Text(
        //                           'Account Number : ' +
        //                               accountNumberController.text,
        //                           style: pw.TextStyle(
        //                             fontSize: 12,
        //                             color: PdfColor.fromInt(0xff2f2e41),
        //                           ),
        //                           textAlign: pw.TextAlign.left,
        //                         ),
        //                         pw.Text(
        //                           'ifsc Code : ' + ifscCodeController.text,
        //                           style: pw.TextStyle(
        //                             fontSize: 12,
        //                             color: PdfColor.fromInt(0xff2f2e41),
        //                           ),
        //                           textAlign: pw.TextAlign.left,
        //                         ),
        //                         pw.Text(
        //                           'Bank Number : ' + bankNameController.text,
        //                           style: pw.TextStyle(
        //                             fontSize: 12,
        //                             color: PdfColor.fromInt(0xff2f2e41),
        //                           ),
        //                           textAlign: pw.TextAlign.left,
        //                         ),
        //                         pw.Text(
        //                           'Branch Name : ' + branchNameController.text,
        //                           style: pw.TextStyle(
        //                             fontSize: 12,
        //                             color: PdfColor.fromInt(0xff2f2e41),
        //                           ),
        //                           textAlign: pw.TextAlign.left,
        //                         ),
        //                       ]),
        //                 ),
        //                 decoration: pw.BoxDecoration(
        //                     border: pw.Border.all(width: 0.5))),
        //             pw.Container(
        //                 height: 100,
        //                 width: 280,
        //                 child: pw.Padding(
        //                   padding: const pw.EdgeInsets.all(8.0),
        //                   child: pw.Column(
        //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
        //                       mainAxisAlignment: pw.MainAxisAlignment.start,
        //                       children: [
        //                         pw.Text(
        //                           'Terms & Condition',
        //                           style: pw.TextStyle(
        //                             fontSize: 14,
        //                             color: PdfColor.fromInt(0xff2f2e41),
        //                             fontWeight: pw.FontWeight.bold,
        //                           ),
        //                           textAlign: pw.TextAlign.left,
        //                         ),
        //                         pw.Text(
        //                           termsandcondition.text,
        //                           style: pw.TextStyle(
        //                             fontSize: 14,
        //                             color: PdfColor.fromInt(0xff2f2e41),
        //                           ),
        //                           textAlign: pw.TextAlign.left,
        //                         ),
        //                       ]),
        //                 ),
        //                 decoration: pw.BoxDecoration(
        //                     border: pw.Border.all(width: 0.5))),
        //           ],
        //         ),
        //         pw.SizedBox(height: 20),
        //         //mohit here the problems

        //          pw.Align(
        //           alignment: pw.Alignment.centerRight,
        //           child: pw.Column(
        //               mainAxisAlignment: pw.MainAxisAlignment.end,
        //               children: [
        //                 pw.SizedBox(
        //                   child: pw.SizedBox(
        //                       width: 50.0,
        //                       height: 50.0,
        //                       child: widget.stamp == null
        //                           ? pw.Container()
        //                           : pw.Image(pw.MemoryImage(widget.stamp))
        //                       //  child: null,
        //                       ),
        //                 ),
        //                 pw.Text(
        //                   'For ' + businessNameController.text,
        //                   style: pw.TextStyle(
        //                     fontSize: 10,
        //                     color: PdfColor.fromInt(0xff2f2e41),
        //                     fontWeight: pw.FontWeight.bold,
        //                   ),
        //                   textAlign: pw.TextAlign.left,
        //                 ),
        //                 pw.SizedBox(
        //                   child: pw.SizedBox(
        //                       width: 50.0,
        //                       height: 50.0,
        //                       child:
        //                         widget.sign == null
        //                               ? pw.Container()
        //                               : pw.Image(pw.MemoryImage(widget.sign))
        //                       //  child: null,
        //                       ),
        //                 ),
        //                 pw.Text(
        //                   'Authorised Signatory',
        //                   style: pw.TextStyle(
        //                     fontSize: 10,
        //                     color: PdfColor.fromInt(0xff2f2e41),
        //                     fontWeight: pw.FontWeight.bold,
        //                   ),
        //                   textAlign: pw.TextAlign.left,
        //                 ),
        //               ]),
        //         ),
        //          pw.SizedBox(height: 50),
        //         pw.Align(
        //             alignment: pw.Alignment.center,
        //             child: pw.Text(
        //               'This is a Computer Generated Invoice ',
        //               style: pw.TextStyle(
        //                 fontSize: 12,
        //                 color: PdfColor.fromInt(0xff2f2e41),
        //                 fontWeight: pw.FontWeight.bold,
        //               ),
        //               textAlign: pw.TextAlign.left,
        //             )),

        //       ],
        //     )        
                      
                      
                      ])
                : 
                pw.Column(children: [
                    pw.Align(
                      alignment: pw.Alignment.topRight,
                      child: pw.SizedBox(
                        width: 100.0,
                        child: pw.Text(
                          'Original for Buyer',
                          style: pw.TextStyle(
                            fontSize: 12,
                            color: PdfColor.fromInt(0xff2f2e41),
                          ),
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                    ),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                        children: [
                          pw.SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: pw.Image(pw.MemoryImage(widget.logo))
                              //  child: null,
                              ),
                          pw.Column(children: [
                            pw.Text(
                              businessNameController.text,
                              style: pw.TextStyle(
                                fontSize: 25,
                                color: PdfColor.fromInt(0xff2f2e41),
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(
                              width: 242.0,
                              child: pw.Text(
                                businesAddressController.text,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  color: PdfColor.fromInt(0xff2f2e41),
                                ),
                                textAlign: pw.TextAlign.center,
                              ),
                            )
                          ]),
                          pw.SizedBox(width: 50.0, height: 50.0, child: null
                              //  child: null,
                              ),
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Container(
                        padding: pw.EdgeInsets.all(10),
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Row(children: [
                          pw.SizedBox(width: 20),
                          pw.Container(
                            width: 262,
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    'Invoice No :        ' + invoiceno.text,
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColor.fromInt(0xff2f2e41),
                                    ),
                                    textAlign: pw.TextAlign.left,
                                  ),
                                  pw.Text(
                                    'Date of Invoice :   ' +
                                        DateFormat('dd/MM/yyyy')
                                            .format(DateTime.now())
                                            .toString(),
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColor.fromInt(0xff2f2e41),
                                    ),
                                    textAlign: pw.TextAlign.left,
                                  ),
                                  pw.Text(
                                    'State  :' + bstate.text,
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColor.fromInt(0xff2f2e41),
                                    ),
                                    textAlign: pw.TextAlign.left,
                                  ),
                                  pw.Text(
                                    'Reverse Charge :    N',
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColor.fromInt(0xff2f2e41),
                                    ),
                                    textAlign: pw.TextAlign.left,
                                  ),
                                ]),
                          ),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Transport :          ' + vehiclemode.text,
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    color: PdfColor.fromInt(0xff2f2e41),
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                                pw.Text(
                                  'Vehicle No :         ' + vehicleno.text,
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    color: PdfColor.fromInt(0xff2f2e41),
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                                pw.Text(
                                  'Place of Supply :    ',
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    color: PdfColor.fromInt(0xff2f2e41),
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                                pw.Text(
                                  'eWaybill No :        ',
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    color: PdfColor.fromInt(0xff2f2e41),
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                                pw.Text(
                                  'GR No :              ',
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    color: PdfColor.fromInt(0xff2f2e41),
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ])
                        ])),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.only(top: 10, bottom: 10),
                        child: pw.Text(
                          'Billed to :  ',
                          style: pw.TextStyle(
                            fontSize: 15,
                            color: PdfColor.fromInt(0xff2f2e41),
                            fontWeight: pw.FontWeight.bold,
                          ),
                          textAlign: pw.TextAlign.left,
                        ),
                      ),
                    ),
                    pw.Container(
                        // width: 600,
                        height: 200,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(width: 1),
                        ),
                        child: pw.Row(children: [
                          pw.SizedBox(width: 60),
                          pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(height: 10),
                              pw.Text(
                                'Name :        ' + sname.text,
                                style: pw.TextStyle(
                                  fontSize: 13,
                                  color: PdfColor.fromInt(0xff2f2e41),
                                ),
                                textAlign: pw.TextAlign.left,
                              ),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                'Mobile No :        ' + sphone.text,
                                style: pw.TextStyle(
                                  fontSize: 13,
                                  color: PdfColor.fromInt(0xff2f2e41),
                                ),
                                textAlign: pw.TextAlign.left,
                              ),
                            ],
                          ),
                          pw.SizedBox(width: 140),
                          pw.Column(
                            children: [
                              pw.SizedBox(height: 10),
                              pw.Text(
                                'GST :        ' + sgstn.text,
                                style: pw.TextStyle(
                                  fontSize: 13,
                                  color: PdfColor.fromInt(0xff2f2e41),
                                ),
                                textAlign: pw.TextAlign.left,
                              ),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                '',
                                style: pw.TextStyle(
                                  fontSize: 13,
                                  color: PdfColor.fromInt(0xff2f2e41),
                                ),
                                textAlign: pw.TextAlign.left,
                              ),
                            ],
                          ),
                        ])),
                    pw.SizedBox(height: 20),
                    
                           
                  ]);
          },

        //   footer: (pw.Context context) {
        //     return 
            
        //     pw.Column(
        //       crossAxisAlignment: pw.CrossAxisAlignment.start,
        //       mainAxisAlignment: pw.MainAxisAlignment.start,
        //       children: [
        //         pw.Row(
        //           mainAxisAlignment: pw.MainAxisAlignment.start,
        //           crossAxisAlignment: pw.CrossAxisAlignment.start,
        //           children: [
        //             pw.Container(
        //                 height: 100,
        //                 width: 250,
        //                 child: pw.Padding(
        //                   padding: const pw.EdgeInsets.all(8.0),
        //                   child: pw.Column(
        //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
        //                       mainAxisAlignment: pw.MainAxisAlignment.start,
        //                       children: [
        //                         pw.Text(

        //                           'Company Bank A/C Details',
        //                           style: pw.TextStyle(
        //                             fontSize: 14,
        //                             color: PdfColor.fromInt(0xff2f2e41),
        //                             fontWeight: pw.FontWeight.bold,
        //                           ),
        //                           textAlign: pw.TextAlign.left,
        //                         ),
        //                         pw.Text(
        //                           'Account Number : ' +
        //                               accountNumberController.text,
        //                           style: pw.TextStyle(
        //                             fontSize: 12,
        //                             color: PdfColor.fromInt(0xff2f2e41),
        //                           ),
        //                           textAlign: pw.TextAlign.left,
        //                         ),
        //                         pw.Text(
        //                           'ifsc Code : ' + ifscCodeController.text,
        //                           style: pw.TextStyle(
        //                             fontSize: 12,
        //                             color: PdfColor.fromInt(0xff2f2e41),
        //                           ),
        //                           textAlign: pw.TextAlign.left,
        //                         ),
        //                         pw.Text(
        //                           'Bank Number : ' + bankNameController.text,
        //                           style: pw.TextStyle(
        //                             fontSize: 12,
        //                             color: PdfColor.fromInt(0xff2f2e41),
        //                           ),
        //                           textAlign: pw.TextAlign.left,
        //                         ),
        //                         pw.Text(
        //                           'Branch Name : ' + branchNameController.text,
        //                           style: pw.TextStyle(
        //                             fontSize: 12,
        //                             color: PdfColor.fromInt(0xff2f2e41),
        //                           ),
        //                           textAlign: pw.TextAlign.left,
        //                         ),
        //                       ]),
        //                 ),
        //                 decoration: pw.BoxDecoration(
        //                     border: pw.Border.all(width: 0.5))),
        //             pw.Container(
        //                 height: 100,
        //                 width: 280,
        //                 child: pw.Padding(
        //                   padding: const pw.EdgeInsets.all(8.0),
        //                   child: pw.Column(
        //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
        //                       mainAxisAlignment: pw.MainAxisAlignment.start,
        //                       children: [
        //                         pw.Text(
        //                           'Terms & Condition',
        //                           style: pw.TextStyle(
        //                             fontSize: 14,
        //                             color: PdfColor.fromInt(0xff2f2e41),
        //                             fontWeight: pw.FontWeight.bold,
        //                           ),
        //                           textAlign: pw.TextAlign.left,
        //                         ),
        //                         pw.Text(
        //                           termsandcondition.text,
        //                           style: pw.TextStyle(
        //                             fontSize: 14,
        //                             color: PdfColor.fromInt(0xff2f2e41),
        //                           ),
        //                           textAlign: pw.TextAlign.left,
        //                         ),
        //                       ]),
        //                 ),
        //                 decoration: pw.BoxDecoration(
        //                     border: pw.Border.all(width: 0.5))),
        //           ],
        //         ),
        //         pw.SizedBox(height: 20),
        //         //mohit here the problems

        //          pw.Align(
        //           alignment: pw.Alignment.centerRight,
        //           child: pw.Column(
        //               mainAxisAlignment: pw.MainAxisAlignment.end,
        //               children: [
        //                 pw.SizedBox(
        //                   child: pw.SizedBox(
        //                       width: 50.0,
        //                       height: 50.0,
        //                       child: widget.stamp == null
        //                           ? pw.Container()
        //                           : pw.Image(pw.MemoryImage(widget.stamp))
        //                       //  child: null,
        //                       ),
        //                 ),
        //                 pw.Text(
        //                   'For ' + businessNameController.text,
        //                   style: pw.TextStyle(
        //                     fontSize: 10,
        //                     color: PdfColor.fromInt(0xff2f2e41),
        //                     fontWeight: pw.FontWeight.bold,
        //                   ),
        //                   textAlign: pw.TextAlign.left,
        //                 ),
        //                 pw.SizedBox(
        //                   child: pw.SizedBox(
        //                       width: 50.0,
        //                       height: 50.0,
        //                       child:
        //                         widget.sign == null
        //                               ? pw.Container()
        //                               : pw.Image(pw.MemoryImage(widget.sign))
        //                       //  child: null,
        //                       ),
        //                 ),
        //                 pw.Text(
        //                   'Authorised Signatory',
        //                   style: pw.TextStyle(
        //                     fontSize: 10,
        //                     color: PdfColor.fromInt(0xff2f2e41),
        //                     fontWeight: pw.FontWeight.bold,
        //                   ),
        //                   textAlign: pw.TextAlign.left,
        //                 ),
        //               ]),
        //         ),
        //          pw.SizedBox(height: 50),
        //         pw.Align(
        //             alignment: pw.Alignment.center,
        //             child: pw.Text(
        //               'This is a Computer Generated Invoice ',
        //               style: pw.TextStyle(
        //                 fontSize: 12,
        //                 color: PdfColor.fromInt(0xff2f2e41),
        //                 fontWeight: pw.FontWeight.bold,
        //               ),
        //               textAlign: pw.TextAlign.left,
        //             )),

        //       ],
        //     )
        //    ;
        //  },

          build: (context) => <pw.Widget>[
                // pw.Table.fromTextArray(data: List<List<Widget>>.generate(l.length~/3+1, (index) => null)),
                pw.Container(
                  child: pw.Column(
                    children: [
                      pw.Container(
                        width: 600,
                        height: 30,
                        decoration: pw.BoxDecoration(
                            color: PdfColor.fromInt(0xff2F2E41)),
                        child: pw.Row(
                          children: [
                            pw.Container(
                              alignment: pw.Alignment.center,
                              width: 30,
                              child: pw.Text(
                                'S.N',
                                style: pw.TextStyle(
                                  fontSize: 13,
                                  color: PdfColor.fromInt(0xfff1f3f6),
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              width: 100,
                              child: pw.Text(
                                'Product Code ',
                                style: pw.TextStyle(
                                  fontSize: 13,
                                  color: PdfColor.fromInt(0xfff1f3f6),
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              width: 100,
                              child: pw.Text(
                                'Product Name ',
                                style: pw.TextStyle(
                                  fontSize: 13,
                                  color: PdfColor.fromInt(0xfff1f3f6),
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                textAlign: pw.TextAlign.left,
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              width: 50,
                              child: pw.Text(
                                'HSN',
                                style: pw.TextStyle(
                                  fontSize: 13,
                                  color: PdfColor.fromInt(0xfff1f3f6),
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                textAlign: pw.TextAlign.left,
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              width: 50,
                              child: pw.Text(
                                'Quantity ',
                                style: pw.TextStyle(
                                  fontSize: 13,
                                  color: PdfColor.fromInt(0xfff1f3f6),
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                textAlign: pw.TextAlign.left,
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              width: 50,
                              child: pw.Text(
                                'Unit ',
                                style: pw.TextStyle(
                                  fontSize: 13,
                                  color: PdfColor.fromInt(0xfff1f3f6),
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                textAlign: pw.TextAlign.left,
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              width: 30,
                              child: pw.Text(
                                'Rate ',
                                style: pw.TextStyle(
                                  fontSize: 13,
                                  color: PdfColor.fromInt(0xfff1f3f6),
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                textAlign: pw.TextAlign.left,
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              width: 70,
                              child: pw.Text(
                                'Tax Rate',
                                style: pw.TextStyle(
                                  fontSize: 13,
                                  color: PdfColor.fromInt(0xfff1f3f6),
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                textAlign: pw.TextAlign.left,
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              width: 50,
                              child: pw.Text(
                                'Amount',
                                style: pw.TextStyle(
                                  fontSize: 13,
                                  color: PdfColor.fromInt(0xfff1f3f6),
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                textAlign: pw.TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
               
                ),

                pw.Wrap(
                    children: List<pw.Widget>.generate(
                  l.length,
                  (index) => pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Wrap(
                      children: [
                        pw.Container(
                          width: 600,
                          height: 30,
                          decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              border: pw.Border.all(
                                  width: 0.000000001,
                                  color: PdfColor.fromInt(0xff707070))),
                          child: pw.Row(
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.center,
                                width: 30,
                                child: pw.Text(
                                  (index + 1).toString(),
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 100,
                                child: pw.Text(
                                  l[index]['productCode'],
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 100,
                                child: pw.Text(
                                  l[index]['productName'],
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  l[index]['hsncode'],
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  l[index]['quantity'],
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  l[index]['unit'],
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 30,
                                child: pw.Text(
                                  l[index]['sellingrate'],
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 70,
                                child: pw.Text(
                                  l[index]['taxamount'],
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  // 'erro here mohit',
                                  l[index]['totalamount'],
                                  style: pw.TextStyle(
                                      fontSize: 13,
                                      fontWeight: pw.FontWeight.normal),
                                  textAlign: pw.TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                pw.Wrap(children: [
                  pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Wrap(
                      children: [
                        pw.Container(
                          width: 600,
                          height: 30,
                          decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              border: pw.Border.all(
                                  width: 0.000000001,
                                  color: PdfColor.fromInt(0xff707070))),
                          child: pw.Row(
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 30,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 100,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 100,
                                child: pw.Text(
                                  'Taxable amount',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  totalquantity.toString(),
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 30,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 70,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  totalamount.toString(),
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                pw.Wrap(children: [
                  pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Wrap(
                      children: [
                        pw.Container(
                          width: 600,
                          height: 30,
                          decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              border: pw.Border.all(
                                  width: 0.000000001,
                                  color: PdfColor.fromInt(0xff707070))),
                          child: pw.Row(
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 30,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 100,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 100,
                                child: pw.Text(
                                  'Total',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  totalquantity.toString(),
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 30,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 70,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  totalamount.toString(),
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                pw.Wrap(
                    children: List<pw.Widget>.generate(
                  taxes.length,
                  (index) => pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Wrap(
                      children: [
                        pw.Container(
                          width: 600,
                          height: 30,
                          decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              border: pw.Border.all(
                                  width: 0.000000001,
                                  color: PdfColor.fromInt(0xff707070))),
                          child: pw.Row(
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 30,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 100,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 100,
                                child: pw.Text(
                                  'Tax Amount',
                                  style: pw.TextStyle(
                                      fontSize: 13,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 30,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 20,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 80,
                                child: pw.Text(
                                  taxes.entries
                                          .elementAt(index)
                                          .key
                                          .toString() +
                                      '% ' +
                                      taxtype.text,
                                  style: pw.TextStyle(
                                      fontSize: 13,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 20 ,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 100,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  //overflow: TextOverflow.ellipsis,
                                  // 'here the error',
                                  (double.tryParse(taxes.entries
                                              .elementAt(index)
                                              .key
                                              .toString()) *
                                          double.tryParse((taxes.entries
                                                  .elementAt(index)
                                                  .value)
                                              .toString()) /
                                          100.toInt())
                                      .toString(),
                                  maxLines: 1,
                                  style: pw.TextStyle(
                                      fontSize: 13,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      // children: [
                      //   pw.SizedBox(
                      //     width: 100
                      //   ),
                      //   pw.Paragraph(text: 'Tax Amount'
                      //   style: Text)
                      // ]
                    ),
                  ),
                )),

                pw.Wrap(
                    children: List<pw.Widget>.generate(
                  l2.length,
                  (index) => pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Wrap(
                      children: [
                        pw.Container(
                          width: 600,
                          height: 30,
                          decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              border: pw.Border.all(
                                  width: 0.000000001,
                                  color: PdfColor.fromInt(0xff707070))),
                          child: pw.Row(
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 30,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 100,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 100,
                                child: pw.Text(
                                  'Other Charges',
                                  style: pw.TextStyle(
                                      fontSize: 13,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 30,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 20,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 80,
                                child: pw.Text(
                                  l2[index]['otherchargename'],
                                  style: pw.TextStyle(
                                      fontSize: 13,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 30,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 90,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  l2[index]['otherchargevalue'].toString(),
                                  style: pw.TextStyle(
                                      fontSize: 13,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),

                discount != 0.0
                    ? pw.Wrap(children: [
                        pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Wrap(
                            children: [
                              pw.Container(
                                width: 600,
                                height: 30,
                                decoration: pw.BoxDecoration(
                                    color: PdfColors.white,
                                    border: pw.Border.all(
                                        width: 0.000000001,
                                        color: PdfColor.fromInt(0xff707070))),
                                child: pw.Row(
                                  children: [
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 30,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 100,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 100,
                                      child: pw.Text(
                                        'Discount',
                                        style: pw.TextStyle(
                                            fontSize: 13,
                                            fontWeight: pw.FontWeight.bold),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 30,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 20,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 80,
                                      child: pw.Text(
                                        discount.toString() + '%',
                                        style: pw.TextStyle(
                                            fontSize: 13,
                                            fontWeight: pw.FontWeight.bold),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 30,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 90,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 50,
                                      child: pw.Text(
                                        // '- Error Here Mohit',
                                        // +
                                        (discount * totalamount / 100)
                                            .toString(),
                                        style: pw.TextStyle(
                                            fontSize: 13,
                                            fontWeight: pw.FontWeight.bold),
                                        textAlign: pw.TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])
                    : pw.Container(),

                tcs != 0.0
                    ? pw.Wrap(children: [
                        pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Wrap(
                            children: [
                              pw.Container(
                                width: 600,
                                height: 30,
                                decoration: pw.BoxDecoration(
                                    color: PdfColors.white,
                                    border: pw.Border.all(
                                        width: 0.000000001,
                                        color: PdfColor.fromInt(0xff707070))),
                                child: pw.Row(
                                  children: [
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 30,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 100,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 100,
                                      child: pw.Text(
                                        'TCS',
                                        style: pw.TextStyle(
                                            fontSize: 13,
                                            fontWeight: pw.FontWeight.bold),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 30,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 20,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 80,
                                      child: pw.Text(
                                        tcs.toString() + '%',
                                        style: pw.TextStyle(
                                            fontSize: 13,
                                            fontWeight: pw.FontWeight.bold),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 30,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 90,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 50,
                                      child: pw.Text(
                                        //'Error here mohit',
                                        (tcs * totalamount / 100).toString(),
                                        style: pw.TextStyle(
                                            fontSize: 13,
                                            fontWeight: pw.FontWeight.bold),
                                        textAlign: pw.TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])
                    : pw.Container(),
                roundoff != 0.0
                    ? pw.Wrap(children: [
                        pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Wrap(
                            children: [
                              pw.Container(
                                width: 600,
                                height: 30,
                                decoration: pw.BoxDecoration(
                                    color: PdfColors.white,
                                    border: pw.Border.all(
                                        width: 0.000000001,
                                        color: PdfColor.fromInt(0xff707070))),
                                child: pw.Row(
                                  children: [
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 30,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 100,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 100,
                                      child: pw.Text(
                                        'Round Off',
                                        style: pw.TextStyle(
                                            fontSize: 13,
                                            fontWeight: pw.FontWeight.bold),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 30,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 20,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 80,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                            fontSize: 13,
                                            fontWeight: pw.FontWeight.bold),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 30,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 90,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      width: 50,
                                      child: pw.Text(
                                        roundoff.toString(),
                                        style: pw.TextStyle(
                                            fontSize: 13,
                                            fontWeight: pw.FontWeight.bold),
                                        textAlign: pw.TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])
                    : pw.Container(),
                pw.Wrap(children: [
                  pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Wrap(
                      children: [
                        pw.Container(
                          width: 600,
                          height: 30,
                          decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              border: pw.Border.all(
                                  width: 0.000000001,
                                  color: PdfColor.fromInt(0xff707070))),
                          child: pw.Row(
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 30,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 100,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 100,
                                child: pw.Text(
                                  'Grand Total',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 70,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 30,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 30,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 70,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  (finalamount).toStringAsFixed(2).toString(),
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),

                pw.Wrap(children: [
                  pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Wrap(
                      children: [
                        pw.Container(
                          width: 600,
                        //  height: 40,
                          decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              border: pw.Border.all(
                                  width: 0.000000001,
                                  color: PdfColor.fromInt(0xff707070))),
                          child: pw.Row(
                            children: [
                              pw.Padding(
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        'Amount Chargeable(in words)',
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.bold,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                      pw.Text(
                                        //    'error here',
                                        'INR ' +
                                            NumberToWord().convert(
                                                'en-in', finalamount.toInt()) +
                                            'Only',
                                        style: pw.TextStyle(
                                          fontSize: 13,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ]),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 10,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 10,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 70,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 30,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 30,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 70,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                width: 50,
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ]),

                //MOHIT HERE
 
                  pw.Wrap(children:[pw.Column(
            
              children: [
                pw.SizedBox(height: 20),
                 pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.SizedBox(
                          child: pw.SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: widget.stamp == null
                                  ? pw.Container()
                                  : pw.Image(pw.MemoryImage(widget.stamp))
                              //  child: null,
                              ),
                        ),
                        pw.Text(
                          'For ' + businessNameController.text,
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromInt(0xff2f2e41),
                            fontWeight: pw.FontWeight.bold,
                          ),
                          textAlign: pw.TextAlign.left,
                        ),
                        pw.SizedBox(
                          child: pw.SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child:
                                widget.sign == null
                                      ? pw.Container()
                                      : pw.Image(pw.MemoryImage(widget.sign))
                              //  child: null,
                              ),
                        ),
                        pw.Text(
                          'Authorised Signatory',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromInt(0xff2f2e41),
                            fontWeight: pw.FontWeight.bold,
                          ),
                          textAlign: pw.TextAlign.left,
                        ),
                      ]),
                ),
                 pw.SizedBox(height: 50),
                pw.Align(
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      'This is a Computer Generated Invoice ',
                      style: pw.TextStyle(
                        fontSize: 12,
                        color: PdfColor.fromInt(0xff2f2e41),
                        fontWeight: pw.FontWeight.bold,
                      ),
                      textAlign: pw.TextAlign.left,
                    )),

              ],
            )


                ])
              ]),
    );
    uploadtostorage();

    return await pdf.save();
  }
}
