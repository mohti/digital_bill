import 'package:digitalbillbook/product/addnewproduct.dart';
import 'package:digitalbillbook/reports/productList.dart';
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
                    padding: const EdgeInsets.all(15.0),
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
                padding: const EdgeInsets.only(right:10.0),
                child: Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Product1 extends StatelessWidget {
  final String uid;
  Product1(this.uid);
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
          'Products',
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
                null,
                ' Add New Product',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Addproduct(uid))),
                w),
            Tab(
                null,
                ' Product List',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductList(uid))),
                w),
          ],
        ),
      ),
    );
  }
}
