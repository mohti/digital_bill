import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:digitalbillbook/controller/reports/stockSummaryController.dart';
import 'package:digitalbillbook/customwidgets/CustomInputDecorationWidget.dart';
import 'package:digitalbillbook/tables/stocksummarytable.dart';
import 'package:get/get.dart';
import 'package:gst_verification/gst_verification.dart';
import 'package:path/path.dart';
import 'package:adobe_xd/adobe_xd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

class StockSummaryController extends GetxController {
  // var initialdate = DateTime.now(), finaldate = DateTime.now();
  FirebaseAuth auth = FirebaseAuth.instance;

  String uid = '';

  @override
  void onInit() {
    super.onInit();
    uid = auth.currentUser.uid.toString();
    print(uid);
  }

  // Future<bool> _requestPermissions() async {
  // var permission = await PermissionHandler()
  //     .checkPermissionStatus(PermissionGroup.storage);
  // if (permission != PermissionStatus.granted) {
  //   await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  //   permission = await PermissionHandler()
  //       .checkPermissionStatus(PermissionGroup.storage);
  // }
  //   return permission == PermissionStatus.granted;
  // }
  bool productCode = true;
  bool productName = true;
  bool quantity = true;
  bool taxRate = true;
  bool ammount = true;
  bool date = true;

  // String textfieldValues;
  TextEditingController askValues = TextEditingController();
  String selectbyfilter;
  String settingUitextvalues = 'Product code';
  Widget widgetTable;

  String selctbyFilter;
  double fontSizeForMainColumn = 6;
  final listofSelect = [
    'Product Code',
    'Product name',
    'Quanitity',
    'Tax Rate',
    'Date',
    'Ammount'
  ];
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

  Future<void> fc(
      DateTime initialdate, DateTime finaldate, String textfieldValues) async {
    var excel = Excel.createExcel();
    var sheet = excel['stocksummary'];
    // print(textfieldValues);
    sheet.appendRow([
      'From ' +
          DateFormat('dd/MM/yyyy').format(initialdate).toString() +
          ' to ' +
          DateFormat('dd/MM/yyyy').format(finaldate).toString(),
    ]);


    List<String> dataList = [
      'Pro Code',
      'Pro Name',
      'Date',
      'Quantity',
      'Applied Tax',
      'hsncode',
      'purchaserate',
      'sellingprice',
      'Total Amount'
    ];
    if (date == false) {
      dataList.remove('Date');
    }
    if (productCode == false) {
      dataList.remove('Pro Code');
    }
    if (productName == false) {
      dataList.remove('Pro Name');
    }
    if (quantity == false) {
      dataList.remove('Quantity');
    }

    if (taxRate == false) {
      dataList.remove('Applied Tax');
    }

    if (ammount == false) {
      dataList.remove('Total Amount');
    }
    sheet.appendRow(dataList);

    FirebaseFirestore.instance
        .collection('userData')
        .doc(auth.currentUser.uid)
        .collection('Product')
        .where('date',
            isGreaterThanOrEqualTo: initialdate, isLessThanOrEqualTo: finaldate)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final Timestamp timestamp = (doc['date']) as Timestamp;
        final DateTime d = timestamp.toDate();
        print(
          doc['hsncode'],
        );
        print(textfieldValues.toString() + 'textfieldValues');
        // print(askValues);
        if (textfieldValues == null || textfieldValues == '') {
        List<String> resultList = [
          doc['productCode'],
          doc['productName'],
          DateFormat('dd/MM/yyyy').format(d),
          doc['quantity'].toString(),
          doc['cgst'].toString(),
          doc['hsncode'].toString(),
          doc['purchaserate'].toString(),
          doc['sellingprice'].toString(),
          doc['totalAmount'].toString()
        ];
        if (date == false) {
          resultList.remove(DateFormat('dd/MM/yyyy').format(d));
        }
        if (productCode == false) {
          resultList.remove(
            doc['productCode'],
          );
        }
        if (productName == false) {
          resultList.remove(doc['productName']);
        }
        if (quantity == false) {
          resultList.remove(doc['quantity'].toString());
        }

        if (taxRate == false) {
          resultList.remove(doc['cgst'].toString());
        }

        if (ammount == false) {
          resultList.remove(doc['totalAmount'].toString());
        }

        sheet.appendRow(resultList);
        print(resultList.toString() + "=============");
        }
         else {
          if (textfieldValues == doc['productCode'].toString()) {
            List<String> resultList = [
              doc['productCode'],
              doc['productName'],
              DateFormat('dd/MM/yyyy').format(d),
              doc['quantity'].toString(),
              doc['cgst'].toString(),
              doc['hsncode'].toString(),
              doc['purchaserate'].toString(),
              doc['sellingprice'].toString(),
              doc['totalAmount'].toString()
            ];
            if (date == false) {
              resultList.remove(DateFormat('dd/MM/yyyy').format(d));
            }
            if (productCode == false) {
              resultList.remove(
                doc['productCode'],
              );
            }
            if (productName == false) {
              resultList.remove(doc['productName']);
            }
            if (quantity == false) {
              resultList.remove(doc['quantity'].toString());
            }

            if (taxRate == false) {
              resultList.remove(doc['cgst'].toString());
            }

            if (ammount == false) {
              resultList.remove(doc['totalAmount'].toString());
            }
            sheet.appendRow(resultList);
          }
        }
      });
    });
    // if (textfieldValues == null || textfieldValues == '') {
    // } else {
    //   sheet.appendRow([
    //     'Filters',
    //     askValues,
    //     '=',
    //     textfieldValues,
    //   ]);
    // }

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path + sheet.toString();
    print(appDocPath);

    final isPermissionStatusGranted = await _requestPermissions();
    if (isPermissionStatusGranted) {
      excel.encode().then((onValue) {
        File(join("$appDocPath/excel.xlsx"))
          ..createSync(recursive: true)
          ..writeAsBytesSync(onValue);
      });
    } else {
    }
    OpenFile.open("$appDocPath/excel.xlsx");
  }
}
