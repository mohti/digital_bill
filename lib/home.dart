import 'dart:async';

import 'package:adobe_xd/adobe_xd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalbillbook/Invoicestyle.dart';
import 'package:digitalbillbook/businessinfo.dart';
import 'package:digitalbillbook/customwidgets/homepageicon.dart';
import 'package:digitalbillbook/ewaybill/ewaybill1.dart';
import 'package:digitalbillbook/invoices/invoicefirst.dart';
import 'package:digitalbillbook/notification/notification.dart';
import 'package:digitalbillbook/parties/parties1.dart';
import 'package:digitalbillbook/plan/plandetails.dart';

import 'package:digitalbillbook/product/product1.dart';
import 'package:digitalbillbook/reports/lowstock.dart';
import 'package:digitalbillbook/reports/purchsesummary.dart';
import 'package:digitalbillbook/reports/report1.dart';
import 'package:digitalbillbook/reports/salesummary.dart';
import 'package:digitalbillbook/reports/stocksummary.dart';
import 'package:digitalbillbook/settings/settings.dart';
import 'package:digitalbillbook/signup_and_loginpages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'customwidgets/homepagetiles.dart';
import 'models/businessprofile.dart';
import 'models/invoicesettingsmodel.dart';
import 'models/plandetails.dart';

class Home extends StatefulWidget {
  final String uid;
  Home(this.uid);
  @override
  _HomeState createState() => _HomeState();
}

class Widgetfunction {
  final Widget w;
  final Function f;
  Widgetfunction(this.w, this.f);
}

List<String> row1 = ['home', 'Invoice', 'Parties', 'Reports'];
List<String> row2 = [
  'Invoice Style',
  'Products',
  'e-Way Bill',
  'Business Profile'
];
List<String> row3 = ['Notification', 'Settings', 'Support', 'Logout'];

class HomeIcons extends StatelessWidget {
  final List<Widgetfunction> l1, l2, l3;
  final List<String> s1, s2, s3;

  HomeIcons(this.l1, this.l2, this.l3, this.s1, this.s2, this.s3);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(children: [
          HomePageIcon(l1, s1, 0),
          SizedBox(
            height: 15,
          ),
          HomePageIcon(l2, s2, 0),
          SizedBox(
            height: 15,
          ),
          HomePageIcon(l3, s3, 0),
          SizedBox(
            height: 15,
          ),
        ]),
        Column(children: [
          HomePageIcon(l1, s1, 1),
          SizedBox(
            height: 15,
          ),
          HomePageIcon(l2, s2, 1),
          SizedBox(
            height: 15,
          ),
          HomePageIcon(l3, s3, 1),
          SizedBox(
            height: 15,
          ),
        ]),
        Column(children: [
          HomePageIcon(l1, s1, 2),
          SizedBox(
            height: 15,
          ),
          HomePageIcon(l2, s2, 2),
          SizedBox(
            height: 15,
          ),
          HomePageIcon(l3, s3, 2),
          SizedBox(
            height: 15,
          ),
        ]),
        Column(children: [
          HomePageIcon(l1, s1, 3),
          SizedBox(
            height: 15,
          ),
          HomePageIcon(l2, s2, 3),
          SizedBox(
            height: 15,
          ),
          HomePageIcon(l3, s3, 3),
          SizedBox(
            height: 15,
          ),
        ]),
      ],
    );
  }
}

class _HomeState extends State<Home> {
  bool allDataloaded = false;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    print('mohit home.dart  intilized  uid == ' + widget.uid);

    if (widget.uid != null) {
      String uid = widget.uid;
      check();
    } else {
      print('error occured ');

      // Toast('somthing  wrong')
    }
    super.initState();
  }

  String _downloadURL;

  final settings = new InvoiceSettingsmodel('', '');

  final db = FirebaseFirestore.instance;
  final businessNameController = TextEditingController();
  final phoneController = TextEditingController();
  final authorisedSignatureController = TextEditingController();
  final iconController = TextEditingController();
  final signatureController = TextEditingController();
  final businessStampController = TextEditingController();
  final emailController = TextEditingController();
  final gstNumberController = TextEditingController();
  final businesAddressController = TextEditingController();
  final industryTypeController = TextEditingController();
  final businessTypeController = TextEditingController();
  final bankNameController = TextEditingController();
  final ifscCodeController = TextEditingController();
  final accountNumberController = TextEditingController();

  int invoice;
  DateTime duration;
  final planName = TextEditingController();
  int ewaybillno;
  String subtitle01 = '';
  String subtitle02 = '';
  String subtitle03 = '';
  String subtitle11 = '';
  String subtitle12 = '';
  String subtitle13 = '';
  String subtitle21 = '';
  String subtitle22 = '';
  String subtitle23 = '';

  Future<Null> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
  }

  bool invoice0or1 = false;
  check() async {
    //db =  await FirebaseFirestore.instance;
    downloadURLExample(widget.uid);
    _getBusinessDetails(widget.uid);
    _getBusinessDetails2(widget.uid);
    _getBusinessDetails3(widget.uid);
    _getBusinessDetails4(widget.uid);
    _getBusinessDetails5(widget.uid);
    _getBusinessDetails6(widget.uid);
    await _getBusinessSalesDetailsMonth(widget.uid);
    setState(() {
      allDataloaded = true;
    });
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {
       totalamount = 0;
       totalproducts = 0;
       totalquantity = 0;
       totalAmountLastmonthsale = 0;
       totalproductsLastmonthsale = 0;
       totalquantityLastmonthsale = 0;
    });
    initState();
    // refreshData();
    // check();
    // setState(() {});
  }

  Future<void> downloadURLExample(String uid) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(uid + '/business/logo.png')
        .getDownloadURL();

    setState(() {
      print(downloadURL);
      _downloadURL = downloadURL;
    });
    // Within your widgets:
    // Image.network(downloadURL);
  }

  Future<Null> _getBusinessDetails2(String uid) async {
    await db
        .collection("userData")
        .doc(uid)
        .collection("PurchaseInvoice")
        .orderBy('sdate', descending: true)
        .get()
        .then((valuee) {
      setState(() {
        subtitle21 = valuee.docs.first.data()['invoiceno'] == null
            ? ' '
            : 'Invoice No. : ' + valuee.docs.first.data()['invoiceno'];
        subtitle22 = valuee.docs.first.data()['sname'] == null
            ? ''
            : 'Buyer Name : ' + valuee.docs.first.data()['sname'];
        subtitle23 =
            valuee.docs.first.data()['listOfProducts'][0]['totalamount'] == null
                ? ''
                : 'Amount : ' +
                    valuee.docs.first.data()['listOfProducts'][0]
                        ['totalamount'];
      });
    });
  }

  Future<Null> _getBusinessDetails3(String uid) async {
    await db
        .collection("userData")
        .doc(uid)
        .collection("Invoice")
        .orderBy('sdate', descending: true)
        .get()
        .then((valuee) {
      setState(() {
        subtitle11 = 'Invoice No. : ' + valuee.docs.first.data()['invoiceno'];
        subtitle12 = 'Buyer Name : ' + valuee.docs.first.data()['sname'];
        subtitle13 = 'Amount : ' +
            valuee.docs.first.data()['listOfProducts'][0]['totalamount'];
      });
    });
  }

  Future<Null> _checkifDataexists(String uid) async {
    await FirebaseFirestore.instance
        .collection('userData')
        .doc('Q2LgkWSZoYb4wTNTJNllkqTAWqm2')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
        print('Document data: ${documentSnapshot.data()}');
      }
    });
  }

  Future<Null> setUpdatabase(String uid) async {
    final db = FirebaseFirestore.instance;
    print('setupdatabase mohit');

    print('document does esixts mohit');
    print(uid.toString() + 'mohit');
    final businessInfo = new BusinessProfile(
        '', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');

    final plandetails = new PlanDetails('Free Trial',
        DateTime.now().add(Duration(days: 31)), DateTime.now(), 100, 100);

    await db
        .collection("userData")
        .doc(uid)
        .collection("planDetails")
        .doc('plan')
        .set(plandetails.toJson());

    await db
        .collection("userData")
        .doc(uid)
        .collection("invoiceSettings")
        .doc('invoiceSettings')
        .set(settings.toJson());
    // Call the user's CollectionReference to add a new user
    await db
        .collection("userData")
        .doc(uid)
        .collection("BusinessInfo")
        .doc('businessName')
        .set(businessInfo.toJson());
    await db
        .collection("userData")
        .doc(uid)
        .collection("termsAndConditiononInvoice")
        .doc('termsAndConditiononInvoice')
        .set({'termsAndCondition': ''});
  }

  Future<Null> _getBusinessDetails4(String uid) async {
    await db
        .collection("userData")
        .doc(uid)
        .collection("Product")
        .where("quantity", isLessThanOrEqualTo: 100)
        .get()
        .then((valuee) {
      setState(() {
        subtitle01 = 'Product Name: ' + valuee.docs.first.data()['productName'];
        subtitle02 = 'Product Code: ' + valuee.docs.first.data()['productCode'];
        subtitle03 = 'Remaining Quantity: ' +
            valuee.docs.first.data()['quantity'].toString();
      });
    });
  }

  double totalamount = 0;
  int totalproducts = 0;
  int totalquantity = 0;
  double totalAmountLastmonthsale = 0;
  // String totalAmountLastmonthsales =
  //     totalAmountLastmonthsale.toString().split('.');
  int totalproductsLastmonthsale = 0;

  int totalquantityLastmonthsale = 0;

  Future<Null> _getBusinessDetails5(String uid) async {
    await db
        .collection("userData")
        .doc(uid)
        .collection("Product")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          totalamount = totalamount + doc.get('totalAmount');
          totalproducts = totalproducts + 1;
          totalquantity = totalquantity + doc['quantity'];
        });
      });
    });
  }

  var date = DateTime.now();
  Future<Null> _getBusinessSalesDetailsMonth(String uid) async {
    print('MOHIT sale statere');
    await db
        .collection("userData")
        .doc(uid)
        .collection("Invoice")
        .where('sdate',
            isGreaterThanOrEqualTo: new DateTime(date.year, date.month, 1))
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          print('MOHIT' + doc['listOfProducts'][0]['totalamount'].toString());
          totalAmountLastmonthsale = totalAmountLastmonthsale +
              double.parse(doc['listOfProducts'][0]['totalamount']);
          totalproductsLastmonthsale = totalproductsLastmonthsale + 1;
          totalquantityLastmonthsale = totalquantityLastmonthsale +
              int.tryParse(doc['listOfProducts'][0]['quantity']);
          print(totalamount.toString() + 'MOHIT');
        });
      });
    });
  }

  Future<Null> _getBusinessDetails(String uid) async {
    await db
        .collection("userData")
        .doc(uid)
        .collection("BusinessInfo")
        .doc('businessName')
        .get()
        .then((valuee) {
      setState(() {
        bankNameController.text =
            valuee.data()['bankName'] == null ? '' : valuee.data()['bankName'];
        accountNumberController.text = valuee.data()['accountNumber'] == null
            ? ''
            : valuee.data()['accountNumber'];
        ifscCodeController.text =
            valuee.data()['ifscCode'] == null ? '' : valuee.data()['ifscCode'];

        businessNameController.text = valuee.data()['businessName'] == null
            ? ''
            : valuee.data()['businessName'];
        businesAddressController.text = valuee.data()['businessAddress'] == null
            ? ''
            : valuee.data()['businessAddress'];
        gstNumberController.text = valuee.data()['gstNumber'] == null
            ? ''
            : valuee.data()['gstNumber'];
        emailController.text =
            valuee.data()['email'] == null ? '' : valuee.data()['email'];
        phoneController.text =
            valuee.data()['phone'] == null ? '' : valuee.data()['phone'];
      });
    });
  }

  Future<Null> _getBusinessDetails6(String uid) async {
    await db
        .collection("userData")
        .doc(widget.uid)
        .collection("planDetails")
        .doc('plan')
        .get()
        .then((valuee) {
      setState(() {
        final Timestamp timestamp = (valuee.data()['duration']) as Timestamp;
        duration = timestamp.toDate();
        planName.text = valuee.data()['planName'];
        ewaybillno = valuee.data()['remainingewaybill'];
        invoice = valuee.data()['remaininginvoices'];
        allDataloaded = true;
      });
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    _getBusinessDetails(widget.uid);

    _getBusinessDetails6(widget.uid);
    _navigateAndDisplaySelection(BuildContext context) async {
      // Navigator.push returns a Future that completes after calling
      // Navigator.pop on the Selection Screen.
      final result = await Navigator.push(
        context,

        // Create the SelectionScreen in the next step.
        MaterialPageRoute(builder: (context) => InvoiceStyle()),
      );

      setState(() {
        invoice0or1 = result;
      });
    }

    List<Widgetfunction> l2 = [
      Widgetfunction(
        SvgPicture.string(
          '<svg viewBox="50.0 682.0 30.0 32.0" ><path transform="translate(50.0, 682.0)" d="M 30 3 L 30 21.00000190734863 C 30 22.65624809265137 28.74023628234863 24 27.18750190734863 24 L 24.375 24 L 24.375 11.00000095367432 C 24.375 8.243749618530273 22.271484375 6 19.6875 6 L 7.5 6 L 7.5 3 C 7.5 1.34375011920929 8.759765625 0 10.3125 0 L 27.18750190734863 0 C 28.74023628234863 0 30 1.34375011920929 30 3 Z M 22.5 11.00000095367432 L 22.5 29 C 22.5 30.65625 21.24023628234863 32 19.6875 32 L 2.8125 32 C 1.259765625 32 0 30.65625 0 29 L 0 11.00000095367432 C 0 9.343750953674316 1.259765625 8 2.8125 8 L 19.6875 8 C 21.24023628234863 8 22.5 9.343750953674316 22.5 11.00000095367432 Z M 18.515625 12.75 C 18.515625 12.33750057220459 18.19921875 12 17.8125 12 L 4.453125 12 C 4.06640625 12 3.75 12.33750057220459 3.75 12.75 L 3.75 16 L 18.515625 16 L 18.515625 12.75 Z" fill="none" stroke="#f1f3f6" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
          allowDrawingOutsideViewBox: true,
        ),
        () {
          _navigateAndDisplaySelection(context);
        },
      ),
      Widgetfunction(
        SvgPicture.string(
          '<svg viewBox="145.0 682.0 30.0 32.0" ><path transform="translate(139.0, 679.0)" d="M 24.74999809265137 3.000000238418579 L 9.75 3.000000238418579 C 7.687499523162842 3.000000238418579 6.018750190734863 4.440000057220459 6.018750190734863 6.200000286102295 L 5.999999523162842 31.80000114440918 C 5.999999523162842 33.55999755859375 7.668749332427979 35 9.731249809265137 35 L 32.25 35 C 34.3125 35 36 33.55999755859375 36 31.80000114440918 L 36 12.60000133514404 L 24.74999809265137 3.000000238418579 Z M 28.49999809265137 25.39999961853027 L 22.87499809265137 25.39999961853027 L 22.87499809265137 30.20000267028809 L 19.12499809265137 30.20000267028809 L 19.12499809265137 25.39999961853027 L 13.5 25.39999961853027 L 13.5 22.19999885559082 L 19.12499809265137 22.19999885559082 L 19.12499809265137 17.39999961853027 L 22.87499809265137 17.39999961853027 L 22.87499809265137 22.19999885559082 L 28.49999809265137 22.19999885559082 L 28.49999809265137 25.39999961853027 Z M 22.87499809265137 14.20000076293945 L 22.87499809265137 5.400000095367432 L 33.1875 14.20000076293945 L 22.87499809265137 14.20000076293945 Z" fill="none" stroke="#f1f3f6" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
          allowDrawingOutsideViewBox: true,
        ),
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Product1(widget.uid)),
        ).then((value) {
          setState(() {});
        }),
      ),
      Widgetfunction(
          SvgPicture.string(
            '<svg viewBox="236.1 686.0 36.0 24.0" ><path transform="translate(236.1, 683.75)" d="M 34.94812774658203 13.24821472167969 L 31.65750122070312 10.11428546905518 C 30.98250198364258 9.471428871154785 30.06562423706055 9.112499237060547 29.109375 9.112499237060547 L 27 9.112499237060547 L 27 3.964285612106323 C 27 3.016071557998657 26.19562339782715 2.25 25.19999885559082 2.25 L 1.799999952316284 2.25 C 0.8043749928474426 2.25 0 3.016071557998657 0 3.964285612106323 L 0 21.96428489685059 C 0 24.33214378356934 2.013750076293945 26.25 4.5 26.25 C 5.979374885559082 26.25 7.278749465942383 25.55892944335938 8.09999942779541 24.51428604125977 C 8.921250343322754 25.56428527832031 10.22062587738037 26.25 11.69999980926514 26.25 C 14.18625068664551 26.25 16.19999885559082 24.33214378356934 16.19999885559082 21.96428489685059 C 16.19999885559082 21.66964340209961 16.16625022888184 21.38571548461914 16.11000061035156 21.10714340209961 L 25.28999900817871 21.10714340209961 C 25.22812652587891 21.38571548461914 25.20000076293945 21.66964340209961 25.20000076293945 21.96428489685059 C 25.20000076293945 24.33214378356934 27.2137508392334 26.25 29.69999885559082 26.25 C 32.18624877929688 26.25 34.20000076293945 24.33214378356934 34.20000076293945 21.96428489685059 C 34.20000076293945 21.66964340209961 34.16625213623047 21.38571548461914 34.11000061035156 21.10714340209961 L 35.09999847412109 21.10714340209961 C 35.59500122070312 21.10714340209961 36 20.72142791748047 36 20.25 L 36 15.66964244842529 C 36 14.7589282989502 35.62312698364258 13.89107131958008 34.94812774658203 13.24821472167969 Z M 4.5 23.6785717010498 C 3.509999752044678 23.6785717010498 2.699999809265137 22.90714263916016 2.699999809265137 21.96428489685059 C 2.699999809265137 21.02142906188965 3.509999752044678 20.25 4.5 20.25 C 5.490000247955322 20.25 6.299999713897705 21.02142906188965 6.299999713897705 21.96428489685059 C 6.299999713897705 22.90714263916016 5.490000247955322 23.6785717010498 4.5 23.6785717010498 Z M 11.69999980926514 23.6785717010498 C 10.70999908447266 23.6785717010498 9.899999618530273 22.90714263916016 9.899999618530273 21.96428489685059 C 9.899999618530273 21.02142906188965 10.70999908447266 20.25 11.69999980926514 20.25 C 12.6899995803833 20.25 13.5 21.02142906188965 13.5 21.96428489685059 C 13.5 22.90714263916016 12.6899995803833 23.6785717010498 11.69999980926514 23.6785717010498 Z M 27 11.6785717010498 L 29.109375 11.6785717010498 C 29.35125160217285 11.6785717010498 29.57625198364258 11.76964378356934 29.74500274658203 11.93035793304443 L 32.18062591552734 14.25 L 27 14.25 L 27 11.6785717010498 Z M 29.69999885559082 23.6785717010498 C 28.71000099182129 23.6785717010498 27.89999961853027 22.90714263916016 27.89999961853027 21.96428489685059 C 27.89999961853027 21.02142906188965 28.71000099182129 20.25 29.69999885559082 20.25 C 30.68999862670898 20.25 31.5 21.02142906188965 31.5 21.96428489685059 C 31.5 22.90714263916016 30.68999862670898 23.6785717010498 29.69999885559082 23.6785717010498 Z" fill="#2f2e41" stroke="#f1f3f6" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
            allowDrawingOutsideViewBox: true,
          ),
          (duration.isAfter(DateTime.now()))
              ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Ewaybill1(widget.uid)),
                  ).then((value) {
                    setState(() {});
                  })
              : () {
                  _scaffoldkey.currentState.showSnackBar(SnackBar(
                      content: Text('Plan Expired. please upgrade your plan')));
                }),
      Widgetfunction(
        // Adobe XD layer: 'Icon ionic-ios-pers…' (group)
        SizedBox(
          width: 32.0,
          height: 32.0,
          child: Stack(
            children: <Widget>[
              SvgPicture.string(
                '<svg viewBox="4.5 4.5 32.0 32.0" ><path  d="M 31.27619552612305 31.33333396911621 C 29.97613143920898 30.87499809265137 28.12604141235352 30.76666641235352 26.93431663513184 30.5 C 26.25094795227051 30.35000038146973 25.25923347473145 29.97499847412109 24.92588424682617 29.57500076293945 C 24.63420295715332 29.22500038146973 24.75087738037109 26.37499809265137 24.78421020507812 25.64166641235352 C 24.79254341125488 25.53333282470703 24.82587814331055 25.42500114440918 24.87587928771973 25.32500076293945 C 25.05922317504883 25.02500152587891 25.47591018676758 24.3083324432373 25.73425483703613 23.65833473205566 C 25.98426818847656 23.02500152587891 26.25094795227051 21.57500076293945 26.36762046813965 20.88333511352539 C 26.40095520019531 20.68333435058594 26.52596282958984 20.50833320617676 26.70096969604492 20.41666793823242 C 26.91764640808105 20.29166984558105 27.20932769775391 20.00833320617676 27.35100173950195 19.30000114440918 C 27.60934638977051 17.99166679382324 28.0177001953125 17.48333549499512 27.96769714355469 16.50833511352539 C 27.94269752502441 16.07500076293945 27.82602691650391 15.84166717529297 27.70101737976074 15.71666812896729 C 27.53434371948242 15.55833530426025 27.47600555419922 15.31666851043701 27.53434371948242 15.10000133514404 C 27.69268417358398 14.46666812896729 27.9260311126709 13.21666812896729 27.96769714355469 11.30000114440918 C 28.04270362854004 7.875000953674316 25.35923767089844 4.500000953674316 20.50899696350098 4.500000953674316 C 15.58375549316406 4.500000953674316 12.96695899963379 7.875000953674316 13.04196262359619 11.30000114440918 C 13.08363246917725 13.21666812896729 13.31697559356689 14.46666812896729 13.4669828414917 15.10000133514404 C 13.51698589324951 15.32500076293945 13.45864963531494 15.55833530426025 13.30030918121338 15.71666812896729 C 13.17530250549316 15.84166717529297 13.05029773712158 16.07500076293945 13.03362941741943 16.50833511352539 C 12.98362731933594 17.48333549499512 13.3919792175293 17.99166679382324 13.65032577514648 19.30000114440918 C 13.79199981689453 20.00000190734863 14.08368110656738 20.29166984558105 14.30035781860352 20.41666793823242 C 14.47536659240723 20.51666831970215 14.60037136077881 20.68333625793457 14.63370609283447 20.88333511352539 C 14.75037956237793 21.57500076293945 15.01705837249756 23.02500152587891 15.26707172393799 23.65833473205566 C 15.52541828155518 24.3083324432373 15.95044040679932 25.03333282470703 16.12544822692871 25.32500076293945 C 16.18378448486328 25.41666603088379 16.21711730957031 25.52500152587891 16.21711730957031 25.64166641235352 C 16.25045394897461 26.37499809265137 16.36712646484375 29.23333358764648 16.0754451751709 29.57500076293945 C 15.74209499359131 29.97499847412109 14.75037956237793 30.35000038146973 14.0670108795166 30.5 C 12.87528705596924 30.76666641235352 11.02519607543945 30.87499809265137 9.725130081176758 31.33333396911621 C 8.541739463806152 31.74999809265137 5.116570472717285 33.04166412353516 4.516541004180908 35.69166564941406 C 4.424869537353516 36.10833358764648 4.741551876068115 36.5 5.174906730651855 36.5 L 20.50899505615234 36.5 L 35.83475494384766 36.5 C 36.25976943969727 36.5 36.57645416259766 36.10833358764648 36.48478317260742 35.69166564941406 C 35.88475799560547 33.04166412353516 32.45958709716797 31.74999809265137 31.27619552612305 31.33333396911621 Z" fill="none" stroke="#f1f3f6" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                allowDrawingOutsideViewBox: true,
              ),
            ],
          ),
        ),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BusinessInfo(widget.uid),
          ),
        ).then((value) {
          setState(() {});
        }),
      )
    ];
    List<Widgetfunction> l = [
      Widgetfunction(
        SvgPicture.string(
          '<svg viewBox="44.7 585.0 38.0 36.0" ><path transform="translate(44.65, 582.75)" d="M 18.49512672424316 11.59286117553711 L 6.33277416229248 23.79645538330078 L 6.33277416229248 36.96765899658203 C 6.33277416229248 37.67781829833984 6.805325031280518 38.25351715087891 7.388247013092041 38.25351715087891 L 14.78051948547363 38.2302131652832 C 15.36138153076172 38.22667694091797 15.83072376251221 37.65200805664062 15.83071517944336 36.94435501098633 L 15.83071517944336 29.25251388549805 C 15.83071517944336 28.54235076904297 16.30326652526855 27.96665573120117 16.88619041442871 27.96665573120117 L 21.10808372497559 27.96665573120117 C 21.69100570678711 27.96665573120117 22.16355895996094 28.54235076904297 22.16355895996094 29.25251388549805 L 22.16355895996094 36.93872451782227 C 22.16267967224121 37.28045654296875 22.27349281311035 37.60855102539062 22.47152709960938 37.85056686401367 C 22.66956329345703 38.09258270263672 22.93852806091309 38.22860336303711 23.21903228759766 38.22860336303711 L 30.60866737365723 38.25351715087891 C 31.19158554077148 38.25351715087891 31.66414070129395 37.67781829833984 31.66414070129395 36.96765899658203 L 31.66414070129395 23.7876148223877 L 19.50442314147949 11.59286117553711 C 19.20987892150879 11.30361938476562 18.7896728515625 11.30361938476562 18.49512672424316 11.59286117553711 Z M 37.70672607421875 19.88744926452637 L 32.19187927246094 14.34941959381104 L 32.19187927246094 3.217909097671509 C 32.19187927246094 2.68528938293457 31.83746337890625 2.253515720367432 31.4002685546875 2.253515720367432 L 27.70611381530762 2.253515720367432 C 27.26892280578613 2.253515720367432 26.91450881958008 2.68528938293457 26.91450881958008 3.217909574508667 L 26.91450881958008 9.053291320800781 L 21.00847244262695 3.133524656295776 C 19.83958625793457 1.961693286895752 18.15336990356445 1.961693286895752 16.98448371887207 3.133524656295776 L 0.286230593919754 19.88744926452637 C -0.05089546367526054 20.2269115447998 -0.09816046059131622 20.83512687683105 0.1806834936141968 21.24563789367676 L 1.862844228744507 23.73698806762695 C 1.996382474899292 23.93480491638184 2.18902850151062 24.05978393554688 2.398293256759644 24.0843563079834 C 2.607558727264404 24.10893249511719 2.816252470016479 24.03108215332031 2.978348016738892 23.86798286437988 L 18.49512672424316 8.297849655151367 C 18.7896728515625 8.008610725402832 19.20987892150879 8.008610725402832 19.50442504882812 8.2978515625 L 35.02186965942383 23.86798286437988 C 35.35882949829102 24.20768928527832 35.85806655883789 24.15010833740234 36.13671112060547 23.7393970489502 L 37.81887054443359 21.248046875 C 37.95264053344727 21.04976844787598 38.01600646972656 20.79471397399902 37.99496459960938 20.53934860229492 C 37.97391510009766 20.28397750854492 37.87018203735352 20.04936599731445 37.70672988891602 19.88744926452637 Z" fill="none" stroke="#f1f3f6" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
          allowDrawingOutsideViewBox: true,
        ),
        null,
      ),
      Widgetfunction(
          SvgPicture.string(
            '<svg viewBox="147.3 588.0 26.0 30.0" ><path transform="translate(147.3, 588.0)" d="M 22.74999809265137 3.75 L 17.33333206176758 3.75 C 17.33333206176758 1.68164050579071 15.39010524749756 0 12.99999904632568 0 C 10.60989475250244 0 8.666666030883789 1.68164050579071 8.666666030883789 3.75 L 3.249999761581421 3.75 C 1.455729126930237 3.75 0 5.009765625 0 6.5625 L 0 27.1875 C 0 28.740234375 1.455729126930237 30 3.249999761581421 30 L 22.74999809265137 30 C 24.54426956176758 30 25.99999809265137 28.740234375 25.99999809265137 27.1875 L 25.99999809265137 6.5625 C 25.99999809265137 5.009765625 24.54426956176758 3.75 22.74999809265137 3.75 Z M 6.499999523162842 24.84375 C 5.599479198455811 24.84375 4.875 24.216796875 4.875 23.4375 C 4.875 22.658203125 5.599479198455811 22.03125 6.499999523162842 22.03125 C 7.400520801544189 22.03125 8.125 22.658203125 8.125 23.4375 C 8.125 24.216796875 7.400520801544189 24.84375 6.499999523162842 24.84375 Z M 6.499999523162842 19.21875 C 5.599479198455811 19.21875 4.875 18.591796875 4.875 17.8125 C 4.875 17.033203125 5.599479198455811 16.40625 6.499999523162842 16.40625 C 7.400520801544189 16.40625 8.125 17.033203125 8.125 17.8125 C 8.125 18.591796875 7.400520801544189 19.21875 6.499999523162842 19.21875 Z M 6.499999523162842 13.59375 C 5.599479198455811 13.59375 4.875 12.966796875 4.875 12.1875 C 4.875 11.408203125 5.599479198455811 10.78125 6.499999523162842 10.78125 C 7.400520801544189 10.78125 8.125 11.408203125 8.125 12.1875 C 8.125 12.966796875 7.400520801544189 13.59375 6.499999523162842 13.59375 Z M 12.99999904632568 2.34375 C 13.90052127838135 2.34375 14.62499904632568 2.970703125 14.62499904632568 3.75 C 14.62499904632568 4.529296875 13.90052127838135 5.15625 12.99999904632568 5.15625 C 12.09947967529297 5.15625 11.37499904632568 4.529296875 11.37499904632568 3.75 C 11.37499904632568 2.970703125 12.09947967529297 2.34375 12.99999904632568 2.34375 Z M 21.66666603088379 23.90625 C 21.66666603088379 24.16406631469727 21.42291450500488 24.375 21.12499809265137 24.375 L 11.37499904632568 24.375 C 11.0770845413208 24.375 10.83333301544189 24.16406631469727 10.83333301544189 23.90625 L 10.83333301544189 22.96875 C 10.83333301544189 22.7109375 11.0770845413208 22.5 11.37499904632568 22.5 L 21.12499809265137 22.5 C 21.42291450500488 22.5 21.66666603088379 22.7109375 21.66666603088379 22.96875 L 21.66666603088379 23.90625 Z M 21.66666603088379 18.28125 C 21.66666603088379 18.53906440734863 21.42291450500488 18.75 21.12499809265137 18.75 L 11.37499904632568 18.75 C 11.0770845413208 18.75 10.83333301544189 18.53906440734863 10.83333301544189 18.28125 L 10.83333301544189 17.34375 C 10.83333301544189 17.0859375 11.0770845413208 16.875 11.37499904632568 16.875 L 21.12499809265137 16.875 C 21.42291450500488 16.875 21.66666603088379 17.0859375 21.66666603088379 17.34375 L 21.66666603088379 18.28125 Z M 21.66666603088379 12.65625 C 21.66666603088379 12.9140625 21.42291450500488 13.125 21.12499809265137 13.125 L 11.37499904632568 13.125 C 11.0770845413208 13.125 10.83333301544189 12.9140625 10.83333301544189 12.65625 L 10.83333301544189 11.71875 C 10.83333301544189 11.46093654632568 11.0770845413208 11.25 11.37499904632568 11.25 L 21.12499809265137 11.25 C 21.42291450500488 11.25 21.66666603088379 11.46093654632568 21.66666603088379 11.71875 L 21.66666603088379 12.65625 Z" fill="none" stroke="#f1f3f6" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
            allowDrawingOutsideViewBox: true,
          ),
          duration.isAfter(DateTime.now())
              ? () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Invoicefirst(widget.uid, invoice0or1)))
                  .then((value) => onGoBack(value))
              : () {
                  _scaffoldkey.currentState.showSnackBar(SnackBar(
                      content: Text('Plan Expired. please upgrade your plan')));
                }),
      Widgetfunction(
        SizedBox(
          width: 32.0,
          height: 32.0,
          child: Stack(
            children: <Widget>[
              Pinned.fromSize(
                bounds: Rect.fromLTWH(0.0, 0.0, 32.0, 32.0),
                size: Size(32.0, 32.0),
                pinLeft: true,
                pinRight: true,
                pinTop: true,
                pinBottom: true,
                child: SvgPicture.string(
                  '<svg viewBox="4.5 4.5 32.0 32.0" ><path  d="M 31.2756404876709 31.33333396911621 C 29.97560501098633 30.875 28.12555122375488 30.76666641235352 26.93385124206543 30.5 C 26.25049781799316 30.35000038146973 25.25880432128906 29.97500038146973 24.92546272277832 29.57500076293945 C 24.63378715515137 29.22500038146973 24.75045776367188 26.375 24.78379058837891 25.64166641235352 C 24.79212379455566 25.53333473205566 24.82545852661133 25.42500114440918 24.87545967102051 25.32500076293945 C 25.05879783630371 25.02500152587891 25.47547721862793 24.3083324432373 25.73381614685059 23.65833473205566 C 25.98382377624512 23.02500152587891 26.25049781799316 21.57500076293945 26.36716651916504 20.88333511352539 C 26.40050315856934 20.6833324432373 26.52550506591797 20.50833511352539 26.70051002502441 20.41666793823242 C 26.91718292236328 20.29166793823242 27.2088565826416 20.00833511352539 27.35052871704102 19.30000114440918 C 27.60886764526367 17.99166679382324 28.01721382141113 17.48333549499512 27.96721267700195 16.50833511352539 C 27.94221305847168 16.07500076293945 27.82554244995117 15.84166717529297 27.70053863525391 15.71666717529297 C 27.53386688232422 15.55833435058594 27.47553253173828 15.3166675567627 27.53386688232422 15.10000228881836 C 27.69220542907715 14.46666717529297 27.92554473876953 13.21666717529297 27.96721267700195 11.30000114440918 C 28.04221725463867 7.875001430511475 25.35880661010742 4.500000953674316 20.5086669921875 4.500000953674316 C 15.58352565765381 4.500000953674316 12.96678352355957 7.875001430511475 13.04178619384766 11.30000114440918 C 13.08345317840576 13.21666717529297 13.31679344177246 14.46666717529297 13.46679782867432 15.10000228881836 C 13.51679992675781 15.32500076293945 13.45846462249756 15.55833435058594 13.30012702941895 15.71666717529297 C 13.17512321472168 15.84166717529297 13.05011940002441 16.07500076293945 13.03345203399658 16.50833511352539 C 12.98344993591309 17.48333549499512 13.39179515838623 17.99166679382324 13.65013599395752 19.30000114440918 C 13.79180717468262 20.00000190734863 14.08348178863525 20.29166793823242 14.3001537322998 20.41666793823242 C 14.47515964508057 20.51666831970215 14.60016250610352 20.68333625793457 14.63349723815918 20.88333511352539 C 14.75016689300537 21.57500076293945 15.01684188842773 23.02500152587891 15.26684856414795 23.65833473205566 C 15.52518939971924 24.3083324432373 15.95020198822021 25.03333473205566 16.12520790100098 25.32500076293945 C 16.18354225158691 25.41666603088379 16.21687698364258 25.52500152587891 16.21687698364258 25.64166641235352 C 16.25020980834961 26.375 16.36688041687012 29.23333168029785 16.07520484924316 29.57500076293945 C 15.74186229705811 29.97500038146973 14.75016689300537 30.35000038146973 14.06681346893311 30.5 C 12.87511348724365 30.76666641235352 11.02505970001221 30.875 9.725022315979004 31.33333396911621 C 8.541655540466309 31.74999809265137 5.116558074951172 33.04166793823242 4.516541004180908 35.69166946411133 C 4.424871444702148 36.10833358764648 4.741547107696533 36.5 5.174892902374268 36.5 L 20.50866508483887 36.5 L 35.83409881591797 36.5 C 36.25910949707031 36.5 36.57578659057617 36.10833358764648 36.48411560058594 35.69166946411133 C 35.88410568237305 33.04166793823242 32.45900726318359 31.74999809265137 31.2756404876709 31.33333396911621 Z" fill="none" stroke="#f1f3f6" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
              Pinned.fromSize(
                bounds: Rect.fromLTWH(25.3, 16.8, 6.8, 6.8),
                size: Size(32.0, 32.0),
                pinRight: true,
                fixedWidth: true,
                fixedHeight: true,
                child: SvgPicture.string(
                  '<svg viewBox="29.8 21.3 6.8 6.8" ><path transform="translate(5.0, 3.33)" d="M 30.76171875 20.63671875 L 28.86328125 20.63671875 L 28.86328125 18.73828125 C 28.86328125 18.33046913146973 28.53281211853027 18 28.125 18 L 28.125 18 C 27.71718788146973 18 27.38671875 18.33046913146973 27.38671875 18.73828125 L 27.38671875 20.63671875 L 25.48828125 20.63671875 C 25.08046913146973 20.63671875 24.75 20.96718788146973 24.75 21.375 L 24.75 21.375 C 24.75 21.78281211853027 25.08046913146973 22.11328125 25.48828125 22.11328125 L 27.38671875 22.11328125 L 27.38671875 24.01171875 C 27.38671875 24.41953086853027 27.71718788146973 24.75 28.125 24.75 L 28.125 24.75 C 28.53281211853027 24.75 28.86328125 24.41953086853027 28.86328125 24.01171875 L 28.86328125 22.11328125 L 30.76171875 22.11328125 C 31.16953086853027 22.11328125 31.5 21.78281211853027 31.5 21.375 L 31.5 21.375 C 31.5 20.96718788146973 31.16953086853027 20.63671875 30.76171875 20.63671875 Z" fill="none" stroke="#f1f3f6" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Parties1(widget.uid)),
        ),
      ),
      Widgetfunction(
          SizedBox(
            width: 25.0,
            height: 27.0,
            child: Stack(
              children: <Widget>[
                SvgPicture.string(
                  '<svg viewBox="9.0 6.0 25.4 26.6" ><path transform="translate(7.44, 0.99)" d="M 27 31.64825439453125 L 27 15" fill="none" stroke="#f1f3f6" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /><path transform="translate(3.72, 0.0)" d="M 18 32.63720703125 L 18 6" fill="none" stroke="#f1f3f6" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /><path transform="translate(0.0, 1.65)" d="M 9 30.98895263671875 L 9 21" fill="none" stroke="#f1f3f6" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                  allowDrawingOutsideViewBox: true,
                ),
              ],
            ),
          ),
          () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Report1(widget.uid)),
              )),
    ];

    List<Widgetfunction> l3 = [
      Widgetfunction(
        SvgPicture.string(
          '<svg viewBox="51.0 779.0 28.0 28.0" ><path transform="translate(47.96, 775.25)" d="M 10.83838081359863 6.018717765808105 L 8.830356597900391 3.965384721755981 C 5.460246562957764 6.593077659606934 3.241589784622192 10.64230728149414 3.045000076293945 15.23717880249023 L 5.8534255027771 15.23717880249023 C 6.06405782699585 11.43205070495605 7.973787784576416 8.10076904296875 10.83838081359863 6.018717765808105 Z M 28.2365779876709 15.23717880249023 L 31.04500007629395 15.23717880249023 C 30.83436965942383 10.64230728149414 28.61571502685547 6.59307861328125 25.25964546203613 3.96538519859314 L 23.26565933227539 6.018718719482422 C 26.10217094421387 8.10076904296875 28.02593994140625 11.43205070495605 28.236572265625 15.23717880249023 Z M 25.47027778625488 15.95512676239014 C 25.47027778625488 11.5469217300415 23.1673698425293 7.856667518615723 19.15132331848145 6.880256652832031 L 19.15132331848145 5.903846740722656 C 19.15132331848145 4.712052345275879 18.21050071716309 3.750000715255737 17.04500198364258 3.750000715255737 C 15.8795051574707 3.750000715255737 14.93868541717529 4.712052345275879 14.93868541717529 5.903846740722656 L 14.93868541717529 6.880256652832031 C 10.90859222412109 7.856667518615723 8.619724273681641 11.53256320953369 8.619724273681641 15.95512676239014 L 8.619724273681641 23.13461685180664 L 5.811299324035645 26.00641059875488 L 5.811299324035645 27.44231033325195 L 28.27870559692383 27.44231033325195 L 28.27870559692383 26.00641059875488 L 25.47027778625488 23.13461685180664 L 25.47027778625488 15.95512676239014 Z M 17.04500198364258 31.75 C 17.24159240722656 31.75 17.42414093017578 31.73564147949219 17.606689453125 31.69256210327148 C 18.51942825317383 31.49153709411621 19.2636604309082 30.85974502563477 19.62875556945801 29.99820327758789 C 19.7691764831543 29.65358734130859 19.83938789367676 29.28025436401367 19.83938789367676 28.87820243835449 L 14.22253513336182 28.87820243835449 C 14.23657894134521 30.45768928527832 15.48632717132568 31.75 17.04500198364258 31.75 Z" fill="none" stroke="#f1f3f6" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
          allowDrawingOutsideViewBox: true,
        ),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationPage(widget.uid),
          ),
        ).then((value) {
          setState(() {});
        }),
      ),
      Widgetfunction(
        // Adobe XD layer: 'Icon feather-settin…' (group)
        SizedBox(
          width: 33.0,
          height: 33.0,
          child: Stack(
            children: <Widget>[
              Pinned.fromSize(
                bounds: Rect.fromLTWH(12.0, 12.0, 9.0, 9.0),
                size: Size(33.0, 33.0),
                fixedWidth: true,
                fixedHeight: true,
                child: SvgPicture.string(
                  '<svg viewBox="13.5 13.5 9.0 9.0" ><path  d="M 22.5 18 C 22.5 20.48528099060059 20.48528099060059 22.5 18 22.5 C 15.51471900939941 22.5 13.5 20.48528099060059 13.5 18 C 13.5 15.51471900939941 15.51471900939941 13.5 18 13.5 C 20.48528099060059 13.5 22.5 15.51471900939941 22.5 18 Z" fill="none" stroke="#f1f3f6" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
              Pinned.fromSize(
                bounds: Rect.fromLTWH(0.0, 0.0, 33.0, 33.0),
                size: Size(33.0, 33.0),
                pinLeft: true,
                pinRight: true,
                pinTop: true,
                pinBottom: true,
                child: SvgPicture.string(
                  '<svg viewBox="1.5 1.5 33.0 33.0" ><path  d="M 29.10000038146973 22.5 C 28.69148063659668 23.42563438415527 28.88750076293945 24.50672149658203 29.59499931335449 25.23000144958496 L 29.68500137329102 25.31999969482422 C 30.24833297729492 25.8827075958252 30.56486129760742 26.64627456665039 30.56486129760742 27.44250106811523 C 30.56486129760742 28.23872756958008 30.24833297729492 29.00229454040527 29.68500328063965 29.56500053405762 C 29.12229919433594 30.12833023071289 28.35873222351074 30.44485855102539 27.56250381469727 30.44485855102539 C 26.76627922058105 30.44485855102539 26.00271224975586 30.12833023071289 25.44000625610352 29.56500053405762 L 25.35000228881836 29.47499847412109 C 24.62672424316406 28.76749801635742 23.54563903808594 28.57147789001465 22.62000465393066 28.97999572753906 C 21.71330070495605 29.36860084533691 21.12393951416016 30.2585334777832 21.12000274658203 31.24499702453613 L 21.12000274658203 31.5 C 21.12000274658203 33.15685272216797 19.77685737609863 34.5 18.12000274658203 34.5 C 16.46314811706543 34.5 15.12000274658203 33.15685272216797 15.12000274658203 31.5 L 15.12000274658203 31.36499977111816 C 15.09623718261719 30.34900665283203 14.45380878448486 29.45079803466797 13.50000095367432 29.10000228881836 C 12.57436656951904 28.69147872924805 11.4932804107666 28.88750076293945 10.77000045776367 29.59500122070312 L 10.68000030517578 29.68500137329102 C 10.11729621887207 30.24833297729492 9.353728294372559 30.56486129760742 8.557500839233398 30.56486129760742 C 7.761273384094238 30.56486129760742 6.997705936431885 30.24833297729492 6.435001373291016 29.68500137329102 C 5.871670722961426 29.1222972869873 5.555142402648926 28.35873222351074 5.555142402648926 27.56250381469727 C 5.555142402648926 26.76627731323242 5.871670722961426 26.00271034240723 6.435000896453857 25.44000434875488 L 6.52500057220459 25.35000228881836 C 7.232498168945312 24.62672424316406 7.428519725799561 23.54563903808594 7.020000457763672 22.62000465393066 C 6.631399154663086 21.71329879760742 5.74146556854248 21.12393951416016 4.755000591278076 21.12000465393066 L 4.5 21.12000274658203 C 2.843145608901978 21.12000274658203 1.5 19.77685737609863 1.5 18.12000274658203 C 1.5 16.46314811706543 2.843146324157715 15.12000274658203 4.500000476837158 15.12000274658203 L 4.635000228881836 15.12000274658203 C 5.650995254516602 15.0962381362915 6.549203872680664 14.45380973815918 6.90000057220459 13.50000095367432 C 7.308519840240479 12.57436561584473 7.11249828338623 11.4932804107666 6.404999732971191 10.77000045776367 L 6.315000057220459 10.68000030517578 C 5.751669883728027 10.11729621887207 5.435140609741211 9.353729248046875 5.435140609741211 8.557501792907715 C 5.435140609741211 7.76127290725708 5.751669406890869 6.997705459594727 6.315000534057617 6.435000419616699 C 6.877705574035645 5.871669769287109 7.641273021697998 5.555140972137451 8.437500953674316 5.555141448974609 C 9.23372745513916 5.555141448974609 9.997295379638672 5.871669769287109 10.55999946594238 6.435000896453857 L 10.64999961853027 6.52500057220459 C 11.37328052520752 7.232499122619629 12.45436477661133 7.428519725799561 13.3799991607666 7.020000457763672 L 13.5 7.020000457763672 C 14.40670680999756 6.63139820098877 14.99606609344482 5.741464614868164 15 4.755000591278076 L 15 4.5 C 15 2.843145608901978 16.3431453704834 1.499999523162842 18 1.5 C 19.6568546295166 1.5 21 2.843145847320557 21 4.5 L 21 4.635000228881836 C 21.00393486022949 5.621465682983398 21.59329605102539 6.511398792266846 22.50000190734863 6.900001049041748 C 23.42563629150391 7.308520317077637 24.50672149658203 7.112499713897705 25.23000144958496 6.405000686645508 L 25.31999969482422 6.315000534057617 C 25.8827075958252 5.751670360565186 26.64627456665039 5.435142517089844 27.44250106811523 5.435142517089844 C 28.23872756958008 5.435142517089844 29.00229454040527 5.751670837402344 29.56499862670898 6.315000534057617 C 30.12833023071289 6.877706050872803 30.44485855102539 7.641273498535156 30.44485855102539 8.437500953674316 C 30.44485855102539 9.233728408813477 30.12833023071289 9.997295379638672 29.56499862670898 10.5600004196167 L 29.47499847412109 10.65000057220459 C 28.76749801635742 11.3732795715332 28.57147789001465 12.45436477661133 28.97999572753906 13.38000106811523 L 28.9799976348877 13.5 C 29.36860084533691 14.40670680999756 30.2585334777832 14.99606513977051 31.24499702453613 15 L 31.5 15 C 33.15685272216797 15 34.5 16.3431453704834 34.5 18 C 34.5 19.6568546295166 33.15685272216797 21 31.5 21 L 31.36499977111816 21 C 30.37853813171387 21.00393676757812 29.48860549926758 21.59329605102539 29.10000419616699 22.50000190734863 Z" fill="none" stroke="#f1f3f6" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Settings1(widget.uid),
          ),
        ).then((value) {
          setState(() {});
        }),
      ),
      Widgetfunction(
          // Adobe XD layer: 'Icon ionic-ios-chat…' (group)
          SizedBox(
            width: 32.0,
            height: 32.0,
            child: Stack(
              children: <Widget>[
                SvgPicture.string(
                  '<svg viewBox="3.4 3.4 32.0 32.0" ><path transform="translate(0.78, 0.81)" d="M 31.66764450073242 11.98125076293945 L 14.61740779876709 11.98125076293945 C 13.00163555145264 11.98125076293945 11.68593692779541 13.29673480987549 11.68593692779541 14.91224193572998 L 11.68593692779541 26.78236770629883 C 11.68593692779541 28.39787483215332 13.00163555145264 29.70566368103027 14.61740779876709 29.70566368103027 L 24.37359046936035 29.70566368103027 C 24.58902549743652 29.70566368103027 24.80445861816406 29.79798126220703 24.95834350585938 29.95183753967285 L 29.80566024780273 34.42140579223633 C 30.07495307922363 34.68296432495117 30.52121543884277 34.57526397705078 30.52121543884277 34.19831085205078 L 30.52121543884277 30.30570983886719 C 30.52121543884277 29.84413719177246 30.81359100341797 29.69797134399414 31.27523994445801 29.69797134399414 L 31.35218238830566 29.69797134399414 C 32.96795272827148 29.69797134399414 34.59141540527344 28.39787483215332 34.59141540527344 26.77467346191406 L 34.59141540527344 14.91224193572998 C 34.59911346435547 13.28904151916504 33.28341674804688 11.98125076293945 31.66764450073242 11.98125076293945 Z" fill="none" stroke="#f1f3f6" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.0, 0.0)" d="M 13.10040473937988 10.90633773803711 L 26.74982643127441 10.90633773803711 L 26.74982643127441 5.882882118225098 C 26.74982643127441 4.498161792755127 25.62648010253906 3.375 24.24153327941895 3.375 L 5.883293151855469 3.375 C 4.498345375061035 3.375 3.374999761581421 4.498161792755127 3.374999761581421 5.882882118225098 L 3.374999761581421 18.5915355682373 C 3.374999761581421 19.97625541687012 4.498345375061035 21.09941673278809 5.883293151855469 21.09941673278809 L 10.58441829681396 21.09941673278809 L 10.58441829681396 13.41422080993652 C 10.59211158752441 12.02950000762939 11.71545791625977 10.90633773803711 13.10040473937988 10.90633773803711 Z" fill="none" stroke="#f1f3f6" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  allowDrawingOutsideViewBox: true,
                ),
              ],
            ),
          ),
          () => Navigator.pushNamed(context, './support')),
      Widgetfunction(
          // Adobe XD layer: 'Icon ionic-ios-pers…' (group)
          // Adobe XD layer: 'Icon feather-power' (group)
          SizedBox(
            width: 24.0,
            height: 28.0,
            child: Stack(
              children: <Widget>[
                SvgPicture.string(
                  '<svg viewBox="4.5 3.0 24.0 28.0" ><path transform="translate(0.0, -0.46)" d="M 24.97917175292969 9.95999813079834 C 29.66433525085449 14.88031101226807 29.66350936889648 22.85627937316895 24.97732543945312 27.7755184173584 C 20.29113578796387 32.69475936889648 12.69386672973633 32.69475555419922 8.007682800292969 27.7755184173584 C 3.321494817733765 22.85627746582031 3.320669889450073 14.88031101226807 8.005839347839355 9.959997177124023" fill="none" stroke="#f1f3f6" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /><path transform="translate(-1.5, 0.0)" d="M 18 3.000000715255737 L 18 16.99794960021973" fill="none" stroke="#f1f3f6" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                  allowDrawingOutsideViewBox: true,
                ),
              ],
            ),
          ),
          () => _signOut()),
    ];

    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _scaffoldkey,
        body: allDataloaded
            ? SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Card(
                          elevation: 6,
                          child: Container(
                              width: w * 0.95,
                              height: MediaQuery.of(context).size.height * 0.19,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(children: [
                                    Row(children: [
                                      Container(
                                        width: w * 0.31,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 35,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Business Info",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              //color: Colors.black,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 8, 10, 0),
                                              child: Container(
                                                height: 80,
                                                width: w * 0.25,
                                                // child: RaisedButton(
                                                child: (_downloadURL == null)
                                                    ? InkWell(
                                                        // width: w * 0.24,
                                                        onTap: () =>
                                                            (downloadURLExample(
                                                                widget.uid)),
                                                        child: Container(),
                                                        // Text("Tab to Retry"),
                                                      )
                                                    : Image.network(
                                                        _downloadURL,
                                                      ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                          width: w * 0.558,
                                          child: Column(children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    businessNameController.text,
                                                    style: TextStyle(
                                                      fontFamily: 'Arial',
                                                      fontSize: 22,
                                                      color: const Color(
                                                          0xff2f2e41),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    businesAddressController
                                                        .text,
                                                    style: TextStyle(
                                                      fontFamily: 'Arial',
                                                      fontSize: 10,
                                                      color: const Color(
                                                          0xe5707070),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    gstNumberController.text,
                                                    style: TextStyle(
                                                      fontFamily: 'Arial',
                                                      fontSize: 10,
                                                      color: const Color(
                                                          0xe5707070),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    phoneController.text,
                                                    style: TextStyle(
                                                      fontFamily: 'Arial',
                                                      fontSize: 10,
                                                      color: const Color(
                                                          0xe5707070),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    emailController.text,
                                                    style: TextStyle(
                                                      fontFamily: 'Arial',
                                                      fontSize: 10,
                                                      color: const Color(
                                                          0xe5707070),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Positioned(
                                            //   right: 2,
                                            //   bottom: 2,
                                            //   child:
                                          ]),
                                        ),
                                      ),
                                    ]),
                                    Positioned(
                                      right: 2,
                                      bottom: 2,
                                      child: Container(
                                        alignment: Alignment.bottomRight,
                                        padding: EdgeInsets.all(1),
                                        child: InkWell(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BusinessInfo(widget.uid),
                                            ),
                                          ),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 60,
                                            height: 20,
                                            child: Text(
                                              'View More',
                                              style: TextStyle(
                                                fontFamily: 'Bell MT',
                                                fontSize: 10,
                                                color: const Color(0xe5dde8f8),
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(11.0),
                                              color: const Color(0xd902020a),
                                              border: Border.all(
                                                  width: 1.0,
                                                  color:
                                                      const Color(0xd93f3d56)),
                                            ),
                                          ),
                                          // ),
                                        ),
                                      ),
                                    )
                                  ])),
                              color: Color.fromRGBO(241, 243, 246, 1)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            HomePageTiles(
                              homescreentilesicon[0],
                              'Low Stock',
                              subtitle01,
                              subtitle02,
                              subtitle03,
                              () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LowStock(widget.uid))).then((value) {
                                setState(() {});
                              }),
                            ),
                            HomePageTiles(
                              homescreentilesicon[1],
                              'Last Sale Details',
                              subtitle11,
                              subtitle12,
                              subtitle13,
                              () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SalesSummary(widget.uid)))
                                  .then((value) {
                                setState(() {});
                              }),
                            ),
                            HomePageTiles(
                              homescreentilesicon[2],
                              'Last Purchase Details',
                              subtitle21,
                              subtitle22,
                              subtitle23,
                              () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PurchaseSummary(widget.uid)))
                                  .then((value) {
                                setState(() {});
                              }),
                            ),
                            HomePageTiles(
                              homescreentilesicon[3],
                              'Stock Value',
                              'Total Product :' + totalproducts.toString(),
                              'Quantity : ' + totalquantity.toString(),
                              'Amount : ' + totalamount.toStringAsFixed(2),
                              () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StockSummary(widget.uid)))
                                  .then((value) {
                                setState(() {});
                              }),
                            ),
                            HomePageTiles(
                              homescreentilesicon[4],
                              'This Month\'s Sale',
                              'Total Sales :' +
                                  totalproductsLastmonthsale.toString(),
                              'Quantity : ' +
                                  totalquantityLastmonthsale.toString(),
                              'Amount : ' +
                                  totalAmountLastmonthsale.toStringAsFixed(2),
                              () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SalesSummary(widget.uid)))
                                  .then((value) {
                                setState(() {});
                              }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: w * 0.93,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xfff1D55C5).withOpacity(1),
                              Color(0xfff2F508C).withOpacity(1)
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: w * 0.2,
                              child: SvgPicture.string(
                                '<svg viewBox="44.5 454.6 43.6 54.9" ><path transform="translate(40.0, 450.11)" d="M 43.52875518798828 4.5 L 9.038227081298828 4.5 C 6.531877517700195 4.5 4.5 7.061384201049805 4.5 10.22120666503906 L 4.5 53.70237731933594 C 4.5 56.86220169067383 6.531877517700195 59.423583984375 9.038227081298828 59.423583984375 L 43.52875518798828 59.423583984375 C 46.03522109985352 59.423583984375 48.06698226928711 56.86220169067383 48.06698226928711 53.70237731933594 L 48.06698226928711 10.22120666503906 C 48.06698226928711 7.061384201049805 46.03521728515625 4.5 43.52875518798828 4.5 Z M 31.7293643951416 47.98117065429688 L 13.57645511627197 47.98117065429688 L 13.57645511627197 41.11572265625 L 31.7293643951416 41.11572265625 L 31.7293643951416 47.98117065429688 Z M 38.99052810668945 35.39451599121094 L 13.57645511627197 35.39451599121094 L 13.57645511627197 28.52906799316406 L 38.99052810668945 28.52906799316406 L 38.99052810668945 35.39451599121094 Z M 38.99052810668945 22.807861328125 L 13.57645511627197 22.807861328125 L 13.57645511627197 15.94241333007812 L 38.99052810668945 15.94241333007812 L 38.99052810668945 22.807861328125 Z" fill="none" stroke="#f1f3f6" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                allowDrawingOutsideViewBox: true,
                              ),
                            ),
                            Container(
                              width: w * 0.7,
                              height: 160,
                              child: Stack(children: [
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Your Plan - ' + planName.text,
                                        style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontSize: 20,
                                          color: const Color(0xfff2f2f2),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '     Exp. Date:               ' +
                                            DateFormat('dd/MM/yyyy')
                                                .format(duration)
                                                .toString(),
                                        style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontSize: 10,
                                          color: const Color(0xe5ffffff),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '     Remaining Plan :    ' +
                                            invoice.toString() +
                                            ' Invoice, ' +
                                            ewaybillno.toString() +
                                            'e-Way Bill',
                                        style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontSize: 10,
                                          color: const Color(0xe5ffffff),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: SizedBox(
                                            width: 71.0,
                                            height: 21.0,
                                            child: Stack(
                                              children: <Widget>[
                                                Pinned.fromSize(
                                                  bounds: Rect.fromLTWH(
                                                      0.0, 0.0, 71.0, 21.0),
                                                  size: Size(71.0, 21.0),
                                                  pinLeft: true,
                                                  pinRight: true,
                                                  pinTop: true,
                                                  pinBottom: true,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              11.0),
                                                      color: const Color(
                                                          0xfff1f3f6),
                                                      border: Border.all(
                                                          width: 1.0,
                                                          color: const Color(
                                                              0xff3f3d56)),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CurrentPlan(
                                                              widget.uid),
                                                    ),
                                                  ).then((value) {
                                                    setState(() {});
                                                  }),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'View More',
                                                      style: TextStyle(
                                                        fontFamily: 'Bell MT',
                                                        fontSize: 10,
                                                        color: const Color(
                                                            0xe52f2e41),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      HomeIcons(l, l2, l3, row1, row2, row3)
                    ],
                  ),
                ),
              )
            : Center(child: Text('loading')));
  }
}
