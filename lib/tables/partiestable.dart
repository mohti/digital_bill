import 'package:digitalbillbook/parties/updateParties.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

double fontSizeForMainColumn = 6;
Widget buildtable(BuildContext context, DocumentSnapshot product, double w,
    DateTime id, DateTime fd) {
  return Container(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left:0.0),
          child: Container(
            width: w,
            height: 16,
            decoration: BoxDecoration(
                color: Colors.white, border: Border.all(width: 0.1)),
            child: Padding(
              padding: const EdgeInsets.only(left:2.0),
              child: Row(
                children: [
                  Container(
                    alignment:Alignment.centerLeft,
                    width: w * 0.15,
                    child: Text(
                      product['partyName'],
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: fontSizeForMainColumn,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: w * 0.18,
                    child: Text(
                      product['gstn'],
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: fontSizeForMainColumn,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment:Alignment.centerLeft,
                    width: w * 0.15,
                    child: Text(
                      product['address'],
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: fontSizeForMainColumn,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment:Alignment.centerLeft,
                    width: w * 0.1,
                    child: Text(
                      product['city'] == null ? '' : product['city'],
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: fontSizeForMainColumn,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment:Alignment.centerLeft,
                    width: w * 0.1,
                    child: Text(
                      product['state'] == null ? '' : product['state'],
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: fontSizeForMainColumn,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment:Alignment.centerLeft,
                    width: w * 0.1,
                    child: Text(
                      product['country'] == null ? '' : product['country'],
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: fontSizeForMainColumn,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment:Alignment.centerLeft,
                    width: w * 0.1,
                    child: Text(
                      product['pincode'] == null ? '' : product['pincode'],
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: fontSizeForMainColumn,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: w * 0.05,
                    child: InkWell(
                           onTap: () => {
                             
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateParty(product['partyName']),
                                )),
                             print('Tapped')
                           },
                          child: Text(
                         'Edit',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: fontSizeForMainColumn,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
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
    double fontSizeForMainColumn = 6;

    return Container(
      child: Column(
        children: [
          Container(
            width: w,
            height: 16,
            decoration: BoxDecoration(color: const Color(0xff2F2E41)),
            child: Padding(
              padding: const EdgeInsets.only(left:3.0),
              child: Row(
                children: [
                  Container(
                    alignment:Alignment.centerLeft,
                    width: w * 0.15,
                    child: Text(
                      'Company Name',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: fontSizeForMainColumn,
                        color: const Color(0xfff1f3f6),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment:Alignment.centerLeft,
                    width: w * 0.18,
                    child: Text(
                      'GST Number',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: fontSizeForMainColumn,
                        color: const Color(0xfff1f3f6),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment:Alignment.centerLeft,
                    width: w * 0.15,
                    child: Text(
                      'Address',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: fontSizeForMainColumn,
                        color: const Color(0xfff1f3f6),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment:Alignment.centerLeft,
                    width: w * 0.1,
                    child: Text(
                      'City',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: fontSizeForMainColumn,
                        color: const Color(0xfff1f3f6),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment:Alignment.centerLeft,
                    width: w * 0.1,
                    child: Text(
                      'State',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: fontSizeForMainColumn,
                        color: const Color(0xfff1f3f6),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment:Alignment.centerLeft,
                    width: w * 0.1,
                    child: Text(
                      'Country',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: fontSizeForMainColumn,
                        color: const Color(0xfff1f3f6),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment:Alignment.centerLeft,
                    width: w * 0.1,
                    child: Text(
                      'PinCode',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: fontSizeForMainColumn,
                        color: const Color(0xfff1f3f6),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                 


                ],
              ),
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
