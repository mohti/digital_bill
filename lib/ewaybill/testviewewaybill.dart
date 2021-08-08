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
  bool loader = false;
  Future<Null> loaddoc() async {
    print(widget.invoiceno + '  ==================================mohit');
    setState(() {
      loader = true;
    });
    // setState(()async {
    document = await PDFDocument.fromURL('http://' + widget.invoiceno);
    setState(() {
      loader = false;
      //  });
    });
  }

  void initState() {
    loaddoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Eway-bill preview'),
      ),
      body: loader == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(child: PDFViewer(document: document)),
    );
  }
}
