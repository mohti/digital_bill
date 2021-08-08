// ignore: unused_import
import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_svg/svg.dart';

class Tab extends StatelessWidget {
  final String title;
  final Function f;
  final double w;
  final Widget ic;
  Tab(this.ic, this.title, this.f, this.w);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: f,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: w * 1,
          height: 50,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ic,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 12,
                      color: const Color(0xff2f2e41),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}

class AboutUs extends StatelessWidget {
  String aboutUs = 'The Mobile Application JhatpatBill, the Desktop Application JhatpatBill and the Website JhatpatBill are provided by JhatpatBill is a property of Bradvice Solutions PVT Ltd (https://www.bradvicepvt.com), an Indian Company registered under the Companies Act of India having CIN U9000RJ2019PTC065044 with its registered office at FF-27, Cross Road mall, Central Spine, Vidhyadhar Nagar, Jaipur, Rajasthan, India 302039.BRADVICE SOLUTION PVT Ltd is a team of professionals from various domains of corporate consultancy services. At Bradvice Solutions, our professionals are committed to solve business problems and add value to our clients business.Technology is our partner in everything we do. We are committed to delivering quality in all kinds of advisory services.Our services are focused on adding value to the clients by understanding their needs and providing solutions which are theoretically sound and practically implementable as well. We strongly believe in the highest levels of integrity and are committed towards providing excellence and value addition.';
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'About Us',
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
                'About Us',
                style: TextStyle(
                  fontFamily: 'Bell MT',
                  fontSize: 18,
                  color: const Color(0xff2f2e41),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 125,
                  child: SingleChildScrollView(
                  //  controller: controller,
                                    child: Text(
                      aboutUs,
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 12,
                        color: const Color(0xff2f2e41),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Terms & Policy',
                style: TextStyle(
                  fontFamily: 'Bell MT',
                  fontSize: 18,
                  color: const Color(0xff2f2e41),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Tab(null, 'Terms of Service',
                () => Navigator.pushNamed(context, './termsofservice'), w),
            Tab(null, 'Privacy Policy',
                () => Navigator.pushNamed(context, './privacypolicy'), w),
            Tab(
                null,
                'Refund Policy',
                () =>
                    Navigator.pushNamed(context, './acceptableusepolicy.dart'),
                w),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                width: w * 1,
                height: 50,
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: null,
                        ),
                        Text(
                          'Version Number',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 12,
                            color: const Color(0xff2f2e41),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Text(
                      'v1.2.2(100)',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 12,
                        color: const Color(0xff2f2e41),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
