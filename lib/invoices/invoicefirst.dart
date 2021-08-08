import 'package:digitalbillbook/downloadpdfs/idownloadPurchaseinvoice.dart';
import 'package:digitalbillbook/downloadpdfs/idownloadinvoicepdf.dart';
import 'package:digitalbillbook/invoices/invoicemain.dart';
import 'package:digitalbillbook/purchase/purchaseinvoice.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class Tab extends StatelessWidget {
  final String title;
  final Function f;
  final double w;
  final Widget ic;
  Tab(this.ic, this.title, this.f, this.w);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: f,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: w * 1,
          height: 50,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ic,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 12,
                      color: const Color(0xff2f2e41),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}

class Invoicefirst extends StatelessWidget {
  final uid;
  final bool i;
  Invoicefirst(this.uid, this.i);
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
         leading: IconButton(icon:Icon(Icons.arrow_back_ios),
          onPressed: ()=>
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(uid),
          ),
        ),
           //Navigator.of(context).pop(),
           ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Invoice',
          style: TextStyle(
            fontFamily: 'Bell MT',
            fontSize: 24,
            color: const Color(0xfff2f2f2),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Tab(
                SizedBox(
                  width: 10,
                ),
                'Generate New Sale Invoice',
                () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InvoiceMain(uid, i),
                      ),
                    ),
                w),
            Tab(
                SizedBox(
                  width: 10,
                ),
                'Add New Purchase Receipt',
                () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PurchaseInvoice(uid),
                      ),
                    ),
                w),
            Tab(
                SizedBox(
                  width: 10,
                ),
                'All Sales Invoice',
                () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DownloadInvoice(uid),
                      ),
                    ),
                w),
            Tab(
                SizedBox(
                  width: 10,
                ),
                'All Purchase Receipt',
                () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DownloadPurchaseInvoice(uid),
                      ),
                    ),
                w),
          ],
        ),
      ),
    );
  }
}
