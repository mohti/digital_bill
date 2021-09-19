import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class LowStockSummaryController extends GetxController {
  Widget widgetTable;
  var initialdate = DateTime.now(), finaldate = DateTime.now();
  String uid;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void onInit() {
    super.onInit();
    uid = auth.currentUser.uid.toString();
    print(uid);
  }

  Future<Null> selectDate1(BuildContext context) async {
    final DateTime picked1 = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: finaldate);
    if (picked1 != null)
      // setState(() {
      initialdate = picked1;
    update();
    // });
  }

  Future<Null> selectDate2(BuildContext context) async {
    final DateTime picked2 = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked2 != null)
      // setState(() {
      finaldate = picked2;
    update();
    // });
  }
}
