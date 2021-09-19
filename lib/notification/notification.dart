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
        child: Padding(
          padding: const EdgeInsets.only(left :8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                    width: MediaQuery.of(context).size.width-170,
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
     final double screenWidth = MediaQuery.of(context).size.width;

    double screenHeight = MediaQuery.of(context).size.height; //CustomAppbar(),

    Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
        BuildContext context) async* {
      yield* FirebaseFirestore.instance
          .collection('userData')
          .doc(widget.uid)
          .collection('Product')
          .snapshots();
    }

    final double w = MediaQuery.of(context).size.width;

    var purpleForapp = Color(0xfff2f2f2);
        return Scaffold(
          appBar: AppBar(
              leading: IconButton(icon:Icon(Icons.arrow_back_ios),
              onPressed: ()=> Navigator.of(context).pop(),),
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
                gstr1
                    ?
                    Container(
                  width: w * 1,
                  height: gstr1 ? 100 : 0,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(left:10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                     Row(
                                children: [
                                  
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: 
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: 
                                        
                                       Image.asset(
                                      'assets/images/notifications.png',
                                      color: Colors.white),
                                      ),
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(9999.0, 9999.0)),
                                        color:  Color(0x6576d3d3),
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
                                      ? 
                                     
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width-130,
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
                                    ):
                                  
                                   Container()
                            ],
                          )
                ],
              ),
                  ),
            ) 
                : Container(),
            gstr3b
                ? Container(
                    width: w * 1,
                    height: 100,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only (left:10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:   Image.asset(
                                      'assets/images/notifications.png',
                                       color: Colors.white
                                      
                                      ),
                                  ),
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(9999.0, 9999.0)),
                                    color:   const Color(0x6576d3d3),
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
                                  ? SizedBox(   width: MediaQuery.of(context).size.width-130,
                                     
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
                    ),
                  )
                : Container(),
            // lowStockAlert
            //     ?
                 Container(
                    height: 500,
                    child: StreamBuilder(
                        stream: getUsersTripsStreamSnapshots(context),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return const Text("Loading...");
                          return new ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  snapshot.data.docs[index]['quantity'] ==0
                                      ? NotificationBlock(
                                          snapshot.data.docs[index]
                                              ['productCode'],
                                          w)
                                      : null);
                        }),
                  )
                // : Container()
          ],
        ),
      ),
    );
  }
}
