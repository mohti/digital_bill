import 'package:digitalbillbook/reports/lowstock.dart';
import 'package:digitalbillbook/reports/partieslist.dart';
import 'package:digitalbillbook/reports/productList.dart';
import 'package:digitalbillbook/reports/purchsesummary.dart';
import 'package:digitalbillbook/reports/salesummary.dart';
import 'package:digitalbillbook/reports/stocksummary.dart';
import 'package:flutter/material.dart';

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
                      fontFamily: 'Bell MT',
                      fontSize: 18,
                      color: const Color(0xff2f2e41),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right:15.0),
                child: Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Report1 extends StatelessWidget {
  final String uid;
  Report1(this.uid);
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(icon:Icon(Icons.arrow_back_ios),
          onPressed: ()=> Navigator.of(context).pop(),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Reports',
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
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Text(
            //     'Reports',
            //     style: TextStyle(
            //       fontFamily: 'Bell MT',
            //       fontSize: 18,
            //       color: const Color(0xff2f2e41),
            //       fontWeight: FontWeight.w700,
            //     ),
            //     textAlign: TextAlign.left,
            //   ),
            // ),
            SizedBox(height: 40,),
            Tab(
                null,
                ' Stocks Summary',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StockSummary(uid))),
                w),
            Tab(
                null,
                ' Product List (Rate List)',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductList(uid))),
                w),
            Tab(
                null,
                ' Sales Summary',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SalesSummary(uid))),
                w),
            Tab(
                null,
                ' Low Stock',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LowStock(uid))),
                w),
            Tab(
                null,
                ' Party List',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PartiesList(uid))),
                w),
            Tab(
                null,
                ' Purchase Summary',
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PurchaseSummary(uid))),
                w),
          ],
        ),
      ),
    );
  }
}
