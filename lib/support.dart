//import 'dart:html';

import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

List<Item> generateItems(int numberOfItems, Item l) {
  return List.generate(numberOfItems, (int index) {
    return Item(headerValue: l.headerValue, expandedValue: l.expandedValue);
  });
}

class _SupportState extends State<Support> {
  void initState() {
    //assert(_debugLifecycleState == _StateLifecycle.created);
    setState(() {
      selectedListitem = _data;
      //  widgetofquestions = _buildPanel(_data);
    });
  }

  String suppourCard =
      "Have a question to ask ? mail it to support jhatpatbill@gmail.com  we will get back to you";
  Widget widgetofquestions;
  List<Item> selectedListitem;
  List<Item> _data = [
   Item(
        headerValue: 'How to get a sales summary ?',
        expandedValue:
            'Go to home then tap on the reports section tap on Sales Summary and select the fields you want in summary report. \n Home > Reports > Sales Summary'),
    Item(
        headerValue: ' How to change invoice format ?',
        expandedValue:
            ' Go to Home tap on invoice style and select available invoice styles or go to settings tap on invoice setting then invoice style.\n  Home > Invoice Style or Home > Setting > Invoice Setting > Invoice Style'),
    Item(
        headerValue: 'How to generate eWaybill ?',
        expandedValue:
            'Go to the Home tap on eWaybill and enter the invoice number you want to generate eWaybill. \n Home > eWaybill > invoice number '),
    Item(
        headerValue: 'How to add stock alert notification ?',
        expandedValue:
            'Go to Home tap on products, add new products or edit products in the form set low stock reminder and go to setting, select reminder setting and  turn on low stock reminder setting.'),
    Item(
        headerValue: 'How to edit Invoice ?',
        expandedValue:
            'Go to Home tap on invoice go to all invoice and select invoice you want to edit open and check edit button in bottom.\n Home > Invoice > All Invoices (Select Invoice)>  check In bottom edit icon'),
  
  ];

  List<Item> commonQueryData = [
    Item(
        headerValue: 'How to get a sales summary ?',
        expandedValue:
            'Go to home then tap on the reports section tap on Sales Summary and select the fields you want in summary report. \n Home > Reports > Sales Summary'),
    Item(
        headerValue: ' How to change invoice format ?',
        expandedValue:
            ' Go to Home tap on invoice style and select available invoice styles or go to settings tap on invoice setting then invoice style.\n  Home > Invoice Style or Home > Setting > Invoice Setting > Invoice Style'),
    Item(
        headerValue: 'How to generate eWaybill ?',
        expandedValue:
            'Go to the Home tap on eWaybill and enter the invoice number you want to generate eWaybill. \n Home > eWaybill > invoice number '),
    Item(
        headerValue: 'How to add stock alert notification ?',
        expandedValue:
            'Go to Home tap on products, add new products or edit products in the form set low stock reminder and go to setting, select reminder setting and  turn on low stock reminder setting.'),
    Item(
        headerValue: 'How to edit Invoice ?',
        expandedValue:
            'Go to Home tap on invoice go to all invoice and select invoice you want to edit open and check edit button in bottom.\n Home > Invoice > All Invoices (Select Invoice)>  check In bottom edit icon'),
  ];

  List<Item> partyQueryData = [
    Item(
        headerValue: 'How to create a new party ?',
        expandedValue:
            'Go to home, tap on parties and go to add a new party, enter all valid details.\nHome > Parties > Add new Party '),
    Item(
        headerValue: ' How to edit party details ?',
        expandedValue:
            'Go to home, tap on the parties list and click on edit party.\nHome > Parties > Parties list > Edit > Edit Party Details'),
    
  ];

  List<Item> productQueryData = [
    Item(
        headerValue: 'How to add stock alert notification ?',
        expandedValue:
            'Go to Home tap on products, add new products or edit products in the form set low stock reminder and go to setting, select reminder setting and  turn on low stock reminder setting.'),
    Item(
        headerValue: 'How to create new products ?',
        expandedValue:
            ' Go to home, tap on products and go to add new product, enter all valid details.\nHome > Products > Add new Product '),
    Item(
        headerValue: 'How to edit product details ?',
        expandedValue:
            'Go to home, tap on the products list and click on edit product.\nHome > Products > Product List > Edit > Edit Product details'),
    Item(
        headerValue: ' How to check stock details ?',
        expandedValue:
            'Go to home, tap on the reports, select stock summary.\nHome > Reports > Stock Summary'),
    // Item(
    //     headerValue: 'How can I get product list ?',
    //     expandedValue:
    //         'Go to profile tap on change password and change new password.'),
  ];

  List<Item> invoiceQueryData = [
    Item(
        headerValue: ' How to change invoice format ?',
        expandedValue:
            'Go to Home tap on invoice style and select available invoice styles or go to settings tap on invoice setting then invoice style.\nHome > Invoice Style or Home > Setting > Invoice Setting > Invoice Style'),
    Item(
        headerValue: 'How to edit Invoice ?',
        expandedValue:
            ' Go to Home tap on invoice go to all invoice and select invoice you want to edit open and check edit button in bottom.\nHome > Invoice > All Invoices (Select Invoice)>  check In bottom edit icon'),
    Item(
        headerValue: 'How to generate a Bill to Ship to invoice ?',
        expandedValue:
            'Go to Home tap on invoice go to generate invoice and select invoice type as Bill to Ship to.\nHome > Invoice > Generate Invoice >  Select Invoice Type as Bill to ship to'),
    Item(
        headerValue: 'Where do I check all my invoices  ?',
        expandedValue:
            'Go to Home tap on invoice go to all invoices you will find all your invoices or if you want to download all invoice details go to reports select sale summary and export report in excel format.\nHome > Invoice > All Invoices \nFor Sales reports Home > Reports > Sales summary > Export'),
    Item(
        headerValue: ' What is FOC/Gift in the product section ?',
        expandedValue:
            'FOC or Gift products are products  that are free or partially free from the seller side and only sold for Sample or in Offer Discount.'),
  ];

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  int _selected = 1;
  @override
  Widget build(BuildContext context) {
    String isSelected = "commonQuery";

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(icon:Icon(Icons.arrow_back_ios),
          onPressed: ()=> Navigator.of(context).pop(),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Support',
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
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'FAQ',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 16,
                  color: const Color(0xff2f2e41),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 412.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                border: Border.all(width: 0.2, color: const Color(0xff2f2e41)),
              ),
              child: SizedBox(
                width: 391.0,
                height: 16.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          print('ontap pressed');

                          setState(() {
                            isSelected = "commonQuery";
                            widgetofquestions = _buildPanel(commonQueryData);
                            selectedListitem = commonQueryData;
                            _selected = 1;
                          });
                        },
                        child: Text(
                          'Common Query',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 14,
                            color: _selected == 1
                                ? Color(0xff2F2E41)
                                :  Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        )),
                    InkWell(
                        onTap: () {
                          print('ontap pressed');

                          setState(() {
                            widgetofquestions = _buildPanel(partyQueryData);
                            selectedListitem = partyQueryData;
                            _selected = 2;
                          });
                        },
                        child: Ink(
                          child: Text(
                            'Party',
                            style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 14,
                              color: _selected == 2
                                  ? Color(0xff2F2E41)
                                  : Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          print('ontap pressed');

                          setState(() {
                            widgetofquestions = _buildPanel(productQueryData);
                            selectedListitem = productQueryData;
                            _selected = 3;
                          });
                        },
                        child: Text(
                          'Product',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 14,
                            color: _selected == 3
                                ? Color(0xff2F2E41)
                                : Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        )),
                    InkWell(
                        splashColor: Colors.green,
                        onTap: () {
                          setState(() {
                            selectedListitem = invoiceQueryData;
                            _selected = 4;
                          });
                        },
                        child: Text(
                          'Invoice',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 14,
                            color: _selected == 4
                                ? Color(0xff2f2e41)
                                : Colors.grey[800],

                            //    const Color(0xff2f2e41),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            selectedListitem == null
                ? _buildPanel(_data)
                : _buildPanel(selectedListitem),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 0, 10),
              child: Text(
                "24/7 Support",
                style: TextStyle(fontSize: 22),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3.89,
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.email_outlined,
                            size: 34,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Send us an email",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(suppourCard,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10)),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom:20.0),
                            child: RaisedButton(
                              elevation: 0,
                              onPressed: () =>
                                  {_makePhoneCall('mailto:jhatpatbill@gmail.com')},
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  side: BorderSide(color: Colors.black)),
                              child: Text("Contact  us"),
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3.89,
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.call,
                            size: 34,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Call Us",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("1800-210-210-996",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10)),
                          SizedBox(
                            height: 4,
                          ),
                          Text("Mon-Fri 9:00 AM to 8:PM",
                              style: TextStyle(fontSize: 8)),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom:20.0),
                            child: RaisedButton(
                              elevation: 0,
                              onPressed: () =>
                                  {_makePhoneCall('tel:07742330144 ')},
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  side: BorderSide(color: Colors.black)),
                              child: Text("Call us"),
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPanel(List<Item> listItem) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool expanded) {
        if (expanded == false) {
          for (final subop in listItem) {
            if (listItem[index] == subop) {
              setState(() {
                listItem[index].isExpanded = true;
              });
            }
            setState(() {
              subop.isExpanded = false;
            });
          }
        }

        setState(() {
          listItem[index].isExpanded = !expanded;
        });
      },

      // (int index, bool isExpanded) {
      //   setState(() {
      //     listItem[index].isExpanded = !isExpanded;
      //   });
      // },
      children: listItem.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
