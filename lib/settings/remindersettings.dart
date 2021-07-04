import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalbillbook/models/remindersettings.dart';
import 'package:flutter/material.dart';

class Tab extends StatefulWidget {
  final String title;
  final Widget f;
  final double w;
  final Widget ic;
  Tab(this.ic, this.title, this.f, this.w);

  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<Tab> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: widget.w * 1,
          height: 50,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 12,
                  color: const Color(0xff2f2e41),
                ),
                textAlign: TextAlign.left,
              ),
              widget.f
            ],
          ),
        ),
      ),
    );
  }
}

class ReminderSetting extends StatefulWidget {
  final String uid;
  ReminderSetting(this.uid);

  @override
  _ReminderSettingState createState() => _ReminderSettingState();
}

class _ReminderSettingState extends State<ReminderSetting> {
  bool lowStockAlert = false, gstr1 = false, gstr3b = false;
  var reminderSettings = new ReminderSettings(false, false, false);
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    Future<void> setf() async {
      await FirebaseFirestore.instance
          .collection("userData")
          .doc(widget.uid)
          .collection("ReminderSettings")
          .doc('reminderSettings')
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          FirebaseFirestore.instance
              .collection("userData")
              .doc(widget.uid)
              .collection("ReminderSettings")
              .doc('reminderSettings')
              .get()
              .then((value) {
            setState(() {
              lowStockAlert = value.data()['lowStockALert'];
              gstr1 = value.data()['gstr1'];
              gstr3b = value.data()['gstr3b'];
            });
          });
        } else {
          reminderSettings.lowStockALert = lowStockAlert;
          reminderSettings.gstr1 = gstr1;

          reminderSettings.gstr3b = gstr3b;
          // Call the user's CollectionReference to add a new user

          FirebaseFirestore.instance
              .collection("userData")
              .doc(widget.uid)
              .collection("ReminderSettings")
              .doc('reminderSettings')
              .set(reminderSettings.toJson());
        }
      });
    }

    setf();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;

    Future<void> reminderSettingsfc() async{
      reminderSettings.lowStockALert = lowStockAlert;
      reminderSettings.gstr1 = gstr1;

      reminderSettings.gstr3b = gstr3b;
      // Call the user's CollectionReference to add a new user
      final db = FirebaseFirestore.instance;
      return await db
          .collection("userData")
          .doc(widget.uid)
          .collection("ReminderSettings")
          .doc('reminderSettings')
          .set(reminderSettings.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Reminder Settings',
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
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Customize Invoice',
                style: TextStyle(
                  fontFamily: 'Bell MT',
                  fontSize: 18,
                  color: const Color(0xff2f2e41),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Tab(
                null,
                'Low Stock ALert',
                SizedBox(
                  width: 70,
                  height: 30,
                  child: Switch(
                    //initial value
                    value: lowStockAlert,
                    activeTrackColor: Color(0xff2F2E41),
                    activeColor: Colors.white,

                    inactiveThumbColor: Colors.white,

                    onChanged: (bool state) {
                      setState(() {
                        lowStockAlert = state;
                        reminderSettingsfc();
                      });

                      //Use it to manage the different states
                    },
                  ),
                ),
                w),
            Tab(
                null,
                'GSTR 1 Due Date Alert',
                SizedBox(
                  width: 70,
                  height: 30,
                  child: Switch(
                    //initial value
                    value: gstr1,
                    activeTrackColor: Color(0xff2F2E41),
                    activeColor: Colors.white,

                    inactiveThumbColor: Colors.white,

                    onChanged: (bool state) {
                      setState(() {
                        gstr1 = state;
                        reminderSettingsfc();
                      });

                      //Use it to manage the different states
                    },
                  ),
                ),
                w),
            Tab(
                null,
                'GSTR 3B Due Date Alert',
                SizedBox(
                  width: 70,
                  height: 100,
                  child: Switch(
                    //initial value
                    value: gstr3b,

                    activeTrackColor: Color(0xff2F2E41),
                    activeColor: Colors.white,

                    inactiveThumbColor: Colors.white,

                    onChanged: (bool state) {
                      setState(() {
                        gstr3b = state;
                        reminderSettingsfc();
                      });

                      //Use it to manage the different states
                    },
                  ),
                ),
                w),
          ],
        ),
      ),
    );
  }
}
