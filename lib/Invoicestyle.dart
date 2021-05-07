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
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}

class InvoiceStyle extends StatefulWidget {
  @override
  _InvoiceStyleState createState() => _InvoiceStyleState();
}

class _InvoiceStyleState extends State<InvoiceStyle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Invoice Style',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context, false),
              child: Container(
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage('assets/Component7.jpg'),
                    height: 300,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => Navigator.pop(context, true),
              child: Container(
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage('assets/Component12.jpg'),
                    height: 300,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
