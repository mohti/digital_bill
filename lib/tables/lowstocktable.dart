import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget buildtable(BuildContext context, DocumentSnapshot product, double w,
    DateTime id, DateTime fd) {
  final Timestamp timestamp = (product['date']) as Timestamp;
  final DateTime d = timestamp.toDate();
  
  return
      // (
      //   (d.isBefore(fd) && d.isAfter(id)) ||
      //             d.day == id.day ||
      //             d.day == fd.day) &&
       (int.parse(product['quantity'].toString()) < 
        int.parse( product['lowstockreminderat'].toString()))
      ?
      Container(
        child: Column(
          children: [
            Container(
              width: w,
              height: 16,
              decoration: BoxDecoration(
                  color: Colors.white, border: Border.all(width: 0.1)),
              child: Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: w * 0.2,
                      child: Text(
                        product['productCode'],
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 6,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: w * 0.2,
                      child: Text(
                        product['productName'],
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 6,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: w * 0.2,
                      child: Text(
                        product['hsncode'],
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 6,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: w * 0.2,
                      child: Text(
                        product['quantity'].toString(),
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 6,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: w * 0.1,
                      child: 
                        product['quantity'] == null || product['quantity'] == 0||product['quantity'] == 0
                            ? 
                            Text('Out of Stock',
                             style: TextStyle(color: Colors.red,
                            fontFamily: 'Arial',
                            fontSize: 6,
                            fontWeight: FontWeight.w700,
                            ),
                           textAlign: TextAlign.left,
                      
                            )                   
                                 :
                                 Text('Available',
                             style: TextStyle(color: Colors.green,
                            fontFamily: 'Arial',
                            fontSize: 6,
                            fontWeight: FontWeight.w700,
                            ),
                           textAlign: TextAlign.left,
                      
                            )
                       ,
                      
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
  : Container();
  // Center(child: Text('No Data Available'
  // ,
  // style: TextStyle(
  //   fontSize: 48,
  // ),
  // ),);
}

class LowStockTable extends StatelessWidget {
  final String uid;
  final DateTime id, fd;
  LowStockTable(this.uid, this.id, this.fd);

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
        BuildContext context) async* {
      yield* FirebaseFirestore.instance
          .collection('userData')
          .doc(uid)
          .collection('Product')
          .where('date', isGreaterThanOrEqualTo: id, isLessThanOrEqualTo: fd)
          //.where('quantity', isGreaterThan: 'lowstockreminderat')
          .snapshots();
    }

    final w = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          Container(
            width: w,
            height: 16,
            decoration: BoxDecoration(color: const Color(0xff2F2E41)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: w * 0.2,
                    child: Text(
                      'Product Code ',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 6,
                        color: const Color(0xfff1f3f6),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: w * 0.2,
                  child: Text(
                    'Product Name ',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 6,
                      color: const Color(0xfff1f3f6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: w * 0.2,
                  child: Text(
                    'HSN Code ',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 6,
                      color: const Color(0xfff1f3f6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: w * 0.2,
                  child: Text(
                    'Quantity ',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 6,
                      color: const Color(0xfff1f3f6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: w * 0.1,
                  child: Text(
                    'Status ',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 6,
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
          )
        ],
      ),
    );
  }
}
