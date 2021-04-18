import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class ViewEwayBill extends StatefulWidget {
  final String invoiceno;

  ViewEwayBill(
    this.invoiceno,
  );
  @override
  _ViewEwayBillState createState() => _ViewEwayBillState();
}

class _ViewEwayBillState extends State<ViewEwayBill> {
  List<LayoutCallback> _tabGen;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    super.initState();
  }

  Future<Uint8List> getpdf(PdfPageFormat format) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final pdf = File('$appDocPath/$widget.invoiceno.pdf');
    return pdf.readAsBytes();
  }

  @override
  Widget build(BuildContext context) {
    _tabGen = <LayoutCallback>[getpdf];
    return Scaffold(
        body: PdfPreview(
      allowPrinting: false,
      initialPageFormat: PdfPageFormat.a4,
      pdfFileName: 'ewaybill ' + widget.invoiceno,
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
}
