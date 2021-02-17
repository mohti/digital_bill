import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';
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
                      fontFamily: 'Bell MT',
                      fontSize: 18,
                      color: const Color(0xff2f2e41),
                      fontWeight: FontWeight.w700,
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

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Settings',
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
                'Settings',
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
                SvgPicture.string(
                  '<svg viewBox="28.8 148.0 24.0 30.0" ><path transform="translate(28.79, 148.0)" d="M 21 3.75 L 16 3.75 C 16 1.68164050579071 14.20625019073486 0 12 0 C 9.793750762939453 0 8 1.68164050579071 8 3.75 L 3 3.75 C 1.34375 3.75 0 5.009765625 0 6.5625 L 0 27.1875 C 0 28.740234375 1.34375 30 3 30 L 21 30 C 22.65625 30 24 28.740234375 24 27.1875 L 24 6.5625 C 24 5.009765625 22.65625 3.75 21 3.75 Z M 6 24.84375 C 5.168749809265137 24.84375 4.5 24.216796875 4.5 23.4375 C 4.5 22.658203125 5.168749809265137 22.03125 6 22.03125 C 6.831250190734863 22.03125 7.5 22.658203125 7.5 23.4375 C 7.5 24.216796875 6.831250190734863 24.84375 6 24.84375 Z M 6 19.21875 C 5.168749809265137 19.21875 4.5 18.591796875 4.5 17.8125 C 4.5 17.033203125 5.168749809265137 16.40625 6 16.40625 C 6.831250190734863 16.40625 7.5 17.033203125 7.5 17.8125 C 7.5 18.591796875 6.831250190734863 19.21875 6 19.21875 Z M 6 13.59375 C 5.168749809265137 13.59375 4.5 12.966796875 4.5 12.1875 C 4.5 11.40820407867432 5.168749809265137 10.78125 6 10.78125 C 6.831250190734863 10.78125 7.5 11.40820407867432 7.5 12.1875 C 7.5 12.966796875 6.831250190734863 13.59375 6 13.59375 Z M 12 2.34375 C 12.83125019073486 2.34375 13.5 2.970703125 13.5 3.75 C 13.5 4.529296875 12.83125019073486 5.15625 12 5.15625 C 11.16875076293945 5.15625 10.5 4.529296875 10.5 3.75 C 10.5 2.970703125 11.16875076293945 2.34375 12 2.34375 Z M 20 23.90625 C 20 24.16406440734863 19.77500152587891 24.375 19.5 24.375 L 10.5 24.375 C 10.22500038146973 24.375 10 24.16406440734863 10 23.90625 L 10 22.96875 C 10 22.7109375 10.22500038146973 22.5 10.5 22.5 L 19.5 22.5 C 19.77500152587891 22.5 20 22.7109375 20 22.96875 L 20 23.90625 Z M 20 18.28125 C 20 18.53906440734863 19.77500152587891 18.75 19.5 18.75 L 10.5 18.75 C 10.22500038146973 18.75 10 18.53906440734863 10 18.28125 L 10 17.34375 C 10 17.0859375 10.22500038146973 16.875 10.5 16.875 L 19.5 16.875 C 19.77500152587891 16.875 20 17.0859375 20 17.34375 L 20 18.28125 Z M 20 12.65625 C 20 12.9140625 19.77500152587891 13.125 19.5 13.125 L 10.5 13.125 C 10.22500038146973 13.125 10 12.9140625 10 12.65625 L 10 11.71875 C 10 11.4609375 10.22500038146973 11.25 10.5 11.25 L 19.5 11.25 C 19.77500152587891 11.25 20 11.4609375 20 11.71875 L 20 12.65625 Z" fill="none" stroke="#2f2e41" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  allowDrawingOutsideViewBox: true,
                ),
                ' Invoice Settings',
                () => Navigator.pushNamed(context, './invoicesettings'),
                w),
            Tab(
                SvgPicture.string(
                  '<svg viewBox="26.2 199.4 29.9 29.3" ><path transform="translate(23.15, 195.63)" d="M 11.36999988555908 6.119999885559082 L 9.225000381469727 3.974999904632568 C 5.625 6.71999979019165 3.255000114440918 10.94999980926514 3.045000076293945 15.75 L 6.045000076293945 15.75 C 6.269999980926514 11.77499961853027 8.310000419616699 8.295000076293945 11.36999988555908 6.119999885559082 Z M 29.95499801635742 15.75 L 32.95499801635742 15.75 C 32.72999954223633 10.94999980926514 30.35999870300293 6.720000267028809 26.77499771118164 3.975000381469727 L 24.64499664306641 6.12000036239624 C 27.67499732971191 8.295000076293945 29.72999572753906 11.77500057220459 29.95499610900879 15.75 Z M 27 16.5 C 27 11.89500045776367 24.54000091552734 8.039999961853027 20.25 7.020000457763672 L 20.25 6 C 20.25 4.755000114440918 19.2450008392334 3.75 18 3.75 C 16.7549991607666 3.75 15.75 4.755000114440918 15.75 6 L 15.75 7.019999980926514 C 11.44499969482422 8.039999961853027 9 11.88000011444092 9 16.5 L 9 24 L 6 27 L 6 28.5 L 30 28.5 L 30 27 L 27 24 L 27 16.5 Z M 18 33 C 18.20999908447266 33 18.40500068664551 32.98500061035156 18.60000038146973 32.93999862670898 C 19.57500076293945 32.72999954223633 20.3700008392334 32.06999969482422 20.76000022888184 31.16999816894531 C 20.90999984741211 30.80999755859375 20.98500061035156 30.41999816894531 20.98500061035156 29.99999809265137 L 14.98500061035156 29.99999809265137 C 15.00000095367432 31.64999771118164 16.33500099182129 33 18 33 Z" fill="none" stroke="#2f2e41" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  allowDrawingOutsideViewBox: true,
                ),
                'Reminder Settings',
                null,
                w),
            Tab(
                SvgPicture.string(
                  '<svg viewBox="26.2 248.3 31.5 31.5" ><path transform="translate(23.99, 246.0)" d="M 30.74997711181641 2.25 L 5.250023365020752 2.25 C 3.599859476089478 2.25 2.25 3.599789142608643 2.25 5.249953269958496 L 2.25 25.12497711181641 C 2.25 26.7751407623291 3.599859476089478 28.125 5.250023365020752 28.125 L 14.99997711181641 28.125 L 12.00002384185791 31.5 L 12.00002384185791 33.75 L 23.99997711181641 33.75 L 23.99997711181641 31.5 L 21.00002479553223 28.125 L 30.74997711181641 28.125 C 32.40013885498047 28.125 33.75 26.7751407623291 33.75 25.12497711181641 L 33.75 5.249953269958496 C 33.75 3.599789142608643 32.40013885498047 2.25 30.74997711181641 2.25 Z M 30.74997711181641 22.5 L 5.250023365020752 22.5 L 5.250023365020752 5.249953269958496 L 30.74997520446777 5.249953269958496 L 30.74997520446777 22.5 Z" fill="#2f2e41" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  allowDrawingOutsideViewBox: true,
                ),
                'Invoice Desktop',
                null,
                w),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Others',
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
                SvgPicture.string(
                  '<svg viewBox="25.7 340.7 30.0 28.5" ><path transform="translate(22.69, 337.73)" d="M 18 3 L 22.63500022888184 12.39000034332275 L 33 13.90499973297119 L 25.5 21.20999908447266 L 27.27000045776367 31.53000068664551 L 18 26.65500068664551 L 8.729999542236328 31.53000068664551 L 10.5 21.20999908447266 L 3 13.90499973297119 L 13.36499977111816 12.39000034332275 L 18 3 Z" fill="none" stroke="#2f2e41" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                  allowDrawingOutsideViewBox: true,
                ),
                'Rate App on Playstore',
                null,
                w),
            Tab(
                // Adobe XD layer: 'Icon feather-info' (group)
                SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(0.0, 0.0, 30.0, 30.0),
                        size: Size(30.0, 30.0),
                        pinLeft: true,
                        pinRight: true,
                        pinTop: true,
                        pinBottom: true,
                        child: SvgPicture.string(
                          '<svg viewBox="3.0 3.0 30.0 30.0" ><path  d="M 33 18 C 33 26.28427124023438 26.28427124023438 33 18 33 C 9.715728759765625 33 3 26.28427124023438 3 18 C 3 9.715728759765625 9.715728759765625 3 18 3 C 26.28427124023438 3 33 9.715728759765625 33 18 Z" fill="none" stroke="#2f2e41" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(15.0, 15.0, 1.0, 6.0),
                        size: Size(30.0, 30.0),
                        fixedWidth: true,
                        fixedHeight: true,
                        child: SvgPicture.string(
                          '<svg viewBox="18.0 18.0 1.0 6.0" ><path  d="M 18 24 L 18 18" fill="none" stroke="#2f2e41" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(15.0, 9.0, 1.0, 1.0),
                        size: Size(30.0, 30.0),
                        fixedWidth: true,
                        fixedHeight: true,
                        child: SvgPicture.string(
                          '<svg viewBox="18.0 12.0 1.0 1.0" ><path  d="M 18 12 L 18 12" fill="none" stroke="#2f2e41" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                'About Us',
                () => Navigator.pushNamed(context, './AboutUs'),
                w),
          ],
        ),
      ),
    );
  }
}
