import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget buildtable(BuildContext context, DocumentSnapshot product, double w,
    DateTime id, DateTime fd) {
  return Container(
    child: Column(
      children: [
        Container(
          width: w,
          height: 30,
          decoration: BoxDecoration(
              color: Colors.white, border: Border.all(width: 0.1)),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: w * 0.2,
                child: Text(
                  product['partyName'],
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: w * 0.1,
                child: Text(
                  product['gstn'],
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: w * 0.2,
                child: Text(
                  product['address'],
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: w * 0.1,
                child: Text(
                  product['city'] == null ? '' : product['city'],
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: w * 0.1,
                child: Text(
                  product['state'] == null ? '' : product['state'],
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: w * 0.1,
                child: Text(
                  product['country'] == null ? '' : product['country'],
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: w * 0.1,
                child: Text(
                  product['pincode'] == null ? '' : product['pincode'],
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class PartiesTable extends StatelessWidget {
  final String uid;
  final DateTime id, fd;
  PartiesTable(this.uid, this.id, this.fd);

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
        BuildContext context) async* {
      yield* FirebaseFirestore.instance
          .collection('userData')
          .doc(uid)
          .collection('Party')
          .snapshots();
    }

    final w = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          Container(
            width: w,
            height: 30,
            decoration: BoxDecoration(color: const Color(0xff2F2E41)),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: w * 0.2,
                  child: Text(
                    'Name/Company Name',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 10,
                      color: const Color(0xfff1f3f6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: w * 0.1,
                  child: Text(
                    'GST Number',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 10,
                      color: const Color(0xfff1f3f6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: w * 0.2,
                  child: Text(
                    'Address',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 10,
                      color: const Color(0xfff1f3f6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: w * 0.1,
                  child: Text(
                    'City',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 10,
                      color: const Color(0xfff1f3f6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: w * 0.1,
                  child: Text(
                    'State',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 10,
                      color: const Color(0xfff1f3f6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: w * 0.1,
                  child: Text(
                    'Country',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 10,
                      color: const Color(0xfff1f3f6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: w * 0.1,
                  child: Text(
                    'PinCode',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 10,
                      color: const Color(0xfff1f3f6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 600,
            child: StreamBuilder(
                stream: getUsersTripsStreamSnapshots(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text("Loading...");
                  return new ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildtable(
                              context, snapshot.data.docs[index], w, id, fd));
                }),
          ),
        ],
      ),
    );
  }
}
