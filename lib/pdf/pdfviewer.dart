import 'package:flutter/material.dart';

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalbillbook/models/businessprofile.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PdfViewer extends StatefulWidget {
  final String uid;
  PdfViewer(this.uid);
  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  List<LayoutCallback> _tabGen;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    downloadURLExample();
    super.initState();
  }

  Uint8List logo;
  String _downloadURL, _downloadURLsign, _downloadURLstamp;

  Future<void> downloadURLExamplesign() async {
    String downloadURLsign = await firebase_storage.FirebaseStorage.instance
        .ref(widget.uid + '/business/sign.png')
        .getDownloadURL();
    setState(() {
      print(_downloadURL);
      _downloadURLsign = downloadURLsign;
    });
    // Within your widgets:
    // Image.network(downloadURL);
  }

  Future<void> downloadURLExamplestamp() async {
    String downloadURLstamp = await firebase_storage.FirebaseStorage.instance
        .ref(widget.uid + '/business/stamp.png')
        .getDownloadURL();
    setState(() {
      print(_downloadURL);
      _downloadURLstamp = downloadURLstamp;
    });
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
  Widget build(BuildContext context) {
    _tabGen = <LayoutCallback>[generateInvoice];
    return Scaffold(
        body: PdfPreview(
      maxPageWidth: 1000,
      actions: [],
      build: _tabGen[0],
    ));
  }

  final db = FirebaseFirestore.instance;
  final businessNameController = TextEditingController();
  final phoneController = TextEditingController();
  final authorisedSignatureController = TextEditingController();
  final iconController = TextEditingController();
  final signatureController = TextEditingController();
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
  final businessInfo = new BusinessProfile(
      '', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');

  Future<Null> _getBusinessDetails(String uid) async {
    await db
        .collection("userData")
        .doc(uid)
        .collection("BusinessInfo")
        .doc('businessName')
        .get()
        .then((valuee) {
      setState(() {
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

  Future<Uint8List> generateInvoice(PdfPageFormat pageFormat) async {
    _getBusinessDetails(widget.uid);
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) => pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Align(
                      alignment: pw.Alignment.topRight,
                      child: pw.SizedBox(
                        width: 100.0,
                        child: pw.Text(
                          'Original for Buyer',
                          style: pw.TextStyle(
                            fontSize: 9,
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
                              child: pw.Image(pw.MemoryImage(logo))
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
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                        children: [
                          pw.SizedBox(
                            width: 96.0,
                            child: pw.Text(
                              'GSTN : ' + gstNumberController.text,
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColor.fromInt(0xff2f2e41),
                              ),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                          pw.SizedBox(
                            width: 96.0,
                            child: pw.Text(
                              'Email : ' + emailController.text,
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColor.fromInt(0xff2f2e41),
                              ),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                          pw.SizedBox(
                            width: 96.0,
                            child: pw.Text(
                              'Phone No. : ' + phoneController.text,
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColor.fromInt(0xff2f2e41),
                              ),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Container(height: 2, color: PdfColors.black),
                    pw.SizedBox(height: 10),
                    pw.Container(
                        padding: pw.EdgeInsets.all(10),
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Row(children: [
                          pw.SizedBox(width: 20),
                          pw.Container(
                            width: 220,
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    'Invoice No :        ',
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColor.fromInt(0xff2f2e41),
                                    ),
                                    textAlign: pw.TextAlign.left,
                                  ),
                                  pw.Text(
                                    'Date of Invoice :   ',
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColor.fromInt(0xff2f2e41),
                                    ),
                                    textAlign: pw.TextAlign.left,
                                  ),
                                  pw.Text(
                                    'State & State Code :',
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColor.fromInt(0xff2f2e41),
                                    ),
                                    textAlign: pw.TextAlign.left,
                                  ),
                                  pw.Text(
                                    'Reverse Charge :    ',
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
                                  'Transport :          ',
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    color: PdfColor.fromInt(0xff2f2e41),
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                                pw.Text(
                                  'Vehicle No :         ',
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
                    pw.Row(children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Padding(
                              padding: pw.EdgeInsets.only(top: 10, bottom: 10),
                              child: pw.Text(
                                'Billed to :',
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
                                width: 200,
                                child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        'Name :       ',
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                      pw.Text(
                                        'Address :    ',
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                      pw.Text(
                                        'Mobile No. :  ',
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                      pw.Text(
                                        'Email :       ',
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                      pw.Text(
                                        'GSTN :         ',
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          color: PdfColor.fromInt(0xff2f2e41),
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ]))
                          ])
                    ])
                  ])),
    );
    return await pdf.save();
  }
}
