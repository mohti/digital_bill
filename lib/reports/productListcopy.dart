
import 'package:digitalbillbook/controller/reports/productSummaryController.dart';
import 'package:digitalbillbook/tables/table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductListweb extends StatefulWidget {
  ProductListweb({Key key}) : super(key: key);

  @override
  _ProductListwebState createState() => _ProductListwebState();
}

class _ProductListwebState extends State<ProductListweb> {
 Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height; //CustomAppbar(),
    final businessProfileController = Get.put(ProductListController());

    return GetBuilder<ProductListController>(builder: (gxValues) {
      return Scaffold(
        appBar: AppBar(
         leading: IconButton(icon:Icon(Icons.arrow_back_ios),
          onPressed: ()=> Navigator.of(context).pop(),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Product List',
          style: TextStyle(
            fontFamily: 'Bell MT',
            fontSize: 24,
            color: const Color(0xfff2f2f2),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
        body: Padding(
          padding:  EdgeInsets.only(left: screenWidth/25.26),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight/14,),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Date',
                    style: TextStyle(
                        fontSize: screenWidth / 80, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: screenWidth / 14),
                  Card(
                    elevation: 4,
                    child: InkWell(
                      onTap: () => gxValues.selectDate1(context),
                      child: Container(
                        alignment: Alignment.center,
                        width: screenWidth / 3.84,
                        height: screenHeight / 15.42,
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: screenWidth/61,),
                         
                            Text("From ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,

                                  fontSize: screenWidth / 80,
                                )),
                                   SizedBox(width: screenWidth/10.26,),
                         
                            Text(
                                  DateFormat('dd-MM-yyyy').format(
                                    gxValues.initialdate,
                                  ),
                                  style: TextStyle(
                                    fontSize: screenWidth / 80,
                                  )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth / 16.13),
                  Card(
                    elevation: 4,
                    child: InkWell(
                      onTap: () => gxValues.selectDate2(context),
                      child: Container(
                        alignment: Alignment.center,
                        width: screenWidth / 3.84,
                        height: screenHeight / 15.42,
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: screenWidth/61,),
                            Text("To ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                      
                                  fontSize: screenWidth / 80,
                                )),

                            SizedBox(width: screenWidth/10.26,),
                            Text(DateFormat('dd-MM-yyyy').format(gxValues.finaldate),
                                style: TextStyle(
                                  fontSize: screenWidth / 80,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                 
                ],
              ),
             
            //  SizedBox(height: screenHeight/40,),
             
            //  Row(
            //     //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Text(
            //         'Product Code',
            //         style: TextStyle(
            //             fontSize: screenWidth / 80, fontWeight: FontWeight.bold),
            //       ),
            //       SizedBox(width: screenWidth / 44.65),
            //       Card(
            //         elevation: 4,
            //         child: InkWell(
            //           onTap: () => gxValues.selectDate1(context),
            //           child: Container(
            //             alignment: Alignment.center,
            //             width: screenWidth / 3.84,
            //             height: screenHeight / 15.42,
            //             child: Row(
            //               //mainAxisAlignment: MainAxisAlignment.spaceAround,
            //               children: [
            //                 SizedBox(width: screenWidth/61,),
                         
            //                 Text("From ",
            //                     style: TextStyle(
            //                       fontWeight: FontWeight.bold,

            //                       fontSize: screenWidth / 80,
            //                     )),
            //                        SizedBox(width: screenWidth/10.26,),
                         
                        
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       SizedBox(width: screenWidth / 16.13),
            //       Card(
            //           elevation: 4,
            //           child: Container(
            //             width: screenWidth / 3.84,
            //             height: screenHeight / 15.42,
            //             child: DropdownButtonFormField(
            //              // value: gxValues.cgst,
            //               icon: Icon(Icons.keyboard_arrow_down_sharp),
            //               decoration: CoustumInputDecorationWidget('Select By')
            //                   .decoration(),
            //               items: [
            //                 "14+14",
            //                 "9+9",
            //                 '6+6',
            //                 '4.5+4.5',
            //                 '2.5+2.5',
            //                 '1.5+1.5'
            //               ].map((String value) {
            //                 return new DropdownMenuItem<String>(
            //                   value: value,
            //                   child: new Text(value.toString() + " %"),
            //                 );
            //               }).toList(),
            //               // onChanged: (String newValue) {
            //               //   setState(() {
            //               //     gxValues.cgst = newValue;
            //               //     gxValues.cgstController.text = newValue;
            //               //     print(gxValues.cgst + 'MOHIT new value');
            //               //   });
            //              // },
            //               validator: (value) {
            //                 if (value.isEmpty) {
            //                   return 'Pease select CGST + SGST';
            //                 }
            //                 return null;
            //               },
            //             ),
            //           ),
            //         ),
            //         ],
            //   ),
             
              SizedBox(height: screenHeight/17.70,),
               Container(
                 width: screenWidth,
                                child: Center(
                                  child: InkWell(
                                    onTap: () => {
                                       gxValues.widgetTable =
                                    Table1(gxValues.uid, gxValues.initialdate, gxValues.finaldate)
                                    },
                                                                      child: Container(
                                      height: screenHeight / 19,
                                      width: screenWidth / 9.79,
                                      color: const Color(0xff2f2e41),
                                      child: Center(
                                        child: Text(
                                          'Get Product List',
                                          style: TextStyle(
                                              fontSize: screenWidth/ 112.95,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
               ),
              SizedBox(height: screenHeight/17.70,),              
                             gxValues.widgetTable == null
                ?
                              Container(
                  width:screenWidth/1.48 ,
                   height:  screenHeight/21.6,
                    decoration: BoxDecoration(color: const Color(0xff2F2E41)),
                    child:Row(
              children: [
                SizedBox(width: screenWidth/24.61,),
                Container( 
                  alignment: Alignment.centerLeft,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
                 width: screenWidth /9.41,                                                                                                                                                                          
                  child: Text(
                    'Product Code ',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: screenWidth/137,
                      color: const Color(0xfff1f3f6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: screenWidth /6.37,
                  child: Text(
                    'Product Name',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: screenWidth/137,
                      color: const Color(0xfff1f3f6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                 width: screenWidth /10.60  ,
                  child: Text(
                    'HSN Code',
                    style: TextStyle(
                      fontFamily: 'Arial', 
                      fontSize: screenWidth/137,
                      color: const Color(0xfff1f3f6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                 width: screenWidth /8.88,
                  child: Text(      
                    'Purchase Rate',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: screenWidth/137,
                      color: const Color(0xfff1f3f6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: screenWidth/6.19,
                  child: Text(
                    'Selling Rate ',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: screenWidth/137,
                      color: const Color(0xfff1f3f6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
               
              ],
            ),)
:gxValues.widgetTable        
                


                          
            ],
          ),
        ),
      );
    });
  }


}