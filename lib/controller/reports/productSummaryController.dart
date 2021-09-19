import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ProductListController extends GetxController{
   var initialdate = DateTime.now(), finaldate = DateTime.now();
  FirebaseAuth auth = FirebaseAuth.instance;

 String  uid = '';

 @override
  void onInit() {
    super.onInit();
    uid = auth.currentUser.uid.toString();
    print(uid);
   }

    //     Future<bool> _requestPermissions() async {
    //     var permission = await PermissionHandler()
    //    .checkPermissionStatus(PermissionGroup.storage);
    //     if (permission != PermissionStatus.granted) {
    //   await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    //   permission = await PermissionHandler()
    //  .checkPermissionStatus(PermissionGroup.storage);
    //   }
    //   return permission == PermissionStatus.granted;
    // }

    String textfieldValues;
    String askValues = 'productCode';
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

    Future<Null> selectDate1(BuildContext context) async {
      final DateTime picked1 = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          initialDatePickerMode: DatePickerMode.day,
          firstDate: DateTime(2015),
          lastDate: finaldate);
      if (picked1 != null) initialdate = picked1;
      update();
    }

    Future<Null> selectDate2(BuildContext context) async {
      final DateTime picked2 = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          initialDatePickerMode: DatePickerMode.day,
          firstDate: DateTime(2015),
          lastDate: DateTime(2101));
      if (picked2 != null) finaldate = picked2;
      update();
    }


}