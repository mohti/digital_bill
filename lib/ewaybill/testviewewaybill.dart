import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class TestViewEwayBill extends StatefulWidget {
  final String invoiceno;

  TestViewEwayBill(
    this.invoiceno,
  );
  @override
  _TestViewEwayBillState createState() => _TestViewEwayBillState();
}

class _TestViewEwayBillState extends State<TestViewEwayBill> {
  PDFDocument document;

  Future<Null> loaddoc() async {
    document = await PDFDocument.fromURL(widget.invoiceno);
  }

  @override
  Widget build(BuildContext context) {
    loaddoc();
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
      ),
      body: Center(child: PDFViewer(document: document)),
    );
  }
}
