import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalbillbook/models/businessprofile.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditRow extends StatelessWidget {
  final String s1, s2;
  final TextEditingController c1;
  final bool edit;
  EditRow(this.s1, this.s2, this.c1, this.edit);
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width * 0.99;
    return Container(
      decoration:
          BoxDecoration(color: Colors.white, border: Border.all(width: 0.1)),
      width: w,
      child: Row(
        children: [
          SizedBox(
            width: w * 0.01,
          ),
          Container(
            width: w * 0.4,
            child: Padding(
              padding: const EdgeInsets.only(top: 14.0, bottom: 14),
              child: Text(
                s1,
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 12,
                  color: const Color(0xcc2f2e41),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          SizedBox(
            width: w * 0.05,
          ),
          Container(
            width: w * 0.5,
            child: edit
                ? TextFormField(
                    controller: c1,
                    decoration: InputDecoration(
                      labelText: s1,
                    ),
                    // The validator receives the text that the user has entered.
                  )
                : Text(
                    s2,
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 12,
                      color: const Color(0xff2f2e41),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
          ),
        ],
      ),
    );
  }
}

class BusinessInfo extends StatefulWidget {
  final String uid;
  BusinessInfo(this.uid);

  @override
  _BusinessInfoState createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  bool clicked = false;
  List<String> listOfStr = List();

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _getBusinessDetails(widget.uid);
    downloadURLExample();
  }

  FilePickerResult _result;
  FilePickerResult _resultsign;
  FilePickerResult _resultstamp;
  FileType _pickType = FileType.custom;

  // ignore: unused_field
  bool _loadingPath = false;
  void openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _result = await FilePicker.platform
          .pickFiles(type: _pickType, allowedExtensions: ['png', 'jpg']);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      uploadFile();
    });
  }

  void openFileExplorersign() async {
    setState(() => _loadingPath = true);
    try {
      _resultsign = await FilePicker.platform
          .pickFiles(type: _pickType, allowedExtensions: ['png']);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      uploadFilesign();
    });
  }

  void openFileExplorerstamp() async {
    setState(() => _loadingPath = true);
    try {
      _resultstamp = await FilePicker.platform
          .pickFiles(type: _pickType, allowedExtensions: ['png']);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      uploadFilestamp();
    });
  }

  Future<void> uploadFile() async {
    File file = File(_result.files.first.path);

    await firebase_storage.FirebaseStorage.instance
        .ref(widget.uid + '/business/logo.png')
        .putFile(file);
    downloadURLExample();
  }

  Future<void> uploadFilesign() async {
    File file1 = File(_resultsign.files.first.path);

    await firebase_storage.FirebaseStorage.instance
        .ref(widget.uid + '/business/sign.png')
        .putFile(file1);
    downloadURLExamplesign();
  }

  Future<void> uploadFilestamp() async {
    File file2 = File(_resultstamp.files.first.path);

    await firebase_storage.FirebaseStorage.instance
        .ref(widget.uid + '/business/stamp.png')
        .putFile(file2);
    downloadURLExamplestamp();
  }

  String _downloadURL, _downloadURLsign, _downloadURLstamp;
  Future<void> downloadURLExample() async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(widget.uid + '/business/logo.png')
        .getDownloadURL();
    setState(() {
      print(_downloadURL);
      _downloadURL = downloadURL;
    });
    // Within your widgets:
    // Image.network(downloadURL);
  }

  Future<void> downloadURLExamplesign() async {
    String downloadURLsign = await firebase_storage.FirebaseStorage.instance
        .ref(widget.uid + '/business/sign.png')
        .getDownloadURL();
    setState(() {
      print(_downloadURL);
      _downloadURLsign = downloadURLsign;
    });
    // Within your widgets:
    // Image.network(downloadURL);
  }

  Future<void> downloadURLExamplestamp() async {
    String downloadURLstamp = await firebase_storage.FirebaseStorage.instance
        .ref(widget.uid + '/business/stamp.png')
        .getDownloadURL();
    setState(() {
      print(_downloadURL);
      _downloadURLstamp = downloadURLstamp;
    });
    // Within your widgets:
    // Image.network(downloadURL);
  }

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
  final branchNameController = TextEditingController();
  final businessInfo = new BusinessProfile(
      '', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
  final db = FirebaseFirestore.instance;

  Future<void> addInfo() {
    businessInfo.businessName = businessNameController.text;
    businessInfo.phone = phoneController.text;
    businessInfo.authorisedSignature = authorisedSignatureController.text;
    businessInfo.email = emailController.text;
    businessInfo.gstNumber = gstNumberController.text;
    businessInfo.businessAddress = businesAddressController.text;
    businessInfo.industryType = industryTypeController.text;
    businessInfo.bankName = bankNameController.text;
    businessInfo.businessType = businessTypeController.text;
    businessInfo.ifscCode = ifscCodeController.text;
    businessInfo.accountNumber = accountNumberController.text;
    businessInfo.branchName = branchNameController.text;
    // Call the user's CollectionReference to add a new user
    return db
        .collection("userData")
        .doc(widget.uid)
        .collection("BusinessInfo")
        .doc('businessName')
        .set(businessInfo.toJson());
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
        authorisedSignatureController.text =
            valuee.data()['authorisedSignature'] == null
                ? ''
                : valuee.data()['authorisedSignature'];
        industryTypeController.text = valuee.data()['industryType'] == null
            ? ''
            : valuee.data()['industryType'];
        businessTypeController.text = valuee.data()['businessType'] == null
            ? ''
            : valuee.data()['businessType'];
        bankNameController.text =
            valuee.data()['bankName'] == null ? '' : valuee.data()['bankName'];
        accountNumberController.text = valuee.data()['accountNumber'] == null
            ? ''
            : valuee.data()['accountNumber'];
        ifscCodeController.text =
            valuee.data()['ifscCode'] == null ? '' : valuee.data()['ifscCode'];
        branchNameController.text = valuee.data()['branchName'] == null
            ? ''
            : valuee.data()['branchName'];
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

  final _keyForm1 = GlobalKey<FormState>();

  bool _edit = true;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
        BuildContext context) async* {
      yield* FirebaseFirestore.instance
          .collection('userData')
          .doc(widget.uid)
          .collection('BusinessInfo')
          .snapshots();
    }

    // ignore: unused_local_variable
    final double w = MediaQuery.of(context).size.width;
    final firebaseStorageref = FirebaseFirestore.instance
        .collection("userData")
        .doc(widget.uid)
        .collection("images")
        .doc('logo');
    Future<void> saveImages(List<File> _images, DocumentReference ref) async {
      _images.forEach((image) async {
        String imageURL = await firebase_storage.FirebaseStorage.instance
            .ref(widget.uid + '/business/logo.png')
            .getDownloadURL();
        ref.set({"url": imageURL});
      });
    }

    final firebaseStorageref2 = FirebaseFirestore.instance
        .collection("userData")
        .doc(widget.uid)
        .collection("images")
        .doc('sign');
    Future<void> saveImagessign(
        List<File> _images, DocumentReference ref) async {
      _images.forEach((image) async {
        String imageURL = await firebase_storage.FirebaseStorage.instance
            .ref(widget.uid + '/business/sign.png')
            .getDownloadURL();
        ref.set({"url": imageURL});
      });
    }

    final firebaseStorageref3 = FirebaseFirestore.instance
        .collection("userData")
        .doc(widget.uid)
        .collection("images")
        .doc('stamp');

    Future<void> saveImagesstamp(
        List<File> _images, DocumentReference ref) async {
      _images.forEach((image) async {
        String imageURL = await firebase_storage.FirebaseStorage.instance
            .ref(widget.uid + '/business/stamp.png')
            .getDownloadURL();
        ref.set({"url": imageURL});
      });
    }

    return Scaffold(
        key: _keyForm1,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(47, 46, 65, 1),
          title: Text(
            'Business Profile',
            style: TextStyle(
              fontFamily: 'Bell MT',
              fontSize: 24,
              color: const Color(0xfff2f2f2),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        body: Container(
          child: _edit
              ? Form(
                  key: _keyForm1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Business Name',
                              style: TextStyle(
                                fontFamily: 'Bell MT',
                                fontSize: 14,
                                color: const Color(0xff2f2e41),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            )),
                        Row(
                          children: [
                            Container(
                              width: w * 0.7,
                              decoration: BoxDecoration(color: Colors.white),
                              child: _edit
                                  ? TextFormField(
                                      controller: businessNameController,
                                      decoration: InputDecoration(
                                        labelText: '',
                                      ),
                                      // The validator receives the text that the user has entered.
                                    )
                                  : Text(
                                      '',
                                      style: TextStyle(
                                        fontFamily: 'Arial',
                                        fontSize: 12,
                                        color: const Color(0xff2f2e41),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                            ),
                            _edit
                                ? Container(
                                    height: 100,
                                    width: w * 0.2,
                                    child: RaisedButton(
                                        child: (_downloadURL == null)
                                            ? null
                                            : Image.network(
                                                _downloadURL,
                                              ),
                                        onPressed: () => {
                                              openFileExplorer(),
                                              downloadURLExample(),
                                              saveImages([
                                                File(_result.files.first.path),
                                              ], firebaseStorageref)
                                            }),
                                  )
                                : Container(
                                    height: 100,
                                    width: w * 0.2,
                                    child: (_downloadURL == null)
                                        ? null
                                        : Image.network(
                                            _downloadURL,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                          ),
                                    /*  decoration: BoxDecoration(
                              image: _downloadURL != ' '
                                  ? DecorationImage(
                                      image: NetworkImage(_downloadURL),
                                      fit: BoxFit.fill)
                                  : ' ')*/
                                  )
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Contact Details',
                              style: TextStyle(
                                fontFamily: 'Bell MT',
                                fontSize: 14,
                                color: const Color(0xff2f2e41),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            )),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 0.1)),
                          width: w,
                          child: Row(
                            children: [
                              SizedBox(
                                width: w * 0.01,
                              ),
                              Container(
                                width: w * 0.4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14.0, bottom: 14),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Singature',
                                        style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontSize: 12,
                                          color: const Color(0xcc2f2e41),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        'Image Only in PNG',
                                        style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontSize: 4,
                                          color: const Color(0x992f2e41),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: w * 0.05,
                              ),
                              Container(
                                width: w * 0.5,
                                child: _edit
                                    ? Container(
                                        height: 50,
                                        width: w * 0.2,
                                        child: RaisedButton(
                                            child: (_downloadURLsign == null)
                                                ? null
                                                : Image.network(
                                                    _downloadURLsign,
                                                  ),
                                            onPressed: () => {
                                                  openFileExplorersign(),
                                                  downloadURLExamplesign(),
                                                  saveImagessign([
                                                    File(_resultsign
                                                        .files.first.path),
                                                  ], firebaseStorageref2)
                                                }),
                                      )
                                    : Container(
                                        height: 50,
                                        width: w * 0.2,
                                        child: (_downloadURLsign == null)
                                            ? null
                                            : Image.network(
                                                _downloadURLsign,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                              ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 0.1)),
                          width: w,
                          child: Row(
                            children: [
                              SizedBox(
                                width: w * 0.01,
                              ),
                              Container(
                                width: w * 0.4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14.0, bottom: 14),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Business Stamp',
                                        style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontSize: 12,
                                          color: const Color(0xcc2f2e41),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        'Image Only in PNG',
                                        style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontSize: 4,
                                          color: const Color(0x992f2e41),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: w * 0.05,
                              ),
                              Container(
                                width: w * 0.5,
                                child: _edit
                                    ? Container(
                                        height: 50,
                                        width: w * 0.2,
                                        child: RaisedButton(
                                            child: (_downloadURLstamp == null)
                                                ? null
                                                : Image.network(
                                                    _downloadURLstamp,
                                                  ),
                                            onPressed: () => {
                                                  openFileExplorerstamp(),
                                                  downloadURLExamplestamp(),
                                                  saveImagesstamp([
                                                    File(_resultstamp
                                                        .files.first.path),
                                                  ], firebaseStorageref3)
                                                }),
                                      )
                                    : Container(
                                        height: 50,
                                        width: w * 0.2,
                                        child: (_downloadURLstamp == null)
                                            ? null
                                            : Image.network(
                                                _downloadURLstamp,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                              ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        EditRow('Authorised Signatory', '',
                            authorisedSignatureController, _edit),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 0.1)),
                          width: w,
                          child: Row(
                            children: [
                              SizedBox(
                                width: w * 0.01,
                              ),
                              Container(
                                width: w * 0.4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14.0, bottom: 14),
                                  child: Text(
                                    'Phone Number',
                                    style: TextStyle(
                                      fontFamily: 'Arial',
                                      fontSize: 12,
                                      color: const Color(0xcc2f2e41),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: w * 0.05,
                              ),
                              Container(
                                width: w * 0.5,
                                child: _edit
                                    ? TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length != 10) {
                                            return 'Please Enter Correct ' +
                                                "Phone Number";
                                          }
                                          return null;
                                        },
                                        maxLength: 10,

                                        obscureText: false,
                                        controller: phoneController,
                                        decoration: InputDecoration(
                                          labelText: 'Phone Number',
                                          counterText: '',
                                        ),
                                        // The validator receives the text that the user has entered.
                                      )
                                    : Text(
                                        '',
                                        style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontSize: 12,
                                          color: const Color(0xff2f2e41),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        EditRow('Email', '', emailController, _edit),
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Business Info',
                              style: TextStyle(
                                fontFamily: 'Bell MT',
                                fontSize: 14,
                                color: const Color(0xff2f2e41),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            )),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 0.1)),
                          width: w,
                          child: Row(
                            children: [
                              SizedBox(
                                width: w * 0.01,
                              ),
                              Container(
                                width: w * 0.4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14.0, bottom: 14),
                                  child: Text(
                                    'GST Number',
                                    style: TextStyle(
                                      fontFamily: 'Arial',
                                      fontSize: 12,
                                      color: const Color(0xcc2f2e41),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: w * 0.05,
                              ),
                              Container(
                                width: w * 0.5,
                                child: _edit
                                    ? TextFormField(
                                        maxLength: 15,

                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.characters.last != 'Z' ||
                                              value.length != 15) {
                                            return 'Please Enter Correct ' +
                                                "GSTN";
                                          }
                                          return null;
                                        },
                                        controller: gstNumberController,
                                        decoration: InputDecoration(
                                          labelText: 'GST Number',
                                          counterText: '',
                                        ),
                                        // The validator receives the text that the user has entered.
                                      )
                                    : Text(
                                        '',
                                        style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontSize: 12,
                                          color: const Color(0xff2f2e41),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        EditRow('Business Address', '',
                            businesAddressController, _edit),
                        EditRow(
                            'Industry Type', '', industryTypeController, _edit),
                        EditRow(
                            'Business Type', '', businessTypeController, _edit),
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Bank Details',
                              style: TextStyle(
                                fontFamily: 'Bell MT',
                                fontSize: 14,
                                color: const Color(0xff2f2e41),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            )),
                        EditRow('Bank Name', '', bankNameController, _edit),
                        EditRow('IFSC Code', '', ifscCodeController, _edit),
                        EditRow('Account Number', '', accountNumberController,
                            _edit),
                        EditRow('Bank Branch', '', branchNameController, _edit),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () => _edit
                              ? {
                                  if (_keyForm1.currentState.validate())
                                    {
                                      /*          saveImages([
                                                File(_result.files.first.path)
                                              ], firebaseStorageref),*/
                                      // If the form is valid, display a Snackbar.
                                      addInfo(),

                                      setState(() {
                                        _edit = false;
                                      }),
                                    }
                                  else
                                    {}
                                }
                              : setState(() {
                                  _edit = true;
                                }),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              color: const Color(0xfff3F3D56),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Edit Details',
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 16,
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )
              : StreamBuilder(
                  stream: getUsersTripsStreamSnapshots(context),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Text("Loading...");
                    return new ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) => Form(
                              key: _keyForm1,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          'Business Name',
                                          style: TextStyle(
                                            fontFamily: 'Bell MT',
                                            fontSize: 14,
                                            color: const Color(0xff2f2e41),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.left,
                                        )),
                                    Row(
                                      children: [
                                        Container(
                                          width: w * 0.7,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                          child: _edit
                                              ? TextFormField(
                                                  controller:
                                                      businessNameController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Business Name',
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.0),
                                                    ),
                                                  ),
                                                  // The validator receives the text that the user has entered.
                                                )
                                              : Text(
                                                  snapshot.data.docs[index][
                                                              'businessName'] ==
                                                          ' '
                                                      ? ' '
                                                      : snapshot
                                                              .data.docs[index]
                                                          ['businessName'],
                                                  style: TextStyle(
                                                    fontFamily: 'Arial',
                                                    fontSize: 12,
                                                    color:
                                                        const Color(0xff2f2e41),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                        ),
                                        _edit
                                            ? Container(
                                                height: 100,
                                                width: w * 0.2,
                                                child: RaisedButton(
                                                    child:
                                                        (_downloadURL == null)
                                                            ? null
                                                            : Image.network(
                                                                _downloadURL,
                                                              ),
                                                    onPressed: () =>
                                                        openFileExplorer()),
                                              )
                                            : Container(
                                                height: 100,
                                                width: w * 0.2,
                                                child: (_downloadURL == null)
                                                    ? null
                                                    : Image.network(
                                                        _downloadURL,
                                                        loadingBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Widget child,
                                                                ImageChunkEvent
                                                                    loadingProgress) {
                                                          if (loadingProgress ==
                                                              null)
                                                            return child;
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        },
                                                      ),
                                                /*  decoration: BoxDecoration(
                              image: _downloadURL != ' '
                                  ? DecorationImage(
                                      image: NetworkImage(_downloadURL),
                                      fit: BoxFit.fill)
                                  : ' ')*/
                                              )
                                      ],
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          'Contact Details',
                                          style: TextStyle(
                                            fontFamily: 'Bell MT',
                                            fontSize: 14,
                                            color: const Color(0xff2f2e41),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.left,
                                        )),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(width: 0.1)),
                                      width: w,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: w * 0.01,
                                          ),
                                          Container(
                                            width: w * 0.4,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 14.0, bottom: 14),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Singature',
                                                    style: TextStyle(
                                                      fontFamily: 'Arial',
                                                      fontSize: 12,
                                                      color: const Color(
                                                          0xcc2f2e41),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    'Image Only in PNG',
                                                    style: TextStyle(
                                                      fontFamily: 'Arial',
                                                      fontSize: 4,
                                                      color: const Color(
                                                          0x992f2e41),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: w * 0.05,
                                          ),
                                          Container(
                                            width: w * 0.5,
                                            child: _edit
                                                ? Container(
                                                    height: 50,
                                                    width: w * 0.2,
                                                    child: RaisedButton(
                                                        child:
                                                            (_downloadURLsign =
                                                                    null)
                                                                ? null
                                                                : Image.network(
                                                                    _downloadURLsign,
                                                                  ),
                                                        onPressed: () => {
                                                              openFileExplorersign(),
                                                              downloadURLExamplesign(),
                                                              saveImages([
                                                                File(_resultsign
                                                                    .files
                                                                    .first
                                                                    .path)
                                                              ], firebaseStorageref)
                                                            }),
                                                  )
                                                : Container(
                                                    height: 50,
                                                    width: w * 0.2,
                                                    child: (_downloadURLsign ==
                                                            null)
                                                        ? null
                                                        : Image.network(
                                                            _downloadURLsign,
                                                            loadingBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Widget
                                                                        child,
                                                                    ImageChunkEvent
                                                                        loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null)
                                                                return child;
                                                              return Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            },
                                                          ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(width: 0.1)),
                                      width: w,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: w * 0.01,
                                          ),
                                          Container(
                                            width: w * 0.4,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 14.0, bottom: 14),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Business Stamp',
                                                    style: TextStyle(
                                                      fontFamily: 'Arial',
                                                      fontSize: 12,
                                                      color: const Color(
                                                          0xcc2f2e41),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    'Image Only in PNG',
                                                    style: TextStyle(
                                                      fontFamily: 'Arial',
                                                      fontSize: 4,
                                                      color: const Color(
                                                          0x992f2e41),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: w * 0.05,
                                          ),
                                          Container(
                                            width: w * 0.5,
                                            child: _edit
                                                ? Container(
                                                    height: 50,
                                                    width: w * 0.2,
                                                    child: RaisedButton(
                                                        child:
                                                            (_downloadURLstamp ==
                                                                    null)
                                                                ? null
                                                                : Image.network(
                                                                    _downloadURLstamp,
                                                                  ),
                                                        onPressed: () => {
                                                              openFileExplorerstamp(),
                                                              downloadURLExamplestamp(),
                                                              saveImages([
                                                                File(
                                                                    _resultstamp
                                                                        .files
                                                                        .first
                                                                        .path)
                                                              ], firebaseStorageref)
                                                            }),
                                                  )
                                                : Container(
                                                    height: 50,
                                                    width: w * 0.2,
                                                    child: (_downloadURLstamp ==
                                                            null)
                                                        ? null
                                                        : Image.network(
                                                            _downloadURLstamp,
                                                            loadingBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Widget
                                                                        child,
                                                                    ImageChunkEvent
                                                                        loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null)
                                                                return child;
                                                              return Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            },
                                                          ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    EditRow(
                                        'authorised Signatory',
                                        snapshot.data.docs[index]
                                                    ['authorisedSignature'] ==
                                                ' '
                                            ? ' '
                                            : snapshot.data.docs[index]
                                                ['authorisedSignature'],
                                        authorisedSignatureController,
                                        _edit),
                                    EditRow(
                                        'Phone Number',
                                        snapshot.data.docs[index]['phone'] ==
                                                ' '
                                            ? ' '
                                            : snapshot.data.docs[index]
                                                ['phone'],
                                        phoneController,
                                        _edit),
                                    EditRow(
                                        'Email',
                                        snapshot.data.docs[index]['email'] ==
                                                ' '
                                            ? ' '
                                            : snapshot.data.docs[index]
                                                ['email'],
                                        emailController,
                                        _edit),
                                    Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          'Business Info',
                                          style: TextStyle(
                                            fontFamily: 'Bell MT',
                                            fontSize: 14,
                                            color: const Color(0xff2f2e41),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.left,
                                        )),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(width: 0.1)),
                                      width: w,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: w * 0.01,
                                          ),
                                          Container(
                                            width: w * 0.4,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 14.0, bottom: 14),
                                              child: Text(
                                                'GST Number',
                                                style: TextStyle(
                                                  fontFamily: 'Arial',
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xcc2f2e41),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: w * 0.05,
                                          ),
                                          Container(
                                            width: w * 0.5,
                                            child: _edit
                                                ? TextFormField(
                                                    validator: (value) {
                                                      if (value.isEmpty ||
                                                          value.characters
                                                                  .last !=
                                                              'Z' ||
                                                          value.length != 15) {
                                                        return 'Please Enter Correct ' +
                                                            "GSTN";
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        gstNumberController,
                                                    decoration: InputDecoration(
                                                      labelText: 'GST Number',
                                                    ),
                                                    // The validator receives the text that the user has entered.
                                                  )
                                                : Text(
                                                    snapshot.data.docs[index]
                                                                ['gstNumber'] ==
                                                            null
                                                        ? ' '
                                                        : snapshot.data
                                                                .docs[index]
                                                            ['gstNumber'],
                                                    style: TextStyle(
                                                      fontFamily: 'Arial',
                                                      fontSize: 12,
                                                      color: const Color(
                                                          0xff2f2e41),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    EditRow(
                                        'Business Address',
                                        snapshot.data.docs[index]
                                                    ['businessAddress'] ==
                                                null
                                            ? ' '
                                            : snapshot.data.docs[index]
                                                ['businessAddress'],
                                        businesAddressController,
                                        _edit),
                                    EditRow(
                                        'Industry Type',
                                        snapshot.data.docs[index]
                                                    ['industryType'] ==
                                                null
                                            ? ' '
                                            : snapshot.data.docs[index]
                                                ['industryType'],
                                        industryTypeController,
                                        _edit),
                                    EditRow(
                                        'Business Type',
                                        snapshot.data.docs[index]
                                                    ['businessType'] ==
                                                null
                                            ? ' '
                                            : snapshot.data.docs[index]
                                                ['businessType'],
                                        businessTypeController,
                                        _edit),
                                    Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          'Bank Details',
                                          style: TextStyle(
                                            fontFamily: 'Bell MT',
                                            fontSize: 14,
                                            color: const Color(0xff2f2e41),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.left,
                                        )),
                                    EditRow(
                                        'Bank Name',
                                        snapshot.data.docs[index]['bankName'] ==
                                                null
                                            ? ' '
                                            : snapshot.data.docs[index]
                                                ['bankName'],
                                        bankNameController,
                                        _edit),
                                    EditRow(
                                        'IFSC Code',
                                        snapshot.data.docs[index]['ifscCode'] ==
                                                null
                                            ? ' '
                                            : snapshot.data.docs[index]
                                                ['ifscCode'],
                                        ifscCodeController,
                                        _edit),
                                    EditRow(
                                        'Account Number',
                                        snapshot.data.docs[index]
                                                    ['accountNumber'] ==
                                                null
                                            ? ' '
                                            : snapshot.data.docs[index]
                                                ['accountNumber'],
                                        accountNumberController,
                                        _edit),
                                    EditRow(
                                        'Bank Branch',
                                        snapshot.data.docs[index]
                                                    ['branchName'] ==
                                                null
                                            ? ' '
                                            : snapshot.data.docs[index]
                                                ['branchName'],
                                        branchNameController,
                                        _edit),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () => _edit
                                          ? {
                                              if (_keyForm1.currentState
                                                  .validate())
                                                {
                                                  /*          saveImages([
                                                File(_result.files.first.path)
                                              ], firebaseStorageref),*/
                                                  // If the form is valid, display a Snackbar.
                                                  addInfo(),
                                                  setState(() {
                                                    _edit = false;
                                                  }),
                                                }
                                              else
                                                {}
                                            }
                                          : setState(() {
                                              _edit = true;
                                            }),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 200,
                                          color: const Color(0xfff3F3D56),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Edit Details',
                                              style: TextStyle(
                                                fontFamily: 'Arial',
                                                fontSize: 16,
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ));
                  }),
        ));
  }
}
