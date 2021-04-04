import 'package:adobe_xd/pinned.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalbillbook/models/remindersettings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class NotificationBlock extends StatelessWidget {
  final String productCode;
  final double w;
  NotificationBlock(this.productCode, this.w);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: w * 1,
        height: 100,
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    child: // Adobe XD layer: 'Icon feather-alert-…' (group)
                        Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.error_outline_rounded,
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      color: const Color(0xff8b9dff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x658f89d6),
                          offset: Offset(0, 6),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 194.0,
                  height: 43.0,
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: 'Neusa Next Std',
                        fontSize: 15,
                        color: const Color(0xff515c6f),
                      ),
                      children: [
                        TextSpan(
                          text: 'Stock Alert Product Code ',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: '#' + productCode,
                          style: TextStyle(
                            color: const Color(0xffff6969),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: ' is ',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: 'OutofStock',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: w * 0.2,
                ),
                // Adobe XD layer: 'Indicator' (group)
                SizedBox(
                  width: 9.0,
                  height: 9.0,
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(0.0, 0.0, 9.0, 9.0),
                        size: Size(9.0, 9.0),
                        pinLeft: true,
                        pinRight: true,
                        pinTop: true,
                        pinBottom: true,
                        child:
                            // Adobe XD layer: 'indicator base' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: const Color(0xffff6969),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationPage extends StatefulWidget {
  final String uid;
  NotificationPage(this.uid);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool lowStockAlert = false, gstr1 = false, gstr3b = false;
  var reminderSettings = new ReminderSettings(false, false, false);
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    Future<void> setf() async {
      await FirebaseFirestore.instance
          .collection("userData")
          .doc(widget.uid)
          .collection("ReminderSettings")
          .doc('reminderSettings')
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          FirebaseFirestore.instance
              .collection("userData")
              .doc(widget.uid)
              .collection("ReminderSettings")
              .doc('reminderSettings')
              .get()
              .then((value) {
            setState(() {
              lowStockAlert = value.data()['lowStockALert'];
              gstr1 = value.data()['gstr1'];
              gstr3b = value.data()['gstr3b'];
            });
          });
        } else {
          reminderSettings.lowStockALert = lowStockAlert;
          reminderSettings.gstr1 = gstr1;

          reminderSettings.gstr3b = gstr3b;
          // Call the user's CollectionReference to add a new user

          FirebaseFirestore.instance
              .collection("userData")
              .doc(widget.uid)
              .collection("ReminderSettings")
              .doc('reminderSettings')
              .set(reminderSettings.toJson());
        }
      });
    }

    setf();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
        BuildContext context) async* {
      yield* FirebaseFirestore.instance
          .collection('userData')
          .doc(widget.uid)
          .collection('Product')
          .snapshots();
    }

    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Notification',
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
          children: [
            Container(
              width: w * 1,
              height: 100,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  gstr1
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.string(
                                    '<svg viewBox="41.4 231.4 29.9 29.3" ><path transform="translate(38.35, 227.63)" d="M 11.36999988555908 6.119999885559082 L 9.225000381469727 3.974999904632568 C 5.625 6.71999979019165 3.255000114440918 10.94999980926514 3.045000076293945 15.75 L 6.045000076293945 15.75 C 6.269999980926514 11.77499961853027 8.310000419616699 8.295000076293945 11.36999988555908 6.119999885559082 Z M 29.95499801635742 15.75 L 32.95499801635742 15.75 C 32.72999954223633 10.94999980926514 30.35999870300293 6.720000267028809 26.77499771118164 3.975000381469727 L 24.64499664306641 6.12000036239624 C 27.67499732971191 8.295000076293945 29.72999572753906 11.77500057220459 29.95499610900879 15.75 Z M 27 16.5 C 27 11.89500045776367 24.54000091552734 8.039999961853027 20.25 7.020000457763672 L 20.25 6 C 20.25 4.755000114440918 19.2450008392334 3.75 18 3.75 C 16.7549991607666 3.75 15.75 4.755000114440918 15.75 6 L 15.75 7.019999980926514 C 11.44499969482422 8.039999961853027 9 11.88000011444092 9 16.5 L 9 24 L 6 27 L 6 28.5 L 30 28.5 L 30 27 L 27 24 L 27 16.5 Z M 18 33 C 18.20999908447266 33 18.40500068664551 32.98500061035156 18.60000038146973 32.93999862670898 C 19.57500076293945 32.72999954223633 20.3700008392334 32.06999969482422 20.76000022888184 31.16999816894531 C 20.90999984741211 30.80999755859375 20.98500061035156 30.41999816894531 20.98500061035156 29.99999809265137 L 14.98500061035156 29.99999809265137 C 15.00000095367432 31.64999771118164 16.33500099182129 33 18 33 Z" fill="#f1f3f6" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(9999.0, 9999.0)),
                                  color: const Color(0xff4ad1c7),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x6576d3d3),
                                      offset: Offset(0, 6),
                                      blurRadius: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            gstr1
                                ? SizedBox(
                                    width: 194.0,
                                    height: 80.0,
                                    child: SingleChildScrollView(
                                        child: Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Neusa Next Std',
                                          fontSize: 15,
                                          color: const Color(0xff515c6f),
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                'Last Date of Filling for January GSTR 1 ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '24/' +
                                                DateFormat('MM/yyyy')
                                                    .format(DateTime.now())
                                                    .toString(),
                                            style: TextStyle(
                                              color: const Color(0xffff6969),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ' Submit your return to save penalty. ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.left,
                                    )),
                                  )
                                : Container()
                          ],
                        )
                      : Container()
                ],
              ),
            ),
            gstr3b
                ? Container(
                    width: w * 1,
                    height: 100,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.string(
                                    '<svg viewBox="41.4 231.4 29.9 29.3" ><path transform="translate(38.35, 227.63)" d="M 11.36999988555908 6.119999885559082 L 9.225000381469727 3.974999904632568 C 5.625 6.71999979019165 3.255000114440918 10.94999980926514 3.045000076293945 15.75 L 6.045000076293945 15.75 C 6.269999980926514 11.77499961853027 8.310000419616699 8.295000076293945 11.36999988555908 6.119999885559082 Z M 29.95499801635742 15.75 L 32.95499801635742 15.75 C 32.72999954223633 10.94999980926514 30.35999870300293 6.720000267028809 26.77499771118164 3.975000381469727 L 24.64499664306641 6.12000036239624 C 27.67499732971191 8.295000076293945 29.72999572753906 11.77500057220459 29.95499610900879 15.75 Z M 27 16.5 C 27 11.89500045776367 24.54000091552734 8.039999961853027 20.25 7.020000457763672 L 20.25 6 C 20.25 4.755000114440918 19.2450008392334 3.75 18 3.75 C 16.7549991607666 3.75 15.75 4.755000114440918 15.75 6 L 15.75 7.019999980926514 C 11.44499969482422 8.039999961853027 9 11.88000011444092 9 16.5 L 9 24 L 6 27 L 6 28.5 L 30 28.5 L 30 27 L 27 24 L 27 16.5 Z M 18 33 C 18.20999908447266 33 18.40500068664551 32.98500061035156 18.60000038146973 32.93999862670898 C 19.57500076293945 32.72999954223633 20.3700008392334 32.06999969482422 20.76000022888184 31.16999816894531 C 20.90999984741211 30.80999755859375 20.98500061035156 30.41999816894531 20.98500061035156 29.99999809265137 L 14.98500061035156 29.99999809265137 C 15.00000095367432 31.64999771118164 16.33500099182129 33 18 33 Z" fill="#f1f3f6" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(9999.0, 9999.0)),
                                  color: const Color(0xff4ad1c7),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x6576d3d3),
                                      offset: Offset(0, 6),
                                      blurRadius: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            gstr3b
                                ? SizedBox(
                                    width: 194.0,
                                    height: 80.0,
                                    child: SingleChildScrollView(
                                        child: Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Neusa Next Std',
                                          fontSize: 15,
                                          color: const Color(0xff515c6f),
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                'Last Date of Filling for January GSTR 3B ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '24/ ' +
                                                DateFormat('MM/yyyy')
                                                    .format(DateTime.now())
                                                    .toString(),
                                            style: TextStyle(
                                              color: const Color(0xffff6969),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ' Submit your return to save penalty. ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.left,
                                    )),
                                  )
                                : Container()
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(),
            lowStockAlert
                ? Container(
                    height: 500,
                    child: StreamBuilder(
                        stream: getUsersTripsStreamSnapshots(context),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return const Text("Loading...");
                          return new ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  snapshot.data.docs[index]['quantity'] == 0
                                      ? NotificationBlock(
                                          snapshot.data.docs[index]
                                              ['productCode'],
                                          w)
                                      : null);
                        }),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
