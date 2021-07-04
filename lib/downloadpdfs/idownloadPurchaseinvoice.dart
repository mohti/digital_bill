import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:share/share.dart';

class DownloadPurchaseInvoice extends StatefulWidget {
  final String uid;
  DownloadPurchaseInvoice(this.uid);
  bool isloading = false;

  @override
  _DownloadPurchaseInvoiceState createState() =>
      _DownloadPurchaseInvoiceState();
}

class _DownloadPurchaseInvoiceState extends State<DownloadPurchaseInvoice> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
        BuildContext context) async* {
      yield* FirebaseFirestore.instance
          .collection('userData')
          .doc(widget.uid)
          .collection('PurchaseInvoice')
          .snapshots();
    }

    Future<void> downloadAndSharePdf(String filename) async {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File downloadToFile = File('${appDocDir.path}/$filename.pdf');

      await firebase_storage.FirebaseStorage.instance
          .ref(widget.uid + '/PurchaseInvoice/' + filename + '.pdf')
          .writeToFile(downloadToFile);
      setState(() {
        widget.isloading = false;
      });

      Share.shareFiles(['${appDocDir.path}/$filename.pdf']);
    }

    Future<void> dowloadAndOpenPdf(String filename) async {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File downloadToFile = File('${appDocDir.path}/$filename.pdf');

      await firebase_storage.FirebaseStorage.instance
          .ref(widget.uid + '/PurchaseInvoice/' + filename + '.pdf')
          .writeToFile(downloadToFile);
      setState(() {
        widget.isloading = false;
      });
      OpenFile.open('${appDocDir.path}/$filename.pdf');

      //Share.shareFiles(['${appDocDir.path}/$filename.pdf']);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Purchase Receipt',
          style: TextStyle(
            fontFamily: 'Bell MT',
            fontSize: 24,
            color: const Color(0xfff2f2f2),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: Stack(
        children: [
          StreamBuilder(
              stream: getUsersTripsStreamSnapshots(context),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 210,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) => Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.isloading = true;
                          });
                          dowloadAndOpenPdf(
                              snapshot.data.docs[index]['invoiceno']);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            image: DecorationImage(
                              image: const AssetImage(
                                  'assets/downloadinvoicebg.jpg'),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                                width: 0.2, color: const Color(0xff2f2e41)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(3, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.white),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Adobe XD layer: 'Icon awesome-file-p…' (shape)
                            SvgPicture.string(
                              '<svg viewBox="46.7 238.0 27.0 36.0" ><path transform="translate(46.7, 238.0)" d="M 12.78984355926514 18.00703048706055 C 12.43828105926514 16.88203048706055 12.4453125 14.70937442779541 12.64921855926514 14.70937442779541 C 13.23984336853027 14.70937442779541 13.18359375 17.30390548706055 12.78984355926514 18.00703048706055 Z M 12.67031192779541 21.32578086853027 C 12.12890529632568 22.74609375 11.45390605926514 24.37031173706055 10.67343711853027 25.734375 C 11.96015548706055 25.2421875 13.41562461853027 24.52499961853027 15.09609317779541 24.19453048706055 C 14.20312404632568 23.51953125 13.34531211853027 22.54921722412109 12.67031192779541 21.32578086853027 Z M 6.053906440734863 30.10078048706055 C 6.053906440734863 30.15703010559082 6.982031345367432 29.72109222412109 8.5078125 27.27421760559082 C 8.036718368530273 27.71718597412109 6.461718559265137 28.99687385559082 6.053906440734863 30.10078048706055 Z M 17.4375 11.25 L 27 11.25 L 27 34.3125 C 27 35.24765777587891 26.24765586853027 36 25.3125 36 L 1.6875 36 C 0.7523437738418579 36 0 35.24765777587891 0 34.3125 L 0 1.6875 C 0 0.7523437738418579 0.7523437738418579 0 1.6875 0 L 15.75 0 L 15.75 9.5625 C 15.75 10.49062538146973 16.50937461853027 11.25 17.4375 11.25 Z M 16.875 23.32968711853027 C 15.46875 22.47187423706055 14.53359413146973 21.29062461853027 13.87265586853027 19.546875 C 14.18906211853027 18.24609375 14.68828105926514 16.27031326293945 14.30859375 15.03281211853027 C 13.97812461853027 12.96562480926514 11.32734394073486 13.16953086853027 10.94765663146973 14.5546875 C 10.59609413146973 15.84140586853027 10.91953182220459 17.65546798706055 11.51718807220459 19.96875 C 10.70156288146973 21.90937423706055 9.49921989440918 24.51093673706055 8.6484375 26.00156211853027 C 8.641406059265137 26.00156211853027 8.641406059265137 26.00859260559082 8.634374618530273 26.00859260559082 C 6.72890567779541 26.98593711853027 3.45937442779541 29.13749885559082 4.802343368530273 30.78984260559082 C 5.196093559265137 31.27499961853027 5.927343368530273 31.49296760559082 6.314062118530273 31.49296760559082 C 7.57265567779541 31.49296760559082 8.82421875 30.22734260559082 10.61015605926514 27.14765548706055 C 12.42421817779541 26.54999923706055 14.4140625 25.8046875 16.16484451293945 25.51640510559082 C 17.69062614440918 26.34609222412109 19.4765625 26.88749885559082 20.66484451293945 26.88749885559082 C 22.71796989440918 26.88749885559082 22.85859489440918 24.63749885559082 22.05000114440918 23.83593559265137 C 21.07265663146973 22.87968635559082 18.23203277587891 23.15390396118164 16.875 23.32968521118164 Z M 26.5078125 7.3828125 L 19.6171875 0.4921875 C 19.30078125 0.17578125 18.87187576293945 0 18.421875 0 L 18 0 L 18 9 L 27 9 L 27 8.571093559265137 C 27 8.128125190734863 26.82421875 7.69921875 26.5078125 7.3828125 Z M 21.29765701293945 25.33359336853027 C 21.5859375 25.14374923706055 21.12187576293945 24.49687385559082 18.28828239440918 24.70078086853027 C 20.89687538146973 25.81171798706055 21.29765701293945 25.33359336853027 21.29765701293945 25.33359336853027 Z" fill="#6c63ff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                            Text(
                              snapshot.data.docs[index]['invoiceno'] +
                                  '\n' +
                                  DateFormat('dd/MM/yyyy')
                                      .format((snapshot.data.docs[index]
                                              ['sdate'] as Timestamp)
                                          .toDate())
                                      .toString(),
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 12,
                                color: const Color(0xff2f2e41),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            InkWell(
                                onTap: () {
                                  downloadAndSharePdf(
                                      snapshot.data.docs[index]['invoiceno']);
                                },
                                child: Icon(
                                  Icons.share,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
          widget.isloading == true
              ?Positioned(
                     top:
                       MediaQuery.of(context).size.height/2.5,
                      right: MediaQuery.of(context).size.width/2.6,
                                 
                    child:
                    Container(
                    alignment: Alignment.center,
                    child: Column(children: [
                    CircularProgressIndicator(),
                   SizedBox(height: 5,),
                    Text('Just a Second...'),
                ]),
                  )
                  )
              : Container()
        ],
      ),
      /* Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),
                    image: DecorationImage(
                      image: const AssetImage(''),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(width: 0.2, color: const Color(0xff2f2e41)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(3, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                Text(
                  'INN011',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 12,
                    color: const Color(0xff2f2e41),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ), */
    );
  }
}
