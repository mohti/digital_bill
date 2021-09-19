import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class PurchaseSummaryController extends GetxController {
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

  String textfieldValues;
  // String askValues = 'productCode';
  String selectbyfilter;
  // String settingUitextvalues = 'Product code';
  Widget widgetTable;

  String selctbyFilter;
  double fontSizeForMainColumn = 6;
  bool productCode = true;
  bool productName = true;
  bool quantity = true;
  bool taxRate = true;
  bool ammount = true;
  bool date = true;
  final listofSelect = [
    'Product Code',
    'Product name',
    'Quanitity',
    'Tax Rate',
    'Date',
    'Ammount'
  ];

  Future<void> fc(DateTime initialdate, DateTime finaldate) async {
    var excel = Excel.createExcel();
    // or
    //var excel = Excel.decodeBytes(bytes);
    var sheet = excel['purchaseSummary'];
    sheet.appendRow([
      'From ' +
          DateFormat('dd/MM/yyyy').format(initialdate).toString() +
          ' to ' +
          DateFormat('dd/MM/yyyy').format(finaldate).toString(),
    ]);
    if (textfieldValues == null || textfieldValues == '') {
    } else {
      // sheet.appendRow(['Filter:-   ' + askValues + ' = ' + textfieldValues]);
    }

    await FirebaseFirestore.instance
        .collection('userData')
        .doc(auth.currentUser.uid)
        .collection('PurchaseInvoice')
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
          product['sgstn'] == null ? '' : product['sgstn'],
          product['sname'] == null ? '' : product['sname'],
          product['listOfProducts'][0]['hsncode'],
          product['listOfProducts'][0]['quantity'],
          product['listOfProducts'][0]['taxrate'],
          product['listOfProducts'][0]['totalamount'],
          product['listOfProducts'][0]['taxamount']
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
        sheet.insertRow(1);
        sheet.appendRow(resultList);
        
      });
    });

    List<String> dataList = [
      'Receipt No.',
      'Date',
      'Pro Code',
      'Pro Name',
      'GSTN',
      'Buyer Name',
      'HSN',
      'Quantity',
      'Tax',
      'Invoice Value',
      'TAX Value'
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
      dataList.remove('Tax');
    }

    if (ammount == false) {
      dataList.remove('Invoice Value');
    }

    sheet.insertRowIterables(dataList, 1);

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
      // handle the scenario when user declines the permissions
    }
    OpenFile.open("$appDocPath/excel.xlsx");
  }

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
