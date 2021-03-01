import 'package:digitalbillbook/customwidgets/table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductList extends StatefulWidget {
  final String uid;
  ProductList(this.uid);
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Products List',
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
                'Product List',
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 50,
                    child: TextField(
                      readOnly: true,
                      onTap: () => selectDate1(context),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          labelText: "From " +
                              DateFormat('dd-MM-yyyy').format(initialdate)),
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 50,
                    child: TextField(
                      readOnly: true,
                      onTap: () => selectDate2(context),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          labelText: "to " +
                              DateFormat('dd-MM-yyyy').format(finaldate)),
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
            Table1(widget.uid, initialdate, finaldate)
          ],
        ),
      ),
    );
  }
}
