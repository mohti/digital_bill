import 'dart:ffi';
import 'dart:io';

import 'package:digitalbillbook/theme/colors/colors.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:digitalbillbook/controller/reports/saleSummaryController.dart';
import 'package:digitalbillbook/customwidgets/CustomInputDecorationWidget.dart';
import 'package:digitalbillbook/tables/salsummarytable.dart';
import 'package:get/state_manager.dart';
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

class SalesSummary extends StatefulWidget {
  final String uid;
  SalesSummary(this.uid);
  @override
  _SalesSummary createState() => _SalesSummary();
}

class _SalesSummary extends State<SalesSummary> {
  var initialdate = DateTime.now(), finaldate = DateTime.now();
  String textfieldValues;
  String askValues = 'productCode';
  String selectbyfilter;
  // String selectbyfilter;
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

  bool _value1 = false;
  bool _value2 = false;

  final businessProfileController = Get.put(SalesSummaryController());
  bool hello = true;
  bool hello1 = false;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0, right: 20),
        child: GetBuilder<SalesSummaryController>(
            id: 'dropdown',
            builder: (gxValues) {
              return InkWell(
                onTap: () => gxValues.fc(initialdate, finaldate),

                child: Image.asset("assets/images/exporticon.png",width: 100,height: 100,),
                //  SizedBox(
                //   width: 65.0,
                //   height: 65.0,
                //   child: Stack(
                //     children: <Widget>[
                //       Pinned.fromSize(
                //         bounds: Rect.fromLTWH(0.0, 0.0, 65.0, 65.0),
                //         size: Size(65.0, 65.0),
                //         pinLeft: true,
                //         pinRight: true,
                //         pinTop: true,
                //         pinBottom: true,
                //         child: Container(
                //           decoration: BoxDecoration(
                //             borderRadius:
                //                 BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                //             color: const Color(0xffffffff),
                //             border: Border.all(
                //                 width: 1.0, color: const Color(0xff2f2e41)),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: const Color(0x66404040),
                //                 offset: Offset(6, 6),
                //                 blurRadius: 12,
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       Pinned.fromSize(
                //         bounds: Rect.fromLTWH(20.6, 18.0, 25.7, 21.5),
                //         size: Size(65.0, 65.0),
                //         child:
                //             // Adobe XD layer: 'Icon awesome-file-e…' (shape)
                //             SvgPicture.string(
                //           '<svg viewBox="66.6 554.0 25.7 21.5" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(66.65, 554.0)" d="M 17.13576507568359 5.118847370147705 C 17.13576507568359 4.854296684265137 17.02420425415039 4.59814453125 16.82339477539062 4.4091796875 L 12.45466613769531 0.2939453125 C 12.25385665893555 0.10498046875 11.98164844512939 0 11.69605159759521 0 L 11.42384338378906 0 L 11.42384338378906 5.375 L 17.13576507568359 5.375 L 17.13576507568359 5.118847370147705 Z M 25.48052597045898 12.93359375 L 21.2099723815918 8.885546684265137 C 20.75926780700684 8.46142578125 19.98726463317871 8.759570121765137 19.98726463317871 9.360057830810547 L 19.98726463317871 12.09375 L 17.13130378723145 12.09375 L 17.13130378723145 14.78125 L 19.98726463317871 14.78125 L 19.98726463317871 17.51914024353027 C 19.98726463317871 18.11962890625 20.75926780700684 18.41777420043945 21.2099723815918 17.99365234375 L 25.48052597045898 13.94140625 C 25.77504730224609 13.66425800323486 25.77504730224609 13.21074104309082 25.48052597045898 12.93359375 Z M 8.567882537841797 14.109375 L 8.567882537841797 12.765625 C 8.567882537841797 12.39609336853027 8.889178276062012 12.09375 9.281872749328613 12.09375 L 17.13576507568359 12.09375 L 17.13576507568359 6.71875 L 11.06684875488281 6.71875 C 10.47780609130859 6.71875 9.99586296081543 6.265234470367432 9.99586296081543 5.7109375 L 9.99586296081543 0 L 1.070985317230225 0 C 0.4774809777736664 0 0 0.4493164122104645 0 1.0078125 L 0 20.4921875 C 0 21.05068397521973 0.4774809777736664 21.5 1.070985317230225 21.5 L 16.06477928161621 21.5 C 16.65828514099121 21.5 17.13576507568359 21.05068397521973 17.13576507568359 20.4921875 L 17.13576507568359 14.78125 L 9.281872749328613 14.78125 C 8.889178276062012 14.78125 8.567882537841797 14.47890567779541 8.567882537841797 14.109375 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>',
                //           allowDrawingOutsideViewBox: true,
                //           fit: BoxFit.fill,
                //         ),
                //       ),
                //       Pinned.fromSize(
                //         bounds: Rect.fromLTWH(12.0, 45.0, 41.0, 8.0),
                //         size: Size(65.0, 65.0),
                //         fixedWidth: true,
                //         fixedHeight: true,
                //         child: Text(
                //           'Export File',
                //           style: TextStyle(
                //             fontFamily: 'Bell MT',
                //             fontSize: 8,
                //             color: const Color(0xff707070),
                //             fontWeight: FontWeight.w700,
                //             shadows: [
                //               Shadow(
                //                 color: const Color(0x29000000),
                //                 offset: Offset(3, 3),
                //                 blurRadius: 6,
                //               )
                //             ],
                //           ),
                //           textAlign: TextAlign.left,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              );
            }),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Sale Summary',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20, 50, 20),
              child: Text(
                'Sale Summary',
                style: TextStyle(
                  fontFamily: 'Bell MT',
                  fontSize: 20,
                  color: const Color(0xff2f2e41),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: Text(
                      'Date',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 12,
                        color: const Color(0xff2f2e41),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  child: InkWell(
                    onTap: () => selectDate1(context),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 40,
                      child: Text("From " +
                          DateFormat('dd-MM-yyyy').format(initialdate)),
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  child: InkWell(
                    onTap: () => selectDate2(context),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 40,
                      child: Text(
                          "To " + DateFormat('dd-MM-yyyy').format(finaldate)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: Text(
                      'Select By',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 12,
                        color: const Color(0xff2f2e41),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                // Card(
                //   elevation: 4,
                //   child: InkWell(
                //     child: Container(
                //       alignment: Alignment.center,
                //       width: MediaQuery.of(context).size.width * 0.35,
                //       height: 40,
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: TextField(
                //           onChanged: (text) {
                //             setState(() {
                //               textfieldValues = text;
                //             });
                //             print('First text field: $text');
                //           },
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Card(
                //   elevation: 4,
                //   child: SizedBox(
                //     width: MediaQuery.of(context).size.width * 0.35,
                //     height: 40,
                //     child: DropdownButtonFormField<String>(
                //       value: selectbyfilter,
                //       icon: Icon(Icons.keyboard_arrow_down_sharp),
                //       decoration: CoustumInputDecorationWidget('select by')
                //           .decoration(),
                //       items: listofSelect.map((String value) {
                //         return new DropdownMenuItem<String>(
                //           value: value,
                //           child: new Text(
                //             value,
                //             style: TextStyle(fontSize: 12),
                //           ),
                //         );
                //       }).toList(),
                //       onChanged: (String newValue) {
                //         setState(() {
                //           selectbyfilter = newValue;
                //           if (selectbyfilter == 'product Code') {
                //             askValues = 'productCode';
                //           }
                //           if (selectbyfilter == 'Product name') {
                //             askValues = 'productName';
                //           }
                //           if (selectbyfilter == 'Quanitity') {
                //             askValues = 'quantity';
                //           }
                //           if (selectbyfilter == 'Tax Rate') {
                //             askValues = 'cgst';
                //           }
                //           if (selectbyfilter == 'Invoice No') {
                //             askValues = 'invoiceno';
                //           }

                //           if (selectbyfilter == 'Ammount') {
                //             askValues = 'totalAmount';
                //           }

                //           settingUitextvalues = selectbyfilter;
                //         });
                //       },
                //       validator: (value) {
                //         if (value.isEmpty) {
                //           return 'Pease select by';
                //         }
                //         return null;
                //       },
                //     ),
                //   ),
                // ),
//            SizedBox(
//             //  height: 40,
//               width: MediaQuery.of(context).size.width * 0.35,

//              child: ExpansionTile(
//            maintainState: true,
//     title: Text('Expand'),
//   children: [
//     Container(
//       child: CheckboxListTile(
//         title: Text('item 1'),
//         value: _value1,
//         onChanged: (val){
//           setState(() {
//             _value1 = val;
//           });
//         },
//       ),
//     ),
//     Container(
//       child: CheckboxListTile(
//         title: Text('item 2'),
//         value: _value2,
//         onChanged: (val){
//           setState(() {
//             _value2 = val;
//           });
//         },
//       ),
//     ),
//   ],
// ),
//            ),

                GetBuilder<SalesSummaryController>(
                    id: 'dropdown',
                    builder: (gxValues) {
                      return Card(
                          elevation: 4,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: 40,
                            child: Center(
                              child: DropdownButton(
                                isDense: true,
                                isExpanded: true,
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(Icons.keyboard_arrow_down_sharp),
                                ),
                                value: null,
                                items: [
                                  DropdownMenuItem(
                                    onTap: () {
                                      gxValues.productCode =
                                          !(gxValues.productCode);
                                      print('clicked');
                                      gxValues.update(['dropdown']);
                                    },
                                    value: 1,
                                    child: Row(
                                      children: <Widget>[
                                        Checkbox(
                                          onChanged: (bool value) {},
                                          value: gxValues.productCode,

                                            activeColor: purpleForapp,
                                        ),
                                        Text(
                                          'Product Code',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem(
                                      onTap: () {
                                        gxValues.productName =
                                            !(gxValues.productName);
                                        print('clicked');
                                        gxValues.update(['dropdown']);
                                      },
                                      value: 2,
                                      child: Row(
                                        children: <Widget>[
                                          Checkbox(
                                            onChanged: (bool value) {},
                                            value: gxValues.productName,
                                            activeColor: purpleForapp,
                                          ),
                                          Text(
                                            'Product name',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      )),
                                  DropdownMenuItem(
                                    onTap: () {
                                      gxValues.quantity = !(gxValues.quantity);
                                      print('clicked');
                                      gxValues.update(['dropdown']);
                                    },
                                    value: 3,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Row(
                                        children: <Widget>[
                                          Checkbox(

                                            activeColor: purpleForapp,
                                            onChanged: (bool value) {},
                                            value: gxValues.quantity,
                                          ),
                                          Text(
                                            'Quanitity',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    onTap: () {
                                      gxValues.taxRate = !(gxValues.taxRate);
                                      print('clicked');
                                      gxValues.update(['dropdown']);
                                    },
                                    value: 4,
                                    child: Row(
                                      children: <Widget>[
                                        Checkbox(

                                            activeColor: purpleForapp,
                                          onChanged: (bool value) {},
                                          value: gxValues.taxRate,
                                        ),
                                        Text(
                                          'Tax Rate',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    onTap: () {
                                      gxValues.date = !(gxValues.date);
                                      print(
                                          'clicked' + gxValues.date.toString());

                                      gxValues.update(['dropdown']);
                                    },
                                    value: 5,
                                    child: Row(
                                      children: <Widget>[
                                        Checkbox(

                                            activeColor: purpleForapp,
                                          onChanged: (bool value) {},
                                          value: gxValues.date,
                                        ),
                                        Text(
                                          'Date',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    onTap: () {
                                      gxValues.ammount = !(gxValues.ammount);
                                      print('clicked');
                                      gxValues.update(['dropdown']);
                                    },
                                    value: 6,
                                    child: Row(
                                      children: <Widget>[
                                        Checkbox(

                                            activeColor: purpleForapp,
                                          onChanged: (bool value) {},
                                          value: gxValues.ammount,
                                        ),
                                        Text(
                                          'Amount',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                                onChanged: (value) {},
                                hint: Center(child: Text('Select By')),
                              ),
                            ),
                          ));
                    }),

                SizedBox(
                  height: 10,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              //  width: MediaQuery.of(context).size.width * 0.45,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                      color: const Color(0xff2f2e41),
                      onPressed: () {
                        setState(() {
                          widgetTable = SalesSummaryTable(
                              widget.uid,
                              initialdate,
                              finaldate,
                              textfieldValues,
                              askValues);
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Get Sales Summary',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            widgetTable == null
                ? GetBuilder<SalesSummaryController>(
                    id: 'dropdown',
                    builder: (gxValues) {
                      return Container(
                        width: w,
                        height: 16,
                        decoration:
                            BoxDecoration(color: const Color(0xff2F2E41)),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: w * 0.09,
                              child: Text(
                                'Receipt No.',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: fontSizeForMainColumn,
                                  color: const Color(0xfff1f3f6),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            gxValues.date == true
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    width: w * 0.1,
                                    child: Text(
                                      'Date',
                                      style: TextStyle(
                                        fontFamily: 'Arial',
                                        fontSize: fontSizeForMainColumn,
                                        color: const Color(0xfff1f3f6),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                : Container(
                                    width: w * 0.1,
                                  ),
                            gxValues.productCode == true
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    width: w * 0.08,
                                    child: Text(
                                      'Pro Code',
                                      style: TextStyle(
                                        fontFamily: 'Arial',
                                        fontSize: fontSizeForMainColumn,
                                        color: const Color(0xfff1f3f6),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                : Container(
                                    width: w * 0.08,
                                  ),
                            gxValues.productName == true
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    width: w * 0.1,
                                    child: Text(
                                      'Pro Name',
                                      style: TextStyle(
                                        fontFamily: 'Arial',
                                        fontSize: fontSizeForMainColumn,
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
                              width: w * 0.16,
                              child: Text(
                                'GSTN',
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
                              alignment: Alignment.centerLeft,
                              width: w * 0.1,
                              child: Text(
                                'Buyer Name',
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
                              alignment: Alignment.centerLeft,
                              width: w * 0.05,
                              child: Text(
                                'HSN',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: fontSizeForMainColumn,
                                  color: const Color(0xfff1f3f6),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            gxValues.quantity == true
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    width: w * 0.08,
                                    child: Text(
                                      'Quantity',
                                      style: TextStyle(
                                        fontFamily: 'Arial',
                                        fontSize: fontSizeForMainColumn,
                                        color: const Color(0xfff1f3f6),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                : Container(
                                    width: w * 0.08,
                                  ),
                            gxValues.taxRate == true
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    width: w * 0.05,
                                    child: Text(
                                      'TAX',
                                      style: TextStyle(
                                        fontFamily: 'Arial',
                                        fontSize: fontSizeForMainColumn,
                                        color: const Color(0xfff1f3f6),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                : Container(
                                    width: w * 0.05,
                                  ),
                            gxValues.ammount == true
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    width: w * 0.08,
                                    child: Text(
                                      'Invoice Value',
                                      style: TextStyle(
                                        fontFamily: 'Arial',
                                        fontSize: fontSizeForMainColumn,
                                        color: const Color(0xfff1f3f6),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                : Container(
                                    width: w * 0.08,
                                  ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: w * 0.09,
                              child: Text(
                                'TAX Value',
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
                      );
                    })
                : widgetTable
          ],
        ),
      ),
    );
  }
}
// import 'package:digitalbillbook/controller/reports/saleSummaryController.dart';
// import 'package:digitalbillbook/tables/salsummarytable.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// // Imports all Widgets included in [multiselect] package
// // import 'package:multiselect/multiselect.dart';

// class SaleSummary extends StatefulWidget {
//   SaleSummary({Key key}) : super(key: key);

//   @override
//   _SaleSummaryState createState() => _SaleSummaryState();
// }

// class _SaleSummaryState extends State<SaleSummary> {
//   List<String> selected = [];
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height; //CustomAppbar(),
//     final businessProfileController = Get.put(SalesSummaryController());
//     bool hello = true;
//     bool hello1 = false;
//     return GetBuilder<SalesSummaryController>(builder: (gxValues) {
//       return Scaffold(
//         appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         centerTitle: true,
//         backgroundColor: Color.fromRGBO(47, 46, 65, 1),
//         title: Text(
//           'Sale Summary',
//           style: TextStyle(
//             fontFamily: 'Bell MT',
//             fontSize: 24,
//             color: const Color(0xfff2f2f2),
//             fontWeight: FontWeight.w700,
//           ),
//           textAlign: TextAlign.left,
//         ),
//       ),
//         body: Padding(
//             padding: EdgeInsets.only(left: screenWidth / 25.26),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: screenHeight / 14,
//                 ),
//                 Row(
//                   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       'Date',
//                       style: TextStyle(
//                           fontSize: screenWidth / 80,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(width: screenWidth / 14),
//                     Card(
//                       elevation: 4,
//                       child: InkWell(
//                         onTap: () => gxValues.selectDate1(context),
//                         child: Container(
//                           alignment: Alignment.center,
//                           width: screenWidth / 3.84,
//                           height: screenHeight / 15.42,
//                           child: Row(
//                             //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               SizedBox(
//                                 width: screenWidth / 61,
//                               ),
//                               Text("From ",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: screenWidth / 80,
//                                   )),
//                               SizedBox(
//                                 width: screenWidth / 10.26,
//                               ),
//                               Text(
//                                   DateFormat('dd-MM-yyyy').format(
//                                     gxValues.initialdate,
//                                   ),
//                                   style: TextStyle(
//                                     fontSize: screenWidth / 80,
//                                   )),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: screenWidth / 16.13),
//                     Card(
//                       elevation: 4,
//                       child: InkWell(
//                         onTap: () => gxValues.selectDate2(context),
//                         child: Container(
//                           alignment: Alignment.center,
//                           width: screenWidth / 3.84,
//                           height: screenHeight / 15.42,
//                           child: Row(
//                             //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               SizedBox(
//                                 width: screenWidth / 61,
//                               ),
//                               Text("To ",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: screenWidth / 80,
//                                   )),
//                               SizedBox(
//                                 width: screenWidth / 10.26,
//                               ),
//                               Text(
//                                   DateFormat('dd-MM-yyyy')
//                                       .format(gxValues.finaldate),
//                                   style: TextStyle(
//                                     fontSize: screenWidth / 80,
//                                   )),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: screenHeight / 40,
//                 ),
//                 Row(
//                   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       'Select By',
//                       style: TextStyle(
//                           fontSize: screenWidth / 80,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(width: screenWidth / 21.33),
//                     // Card(
//                     //   elevation: 4,
//                     //   child: Container(
//                     //     width: screenWidth / 3.84,
//                     //     height: screenHeight / 15.42,
//                     //     child: DropDownMultiSelect(

//                     //       onChanged: (List<String> x) {
//                     //         setState(() {
//                     //           print(x);
//                     //           selected = x;
//                     //           for (var i = 0; i <= x.length; i++) {
//                     //             // switch (x[i]) {
//                     //             if (x[i] == 'Product Code') {
//                     //               gxValues.productCode =
//                     //                   !(gxValues.productCode);

//                     //               break;
//                     //             } else if (x[i] == 'Product name') {
//                     //               gxValues.productCode =
//                     //                   !(gxValues.productCode);

//                     //               break;
//                     //             } else if (x[i] == 'Tax Rate') {
//                     //               gxValues.taxRate = !(gxValues.taxRate);
//                     //               print('done it right');

//                     //               break;
//                     //             } else if (x[i] == 'Quanitity') {
//                     //               gxValues.quantity = !(gxValues.quantity);
//                     //               print('done it right');

//                     //               break;
//                     //             } else if (x[i] == 'Date') {
//                     //               gxValues.date = !(gxValues.date);
//                     //               print(gxValues.date.toString());

//                     //               break;
//                     //             } else if (x[i] == 'Ammount') {
//                     //               gxValues.ammount = !(gxValues.ammount);
//                     //               print('done it right');

//                     //               break;
//                     //             } else {
//                     //               break;
//                     //             }
//                     //           }
//                     //         });
//                     //       },
//                     //       options: [
//                     //         'Product Code',
//                     //         'Product name',
//                     //         'Quanitity',
//                     //         'Tax Rate',
//                     //         'Date',
//                     //         'Ammount'
//                     //       ],
//                     //       selectedValues: selected,
//                     //       whenEmpty: 'Select Something',
//                     //     ),
//                     //   ),
//                     // ),
//                              Card(
//                       elevation: 4,
//                       child: SizedBox(
//                                   width: screenWidth / 3.84,
//                         height: screenHeight / 15.42,

//                         child: DropdownButton(

//                           isDense: true,
//                           // itemHeight: screenHeight/15.42,
//                           isExpanded: true,
//                           icon:  Icon(Icons.keyboard_arrow_down_sharp),
//                           value: null,
//                           items: [
//                         DropdownMenuItem(
//                           onTap: () {
//                             gxValues.productCode = !(gxValues.productCode);
//                             print('clicked');
//                             gxValues.update();
//                           },
//                           value: 1,
//                           child: Row(
//                             children: <Widget>[
//                               Checkbox(
//                                 onChanged: (bool value) {},
//                                 value: gxValues.productCode,
//                               ),
//                               Text('Product Code'),
//                             ],
//                           ),
//                         ),
//                         DropdownMenuItem(
//                           onTap: () {
//                             gxValues.productName = !(gxValues.productName);
//                             print('clicked');
//                             gxValues.update();
//                           },
//                           value: 2,
//                           child: Row(
//                             children: <Widget>[
//                               Checkbox(
//                                 onChanged: (bool value) {},
//                                 value: gxValues.productName,
//                               ),
//                               Text('Product name'),
//                             ],
//                           ),
//                         ),
//                         DropdownMenuItem(
//                           onTap: () {
//                             gxValues.quantity = !(gxValues.quantity);
//                             print('clicked');
//                             gxValues.update();
//                           },
//                           value: 3,
//                           child: Row(
//                             children: <Widget>[
//                               Checkbox(
//                                 onChanged: (bool value) {},
//                                 value: gxValues.quantity,
//                               ),
//                               Text('Quanitity'),
//                             ],
//                           ),
//                         ),
//                         DropdownMenuItem(
//                           onTap: () {
//                             gxValues.taxRate = !(gxValues.taxRate);
//                             print('clicked');
//                             gxValues.update();
//                           },
//                           value: 4,
//                           child: Row(
//                             children: <Widget>[
//                               Checkbox(
//                                 onChanged: (bool value) {},
//                                 value: gxValues.taxRate,
//                               ),
//                               Text('Tax Rate'),
//                             ],
//                           ),
//                         ),
//                         DropdownMenuItem(
//                           onTap: () {
//                             gxValues.date = !(gxValues.date);
//                             print('clicked');
//                             gxValues.update();
//                           },
//                           value: 5,
//                           child: Row(
//                             children: <Widget>[
//                               Checkbox(
//                                 onChanged: (bool value) {},
//                                 value: gxValues.date,
//                               ),
//                               Text('Date'),
//                             ],
//                           ),
//                         ),
//                         DropdownMenuItem(
//                           onTap: () {
//                             gxValues.ammount = !(gxValues.ammount);
//                             print('clicked');
//                             gxValues.update();
//                           },
//                           value: 6,
//                           child: Row(
//                             children: <Widget>[
//                               Checkbox(
//                                 onChanged: (bool value) {},
//                                 value: gxValues.ammount,
//                               ),
//                               Text('Ammount'),
//                             ],
//                           ),
//                         )
//                           ],
//                           onChanged: (value) { },
//                           hint: Text('Select value'),
//                         ),
//                       )),

//                     SizedBox(width: screenWidth / 16.13),
//                     InkWell(
//                       onTap: () {
//                         gxValues.widgetTable = SalesSummaryTable(
//                             gxValues.uid,
//                             gxValues.initialdate,
//                             gxValues.finaldate,
//                             gxValues.textfieldValues,
//                             gxValues.askValues);
//                         gxValues.update();
//                       },
//                       child: Container(
//                         height: screenHeight / 27,
//                         width: screenWidth / 9.79,
//                         color: const Color(0xff2f2e41),
//                         child: Center(
//                           child: Text(
//                             'Get Sale Details',
//                             style: TextStyle(
//                                 fontSize: screenWidth / 112.95,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: screenHeight / 17.70,
//                 ),
//                Container(
//                         width: screenWidth / 1.44,
//                         height: screenHeight / 21.6,
//                         decoration:
//                             BoxDecoration(color: const Color(0xff2F2E41)),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: screenWidth / 147.69,
//                             ),
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               width: screenWidth / 16,
//                               child: Text(
//                                 'Invoice No ',
//                                 style: TextStyle(
//                                   fontFamily: 'Arial',
//                                   fontSize: screenWidth / 137,
//                                   color: const Color(0xfff1f3f6),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               width: screenWidth / 16.55,
//                               child:
//                               gxValues.date == true?
//                               Text(
//                                 'Date',
//                                 style: TextStyle(
//                                   fontFamily: 'Arial',
//                                   fontSize: screenWidth / 137,
//                                   color: const Color(0xfff1f3f6),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 textAlign: TextAlign.left,
//                               ): Container(
//                                  width: screenWidth / 16.55,
//                               ),
//                             ),
//                             gxValues.productCode==true?
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               width: screenWidth / 19.20,
//                               child: Text(
//                                 'Product  Code',
//                                 style: TextStyle(
//                                   fontFamily: 'Arial',
//                                   fontSize: screenWidth / 137,
//                                   color: const Color(0xfff1f3f6),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ):Container(  width: screenWidth / 19.20,
//                             ),
//                             gxValues.productName==true?
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               width: screenWidth / 16.13,
//                               child: Text(
//                                 'Product Name',
//                                 style: TextStyle(
//                                   fontFamily: 'Arial',
//                                   fontSize: screenWidth / 137,
//                                   color: const Color(0xfff1f3f6),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ):Container(width: screenWidth / 16.13,
//                               ),
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               width: screenWidth / 9.84,
//                               child: Text(
//                                 'GSTN',
//                                 style: TextStyle(
//                                   fontFamily: 'Arial',
//                                   fontSize: screenWidth / 137,
//                                   color: const Color(0xfff1f3f6),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               width: screenWidth / 15.36,
//                               child: Text(
//                                 'Buyer Name',
//                                 style: TextStyle(
//                                   fontFamily: 'Arial',
//                                   fontSize: screenWidth / 137,
//                                   color: const Color(0xfff1f3f6),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               width: screenWidth / 25.6,
//                               child: Text(
//                                 'HSN ',
//                                 style: TextStyle(
//                                   fontFamily: 'Arial',
//                                   fontSize: screenWidth / 137,
//                                   color: const Color(0xfff1f3f6),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                             gxValues.quantity==true?
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               width: screenWidth / 21.09,
//                               child: Text(
//                                 'Quantity ',
//                                 style: TextStyle(
//                                   fontFamily: 'Arial',
//                                   fontSize: screenWidth / 137,
//                                   color: const Color(0xfff1f3f6),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ):Container( width: screenWidth / 21.09,
//                              ),
//                             gxValues.taxRate==true?
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               width: screenWidth / 22.85,
//                               child: Text(
//                                 'TAX',
//                                 style: TextStyle(
//                                   fontFamily: 'Arial',
//                                   fontSize: screenWidth / 137,
//                                   color: const Color(0xfff1f3f6),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ):Container(width: screenWidth / 22.85,
//                               ),
//                             gxValues.ammount==true?
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               width: screenWidth / 12.71,
//                               child: Text(
//                                 'Invoice Value',
//                                 style: TextStyle(
//                                   fontFamily: 'Arial',
//                                   fontSize: screenWidth / 137,
//                                   color: const Color(0xfff1f3f6),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ):Container(width: screenWidth / 12.71,
//                               ),
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               width: screenWidth / 18.11,
//                               child: Text(
//                                 'TAX Value',
//                                 style: TextStyle(
//                                   fontFamily: 'Arial',
//                                   fontSize: screenWidth / 137,
//                                   color: const Color(0xfff1f3f6),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                        gxValues.widgetTable == null
//                     ?

//                     Container() :gxValues.widgetTable
//                     ],
//             )),
//       );
//     });
//   }
// }
