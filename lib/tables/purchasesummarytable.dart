import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Widget buildtable(BuildContext context, DocumentSnapshot product, double w,
    DateTime id, DateTime fd, String textfieldValues, String askValues) {
  final Timestamp timestamp = (product['sdate']) as Timestamp;
  final DateTime d = timestamp.toDate();
  print(id.day.toString() + "mohit purches");

  print(d.day.toString() + "mohit d purches");

  if (textfieldValues == null || textfieldValues == '') {
    return ((d.isBefore(fd) && d.isAfter(id)) ||
            d.day == id.day ||
            d.day == fd.day
        // && textfieldValues == product[askValues]
        )
        ? Container(
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
                        width: w * 0.1,
                        child: Text(
                          product['invoiceno'],
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
                        width: w * 0.05,
                        child: Text(
                          DateFormat('dd/MM/yyyy').format(d),
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
                          product['listOfProducts'][0]['productCode'],
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
                          product['listOfProducts'][0]['productName'],
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
                        width: w * 0.05,
                        child: Text(
                          product['sgstn'] == null ? '' : product['sgstn'],
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
                          product['sname'] == null ? '' : product['sgstn'],
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
                          product['listOfProducts'][0]['hsncode'],
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
                          product['sgstn'] == null ? '' : product['sgstn'],
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
                        width: w * 0.05,
                        child: Text(
                          product['listOfProducts'][0]['taxrate'],
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
                          product['listOfProducts'][0]['totalamount'],
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
                          product['listOfProducts'][0]['taxamount'],
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
          )
        : null;
  } else {
    return ((d.isBefore(fd) && d.isAfter(id))
            //|| (textfieldValues == product[askValues])
            &&
            textfieldValues == product['listOfProducts'][0][askValues])
        ? Container(
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
                        width: w * 0.1,
                        child: Text(
                          product['invoiceno'],
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
                        width: w * 0.05,
                        child: Text(
                          DateFormat('dd/MM/yyyy').format(d),
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
                          product['listOfProducts'][0]['productCode'],
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
                          product['listOfProducts'][0]['productName'],
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
                        width: w * 0.05,
                        child: Text(
                          product['sgstn'] == null ? '' : product['sgstn'],
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
                          product['sname'] == null ? '' : product['sgstn'],
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
                          product['listOfProducts'][0]['hsncode'],
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
                          product['sgstn'] == null ? '' : product['sgstn'],
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
                        width: w * 0.05,
                        child: Text(
                          product['listOfProducts'][0]['taxrate'],
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
                          product['listOfProducts'][0]['totalamount'],
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
                          product['listOfProducts'][0]['taxamount'],
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
          )
        : null;
  }
}

class PurchaseSummarytable extends StatelessWidget {
  final String uid;
  final DateTime id, fd;
  String textfiledValues, askvalues;

  PurchaseSummarytable(
      this.uid, this.id, this.fd, this.textfiledValues, this.askvalues);

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
        BuildContext context) async* {
      yield* FirebaseFirestore.instance
          .collection('userData')
          .doc(uid)
          .collection('PurchaseInvoice')
          .snapshots();
    }

    final w = MediaQuery.of(context).size.width;
    var excel = Excel.createExcel();
    // or
    //var excel = Excel.decodeBytes(bytes);

    var sheet = excel['mySheet'];
    sheet.appendRow([
      'From ' +
          DateFormat('dd/MM/yyyy').format(id).toString() +
          'to' +
          DateFormat('dd/MM/yyyy').format(fd).toString()
    ]);

    return Container(
      child: Column(
        children: [
          Container(
            width: w,
            height: 30,
            decoration: BoxDecoration(color: const Color(0xff2F2E41)),
            child: Row(
              /*  'Receipt No.',
        'Date',
        'Pro Code',
        'Pro Name',
        'GSTN',
        'Buyer Name',
        'HSN',
        'Quantity',
        'TAX',
        'Invoice Value',
        'TAX Value'*/
              children: [
                Container(
                  alignment: Alignment.center,
                  width: w * 0.1,
                  child: Text(
                    'Receipt No.',
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
                  width: w * 0.05,
                  child: Text(
                    'Date',
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
                    'Pro Code',
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
                    'Pro Name',
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
                    'GSTN',
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
                    'Buyer Name',
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
                    'HSN',
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
                    'Quantity',
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
                  width: w * 0.05,
                  child: Text(
                    'TAX',
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
                    'Invoice Value',
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
                    'TAX Value',
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
                          buildtable(context, snapshot.data.docs[index], w, id,
                              fd, textfiledValues, askvalues));
                }),
          ),
        ],
      ),
    );
  }
}
