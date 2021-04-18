// ignore: unused_import
import 'package:adobe_xd/pinned.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_svg/svg.dart';

import 'checkout.dart';

class CurrentPlan extends StatefulWidget {
  final String uid;
  CurrentPlan(this.uid);

  @override
  _CurrentPlanState createState() => _CurrentPlanState();
}

class _CurrentPlanState extends State<CurrentPlan> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    //  final double w = MediaQuery.of(context).size.width;
    FirebaseFirestore.instance
        .collection("userData")
        .doc(widget.uid)
        .collection("planDetails")
        .doc('plan')
        .get()
        .then((value) {
      if (value.data()['planName'] == 'Free Trial') {
        setState(() {
          index = 0;
        });
      }
      if (value.data()['planName'] == 'Basic Plan') {
        setState(() {
          index = 1;
        });
      }
      if (value.data()['planName'] == 'Standard Plan') {
        setState(() {
          index = 2;
        });
      }
      if (value.data()['planName'] == 'Premium Plan') {
        setState(() {
          index = 3;
        });
      }
      if (value.data()['planName'] == 'Premium Plus Plan') {
        setState(() {
          index = 4;
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Current Plan',
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
            SizedBox(
              height: 50,
            ),
            if (index == 0) Text('No Plan'),
            if (index == 1)
              Align(
                alignment: Alignment.center,
                child: Stack(children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.string(
                      '<svg viewBox="32.0 262.8 353.0 215.7" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="10"/></filter><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff683e77"  /><stop offset="1.0" stop-color="#ff1b1b2a"  /></linearGradient></defs><path transform="translate(32.0, 262.75)" d="M 28.81632614135742 0 L 324.1836853027344 0 C 340.0985107421875 0 353 11.21790504455566 353 25.0558967590332 L 353 190.603759765625 C 353 204.4417724609375 340.0985107421875 215.6596527099609 324.1836853027344 215.6596527099609 L 28.81632614135742 215.6596527099609 C 12.90150833129883 215.6596527099609 0 204.4417724609375 0 190.603759765625 L 0 25.0558967590332 C 0 11.21790504455566 12.90150833129883 0 28.81632614135742 0 Z" fill="url(#gradient)" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Basic Plan',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 16,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            height: 1.625,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 77.0,
                              height: 19.0,
                              child: Text(
                                'You Saving',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              '30 %',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffffffff),
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 35.0,
                              height: 19.0,
                              child: Text(
                                'Price',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              '500',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffff0e27),
                                decoration: TextDecoration.lineThrough,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 85.0,
                              height: 19.0,
                              child: Text(
                                'for you only',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              '349',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffffffff),
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 137.0,
                                height: 19.0,
                                child: Text(
                                  ' 1 Month Subscription     ',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    fontSize: 14,
                                    color: const Color(0xa8ffffff),
                                    height: 1.6428571428571428,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),

                              // Adobe XD layer: 'Radio Button' (group)
                              SizedBox(
                                width: 24.0,
                                height: 24.0,
                                child: Stack(
                                  children: <Widget>[
                                    Pinned.fromSize(
                                      bounds:
                                          Rect.fromLTWH(0.0, 0.0, 24.0, 24.0),
                                      size: Size(24.0, 24.0),
                                      pinLeft: true,
                                      pinRight: true,
                                      pinTop: true,
                                      pinBottom: true,
                                      child:
                                          // Adobe XD layer: 'Dot 2' (shape)
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(
                                                  9999.0, 9999.0)),
                                          color: const Color(0x0fFF0E27),
                                        ),
                                      ),
                                    ),
                                    Pinned.fromSize(
                                      bounds:
                                          Rect.fromLTWH(5.0, 5.0, 14.0, 14.0),
                                      size: Size(24.0, 24.0),
                                      pinLeft: true,
                                      pinRight: true,
                                      pinTop: true,
                                      pinBottom: true,
                                      child:
                                          // Adobe XD layer: 'Dot 2' (shape)
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(
                                                  9999.0, 9999.0)),
                                          color: const Color(0xffFF0E27),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 137.0,
                              height: 19.0,
                              child: Text(
                                'Monthly Charges',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              'RS 349',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            if (index == 2)
              Align(
                alignment: Alignment.center,
                child: Stack(children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.string(
                      '<svg viewBox="32.0 262.8 353.0 215.7" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="10"/></filter><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff683e77"  /><stop offset="1.0" stop-color="#ff1b1b2a"  /></linearGradient></defs><path transform="translate(32.0, 262.75)" d="M 28.81632614135742 0 L 324.1836853027344 0 C 340.0985107421875 0 353 11.21790504455566 353 25.0558967590332 L 353 190.603759765625 C 353 204.4417724609375 340.0985107421875 215.6596527099609 324.1836853027344 215.6596527099609 L 28.81632614135742 215.6596527099609 C 12.90150833129883 215.6596527099609 0 204.4417724609375 0 190.603759765625 L 0 25.0558967590332 C 0 11.21790504455566 12.90150833129883 0 28.81632614135742 0 Z" fill="url(#gradient)" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Standard Plan',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 16,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            height: 1.625,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 77.0,
                              height: 19.0,
                              child: Text(
                                'You Saving',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              '40 %',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffffffff),
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 35.0,
                              height: 19.0,
                              child: Text(
                                'Price',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              '1500',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffff0e27),
                                decoration: TextDecoration.lineThrough,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 85.0,
                              height: 19.0,
                              child: Text(
                                'for you only',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              '899',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffffffff),
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 137.0,
                                height: 19.0,
                                child: Text(
                                  ' 3 Month Subscription     ',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    fontSize: 14,
                                    color: const Color(0xa8ffffff),
                                    height: 1.6428571428571428,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),

                              // Adobe XD layer: 'Radio Button' (group)
                              SizedBox(
                                width: 24.0,
                                height: 24.0,
                                child: Stack(
                                  children: <Widget>[
                                    Pinned.fromSize(
                                      bounds:
                                          Rect.fromLTWH(0.0, 0.0, 24.0, 24.0),
                                      size: Size(24.0, 24.0),
                                      pinLeft: true,
                                      pinRight: true,
                                      pinTop: true,
                                      pinBottom: true,
                                      child:
                                          // Adobe XD layer: 'Dot 2' (shape)
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(
                                                  9999.0, 9999.0)),
                                          color: const Color(0x0fFF0E27),
                                        ),
                                      ),
                                    ),
                                    Pinned.fromSize(
                                      bounds:
                                          Rect.fromLTWH(5.0, 5.0, 14.0, 14.0),
                                      size: Size(24.0, 24.0),
                                      pinLeft: true,
                                      pinRight: true,
                                      pinTop: true,
                                      pinBottom: true,
                                      child:
                                          // Adobe XD layer: 'Dot 2' (shape)
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(
                                                  9999.0, 9999.0)),
                                          color: const Color(0xffFF0E27),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 137.0,
                              height: 19.0,
                              child: Text(
                                'Monthly Charges',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              'RS 300',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            if (index == 3)
              Align(
                alignment: Alignment.center,
                child: Stack(children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.string(
                      '<svg viewBox="32.0 262.8 353.0 215.7" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="10"/></filter><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff683e77"  /><stop offset="1.0" stop-color="#ff1b1b2a"  /></linearGradient></defs><path transform="translate(32.0, 262.75)" d="M 28.81632614135742 0 L 324.1836853027344 0 C 340.0985107421875 0 353 11.21790504455566 353 25.0558967590332 L 353 190.603759765625 C 353 204.4417724609375 340.0985107421875 215.6596527099609 324.1836853027344 215.6596527099609 L 28.81632614135742 215.6596527099609 C 12.90150833129883 215.6596527099609 0 204.4417724609375 0 190.603759765625 L 0 25.0558967590332 C 0 11.21790504455566 12.90150833129883 0 28.81632614135742 0 Z" fill="url(#gradient)" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Premium Plan',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 16,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            height: 1.625,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 77.0,
                              height: 19.0,
                              child: Text(
                                'You Saving',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              '50 %',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffffffff),
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 35.0,
                              height: 19.0,
                              child: Text(
                                'Price',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              '3000',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffff0e27),
                                decoration: TextDecoration.lineThrough,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 85.0,
                              height: 19.0,
                              child: Text(
                                'for you only',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              '1499',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffffffff),
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 137.0,
                                height: 19.0,
                                child: Text(
                                  ' 12 Month Subscription    ',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    fontSize: 14,
                                    color: const Color(0xa8ffffff),
                                    height: 1.6428571428571428,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),

                              // Adobe XD layer: 'Radio Button' (group)
                              SizedBox(
                                width: 24.0,
                                height: 24.0,
                                child: Stack(
                                  children: <Widget>[
                                    Pinned.fromSize(
                                      bounds:
                                          Rect.fromLTWH(0.0, 0.0, 24.0, 24.0),
                                      size: Size(24.0, 24.0),
                                      pinLeft: true,
                                      pinRight: true,
                                      pinTop: true,
                                      pinBottom: true,
                                      child:
                                          // Adobe XD layer: 'Dot 2' (shape)
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(
                                                  9999.0, 9999.0)),
                                          color: const Color(0x0fFF0E27),
                                        ),
                                      ),
                                    ),
                                    Pinned.fromSize(
                                      bounds:
                                          Rect.fromLTWH(5.0, 5.0, 14.0, 14.0),
                                      size: Size(24.0, 24.0),
                                      pinLeft: true,
                                      pinRight: true,
                                      pinTop: true,
                                      pinBottom: true,
                                      child:
                                          // Adobe XD layer: 'Dot 2' (shape)
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(
                                                  9999.0, 9999.0)),
                                          color: const Color(0xffFF0E27),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 137.0,
                              height: 19.0,
                              child: Text(
                                'Monthly Charges',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              'RS 250',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            if (index == 4)
              Align(
                alignment: Alignment.center,
                child: Stack(children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.string(
                      '<svg viewBox="32.0 262.8 353.0 215.7" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="10"/></filter><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff683e77"  /><stop offset="1.0" stop-color="#ff1b1b2a"  /></linearGradient></defs><path transform="translate(32.0, 262.75)" d="M 28.81632614135742 0 L 324.1836853027344 0 C 340.0985107421875 0 353 11.21790504455566 353 25.0558967590332 L 353 190.603759765625 C 353 204.4417724609375 340.0985107421875 215.6596527099609 324.1836853027344 215.6596527099609 L 28.81632614135742 215.6596527099609 C 12.90150833129883 215.6596527099609 0 204.4417724609375 0 190.603759765625 L 0 25.0558967590332 C 0 11.21790504455566 12.90150833129883 0 28.81632614135742 0 Z" fill="url(#gradient)" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Premium Plus Plan',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 16,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            height: 1.625,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 77.0,
                              height: 19.0,
                              child: Text(
                                'You Saving',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              '70 %',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffffffff),
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 35.0,
                              height: 19.0,
                              child: Text(
                                'Price',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              '6000',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffff0e27),
                                decoration: TextDecoration.lineThrough,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 85.0,
                              height: 19.0,
                              child: Text(
                                'for you only',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              '1799',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffffffff),
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 137.0,
                                height: 19.0,
                                child: Text(
                                  ' 12 Month Subscription    ',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    fontSize: 14,
                                    color: const Color(0xa8ffffff),
                                    height: 1.6428571428571428,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),

                              // Adobe XD layer: 'Radio Button' (group)
                              SizedBox(
                                width: 24.0,
                                height: 24.0,
                                child: Stack(
                                  children: <Widget>[
                                    Pinned.fromSize(
                                      bounds:
                                          Rect.fromLTWH(0.0, 0.0, 24.0, 24.0),
                                      size: Size(24.0, 24.0),
                                      pinLeft: true,
                                      pinRight: true,
                                      pinTop: true,
                                      pinBottom: true,
                                      child:
                                          // Adobe XD layer: 'Dot 2' (shape)
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(
                                                  9999.0, 9999.0)),
                                          color: const Color(0x0fFF0E27),
                                        ),
                                      ),
                                    ),
                                    Pinned.fromSize(
                                      bounds:
                                          Rect.fromLTWH(5.0, 5.0, 14.0, 14.0),
                                      size: Size(24.0, 24.0),
                                      pinLeft: true,
                                      pinRight: true,
                                      pinTop: true,
                                      pinBottom: true,
                                      child:
                                          // Adobe XD layer: 'Dot 2' (shape)
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(
                                                  9999.0, 9999.0)),
                                          color: const Color(0xffFF0E27),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 137.0,
                              height: 19.0,
                              child: Text(
                                'Monthly Charges',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              'RS 150',
                              style: TextStyle(
                                fontFamily: 'Acumin Pro',
                                fontSize: 20,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),

            // Adobe XD layer: 'Primary Button - Sm…' (group)
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 168.0,
                  height: 38.0,
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(0.0, 0.0, 168.0, 38.0),
                        size: Size(168.0, 38.0),
                        pinLeft: true,
                        pinRight: true,
                        pinTop: true,
                        pinBottom: true,
                        child:
                            // Adobe XD layer: 'Button' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: const Color(0xff2f2e41),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Checkout(widget.uid),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Upgrade Your Plan',
                            style: TextStyle(
                              fontFamily: 'SF Pro Text',
                              fontSize: 14,
                              color: const Color(0xffffffff),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
