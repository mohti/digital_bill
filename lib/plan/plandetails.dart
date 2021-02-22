// ignore: unused_import
import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_svg/svg.dart';

class CurrentPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  final double w = MediaQuery.of(context).size.width;

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
            Align(
              alignment: Alignment.center,
              child: Stack(children: [
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.string(
                    '<svg viewBox="26.0 170.8 360.2 264.2" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="10"/></filter><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff683e77"  /><stop offset="1.0" stop-color="#ff1b1b2a"  /></linearGradient></defs><path transform="translate(26.0, 170.75)" d="M 29.40257835388184 0 L 330.7790222167969 0 C 347.0176086425781 0 360.1816101074219 13.74526309967041 360.1816101074219 30.70090866088867 L 360.1816101074219 233.5461730957031 C 360.1816101074219 250.5018310546875 347.0176086425781 264.2470703125 330.7790222167969 264.2470703125 L 29.40257835388184 264.2470703125 C 13.16398239135742 264.2470703125 0 250.5018310546875 0 233.5461730957031 L 0 30.70090866088867 C 0 13.74526309967041 13.16398239135742 0 29.40257835388184 0 Z" fill="url(#gradient)" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>',
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
                            '66 %',
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
                            '900',
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
                                    bounds: Rect.fromLTWH(0.0, 0.0, 24.0, 24.0),
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
                                            Radius.elliptical(9999.0, 9999.0)),
                                        color: const Color(0x0f000000),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(5.0, 5.0, 14.0, 14.0),
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
                                            Radius.elliptical(9999.0, 9999.0)),
                                        color: const Color(0xff32e907),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 159.0,
                            child: Text(
                              'Start Date : 12/12/2019          ',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xffff0e27),
                                height: 1.6428571428571428,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            width: 159.0,
                            child: Text(
                              '   End Date : 12/12/2019',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xffff0e27),
                                height: 1.6428571428571428,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
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
                        onTap: () => Navigator.pushNamed(context, './checkout'),
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
