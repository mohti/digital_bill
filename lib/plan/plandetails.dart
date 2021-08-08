// ignore: unused_import
import 'package:adobe_xd/pinned.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'checkout.dart';

class CurrentPlan extends StatefulWidget {
  final String uid;
  CurrentPlan(this.uid);

  @override
  _CurrentPlanState createState() => _CurrentPlanState();
}

class _CurrentPlanState extends State<CurrentPlan> {
  int invoice;
  DateTime duration;
  final planName = TextEditingController();
  int ewaybillno;
  int index = 0;

  Future<Null> _getBusinessDetails6(String uid)  {
     FirebaseFirestore.instance
        .collection("userData")
        .doc(widget.uid)
        .collection("planDetails")
        .doc('plan')
        .get()
        .then((valuee) {
      setState(() {
        final Timestamp timestamp = (valuee.data()['duration']) as Timestamp;
        duration = timestamp.toDate();
        planName.text = valuee.data()['planName'];
        ewaybillno = valuee.data()['remainingewaybill'];
        invoice = valuee.data()['remaininginvoices'];
        // allDataloaded = true;
      });
    });
  }

  @override
  void initState() {
    _getBusinessDetails6(widget.uid);
    super.initState();
  }

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

     final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
         leading: IconButton(icon:Icon(Icons.arrow_back_ios),
          onPressed: ()=> Navigator.of(context).pop(),),
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
            if (index == 0)
            
              Container(
                 alignment: Alignment.center,
                        width: w * 0.93,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xfff1D55C5).withOpacity(1),
                              Color(0xfff2F508C).withOpacity(1)
                            ],
                          ),
                        ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: w * 0.2,
                      child: SvgPicture.string(
                        '<svg viewBox="44.5 454.6 43.6 54.9" ><path transform="translate(40.0, 450.11)" d="M 43.52875518798828 4.5 L 9.038227081298828 4.5 C 6.531877517700195 4.5 4.5 7.061384201049805 4.5 10.22120666503906 L 4.5 53.70237731933594 C 4.5 56.86220169067383 6.531877517700195 59.423583984375 9.038227081298828 59.423583984375 L 43.52875518798828 59.423583984375 C 46.03522109985352 59.423583984375 48.06698226928711 56.86220169067383 48.06698226928711 53.70237731933594 L 48.06698226928711 10.22120666503906 C 48.06698226928711 7.061384201049805 46.03521728515625 4.5 43.52875518798828 4.5 Z M 31.7293643951416 47.98117065429688 L 13.57645511627197 47.98117065429688 L 13.57645511627197 41.11572265625 L 31.7293643951416 41.11572265625 L 31.7293643951416 47.98117065429688 Z M 38.99052810668945 35.39451599121094 L 13.57645511627197 35.39451599121094 L 13.57645511627197 28.52906799316406 L 38.99052810668945 28.52906799316406 L 38.99052810668945 35.39451599121094 Z M 38.99052810668945 22.807861328125 L 13.57645511627197 22.807861328125 L 13.57645511627197 15.94241333007812 L 38.99052810668945 15.94241333007812 L 38.99052810668945 22.807861328125 Z" fill="none" stroke="#f1f3f6" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                    Container(
                      width: w * 0.7,
                      height: 160,
                      child: Stack(children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Your Plan - ' + planName.text,
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 20,
                                  color: const Color(0xfff2f2f2),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '     Exp. Date:               ' +
                                    DateFormat('dd/MM/yyyy')
                                        .format(duration)
                                        .toString(),
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 10,
                                  color: const Color(0xe5ffffff),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '     Remaining Plan :    ' +
                                    invoice.toString() +
                                    ' Invoice, ' +
                                    ewaybillno.toString() +
                                    'e-Way Bill',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 10,
                                  color: const Color(0xe5ffffff),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),

            // Text('No Plan'),

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
