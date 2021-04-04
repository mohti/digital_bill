import 'dart:io';

import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalbillbook/tables/lowstocktable.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class LowStock extends StatefulWidget {
  final String uid;
  LowStock(this.uid);
  @override
  _LowStockState createState() => _LowStockState();
}

class _LowStockState extends State<LowStock> {
  Future<bool> _requestPermissions() async {
    var permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }

    return permission == PermissionStatus.granted;
  }

  Future<void> fc() async {
    var excel = Excel.createExcel();
    // or
    //var excel = Excel.decodeBytes(bytes);
    var sheet = excel['mySheet'];
    sheet.appendRow([
      'From ' +
          DateFormat('dd/MM/yyyy').format(initialdate).toString() +
          ' to ' +
          DateFormat('dd/MM/yyyy').format(finaldate).toString(),
    ]);

    FirebaseFirestore.instance
        .collection('userData')
        .doc(widget.uid)
        .collection('Product')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final Timestamp timestamp = (doc['date']) as Timestamp;
        final DateTime d = timestamp.toDate();
        if ((d.isBefore(finaldate) && d.isAfter(initialdate)) ||
            d.day == initialdate.day ||
            d.day == finaldate.day &&
                doc['quantity'] <= doc['lowstockreminderat'])
          sheet.appendRow([
            doc['productCode'],
            doc['productName'],
            doc['hsncode'],
            doc['purchaserate'],
            doc['sellingprice']
          ]);
      });
    });

    sheet.appendRow([
      'productCode',
      'productName',
      'hsncode',
      'purchaserate',
      'sellingprice'
    ]);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    print(appDocPath);

    final isPermissionStatusGranted = await _requestPermissions();
    if (isPermissionStatusGranted) {
      excel.encode().then((onValue) {
        File(join("$appDocPath/excel.xlsx"))
          ..createSync(recursive: true)
          ..writeAsBytesSync(onValue);
      });
    } else {
      // handle the scenario when user declines the permissions
    }
    OpenFile.open("$appDocPath/excel.xlsx");
  }

  var initialdate = DateTime.now(), finaldate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Future<Null> selectDate1(BuildContext context) async {
      final DateTime picked1 = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          initialDatePickerMode: DatePickerMode.day,
          firstDate: DateTime(2015),
          lastDate: finaldate);
      if (picked1 != null)
        setState(() {
          initialdate = picked1;
        });
    }

    Future<Null> selectDate2(BuildContext context) async {
      final DateTime picked2 = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          initialDatePickerMode: DatePickerMode.day,
          firstDate: DateTime(2015),
          lastDate: DateTime(2101));
      if (picked2 != null)
        setState(() {
          finaldate = picked2;
        });
    }

    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () => fc(),
        child: SizedBox(
          width: 65.0,
          height: 65.0,
          child: Stack(
            children: <Widget>[
              Pinned.fromSize(
                bounds: Rect.fromLTWH(0.0, 0.0, 65.0, 65.0),
                size: Size(65.0, 65.0),
                pinLeft: true,
                pinRight: true,
                pinTop: true,
                pinBottom: true,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    color: const Color(0xffffffff),
                    border:
                        Border.all(width: 1.0, color: const Color(0xff2f2e41)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x66404040),
                        offset: Offset(6, 6),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                ),
              ),
              Pinned.fromSize(
                bounds: Rect.fromLTWH(20.6, 18.0, 25.7, 21.5),
                size: Size(65.0, 65.0),
                child:
                    // Adobe XD layer: 'Icon awesome-file-e…' (shape)
                    SvgPicture.string(
                  '<svg viewBox="66.6 554.0 25.7 21.5" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(66.65, 554.0)" d="M 17.13576507568359 5.118847370147705 C 17.13576507568359 4.854296684265137 17.02420425415039 4.59814453125 16.82339477539062 4.4091796875 L 12.45466613769531 0.2939453125 C 12.25385665893555 0.10498046875 11.98164844512939 0 11.69605159759521 0 L 11.42384338378906 0 L 11.42384338378906 5.375 L 17.13576507568359 5.375 L 17.13576507568359 5.118847370147705 Z M 25.48052597045898 12.93359375 L 21.2099723815918 8.885546684265137 C 20.75926780700684 8.46142578125 19.98726463317871 8.759570121765137 19.98726463317871 9.360057830810547 L 19.98726463317871 12.09375 L 17.13130378723145 12.09375 L 17.13130378723145 14.78125 L 19.98726463317871 14.78125 L 19.98726463317871 17.51914024353027 C 19.98726463317871 18.11962890625 20.75926780700684 18.41777420043945 21.2099723815918 17.99365234375 L 25.48052597045898 13.94140625 C 25.77504730224609 13.66425800323486 25.77504730224609 13.21074104309082 25.48052597045898 12.93359375 Z M 8.567882537841797 14.109375 L 8.567882537841797 12.765625 C 8.567882537841797 12.39609336853027 8.889178276062012 12.09375 9.281872749328613 12.09375 L 17.13576507568359 12.09375 L 17.13576507568359 6.71875 L 11.06684875488281 6.71875 C 10.47780609130859 6.71875 9.99586296081543 6.265234470367432 9.99586296081543 5.7109375 L 9.99586296081543 0 L 1.070985317230225 0 C 0.4774809777736664 0 0 0.4493164122104645 0 1.0078125 L 0 20.4921875 C 0 21.05068397521973 0.4774809777736664 21.5 1.070985317230225 21.5 L 16.06477928161621 21.5 C 16.65828514099121 21.5 17.13576507568359 21.05068397521973 17.13576507568359 20.4921875 L 17.13576507568359 14.78125 L 9.281872749328613 14.78125 C 8.889178276062012 14.78125 8.567882537841797 14.47890567779541 8.567882537841797 14.109375 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>',
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
              Pinned.fromSize(
                bounds: Rect.fromLTWH(12.0, 45.0, 41.0, 8.0),
                size: Size(65.0, 65.0),
                fixedWidth: true,
                fixedHeight: true,
                child: Text(
                  'Export File',
                  style: TextStyle(
                    fontFamily: 'Bell MT',
                    fontSize: 8,
                    color: const Color(0xff707070),
                    fontWeight: FontWeight.w700,
                    shadows: [
                      Shadow(
                        color: const Color(0x29000000),
                        offset: Offset(3, 3),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Low Stocks',
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Low Stock Summary',
                style: TextStyle(
                  fontFamily: 'Bell MT',
                  fontSize: 18,
                  color: const Color(0xff2f2e41),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Date',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 12,
                    color: const Color(0xff2f2e41),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
                Card(
                  elevation: 4,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 50,
                    child: InkWell(
                      onTap: () => selectDate1(context),
                      child: Text("From " +
                          DateFormat('dd-MM-yyyy').format(initialdate)),
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 50,
                    child: InkWell(
                      onTap: () => selectDate2(context),
                      child: Text(
                          "to " + DateFormat('dd-MM-yyyy').format(finaldate)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            /*         Container(
              decoration: BoxDecoration(
                  color: const Color(0xfff3F3D56),
                  borderRadius: BorderRadius.circular(2)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 60.0, right: 60, top: 10, bottom: 10),
                child: Text(
                  'Product List',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 16,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),*/
            SizedBox(
              height: 20,
            ),
            LowStockTable(widget.uid, initialdate, finaldate)
          ],
        ),
      ),
    );
  }
}
