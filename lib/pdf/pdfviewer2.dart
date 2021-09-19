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

class PdfViewer2 extends StatefulWidget {
  final String uid;
  final bool generalreportornot;
  final invoiceid;
  final Uint8List sign, stamp, logo;
  PdfViewer2(this.uid, this.generalreportornot, this.invoiceid, this.sign,
      this.stamp, this.logo);
  @override
  _PdfViewer2State createState() => _PdfViewer2State();
}

class _PdfViewer2State extends State<PdfViewer2> {
  List<LayoutCallback> _tabGen;
  @override
  void initState() {
    print("pdf2 initiated ==========mohit");
    getallData();
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
  final taxamount = TextEditingController();
  final totalamount = TextEditingController();
  final transporterid = TextEditingController();
  final transportername = TextEditingController();
  final tracnsportdocno = TextEditingController();
  final tdate = TextEditingController();
  final vehiclemode = TextEditingController();
  final vehicleno = TextEditingController();
  final from = TextEditingController();
  final taxtype = TextEditingController();
  final transportdocno = TextEditingController();

  String discountStr;
  String roundoffStr;
  String tcsStr;

  double discount = 0;
  double roundoff = 0;
  double tcs = 0;
  double totaltax = 0;

  final businessInfo = new BusinessProfile(
      '', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
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
      '',
      null,
      null,
      null,
      null);
  List<Map<String, dynamic>> l2 = [];
  getallData() async {
    await _gettermsandcondition(widget.uid);
    await _invoicedetails(widget.uid);
    await _getBusinessDetails(widget.uid);
    getUsersTripsStreamSnapshots(context);
  }

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

        print(l);
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
            ? ' '
            : valuee.data()['termsAndCondition'];
      });
    });
  }

  Map<String, dynamic> m;
  List<Map<String, dynamic>> l = [];
  var taxes = new Map();
  Future<Null> _invoicedetails(String uid) async {
    await db
        .collection("userData")
        .doc(uid)
        .collection("Invoice")
        .doc(widget.invoiceid)
        .get()
        .then((valuee) {
      setState(() {
        invoiceno.text = valuee.data()['invoiceno'] == null
            ? ''
            : valuee.data()['invoiceno'];
        bname.text =
            valuee.data()['bname'] == null ? '' : valuee.data()['bname'];
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
        tdate.text = valuee.data()['tdate'] == null
            ? ''
            : valuee.data()['tdate'].toString();
        taxtype.text =
            valuee.data()['taxtype'] == null ? '' : valuee.data()['taxtype'];
        discountStr =
            valuee.data()['discount'] == null ? '' : valuee.data()['discount'];
        if (discountStr.isNotEmpty) {
          discount = double.parse(discountStr);
        }
        tcsStr = valuee.data()['tcs'] == null ? '' : valuee.data()['tcs'];
        if (tcsStr.isNotEmpty) {
          tcs = double.parse(tcsStr);
        }
        roundoffStr =
            valuee.data()['roundoff'] == null ? '' : valuee.data()['roundoff'];
        if (roundoffStr.isNotEmpty) {
          roundoff = double.parse(roundoffStr);
        }
        l = List.castFrom(valuee.data()['listOfProducts']);
        l2 = List.castFrom(valuee.data()['othercharges']);
      });
    });
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    yield* FirebaseFirestore.instance
        .collection("userData")
        .doc(widget.uid)
        .collection("Invoice")
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
            totalquantity + double.parse(element['quantity'].toString());
        totalamount =
            totalamount + double.parse(element['baseTotalAmount'].toString());
      });
    });
    setState(() {
      finalamount = totalamount;
    });
    l.forEach((element) {
      setState(() {
        taxes[element['taxrate']] = taxes[element['taxrate']] +
            double.parse(element['baseTotalAmount']);
        print(taxes[element['taxrate']]);
      });
    });
    taxes.forEach((key, value) {
      setState(() {
        finalamount = finalamount +
            double.parse(key.toString()) *
                double.parse(value.toString()) /
                100.0;
      });
    });
    l2.forEach((element) {
      setState(() {
        finalamount = finalamount + (element['otherchargevalue']);
      });
    });
    setState(() {
      finalamount = (finalamount - ((discount) * (totalamount / 100))) +
          (tcs * totalamount / 100) +
          roundoff;
      // finalamount = finalamount - (discount * totalamount / 100) + roundoff;
    });
    final pdf = pw.Document();
    Future<void> uploadtostorage() async {
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/" + widget.invoiceid + "example.pdf");
      file.writeAsBytes(await pdf.save());
      await firebase_storage.FirebaseStorage.instance
          .ref(widget.uid + '/Invoice/' + widget.invoiceid + '.pdf')
          .putFile(file)
          .catchError((onerror) {
        print(onerror);
      });
    }

    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.only(top: 10, right: 18, left: 30, bottom: 10),
          header: (pw.Context context) {
            return widget.generalreportornot == false
                ? pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
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
                        pw.SizedBox(height: 10),
                        pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                        width: 282,
                                        padding: pw.EdgeInsets.all(0),
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all()),
                                        child: pw.Row(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Column(
                                                mainAxisAlignment: pw
                                                    .MainAxisAlignment
                                                    .spaceBetween,
                                                crossAxisAlignment:
                                                    pw.CrossAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                      width: 282,
                                                      height: 150,
                                                      decoration:
                                                          pw.BoxDecoration(
                                                              border: pw.Border
                                                                  .all()),
                                                      child: pw.Column(
                                                          mainAxisAlignment: pw
                                                              .MainAxisAlignment
                                                              .start,
                                                          children: [
                                                            pw.SizedBox(
                                                                height: 20),
                                                            pw.Row(children: [
                                                              pw.SizedBox(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  child: pw.Image(
                                                                      pw.MemoryImage(
                                                                          widget
                                                                              .logo))),
                                                              pw.SizedBox(
                                                                  height: 10),

                                                              /*
                                                                 pw.SizedBox(
                                                                    child: pw.SizedBox(
                                                                        width: 50.0,
                                                                        height: 50.0,
                                                                        child:
                                                                            pw.Image(pw.MemoryImage(widget.sign)) == null
                                                                                ? null
                                                                                : pw.Image(pw.MemoryImage(widget.sign))
                                                                        //  child: null,
                                                                        ),
                                                                  ),
                                                                  */
                                                              pw.Column(
                                                                  mainAxisAlignment: pw
                                                                      .MainAxisAlignment
                                                                      .start,
                                                                  crossAxisAlignment: pw
                                                                      .CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    pw.Container(
                                                                      width:
                                                                          200,
                                                                      //  height: 130,
                                                                      //height: 200,
                                                                      child: pw
                                                                          .Padding(
                                                                        padding:
                                                                            pw.EdgeInsets.all(1),
                                                                        //width: 100,
                                                                        child: pw
                                                                            .Paragraph(
                                                                          style:
                                                                              pw.TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                PdfColor.fromInt(0xff2f2e41),
                                                                            fontWeight:
                                                                                pw.FontWeight.bold,
                                                                          ),
                                                                          text:
                                                                              businessNameController.text,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    // pw.Text(
                                                                    //   // 'hello mohit',
                                                                    //   businessNameController
                                                                    //       .text,
                                                                    //   style: pw
                                                                    //       .TextStyle(
                                                                    //     fontSize:
                                                                    //         15,
                                                                    //     color: PdfColor.fromInt(
                                                                    //         0xff2f2e41),
                                                                    //     fontWeight: pw
                                                                    //         .FontWeight
                                                                    //         .bold,
                                                                    //   ),
                                                                    // ),
                                                                    pw.SizedBox(
                                                                      width:
                                                                          230.0,
                                                                      child: pw
                                                                          .Text(
                                                                        businesAddressController
                                                                            .text,
                                                                        style: pw
                                                                            .TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              PdfColor.fromInt(0xff2f2e41),
                                                                        ),
                                                                        textAlign: pw
                                                                            .TextAlign
                                                                            .center,
                                                                      ),
                                                                    ),
                                                                    pw.SizedBox(
                                                                      width:
                                                                          230.0,
                                                                      child: pw
                                                                          .Text(
                                                                        'Gstn : ' +
                                                                            gstNumberController.text,
                                                                        style: pw
                                                                            .TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              PdfColor.fromInt(0xff2f2e41),
                                                                        ),
                                                                        textAlign: pw
                                                                            .TextAlign
                                                                            .center,
                                                                      ),
                                                                    ),

                                                                    pw.SizedBox(
                                                                        width:
                                                                            230.0,
                                                                        child: pw
                                                                            .Text(
                                                                          'Phone No: ' +
                                                                              phoneController.text,
                                                                          style:
                                                                              pw.TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                PdfColor.fromInt(0xff2f2e41),
                                                                          ),
                                                                          textAlign: pw
                                                                              .TextAlign
                                                                              .center,
                                                                        )),
                                                                    pw.SizedBox(
                                                                      width:
                                                                          230.0,
                                                                      child: pw
                                                                          .Text(
                                                                        'Email :' +
                                                                            emailController.text,
                                                                        style: pw
                                                                            .TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              PdfColor.fromInt(0xff2f2e41),
                                                                        ),
                                                                        textAlign: pw
                                                                            .TextAlign
                                                                            .center,
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ]),
                                                            // widget
                                                            //         .generalreportornot
                                                            //     ? pw.Container(
                                                            //         width: 272,
                                                            //         height: 100,
                                                            //         decoration: pw
                                                            //             .BoxDecoration(
                                                            //           border: pw.Border.all(
                                                            //               width:
                                                            //                   1),
                                                            //         ),
                                                            //         child: pw.Row(
                                                            //             children: [
                                                            //               pw.SizedBox(
                                                            //                   width: 10),
                                                            //               pw.Column(
                                                            //                 mainAxisAlignment:
                                                            //                     pw.MainAxisAlignment.start,
                                                            //                 crossAxisAlignment:
                                                            //                     pw.CrossAxisAlignment.start,
                                                            //                 children: [
                                                            //                   pw.SizedBox(height: 3),
                                                            //                   pw.Text(
                                                            //                     'Billed to :  ',
                                                            //                     style: pw.TextStyle(
                                                            //                       fontSize: 15,
                                                            //                       color: PdfColor.fromInt(0xff2f2e41),
                                                            //                       fontWeight: pw.FontWeight.bold,
                                                            //                     ),
                                                            //                     textAlign: pw.TextAlign.left,
                                                            //                   ),
                                                            //                   pw.SizedBox(height: 10),
                                                            //                   pw.Text(
                                                            //                     'Name :        ' + sname.text,
                                                            //                     style: pw.TextStyle(
                                                            //                       fontSize: 13,
                                                            //                       color: PdfColor.fromInt(0xff2f2e41),
                                                            //                     ),
                                                            //                     textAlign: pw.TextAlign.left,
                                                            //                   ),
                                                            //                   pw.SizedBox(height: 10),
                                                            //                   pw.Text(
                                                            //                     'Mobile No :  ' + sphone.text,
                                                            //                     style: pw.TextStyle(
                                                            //                       fontSize: 13,
                                                            //                       color: PdfColor.fromInt(0xff2f2e41),
                                                            //                     ),
                                                            //                     textAlign: pw.TextAlign.left,
                                                            //                   ),
                                                            //                   pw.Text(
                                                            //                     'GSTN :        ' + sgstn.text,
                                                            //                     style: pw.TextStyle(
                                                            //                       fontSize: 13,
                                                            //                       color: PdfColor.fromInt(0xff2f2e41),
                                                            //                     ),
                                                            //                     textAlign: pw.TextAlign.left,
                                                            //                   ),
                                                            //                 ],
                                                            //               ),
                                                            //               pw.Column(
                                                            //                 mainAxisAlignment:
                                                            //                     pw.MainAxisAlignment.start,
                                                            //                 crossAxisAlignment:
                                                            //                     pw.CrossAxisAlignment.start,
                                                            //                 children: [
                                                            //                   pw.SizedBox(height: 10),
                                                            //                   pw.Text(
                                                            //                     sname.text,
                                                            //                     style: pw.TextStyle(
                                                            //                       fontSize: 13,
                                                            //                       color: PdfColor.fromInt(0xff2f2e41),
                                                            //                     ),
                                                            //                     textAlign: pw.TextAlign.left,
                                                            //                   ),
                                                            //                   pw.SizedBox(height: 10),
                                                            //                   pw.Text(
                                                            //                     sphone.text,
                                                            //                     style: pw.TextStyle(
                                                            //                       fontSize: 13,
                                                            //                       color: PdfColor.fromInt(0xff2f2e41),
                                                            //                     ),
                                                            //                     textAlign: pw.TextAlign.left,
                                                            //                   ),
                                                            //                   pw.Text(
                                                            //                     sgstn.text,
                                                            //                     style: pw.TextStyle(
                                                            //                       fontSize: 13,
                                                            //                       color: PdfColor.fromInt(0xff2f2e41),
                                                            //                     ),
                                                            //                     textAlign: pw.TextAlign.left,
                                                            //                   ),
                                                            //                 ],
                                                            //               ),
                                                            //             ]))
                                                            //     : pw.Column(
                                                            //         children: [
                                                            //           pw.Container(
                                                            //               width: 272,
                                                            //               height: 100,
                                                            //               decoration: pw.BoxDecoration(
                                                            //                 border:
                                                            //                     pw.Border.all(width: 1),
                                                            //               ),
                                                            //               child: pw.Row(children: [
                                                            //                 pw.SizedBox(width: 10),
                                                            //                 pw.Column(
                                                            //                   mainAxisAlignment: pw.MainAxisAlignment.start,
                                                            //                   crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                            //                   children: [
                                                            //                     pw.SizedBox(height: 3),
                                                            //                     pw.Text(
                                                            //                       'Billed to :  ',
                                                            //                       style: pw.TextStyle(
                                                            //                         fontSize: 15,
                                                            //                         color: PdfColor.fromInt(0xff2f2e41),
                                                            //                         fontWeight: pw.FontWeight.bold,
                                                            //                       ),
                                                            //                       textAlign: pw.TextAlign.left,
                                                            //                     ),
                                                            //                     pw.SizedBox(height: 10),
                                                            //                     pw.Text(
                                                            //                       'Name :        ' + sname.text,
                                                            //                       style: pw.TextStyle(
                                                            //                         fontSize: 13,
                                                            //                         color: PdfColor.fromInt(0xff2f2e41),
                                                            //                       ),
                                                            //                       textAlign: pw.TextAlign.left,
                                                            //                     ),
                                                            //                     pw.SizedBox(height: 10),
                                                            //                     pw.Text(
                                                            //                       'Mobile No :' + sphone.text,
                                                            //                       style: pw.TextStyle(
                                                            //                         fontSize: 13,
                                                            //                         color: PdfColor.fromInt(0xff2f2e41),
                                                            //                       ),
                                                            //                       textAlign: pw.TextAlign.left,
                                                            //                     ),
                                                            //                     pw.Text(
                                                            //                       'GSTN :        ' + sgstn.text,
                                                            //                       style: pw.TextStyle(
                                                            //                         fontSize: 13,
                                                            //                         color: PdfColor.fromInt(0xff2f2e41),
                                                            //                       ),
                                                            //                       textAlign: pw.TextAlign.left,
                                                            //                     ),
                                                            //                   ],
                                                            //                 ),
                                                            //               ])),
                                                            //           pw.Container(
                                                            //               width: 272,
                                                            //               height: 100,
                                                            //               decoration: pw.BoxDecoration(
                                                            //                 border:
                                                            //                     pw.Border.all(width: 1),
                                                            //               ),
                                                            //               child: pw.Row(children: [
                                                            //                 pw.SizedBox(width: 10),
                                                            //                 pw.Column(
                                                            //                   mainAxisAlignment: pw.MainAxisAlignment.start,
                                                            //                   crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                            //                   children: [
                                                            //                     pw.SizedBox(height: 3),
                                                            //                     pw.Text(
                                                            //                       'Shipped to :  ',
                                                            //                       style: pw.TextStyle(
                                                            //                         fontSize: 15,
                                                            //                         color: PdfColor.fromInt(0xff2f2e41),
                                                            //                         fontWeight: pw.FontWeight.bold,
                                                            //                       ),
                                                            //                       textAlign: pw.TextAlign.left,
                                                            //                     ),
                                                            //                     pw.SizedBox(height: 10),
                                                            //                     pw.Text(
                                                            //                       'Name :        ' + bname.text,
                                                            //                       style: pw.TextStyle(
                                                            //                         fontSize: 13,
                                                            //                         color: PdfColor.fromInt(0xff2f2e41),
                                                            //                       ),
                                                            //                       textAlign: pw.TextAlign.left,
                                                            //                     ),
                                                            //                     pw.SizedBox(height: 10),
                                                            //                     pw.Text(
                                                            //                       'Mobile No :   ' + bphone.text,
                                                            //                       style: pw.TextStyle(
                                                            //                         fontSize: 13,
                                                            //                         color: PdfColor.fromInt(0xff2f2e41),
                                                            //                       ),
                                                            //                       textAlign: pw.TextAlign.left,
                                                            //                     ),
                                                            //                     pw.Text(
                                                            //                       'GSTN :        ' + bgstn.text,
                                                            //                       style: pw.TextStyle(
                                                            //                         fontSize: 13,
                                                            //                         color: PdfColor.fromInt(0xff2f2e41),
                                                            //                       ),
                                                            //                       textAlign: pw.TextAlign.left,
                                                            //                     ),
                                                            //                   ],
                                                            //                 ),
                                                            //               ])),
                                                            //         ],
                                                            //       ),
                                                          ])),
                                                  pw.Container(
                                                      width: 282,
                                                      height: 150,
                                                      decoration:
                                                          pw.BoxDecoration(
                                                        border: pw.Border.all(
                                                            width: 1),
                                                      ),
                                                      child: pw.Row(children: [
                                                        pw.SizedBox(width: 10),
                                                        pw.Column(
                                                          mainAxisAlignment: pw
                                                              .MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment: pw
                                                              .CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            pw.SizedBox(
                                                                height: 3),
                                                            pw.Text(
                                                              'Billed to :  ',
                                                              style:
                                                                  pw.TextStyle(
                                                                fontSize: 15,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xff2f2e41),
                                                                fontWeight: pw
                                                                    .FontWeight
                                                                    .bold,
                                                              ),
                                                              textAlign: pw
                                                                  .TextAlign
                                                                  .left,
                                                            ),
                                                            pw.SizedBox(
                                                                height: 10),
                                                            pw.Text(
                                                              'Name :        ' +
                                                                  sname.text,
                                                              style:
                                                                  pw.TextStyle(
                                                                fontSize: 13,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xff2f2e41),
                                                              ),
                                                              textAlign: pw
                                                                  .TextAlign
                                                                  .left,
                                                            ),
                                                            pw.SizedBox(
                                                                height: 10),
                                                            pw.Text(
                                                              'Mobile No :        ' +
                                                                  sphone.text,
                                                              style:
                                                                  pw.TextStyle(
                                                                fontSize: 13,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xff2f2e41),
                                                              ),
                                                              textAlign: pw
                                                                  .TextAlign
                                                                  .left,
                                                            ),
                                                            pw.Text(
                                                              'GSTN :        ' +
                                                                  sgstn.text,
                                                              style:
                                                                  pw.TextStyle(
                                                                fontSize: 13,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xff2f2e41),
                                                              ),
                                                              textAlign: pw
                                                                  .TextAlign
                                                                  .left,
                                                            ),
                                                          ],
                                                        ),
                                                      ])),
                                                  pw.Container(
                                                      width: 282,
                                                      height: 100,
                                                      decoration:
                                                          pw.BoxDecoration(
                                                        border: pw.Border.all(
                                                            width: 1),
                                                      ),
                                                      child: pw.Row(children: [
                                                        pw.SizedBox(width: 10),
                                                        pw.Column(
                                                          mainAxisAlignment: pw
                                                              .MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment: pw
                                                              .CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            pw.SizedBox(
                                                                height: 3),
                                                            pw.Text(
                                                              'Shipped to :  ',
                                                              style:
                                                                  pw.TextStyle(
                                                                fontSize: 15,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xff2f2e41),
                                                                fontWeight: pw
                                                                    .FontWeight
                                                                    .bold,
                                                              ),
                                                              textAlign: pw
                                                                  .TextAlign
                                                                  .left,
                                                            ),
                                                            pw.SizedBox(
                                                                height: 10),
                                                            pw.Text(
                                                              'Name :        ' +
                                                                  bname.text,
                                                              style:
                                                                  pw.TextStyle(
                                                                fontSize: 13,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xff2f2e41),
                                                              ),
                                                              textAlign: pw
                                                                  .TextAlign
                                                                  .left,
                                                            ),
                                                            pw.SizedBox(
                                                                height: 10),
                                                            pw.Text(
                                                              'Mobile No :        ' +
                                                                  bphone.text,
                                                              style:
                                                                  pw.TextStyle(
                                                                fontSize: 13,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xff2f2e41),
                                                              ),
                                                              textAlign: pw
                                                                  .TextAlign
                                                                  .left,
                                                            ),
                                                            pw.Text(
                                                              'GSTN :        ' +
                                                                  bgstn.text,
                                                              style:
                                                                  pw.TextStyle(
                                                                fontSize: 13,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xff2f2e41),
                                                              ),
                                                              textAlign: pw
                                                                  .TextAlign
                                                                  .left,
                                                            ),
                                                          ],
                                                        ),
                                                      ])),
                                                ],
                                              ),
                                              pw.Container(
                                                width: 275,
                                                height: 400,
                                                child: pw.Column(
                                                  children: [
                                                    pw.Row(children: [
                                                      pw.Column(
                                                        children: [
                                                          pw.Container(
                                                            height: 40,
                                                            padding:
                                                                pw.EdgeInsets
                                                                    .all(4),
                                                            child: pw.Column(
                                                              mainAxisAlignment:
                                                                  pw.MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  pw.CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                pw.Text(
                                                                  'Invoice No :',
                                                                  style: pw
                                                                      .TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: PdfColor
                                                                        .fromInt(
                                                                            0xff2f2e41),
                                                                    fontWeight: pw
                                                                        .FontWeight
                                                                        .bold,
                                                                  ),
                                                                  textAlign: pw
                                                                      .TextAlign
                                                                      .left,
                                                                ),
                                                                pw.Text(
                                                                  invoiceno
                                                                      .text,
                                                                  style: pw
                                                                      .TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: PdfColor
                                                                        .fromInt(
                                                                            0xff2f2e41),
                                                                  ),
                                                                  textAlign: pw
                                                                      .TextAlign
                                                                      .left,
                                                                ),
                                                              ],
                                                            ),
                                                            width: 137.5,
                                                            decoration: pw
                                                                .BoxDecoration(
                                                                    border: pw
                                                                            .Border
                                                                        .all()),
                                                          ),
                                                          pw.Container(
                                                            height: 40,
                                                            padding:
                                                                pw.EdgeInsets
                                                                    .all(4),
                                                            child: pw.Column(
                                                              mainAxisAlignment:
                                                                  pw.MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  pw.CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                pw.Text(
                                                                  'State & State Code :' +
                                                                      sstate
                                                                          .text,
                                                                  style: pw
                                                                      .TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: PdfColor
                                                                        .fromInt(
                                                                            0xff2f2e41),
                                                                    fontWeight: pw
                                                                        .FontWeight
                                                                        .bold,
                                                                  ),
                                                                  textAlign: pw
                                                                      .TextAlign
                                                                      .left,
                                                                ),
                                                                pw.Text(
                                                                  bstate.text,
                                                                  style: pw
                                                                      .TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: PdfColor
                                                                        .fromInt(
                                                                            0xff2f2e41),
                                                                  ),
                                                                  textAlign: pw
                                                                      .TextAlign
                                                                      .left,
                                                                ),
                                                              ],
                                                            ),
                                                            width: 137.5,
                                                            decoration: pw
                                                                .BoxDecoration(
                                                                    border: pw
                                                                            .Border
                                                                        .all()),
                                                          ),
                                                          pw.Container(
                                                            height: 40,
                                                            padding:
                                                                pw.EdgeInsets
                                                                    .all(4),
                                                            child: pw.Column(
                                                              mainAxisAlignment:
                                                                  pw.MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  pw.CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                pw.Text(
                                                                  'Reverse Charge :',
                                                                  style: pw
                                                                      .TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: PdfColor
                                                                        .fromInt(
                                                                            0xff2f2e41),
                                                                    fontWeight: pw
                                                                        .FontWeight
                                                                        .bold,
                                                                  ),
                                                                  textAlign: pw
                                                                      .TextAlign
                                                                      .left,
                                                                ),
                                                                pw.Text(
                                                                  'N',
                                                                  style: pw
                                                                      .TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: PdfColor
                                                                        .fromInt(
                                                                            0xff2f2e41),
                                                                  ),
                                                                  textAlign: pw
                                                                      .TextAlign
                                                                      .left,
                                                                ),
                                                              ],
                                                            ),
                                                            width: 137.5,
                                                            decoration: pw
                                                                .BoxDecoration(
                                                                    border: pw
                                                                            .Border
                                                                        .all()),
                                                          ),
                                                          pw.Container(
                                                            height: 40,
                                                            padding:
                                                                pw.EdgeInsets
                                                                    .all(4),
                                                            child: pw.Column(
                                                              mainAxisAlignment:
                                                                  pw.MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  pw.CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                pw.Text(
                                                                  'Place of Supply :' +
                                                                      sstate
                                                                          .text,
                                                                  style: pw
                                                                      .TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: PdfColor
                                                                        .fromInt(
                                                                            0xff2f2e41),
                                                                    fontWeight: pw
                                                                        .FontWeight
                                                                        .bold,
                                                                  ),
                                                                  textAlign: pw
                                                                      .TextAlign
                                                                      .left,
                                                                ),
                                                                pw.Text(
                                                                  bstate.text,
                                                                  style: pw
                                                                      .TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: PdfColor
                                                                        .fromInt(
                                                                            0xff2f2e41),
                                                                  ),
                                                                  textAlign: pw
                                                                      .TextAlign
                                                                      .left,
                                                                ),
                                                              ],
                                                            ),
                                                            width: 137.5,
                                                            decoration: pw
                                                                .BoxDecoration(
                                                                    border: pw
                                                                            .Border
                                                                        .all()),
                                                          ),
                                                        ],
                                                      ),
                                                      pw.Column(children: [
                                                        pw.Container(
                                                          height: 40,
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  4),
                                                          child: pw.Column(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment: pw
                                                                .CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              pw.Text(
                                                                'Date of Invoice :',
                                                                style: pw
                                                                    .TextStyle(
                                                                  fontSize: 13,
                                                                  color: PdfColor
                                                                      .fromInt(
                                                                          0xff2f2e41),
                                                                  fontWeight: pw
                                                                      .FontWeight
                                                                      .bold,
                                                                ),
                                                                textAlign: pw
                                                                    .TextAlign
                                                                    .left,
                                                              ),
                                                              pw.Text(
                                                                DateFormat(
                                                                        'dd/MM/yyyy')
                                                                    .format(
                                                                        DateTime
                                                                            .now())
                                                                    .toString(),
                                                                style: pw
                                                                    .TextStyle(
                                                                  fontSize: 13,
                                                                  color: PdfColor
                                                                      .fromInt(
                                                                          0xff2f2e41),
                                                                ),
                                                                textAlign: pw
                                                                    .TextAlign
                                                                    .left,
                                                              ),
                                                            ],
                                                          ),
                                                          width: 137.5,
                                                          decoration:
                                                              pw.BoxDecoration(
                                                                  border: pw
                                                                          .Border
                                                                      .all()),
                                                        ),
                                                        pw.Container(
                                                          height: 40,
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  4),
                                                          child: pw.Column(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment: pw
                                                                .CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              pw.Text(
                                                                'Transport :',
                                                                style: pw
                                                                    .TextStyle(
                                                                  fontSize: 13,
                                                                  color: PdfColor
                                                                      .fromInt(
                                                                          0xff2f2e41),
                                                                  fontWeight: pw
                                                                      .FontWeight
                                                                      .bold,
                                                                ),
                                                                textAlign: pw
                                                                    .TextAlign
                                                                    .left,
                                                              ),
                                                              pw.Text(
                                                                vehiclemode
                                                                    .text,
                                                                style: pw
                                                                    .TextStyle(
                                                                  fontSize: 13,
                                                                  color: PdfColor
                                                                      .fromInt(
                                                                          0xff2f2e41),
                                                                ),
                                                                textAlign: pw
                                                                    .TextAlign
                                                                    .left,
                                                              ),
                                                            ],
                                                          ),
                                                          width: 137.5,
                                                          decoration:
                                                              pw.BoxDecoration(
                                                                  border: pw
                                                                          .Border
                                                                      .all()),
                                                        ),
                                                        pw.Container(
                                                          height: 40,
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  4),
                                                          child: pw.Column(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment: pw
                                                                .CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              pw.Text(
                                                                'Vehicle No :',
                                                                style: pw
                                                                    .TextStyle(
                                                                  fontSize: 13,
                                                                  color: PdfColor
                                                                      .fromInt(
                                                                          0xff2f2e41),
                                                                  fontWeight: pw
                                                                      .FontWeight
                                                                      .bold,
                                                                ),
                                                                textAlign: pw
                                                                    .TextAlign
                                                                    .left,
                                                              ),
                                                              pw.Text(
                                                                vehicleno.text,
                                                                style: pw
                                                                    .TextStyle(
                                                                  fontSize: 13,
                                                                  color: PdfColor
                                                                      .fromInt(
                                                                          0xff2f2e41),
                                                                ),
                                                                textAlign: pw
                                                                    .TextAlign
                                                                    .left,
                                                              ),
                                                            ],
                                                          ),
                                                          width: 137.5,
                                                          decoration:
                                                              pw.BoxDecoration(
                                                                  border: pw
                                                                          .Border
                                                                      .all()),
                                                        ),
                                                        pw.Container(
                                                          height: 40,
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  4),
                                                          child: pw.Column(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment: pw
                                                                .CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              pw.Text(
                                                                'Date of Shipment :',
                                                                style: pw
                                                                    .TextStyle(
                                                                  fontSize: 13,
                                                                  color: PdfColor
                                                                      .fromInt(
                                                                          0xff2f2e41),
                                                                  fontWeight: pw
                                                                      .FontWeight
                                                                      .bold,
                                                                ),
                                                                textAlign: pw
                                                                    .TextAlign
                                                                    .left,
                                                              ),
                                                              pw.Text(
                                                                tdate.text,
                                                                style: pw
                                                                    .TextStyle(
                                                                  fontSize: 13,
                                                                  color: PdfColor
                                                                      .fromInt(
                                                                          0xff2f2e41),
                                                                ),
                                                                textAlign: pw
                                                                    .TextAlign
                                                                    .left,
                                                              ),
                                                            ],
                                                          ),
                                                          width: 137.5,
                                                          decoration:
                                                              pw.BoxDecoration(
                                                                  border: pw
                                                                          .Border
                                                                      .all()),
                                                        ),
                                                      ]),
                                                    ]),
                                                    pw.Container(
                                                      height: 40,
                                                      width: 275,
                                                      padding:
                                                          pw.EdgeInsets.all(4),
                                                      child: pw.Column(
                                                        mainAxisAlignment: pw
                                                            .MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment: pw
                                                            .CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          pw.Text(
                                                            'GR No:',
                                                            style: pw.TextStyle(
                                                              fontSize: 13,
                                                              color: PdfColor
                                                                  .fromInt(
                                                                      0xff2f2e41),
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                            ),
                                                            textAlign: pw
                                                                .TextAlign.left,
                                                          ),
                                                          pw.Text(
                                                            tracnsportdocno
                                                                .text,
                                                            style: pw.TextStyle(
                                                              fontSize: 13,
                                                              color: PdfColor
                                                                  .fromInt(
                                                                      0xff2f2e41),
                                                            ),
                                                            textAlign: pw
                                                                .TextAlign.left,
                                                          ),
                                                        ],
                                                      ),
                                                      decoration:
                                                          pw.BoxDecoration(
                                                              border: pw.Border
                                                                  .all()),
                                                    ),
                                                    pw.Container(
                                                      width: 275,
                                                      padding:
                                                          pw.EdgeInsets.all(4),
                                                      child: pw.Column(
                                                        mainAxisAlignment: pw
                                                            .MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment: pw
                                                            .CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          pw.Text(
                                                            'Company Bank A/C Details',
                                                            style: pw.TextStyle(
                                                              fontSize: 13,
                                                              color: PdfColor
                                                                  .fromInt(
                                                                      0xff2f2e41),
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                            ),
                                                            textAlign: pw
                                                                .TextAlign.left,
                                                          ),
                                                          pw.Text(
                                                            'Account Number : ' +
                                                                accountNumberController
                                                                    .text,
                                                            style: pw.TextStyle(
                                                              fontSize: 12,
                                                              color: PdfColor
                                                                  .fromInt(
                                                                      0xff2f2e41),
                                                            ),
                                                            textAlign: pw
                                                                .TextAlign.left,
                                                          ),
                                                          pw.Text(
                                                            'IFSC Code : ' +
                                                                ifscCodeController
                                                                    .text,
                                                            style: pw.TextStyle(
                                                              fontSize: 12,
                                                              color: PdfColor
                                                                  .fromInt(
                                                                      0xff2f2e41),
                                                            ),
                                                            textAlign: pw
                                                                .TextAlign.left,
                                                          ),
                                                          pw.Text(
                                                            'Bank Number : ' +
                                                                bankNameController
                                                                    .text,
                                                            style: pw.TextStyle(
                                                              fontSize: 12,
                                                              color: PdfColor
                                                                  .fromInt(
                                                                      0xff2f2e41),
                                                            ),
                                                            textAlign: pw
                                                                .TextAlign.left,
                                                          ),
                                                          pw.Text(
                                                            'Branch Name : ' +
                                                                branchNameController
                                                                    .text,
                                                            style: pw.TextStyle(
                                                              fontSize: 12,
                                                              color: PdfColor
                                                                  .fromInt(
                                                                      0xff2f2e41),
                                                            ),
                                                            textAlign: pw
                                                                .TextAlign.left,
                                                          ),
                                                        ],
                                                      ),
                                                      decoration:
                                                          pw.BoxDecoration(
                                                              border: pw.Border
                                                                  .all()),
                                                    ),
                                                    pw.Container(
                                                      width: 275,
                                                      height: 121,
                                                      padding:
                                                          pw.EdgeInsets.all(4),
                                                      child: pw.Column(
                                                        mainAxisAlignment: pw
                                                            .MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment: pw
                                                            .CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          pw.Text(
                                                            'Terms of Delivery ',
                                                            style: pw.TextStyle(
                                                              fontSize: 13,
                                                              color: PdfColor
                                                                  .fromInt(
                                                                      0xff2f2e41),
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                            ),
                                                            textAlign: pw
                                                                .TextAlign.left,
                                                          ),
                                                          pw.Text(
                                                            // 'hello there ',
                                                            termsandcondition
                                                                .text,
                                                            style: pw.TextStyle(
                                                              fontSize: 12,
                                                              color: PdfColor
                                                                  .fromInt(
                                                                      0xff2f2e41),
                                                            ),
                                                            textAlign: pw
                                                                .TextAlign.left,
                                                          ),
                                                        ],
                                                      ),
                                                      decoration:
                                                          pw.BoxDecoration(
                                                              border: pw.Border
                                                                  .all()),
                                                    ),
                                                  ],
                                                ),
                                                decoration: pw.BoxDecoration(
                                                    border: pw.Border.all()),
                                              )
                                            ])),
                                  ]),
                            ]),
                        pw.SizedBox(height: 20)
                      ])
                : pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
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
                        pw.SizedBox(height: 10),
                        pw.Container(
                            alignment: pw.Alignment.topCenter,
                            width: 272,
                            padding: pw.EdgeInsets.all(0),
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(width: 1)),
                            child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                          width: 272,
                                          height: 150,
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all()),
                                          child: pw.Column(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.start,
                                              children: [
                                                pw.Row(children: [
                                                  pw.SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child: pw.Image(
                                                          pw.MemoryImage(
                                                              widget.logo))
                                                      //  child: null,
                                                      ),
                                                  pw.Column(
                                                      mainAxisAlignment: pw
                                                          .MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment: pw
                                                          .CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        pw.Container(
                                                          width: 200,
                                                          //height: 200,
                                                          child: pw.Padding(
                                                            padding:
                                                                pw.EdgeInsets
                                                                    .all(2),
                                                            //width: 100,
                                                            child: pw.Paragraph(
                                                              style:
                                                                  pw.TextStyle(
                                                                fontSize: 12,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xff2f2e41),
                                                                fontWeight: pw
                                                                    .FontWeight
                                                                    .bold,
                                                              ),
                                                              text:
                                                                  businessNameController
                                                                      .text,
                                                            ),
                                                          ),
                                                        ),
                                                        // pw.Text(
                                                        //   businessNameController
                                                        //       .text,
                                                        //   style: pw.TextStyle(
                                                        //     fontSize: 15,
                                                        //     color: PdfColor
                                                        //         .fromInt(
                                                        //             0xff2f2e41),
                                                        //     fontWeight: pw
                                                        //         .FontWeight
                                                        //         .bold,
                                                        //   ),
                                                        // ),
                                                        pw.SizedBox(
                                                          width: 230.0,
                                                          child: pw.Text(
                                                            businesAddressController
                                                                .text,
                                                            style: pw.TextStyle(
                                                              fontSize: 12,
                                                              color: PdfColor
                                                                  .fromInt(
                                                                      0xff2f2e41),
                                                            ),
                                                            textAlign: pw
                                                                .TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        pw.Row(
                                                            crossAxisAlignment: pw
                                                                .CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              pw.Padding(
                                                                padding: pw
                                                                        .EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            0),
                                                                child: pw.Column(
                                                                    mainAxisAlignment: pw
                                                                        .MainAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      pw.SizedBox(
                                                                        width:
                                                                            75.0,
                                                                        child: pw
                                                                            .Text(
                                                                          'Gstn : ',
                                                                          style:
                                                                              pw.TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                PdfColor.fromInt(0xff2f2e41),
                                                                          ),
                                                                          textAlign: pw
                                                                              .TextAlign
                                                                              .center,
                                                                        ),
                                                                      ),
                                                                      pw.SizedBox(
                                                                        width:
                                                                            75.0,
                                                                        child: pw
                                                                            .Text(
                                                                          'Phone No. :',
                                                                          style:
                                                                              pw.TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                PdfColor.fromInt(0xff2f2e41),
                                                                          ),
                                                                          textAlign: pw
                                                                              .TextAlign
                                                                              .center,
                                                                        ),
                                                                      ),
                                                                      // pw.SizedBox(
                                                                      //     width:
                                                                      //         75.0,
                                                                      //     child: pw
                                                                      //         .Text(
                                                                      //       'Email :  ',
                                                                      //       style: pw
                                                                      //           .TextStyle(
                                                                      //         fontSize:
                                                                      //             13,
                                                                      //         color:
                                                                      //             PdfColor.fromInt(0xff2f2e41),
                                                                      //       ),
                                                                      //       textAlign: pw
                                                                      //           .TextAlign
                                                                      //           .center,
                                                                      //     ))
                                                                    ]),
                                                              ),
                                                              pw.Column(
                                                                  mainAxisAlignment: pw
                                                                      .MainAxisAlignment
                                                                      .start,
                                                                  crossAxisAlignment: pw
                                                                      .CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    pw.Container(
                                                                      height:
                                                                          15,
                                                                      width:
                                                                          115.0,
                                                                      child: pw
                                                                          .Text(
                                                                        gstNumberController
                                                                            .text,
                                                                        style: pw
                                                                            .TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              PdfColor.fromInt(0xff2f2e41),
                                                                        ),
                                                                        textAlign: pw
                                                                            .TextAlign
                                                                            .center,
                                                                      ),
                                                                    ),

                                                                    // pw.SizedBox(
                                                                    //   height: 40,
                                                                    //   width:115.0,
                                                                    //   child:pw.Padding(
                                                                    //   padding: pw.EdgeInsets.only(right:2),
                                                                    //   child:
                                                                    //       pw.Paragraph(
                                                                    //     text:emailController
                                                                    //         .text,
                                                                    //     style: pw
                                                                    //         .TextStyle(
                                                                    //       fontSize:
                                                                    //           13,
                                                                    //       color: PdfColor
                                                                    //           .fromInt(
                                                                    //               0xff2f2e41),
                                                                    //     ),
                                                                    //     // textAlign: pw
                                                                    //     //     .TextAlign
                                                                    //     //     .left,
                                                                    //   ),
                                                                    // )),
                                                                    pw.SizedBox(
                                                                        height:
                                                                            15,
                                                                        width:
                                                                            115.0,
                                                                        child: pw
                                                                            .Text(
                                                                          phoneController
                                                                              .text,
                                                                          style:
                                                                              pw.TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                PdfColor.fromInt(0xff2f2e41),
                                                                          ),
                                                                          textAlign: pw
                                                                              .TextAlign
                                                                              .center,
                                                                        )),
                                                                    //     pw.Container
                                                                    //   ( width:75,
                                                                    //     height: 50,
                                                                    //     child:pw.Container(
                                                                    //     child:pw.Padding(
                                                                    //     padding: pw.EdgeInsets.all(2),
                                                                    //     //width: 100,
                                                                    //     child:pw.Paragraph(
                                                                    //       style:pw.TextStyle(
                                                                    //         fontSize: 10,
                                                                    //         color: PdfColor.fromInt(0xff2f2e41),
                                                                    //         fontWeight: pw.FontWeight.bold,
                                                                    // ),
                                                                    //       text: emailController.text

                                                                    //   ),
                                                                    //   ),
                                                                    //   ),
                                                                    //   ),
                                                                  ]),
                                                            ]),
                                                        pw.SizedBox(
                                                          width: 272.0,
                                                          child: pw.Text(
                                                            'Email :' +
                                                                emailController
                                                                    .text,
                                                            style: pw.TextStyle(
                                                              fontSize: 13,
                                                              color: PdfColor
                                                                  .fromInt(
                                                                      0xff2f2e41),
                                                            ),
                                                            textAlign: pw
                                                                .TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ]),
                                                ]),
                                                pw.Container(
                                                    width: 272,
                                                    height: 100,
                                                    decoration:
                                                        pw.BoxDecoration(
                                                      border: pw.Border.all(
                                                          width: 1),
                                                    ),
                                                    child: pw.Row(children: [
                                                      pw.SizedBox(width: 10),
                                                      pw.Column(
                                                        mainAxisAlignment: pw
                                                            .MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment: pw
                                                            .CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          pw.SizedBox(
                                                              height: 3),
                                                          pw.Text(
                                                            'Billed to :  ',
                                                            style: pw.TextStyle(
                                                              fontSize: 15,
                                                              color: PdfColor
                                                                  .fromInt(
                                                                      0xff2f2e41),
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                            ),
                                                            textAlign: pw
                                                                .TextAlign.left,
                                                          ),
                                                          pw.SizedBox(
                                                              height: 10),
                                                          pw.Text(
                                                            'Name :        ' +
                                                                sname.text,
                                                            style: pw.TextStyle(
                                                              fontSize: 13,
                                                              color: PdfColor
                                                                  .fromInt(
                                                                      0xff2f2e41),
                                                            ),
                                                            textAlign: pw
                                                                .TextAlign.left,
                                                          ),
                                                          pw.SizedBox(
                                                              height: 10),
                                                          pw.Text(
                                                            'Mobile No :        ' +
                                                                sphone.text,
                                                            style: pw.TextStyle(
                                                              fontSize: 13,
                                                              color: PdfColor
                                                                  .fromInt(
                                                                      0xff2f2e41),
                                                            ),
                                                            textAlign: pw
                                                                .TextAlign.left,
                                                          ),
                                                          pw.Text(
                                                            'GSTN :        ' +
                                                                sgstn.text,
                                                            style: pw.TextStyle(
                                                              fontSize: 13,
                                                              color: PdfColor
                                                                  .fromInt(
                                                                      0xff2f2e41),
                                                            ),
                                                            textAlign: pw
                                                                .TextAlign.left,
                                                          ),
                                                        ],
                                                      ),
                                                    ])),
                                              ])),
                                      pw.Container(
                                          width: 272,
                                          height: 250,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(width: 1),
                                          ),
                                          child: pw.Row(children: [
                                            pw.SizedBox(width: 10),
                                            pw.Column(
                                              // mainAxisAlignment:
                                              //     pw.MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.SizedBox(height: 3),
                                                pw.Text(
                                                  'Billed to :  ',
                                                  style: pw.TextStyle(
                                                    fontSize: 15,
                                                    color: PdfColor.fromInt(
                                                        0xff2f2e41),
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                  ),
                                                  textAlign: pw.TextAlign.left,
                                                ),
                                                pw.SizedBox(height: 5),
                                                pw.Row(
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      pw.Column(
                                                          //mainAxisAlignment: pw.MainAxisAlignment.start,
                                                          crossAxisAlignment: pw
                                                              .CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            pw.SizedBox(
                                                                height: 12),
                                                            pw.Text(
                                                              'Name:',
                                                              style:
                                                                  pw.TextStyle(
                                                                fontSize: 13,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xff2f2e41),
                                                              ),
                                                              textAlign: pw
                                                                  .TextAlign
                                                                  .left,
                                                            ),
                                                            // pw.SizedBox(height: 5),
                                                            pw.Text(
                                                              'Mobile No :',
                                                              style:
                                                                  pw.TextStyle(
                                                                fontSize: 13,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xff2f2e41),
                                                              ),
                                                              textAlign: pw
                                                                  .TextAlign
                                                                  .left,
                                                            ),
                                                            pw.Text(
                                                              'GSTN : ',
                                                              style:
                                                                  pw.TextStyle(
                                                                fontSize: 13,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xff2f2e41),
                                                              ),
                                                              textAlign: pw
                                                                  .TextAlign
                                                                  .left,
                                                            ),
                                                          ]),
                                                      pw.SizedBox(
                                                        width: 5,
                                                      ),
                                                      pw.Column(
                                                          crossAxisAlignment: pw
                                                              .CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            pw.SizedBox(
                                                              height: 10,
                                                              width: 5,
                                                            ),
                                                            pw.Text(
                                                              sname.text,
                                                              style:
                                                                  pw.TextStyle(
                                                                fontSize: 13,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xff2f2e41),
                                                              ),
                                                              textAlign: pw
                                                                  .TextAlign
                                                                  .left,
                                                            ),
                                                            // pw.SizedBox(height: 5),
                                                            pw.Text(
                                                              sphone.text,
                                                              style:
                                                                  pw.TextStyle(
                                                                fontSize: 13,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xff2f2e41),
                                                              ),
                                                              textAlign: pw
                                                                  .TextAlign
                                                                  .left,
                                                            ),
                                                            pw.Text(
                                                              sgstn.text,
                                                              style:
                                                                  pw.TextStyle(
                                                                fontSize: 13,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xff2f2e41),
                                                              ),
                                                              textAlign: pw
                                                                  .TextAlign
                                                                  .left,
                                                            ),
                                                          ]),
                                                    ]),
                                              ],
                                            ),
                                          ])),
                                    ],
                                  ),
                                  pw.Container(
                                    width: 277,
                                    height: 400,
                                    child: pw.Column(
                                      children: [
                                        pw.Row(children: [
                                          pw.Column(
                                            children: [
                                              pw.Container(
                                                height: 40,
                                                padding: pw.EdgeInsets.all(4),
                                                child: pw.Column(
                                                  mainAxisAlignment: pw
                                                      .MainAxisAlignment.start,
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Text(
                                                      'Invoice No :',
                                                      style: pw.TextStyle(
                                                        fontSize: 13,
                                                        color: PdfColor.fromInt(
                                                            0xff2f2e41),
                                                        fontWeight:
                                                            pw.FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          pw.TextAlign.left,
                                                    ),
                                                    pw.Text(
                                                      invoiceno.text,
                                                      style: pw.TextStyle(
                                                        fontSize: 13,
                                                        color: PdfColor.fromInt(
                                                            0xff2f2e41),
                                                      ),
                                                      textAlign:
                                                          pw.TextAlign.left,
                                                    ),
                                                  ],
                                                ),
                                                width: 137.5,
                                                decoration: pw.BoxDecoration(
                                                    border: pw.Border.all()),
                                              ),
                                              pw.Container(
                                                height: 40,
                                                padding: pw.EdgeInsets.all(4),
                                                child: pw.Column(
                                                  mainAxisAlignment: pw
                                                      .MainAxisAlignment.start,
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Text(
                                                      'State :',
                                                      style: pw.TextStyle(
                                                        fontSize: 13,
                                                        color: PdfColor.fromInt(
                                                            0xff2f2e41),
                                                        fontWeight:
                                                            pw.FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          pw.TextAlign.left,
                                                    ),
                                                    pw.Text(
                                                      bstate.text,
                                                      style: pw.TextStyle(
                                                        fontSize: 13,
                                                        color: PdfColor.fromInt(
                                                            0xff2f2e41),
                                                      ),
                                                      textAlign:
                                                          pw.TextAlign.left,
                                                    ),
                                                  ],
                                                ),
                                                width: 137.5,
                                                decoration: pw.BoxDecoration(
                                                    border: pw.Border.all()),
                                              ),
                                              pw.Container(
                                                height: 40,
                                                padding: pw.EdgeInsets.all(4),
                                                child: pw.Column(
                                                  mainAxisAlignment: pw
                                                      .MainAxisAlignment.start,
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Text(
                                                      'Reverse Charge :',
                                                      style: pw.TextStyle(
                                                        fontSize: 13,
                                                        color: PdfColor.fromInt(
                                                            0xff2f2e41),
                                                        fontWeight:
                                                            pw.FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          pw.TextAlign.left,
                                                    ),
                                                    pw.Text(
                                                      'N',
                                                      style: pw.TextStyle(
                                                        fontSize: 13,
                                                        color: PdfColor.fromInt(
                                                            0xff2f2e41),
                                                      ),
                                                      textAlign:
                                                          pw.TextAlign.left,
                                                    ),
                                                  ],
                                                ),
                                                width: 137.5,
                                                decoration: pw.BoxDecoration(
                                                    border: pw.Border.all()),
                                              ),
                                              pw.Container(
                                                height: 40,
                                                padding: pw.EdgeInsets.all(4),
                                                child: pw.Column(
                                                  mainAxisAlignment: pw
                                                      .MainAxisAlignment.start,
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Text(
                                                      'Place of Supply :',
                                                      style: pw.TextStyle(
                                                        fontSize: 13,
                                                        color: PdfColor.fromInt(
                                                            0xff2f2e41),
                                                        fontWeight:
                                                            pw.FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          pw.TextAlign.left,
                                                    ),
                                                    pw.Text(
                                                      sstate.text,
                                                      style: pw.TextStyle(
                                                        fontSize: 13,
                                                        color: PdfColor.fromInt(
                                                            0xff2f2e41),
                                                      ),
                                                      textAlign:
                                                          pw.TextAlign.left,
                                                    ),
                                                  ],
                                                ),
                                                width: 137.5,
                                                decoration: pw.BoxDecoration(
                                                    border: pw.Border.all()),
                                              ),
                                            ],
                                          ),
                                          pw.Column(children: [
                                            pw.Container(
                                              height: 40,
                                              padding: pw.EdgeInsets.all(4),
                                              child: pw.Column(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    pw.CrossAxisAlignment.start,
                                                children: [
                                                  pw.Text(
                                                    'Date of Invoice :',
                                                    style: pw.TextStyle(
                                                      fontSize: 13,
                                                      color: PdfColor.fromInt(
                                                          0xff2f2e41),
                                                      fontWeight:
                                                          pw.FontWeight.bold,
                                                    ),
                                                    textAlign:
                                                        pw.TextAlign.left,
                                                  ),
                                                  pw.Text(
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(DateTime.now())
                                                        .toString(),
                                                    style: pw.TextStyle(
                                                      fontSize: 13,
                                                      color: PdfColor.fromInt(
                                                          0xff2f2e41),
                                                    ),
                                                    textAlign:
                                                        pw.TextAlign.left,
                                                  ),
                                                ],
                                              ),
                                              width: 137.5,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                            ),
                                            pw.Container(
                                              height: 40,
                                              padding: pw.EdgeInsets.all(4),
                                              child: pw.Column(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    pw.CrossAxisAlignment.start,
                                                children: [
                                                  pw.Text(
                                                    'Transport :',
                                                    style: pw.TextStyle(
                                                      fontSize: 13,
                                                      color: PdfColor.fromInt(
                                                          0xff2f2e41),
                                                      fontWeight:
                                                          pw.FontWeight.bold,
                                                    ),
                                                    textAlign:
                                                        pw.TextAlign.left,
                                                  ),
                                                  pw.Text(
                                                    vehiclemode.text,
                                                    style: pw.TextStyle(
                                                      fontSize: 13,
                                                      color: PdfColor.fromInt(
                                                          0xff2f2e41),
                                                    ),
                                                    textAlign:
                                                        pw.TextAlign.left,
                                                  ),
                                                ],
                                              ),
                                              width: 137.5,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                            ),
                                            pw.Container(
                                              height: 40,
                                              padding: pw.EdgeInsets.all(4),
                                              child: pw.Column(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    pw.CrossAxisAlignment.start,
                                                children: [
                                                  pw.Text(
                                                    'Vehicle No :',
                                                    style: pw.TextStyle(
                                                      fontSize: 13,
                                                      color: PdfColor.fromInt(
                                                          0xff2f2e41),
                                                      fontWeight:
                                                          pw.FontWeight.bold,
                                                    ),
                                                    textAlign:
                                                        pw.TextAlign.left,
                                                  ),
                                                  pw.Text(
                                                    vehicleno.text,
                                                    style: pw.TextStyle(
                                                      fontSize: 13,
                                                      color: PdfColor.fromInt(
                                                          0xff2f2e41),
                                                    ),
                                                    textAlign:
                                                        pw.TextAlign.left,
                                                  ),
                                                ],
                                              ),
                                              width: 137.5,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                            ),
                                            pw.Container(
                                              height: 40,
                                              padding: pw.EdgeInsets.all(4),
                                              child: pw.Column(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    pw.CrossAxisAlignment.start,
                                                children: [],
                                              ),
                                              width: 137.5,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all()),
                                            ),
                                          ]),
                                        ]),
                                        pw.Container(
                                          height: 40,
                                          width: 275,
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'GR No:',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                  color: PdfColor.fromInt(
                                                      0xff2f2e41),
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                ),
                                                textAlign: pw.TextAlign.left,
                                              ),
                                              pw.Text(
                                                tracnsportdocno.text,
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                  color: PdfColor.fromInt(
                                                      0xff2f2e41),
                                                ),
                                                textAlign: pw.TextAlign.left,
                                              ),
                                            ],
                                          ),
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all()),
                                        ),
                                        pw.Container(
                                          width: 275,
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Company Bank A/C Details',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                  color: PdfColor.fromInt(
                                                      0xff2f2e41),
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                ),
                                                textAlign: pw.TextAlign.left,
                                              ),
                                              pw.Text(
                                                'Account Number : ' +
                                                    accountNumberController
                                                        .text,
                                                style: pw.TextStyle(
                                                  fontSize: 12,
                                                  color: PdfColor.fromInt(
                                                      0xff2f2e41),
                                                ),
                                                textAlign: pw.TextAlign.left,
                                              ),
                                              pw.Text(
                                                'IFSC Code : ' +
                                                    ifscCodeController.text,
                                                style: pw.TextStyle(
                                                  fontSize: 12,
                                                  color: PdfColor.fromInt(
                                                      0xff2f2e41),
                                                ),
                                                textAlign: pw.TextAlign.left,
                                              ),
                                              pw.Text(
                                                'Bank Number : ' +
                                                    bankNameController.text,
                                                style: pw.TextStyle(
                                                  fontSize: 12,
                                                  color: PdfColor.fromInt(
                                                      0xff2f2e41),
                                                ),
                                                textAlign: pw.TextAlign.left,
                                              ),
                                              pw.Text(
                                                'Branch Name : ' +
                                                    branchNameController.text,
                                                style: pw.TextStyle(
                                                  fontSize: 12,
                                                  color: PdfColor.fromInt(
                                                      0xff2f2e41),
                                                ),
                                                textAlign: pw.TextAlign.left,
                                              ),
                                            ],
                                          ),
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all()),
                                        ),
                                        pw.Container(
                                          width: 275,
                                          height: 121,
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Terms of Delivery',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                  color: PdfColor.fromInt(
                                                      0xff2f2e41),
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                ),
                                                textAlign: pw.TextAlign.left,
                                              ),
                                              pw.Text(
                                                // 'hello',
                                                termsandcondition.text,
                                                style: pw.TextStyle(
                                                  fontSize: 12,
                                                  color: PdfColor.fromInt(
                                                      0xff2f2e41),
                                                ),
                                                textAlign: pw.TextAlign.left,
                                              ),
                                            ],
                                          ),
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all()),
                                        ),
                                      ],
                                    ),
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(width: 2)),
                                  )
                                ])),
                        pw.SizedBox(height: 20)
                      ]);
          },
          footer: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
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
                                  ? null
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
                                  pw.Image(pw.MemoryImage(widget.sign)) == null
                                      ? null
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
            );
          },
          build: (context) => <pw.Widget>[
                //     pw.Table.fromTextArray(data: List<List<Widget>>.generate(l.length~/3+1, (index) => null)),
                pw.Container(
                  child: pw.Column(
                    children: [
                      pw.Container(
                        //width: 6100,
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
                              alignment: pw.Alignment.center,
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
                              alignment: pw.Alignment.center,
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
                              alignment: pw.Alignment.center,
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
                              alignment: pw.Alignment.center,
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
                              alignment: pw.Alignment.center,
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
                              alignment: pw.Alignment.center,
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
                              alignment: pw.Alignment.center,
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
                              alignment: pw.Alignment.center,
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
                if (l != null)
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
                                    l[index]['taxrate'],
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
                                    l[index]['baseTotalAmount'],
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
                                alignment: pw.Alignment.center,
                                width: 130,
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
                                width: 150,
                                child: pw.Text(
                                  'Taxable Amount',
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
                                  totalquantity.toString(),
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                                width: 40,
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
                if (taxes != null)
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                    (double.parse(taxes.entries
                                                .elementAt(index)
                                                .key
                                                .toString()) *
                                            double.parse((taxes.entries
                                                    .elementAt(index)
                                                    .value)
                                                .toString()) /
                                            100.toInt())
                                        .toStringAsFixed(2),
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
                if (l2 != null)
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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

                if (discount != 0.0)
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
                                  width: 50,
                                  child: pw.Text(
                                    '-' +
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
                  ]),
                if (tcs != 0.0)
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
                                  width: 50,
                                  child: pw.Text(
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
                  ]),

                if (roundoff != 0.0)
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                  alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                          height: 40,
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
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                                alignment: pw.Alignment.center,
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
                ])
              ]),
    );
    uploadtostorage();
    return await pdf.save();
  }
}
