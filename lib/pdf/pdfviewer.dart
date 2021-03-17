import 'package:flutter/material.dart';

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalbillbook/models/businessprofile.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfViewer extends StatefulWidget {
  final String uiEd;
  PdfViewer(this.uiEd);
  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  List<LayoutCallback> _tabGen;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _tabGen = <LayoutCallback>[generateInvoice];
    return Scaffold(
        body: PdfPreview(
      maxPageWidth: 700,
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
      });
    });
  }

  Future<Uint8List> generateInvoice(PdfPageFormat pageFormat) async {
    _getBusinessDetails(widget.uiEd);
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) =>
            pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          pw.Align(
            alignment: pw.Alignment.topRight,
            child: pw.SizedBox(
              width: 67.0,
              child: pw.Text(
                'Original for Buyer',
                style: pw.TextStyle(
                  fontSize: 7,
                  color: PdfColor.fromInt(0xff2f2e41),
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
          ),
          pw.Text(
            businessNameController.text,
            style: pw.TextStyle(
              fontSize: 16,
              color: PdfColor.fromInt(0xff2f2e41),
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(
            width: 242.0,
            child: pw.Text(
              businesAddressController.text,
              style: pw.TextStyle(
                fontSize: 7,
                color: PdfColor.fromInt(0xff2f2e41),
              ),
              textAlign: pw.TextAlign.center,
            ),
          )
        ]),
      ),
    );
    return await pdf.save();
  }
}
