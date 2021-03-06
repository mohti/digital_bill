import 'package:digitalbillbook/controller/reports/stockSummaryController.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

double fontSizeForMainColumn = 6;
Widget buildtable(BuildContext context, DocumentSnapshot product, double w,
    DateTime id, DateTime fd, String textfieldValues, String askValues) {
  final Timestamp timestamp = (product['date']) as Timestamp;
  final DateTime d = timestamp.toDate();
  // print(d.toString() + "mohit firebase date");
  // print(id.toString() + "mohit initial date");
  // print(fd.toString() + "mohit final date");
  print( product['productCode'].toString());
  if (textfieldValues == null || textfieldValues == '') {
   return  GetBuilder<StockSummaryController>(
        id: 'dropdown',
        builder: (gxValues) {
          return Container(
            child: Column(
              children: [
                Container(
                  width: w,
                  height: 16,
                  decoration: BoxDecoration(
                      color: Colors.white, border: Border.all(width: 0.1)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Row(
                      children: [
                        gxValues.productCode == true
                            ? Container(
                                alignment: Alignment.centerLeft,
                                width: w * 0.13,
                                child: Text(
                                  product['productCode'],
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: fontSizeForMainColumn,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            : Container(
                                width: w * 0.13,
                              ),
                        gxValues.productName == true
                            ? Container(
                                alignment: Alignment.centerLeft,
                                width: w * 0.13,
                                child: Text(
                                  product['productName'],
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: fontSizeForMainColumn,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            : Container(
                                width: w * 0.13,
                              ),
                        gxValues.date
                            ? Container(
                                alignment: Alignment.centerLeft,
                                width: w * 0.1,
                                child: Text(
                                  DateFormat('dd/MM/yyyy').format(d),
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: fontSizeForMainColumn,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            : Container(
                                width: w * 0.1,
                              ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: w * 0.1,
                          child: Text(
                            product['hsncode'],
                            style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: fontSizeForMainColumn,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        gxValues.quantity == true
                            ? Container(
                                alignment: Alignment.centerLeft,
                                width: w * 0.1,
                                child: Text(
                                  product['quantity'].toString(),
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: fontSizeForMainColumn,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            : Container(
                                width: w * 0.1,
                              ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: w * 0.1,
                          child: Text(
                            product['igst'],
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
                          width: w * 0.1,
                          child: Text(
                            product['purchaserate'] == null
                                ? ''
                                : product['purchaserate'],
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
                          width: w * 0.1,
                          child: Text(
                            product['sellingprice'] == null
                                ? ''
                                : product['sellingprice'],
                            style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: fontSizeForMainColumn,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        gxValues.ammount == true
                            ? Container(
                                alignment: Alignment.centerLeft,
                                width: w * 0.1,
                                child: Text(
                                  product['totalAmount'].toString(),
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: fontSizeForMainColumn,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            : Container(
                                width: w * 0.1,
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
    // : null;"
  } else {
    return ((textfieldValues ==  product['productCode']))
        ?  GetBuilder<StockSummaryController>(
        id: 'dropdown',
        builder: (gxValues) {
          return Container(
            child: Column(
              children: [
                Container(
                  width: w,
                  height: 16,
                  decoration: BoxDecoration(
                      color: Colors.white, border: Border.all(width: 0.1)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Row(
                      children: [
                        gxValues.productCode == true
                            ? Container(
                                alignment: Alignment.centerLeft,
                                width: w * 0.13,
                                child: Text(
                                  product['productCode'],
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: fontSizeForMainColumn,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            : Container(
                                width: w * 0.13,
                              ),
                        gxValues.productName == true
                            ? Container(
                                alignment: Alignment.centerLeft,
                                width: w * 0.13,
                                child: Text(
                                  product['productName'],
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: fontSizeForMainColumn,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            : Container(
                                width: w * 0.13,
                              ),
                        gxValues.date
                            ? Container(
                                alignment: Alignment.centerLeft,
                                width: w * 0.1,
                                child: Text(
                                  DateFormat('dd/MM/yyyy').format(d),
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: fontSizeForMainColumn,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            : Container(
                                width: w * 0.1,
                              ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: w * 0.1,
                          child: Text(
                            product['hsncode'],
                            style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: fontSizeForMainColumn,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        gxValues.quantity == true
                            ? Container(
                                alignment: Alignment.centerLeft,
                                width: w * 0.1,
                                child: Text(
                                  product['quantity'].toString(),
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: fontSizeForMainColumn,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            : Container(
                                width: w * 0.1,
                              ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: w * 0.1,
                          child: Text(
                            product['cgst'],
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
                          width: w * 0.1,
                          child: Text(
                            product['purchaserate'] == null
                                ? ''
                                : product['purchaserate'],
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
                          width: w * 0.1,
                          child: Text(
                            product['sellingprice'] == null
                                ? ''
                                : product['sellingprice'],
                            style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: fontSizeForMainColumn,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        gxValues.ammount == true
                            ? Container(
                                alignment: Alignment.centerLeft,
                                width: w * 0.1,
                                child: Text(
                                  product['totalAmount'].toString(),
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: fontSizeForMainColumn,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            : Container(
                                width: w * 0.1,
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        })
   
        : Container();
  }
}

class StockSummaryTable extends StatelessWidget {
  final String uid;
  final DateTime id, fd;
  String textfiledValues, askvalues;

  StockSummaryTable(
      this.uid, this.id, this.fd, this.textfiledValues, this.askvalues);

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
        BuildContext context) async* {
      yield* FirebaseFirestore.instance
          .collection('userData')
          .doc(uid)
          .collection('Product')
          .where('date', isGreaterThanOrEqualTo: id, isLessThanOrEqualTo: fd)
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
    return GetBuilder<StockSummaryController>(
        id: 'dropdown',
        builder: (gxValues) {
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
                          padding: const EdgeInsets.only(left: 2),
                          child: gxValues.productCode == true
                              ? Container(
                                  alignment: Alignment.centerLeft,
                                  width: w * 0.13,
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
                                )
                              : Container(width: w * 0.13)),
                      gxValues.productName == true
                          ? Container(
                              alignment: Alignment.centerLeft,
                              width: w * 0.13,
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
                            )
                          : Container(
                              width: w * 0.13,
                            ),
                      gxValues.date == true
                          ? Container(
                              alignment: Alignment.centerLeft,
                              width: w * 0.1,
                              child: Text(
                                'Date',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 6,
                                  color: const Color(0xfff1f3f6),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          : Container(
                              width: w * 0.1,
                            ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: w * 0.1,
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
                      gxValues.quantity == true
                          ? Container(
                              alignment: Alignment.centerLeft,
                              width: w * 0.1,
                              child: Text(
                                'Quantity',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 6,
                                  color: const Color(0xfff1f3f6),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          : Container(
                              width: w * 0.1,
                            ),
                      gxValues.taxRate == true
                          ? Container(
                              alignment: Alignment.centerLeft,
                              width: w * 0.1,
                              child: Text(
                                'Applied Tax',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 6,
                                  color: const Color(0xfff1f3f6),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          : Container(
                              width: w * 0.1,
                            ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: w * 0.1,
                        child: Text(
                          'Purchase Rate ',
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
                          'Selling Rate ',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 6,
                            color: const Color(0xfff1f3f6),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      gxValues.ammount == true
                          ? Container(
                              alignment: Alignment.centerLeft,
                              width: w * 0.1,
                              child: Text(
                                'Total Amount',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 6,
                                  color: const Color(0xfff1f3f6),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          : Container(
                              width: w * 0.1,
                            )
                    ],
                  ),
                ),
                Container(
                  height: 600,
                  child: StreamBuilder(
                      stream: getUsersTripsStreamSnapshots(context),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        //Text("Loading...");
                        return new ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) =>
                                buildtable(context, snapshot.data.docs[index],
                                    w, id, fd, textfiledValues, askvalues));
                      }),
                ),
              ],
            ),
          );
        });
  }
}
