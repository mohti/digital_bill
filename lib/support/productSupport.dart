import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';

import '../support.dart';



class productSupport extends StatefulWidget {
  const productSupport({ Key  key }) : super(key: key);

  @override
  _productSupportState createState() => _productSupportState();
}

class _productSupportState extends State<productSupport> {
 
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


  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Product F&Q',
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
            Container(
              child: _buildPanel(),
            ),
          ],
        ),
      ),
    
  
    );
  }


  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
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









