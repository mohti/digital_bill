//import 'dart:html';

import 'package:adobe_xd/pinned.dart';
import 'package:digitalbillbook/support/commonQueries.dart';
import 'package:digitalbillbook/support/invoiceSupport.dart';
import 'package:digitalbillbook/support/partySupoort.dart';
import 'package:digitalbillbook/support/productSupport.dart';
import 'package:flutter/material.dart';

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


  Widget widgetofquestions;
  List<Item> selectedListitem ; 
  List<Item> _data = [
    Item(
        headerValue: 'How can I get sales summary ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How to change invoice format ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How can I edit invoice ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How can I add stock alert ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How can I get product list ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
  ];

  List<Item> commonQueryData = [
    Item(
        headerValue: 'How can I get sales summary ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How to change invoice format ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How can I edit invoice ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How can I add stock alert ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How can I get product list ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
  ];

  List<Item> partyQueryData = [
    Item(
        headerValue: 'How can I get sales summary ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How to change invoice format ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How can I edit invoice ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How can I add stock alert ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How can I get product list ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
  ];

  List<Item> productQueryData = [
    Item(
        headerValue: 'How can I get sales summary ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How to change invoice format ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How can I edit invoice ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How can I add stock alert ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How can I get product list ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
  ];

  List<Item> invoiceQueryData = [
    Item(
        headerValue: 'How can I get sales Invoice summary ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How to change invoice format ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How can I edit invoice ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'How can I add stock alert ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
    Item(
        headerValue: 'Hello it changed ?',
        expandedValue:
            'Go to profile tap on change password and change new password.'),
  ];

  @override
  Widget build(BuildContext context) {
    String isSelected = "commonQuery";

    return Scaffold(
      appBar: AppBar(
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
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'FAQ',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 10,
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
                          });
                        },
                        child: Text(
                          'Common Query',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 10,
                            color: const Color(0xff2f2e41),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        )),
                    InkWell(
                        onTap: () {
                          print('ontap pressed');
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => partySupport()),
                          // );
                          setState(() {
                            widgetofquestions = _buildPanel(partyQueryData);
                            selectedListitem = partyQueryData;
                          });
                        },
                        child:Ink(child: Text(
                          'Party',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 10,
                            color: const Color(0xff2f2e41),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ) ,)),
                    InkWell(
                        onTap: () {
                          print('ontap pressed');
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => productSupport()),
                          // );

                          setState(() {
                            widgetofquestions = _buildPanel(productQueryData);
                            selectedListitem = productQueryData;
                          });
                        },
                        child: Text(
                          'Product',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 10,
                            color: const Color(0xff2f2e41),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        )),
                    InkWell(
                      splashColor: Colors.green,
                        onTap: () {
                         
                          setState(() {
                            selectedListitem = invoiceQueryData;
                          });
                        },
                        child: Text(
                          'Invoice',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 10,
                            color: const Color(0xff2f2e41),
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
            // Container(
            //   child: _buildPanel(_data),
            // ),
            // switch (isSelected) {
            //   case isSelected=="commonQuery":
            //     _buildPanel(commonQueryData);
            //     break;
            //   default:
            // _buildPanel(invoiceQueryData),
            // },
            selectedListitem==null?
             _buildPanel(_data)
            :
             _buildPanel(selectedListitem),
            
          ],
        ),
      ),
    );
  }

  Widget _buildPanel(List<Item> listItem) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          listItem[index].isExpanded = !isExpanded;
        });
      },
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
