import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

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

List<Item> generateItems(int numberOfItems, Item l) {
  return List.generate(numberOfItems, (int index) {
    return Item(headerValue: l.headerValue, expandedValue: l.expandedValue);
  });
}

class _SupportState extends State<Support> {
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
                    Text(
                      'Common Query',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 10,
                        color: const Color(0xff2f2e41),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Party',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 10,
                        color: const Color(0xcc2f2e41),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Product',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 10,
                        color: const Color(0xcc2f2e41),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Invoice',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 10,
                        color: const Color(0xcc2f2e41),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
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
