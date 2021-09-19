import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:get/state_manager.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class SalesSummaryController extends GetxController {
  // var initialdate = DateTime.now(), finaldate = DateTime.now();
  FirebaseAuth auth = FirebaseAuth.instance;

  String uid = '';

  @override
  void onInit() {
    super.onInit();
    uid = auth.currentUser.uid.toString();
    print(uid);
  }

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

  Future<void> fc(DateTime initialdate, DateTime finaldate) async {
    print("fc called");
    print(initialdate.toString());
    var excel = Excel.createExcel();
    var sheet = excel['saleSummary'];
    // sheet.appendRow([
    //   'From ' +
    //       DateFormat('dd/MM/yyyy').format(initialdate).toString() +
    //       ' to ' +
    //       DateFormat('dd/MM/yyyy').format(finaldate).toString(),
    // ]);
    // if (textfieldValues == null || textfieldValues == '') {
    // } else {
    //   sheet.appendRow(['Filter:-   ' + askValues + ' = ' + textfieldValues]);
    // }

    List<String> dataList = [
      'Receipt No.',
      'Date',
      'Pro Code',
      'Pro Name',
      'GSTN',
      'Buyer Name',
      'HSN',
      'Quantity',
      'Tax Rate',
      'Total Amount',
      'TAX',
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
      dataList.remove('Tax Rate');
    }

    if (ammount == false) {
      dataList.remove('Total Amount');
    }
    sheet.appendRow(dataList);
    // sheet.insertRowIterables(dataList, -1);
    // sheet.insertRowIterables(dataList, 1);
    FirebaseFirestore.instance
        .collection('userData')
        .doc(auth.currentUser.uid)
        .collection('Invoice')
        .where('sdate',
            isGreaterThanOrEqualTo: initialdate, isLessThanOrEqualTo: finaldate)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((product) {
        final Timestamp timestamp = (product['sdate']) as Timestamp;
        final DateTime d = timestamp.toDate();

        List<String> resultList = [
          product['invoiceno'],
          DateFormat('dd/MM/yyyy').format(d),
          product['listOfProducts'][0]['productCode'],
          product['listOfProducts'][0]['productName'],
          product['sname'] == null ? '' : product['sgstn'],
          product['listOfProducts'][0]['hsncode'],
          product['bname'],
          product['listOfProducts'][0]['quantity'],
          product['listOfProducts'][0]['taxrate'],
          product['listOfProducts'][0]['totalamount'],
          product['listOfProducts'][0]['taxamount'],
        ];

        if (date == false) {
          resultList.remove(DateFormat('dd/MM/yyyy').format(d));
        }
        if (productCode == false) {
          resultList.remove(product['listOfProducts'][0]['productCode']);
        }
        if (productName == false) {
          resultList.remove(product['listOfProducts'][0]['productName']);
        }
        if (quantity == false) {
          resultList.remove(product['listOfProducts'][0]['quantity']);
        }

        if (taxRate == false) {
          resultList.remove(product['listOfProducts'][0]['taxrate']);
        }

        if (ammount == false) {
          resultList.remove(product['listOfProducts'][0]['totalamount']);
        }
        int i = 2;

        i = i + 1;
        // sheet.insertRow(0);
        sheet.appendRow(resultList);
      });
    });

    // sheet.appendRow();

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    //+sheet.toString();
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

  String textfieldValues;
  String askValues = 'productCode';
  String selectbyfilter;
  String settingUitextvalues = 'Product code';
  Widget widgetTable;
  bool selectedItem;
  String selctbyFilter;
  double fontSizeForMainColumn = 6;
  bool productCode = true;
  bool productName = true;
  bool quantity = true;
  bool taxRate = true;
  bool ammount = true;
  bool date = true;

  // final DropdownMenuItem listofSelect = [

  //    Row(
  //               children: <Widget>[
  //                 Checkbox(
  //                   onChanged: (bool value) {

  //                   }, value:  ,
  //                 ),
  //                 Text('First'),
  //               ],
  //             ),
  //    Row(
  //               children: <Widget>[
  //                 Checkbox(
  //                  ),
  //                 Text('First'),
  //               ],
  //             ),
  //    Row(
  //               children: <Widget>[
  //                 Checkbox(
  //                  ),
  //                 Text('First'),
  //               ],
  //             ),

  // ];

  // Future<Null> selectDate1(BuildContext context) async {
  //   final DateTime picked1 = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       initialDatePickerMode: DatePickerMode.day,
  //       firstDate: DateTime(2015),
  //       lastDate: finaldate);
  //   if (picked1 != null) initialdate = picked1;
  //   update();
  // }

  // Future<Null> selectDate2(BuildContext context) async {
  //   final DateTime picked2 = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       initialDatePickerMode: DatePickerMode.day,
  //       firstDate: DateTime(2015),
  //       lastDate: DateTime(2101));
  //   if (picked2 != null) finaldate = picked2;
  //   update();
  // }
}
