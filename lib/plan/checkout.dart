// ignore: unused_import
import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_svg/svg.dart';

class Checkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(47, 46, 65, 1),
        title: Text(
          'Current Plan',
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
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              color: const Color(0xff2F2E41),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(alignment: Alignment.center, children: [
                        SvgPicture.string(
                          '<svg viewBox="4318.0 4128.0 53.0 53.0" ><path transform="translate(4318.0, 4128.0)" d="M 26.5 0 C 41.13554382324219 0 53 11.8644552230835 53 26.5 C 53 41.13554382324219 41.13554382324219 53 26.5 53 C 11.8644552230835 53 0 41.13554382324219 0 26.5 C 0 11.8644552230835 11.8644552230835 0 26.5 0 Z" fill="#3f3d56" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                        // Adobe XD layer: 'ic_update_24px' (shape)
                        SvgPicture.string(
                          '<svg viewBox="4330.0 4140.0 30.0 30.0" ><path transform="translate(4327.0, 4137.0)" d="M 33.00121688842773 14.86666584014893 L 21.7004508972168 14.86666584014893 L 26.26742553710938 10.16666698455811 C 21.71711921691895 5.666666984558105 14.34995365142822 5.5 9.799646377563477 10 C 5.24933910369873 14.51666641235352 5.24933910369873 21.80000114440918 9.799646377563477 26.31666564941406 C 14.34995365142822 30.83333396911621 21.71711921691895 30.83333396911621 26.26742553710938 26.31666564941406 C 28.53424644470215 24.08333206176758 29.66765594482422 21.46666526794434 29.66765594482422 18.16666603088379 L 33.00121688842773 18.16666603088379 C 33.00121688842773 21.46666526794434 31.53445243835449 25.75000190734863 28.60092163085938 28.64999771118164 C 22.75052261352539 34.44999694824219 13.24988269805908 34.44999694824219 7.399486541748047 28.64999771118164 C 1.565759062767029 22.86666488647461 1.515755534172058 13.46666622161865 7.366150856018066 7.683332443237305 C 13.21654510498047 1.899999022483826 22.60051155090332 1.899999022483826 28.45090866088867 7.683332443237305 L 33.00121688842773 3 L 33.00121688842773 14.86666584014893 Z M 18.83359146118164 11.33333301544189 L 18.83359146118164 18.41666603088379 L 24.66731834411621 21.88333320617676 L 23.46723747253418 23.89999961853027 L 16.33342361450195 19.66666603088379 L 16.33342361450195 11.33333301544189 L 18.83359146118164 11.33333301544189 Z" fill="#ffffff" fill-opacity="0.68" stroke="none" stroke-width="1" stroke-opacity="0.68" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ]),
                      // Adobe XD layer: 'Home' (text)
                      Text(
                        'Subscription Plan',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(alignment: Alignment.center, children: [
                        SvgPicture.string(
                          '<svg viewBox="4429.0 4128.0 53.0 53.0" ><path transform="translate(4429.0, 4128.0)" d="M 26.5 0 C 41.13554382324219 0 53 11.8644552230835 53 26.5 C 53 41.13554382324219 41.13554382324219 53 26.5 53 C 11.8644552230835 53 0 41.13554382324219 0 26.5 C 0 11.8644552230835 11.8644552230835 0 26.5 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                        // Adobe XD layer: 'ic_update_24px' (shape)
                        SvgPicture.string(
                          '<svg viewBox="0.0 0.0 29.0 27.6" ><path transform="translate(-2.0, -5.0)" d="M 27.38564491271973 29.33598327636719 C 28.85615539550781 27.43979835510254 31.02322387695312 24.31980323791504 31.02322387695312 22.41394424438477 C 31.01761436462402 19.85107803344727 29.18914985656738 17.6548900604248 26.66973876953125 17.18492317199707 L 26.66973876953125 11.77209186553955 L 28.48369407653809 12.24129962921143 C 28.52328872680664 12.25088882446289 28.56388092041016 12.25576114654541 28.60462188720703 12.2558126449585 C 28.87177276611328 12.2558126449585 29.08834266662598 12.0392427444458 29.08834266662598 11.77209186553955 L 29.08834266662598 8.869768142700195 C 29.08872985839844 8.648877143859863 28.93942832946777 8.455781936645508 28.72555160522461 8.40056037902832 L 15.66509914398193 5.014516353607178 C 15.58563899993896 4.995173931121826 15.50269603729248 4.995173931121826 15.42323684692383 5.014516353607178 L 2.362783670425415 8.40056037902832 C 2.148905992507935 8.455781936645508 1.999605774879456 8.648876190185547 1.999993443489075 8.869768142700195 L 1.999993443489075 11.77209186553955 C 1.999230742454529 11.92206287384033 2.069123506546021 12.06364059448242 2.188644170761108 12.15423202514648 C 2.306913375854492 12.2448787689209 2.459949493408203 12.27690887451172 2.604643821716309 12.24130058288574 L 4.418596267700195 11.77209281921387 L 4.418596267700195 29.1860294342041 C 4.418596267700195 29.45318222045898 4.635164737701416 29.66975021362305 4.902316570281982 29.66975021362305 L 22.88704490661621 29.66975021362305 C 22.26788139343262 29.94063568115234 21.83253479003906 30.33728408813477 21.83253479003906 30.87905311584473 C 21.83253479003906 32.03998184204102 23.83997535705566 32.57206726074219 25.70229721069336 32.57206726074219 C 27.56462097167969 32.57206726074219 29.57206344604492 32.03998184204102 29.57206344604492 30.87905311584473 C 29.57206344604492 30.04221725463867 28.55141448974609 29.55849647521973 27.38564491271973 29.33598327636719 Z M 30.05578231811523 22.41394424438477 C 30.05578231811523 24.28594017028809 27.18732070922852 28.10733413696289 25.70229721069336 29.89226150512695 C 24.21727752685547 28.10733413696289 21.34881401062012 24.28594017028809 21.34881401062012 22.41394424438477 C 21.34881401062012 20.00958251953125 23.29793739318848 18.06046104431152 25.70229721069336 18.06046104431152 C 28.10666084289551 18.06046104431152 30.05578231811523 20.00958251953125 30.05578231811523 22.41394424438477 Z M 18.93021202087402 18.06045722961426 L 18.93021202087402 16.12557792663574 C 18.93186950683594 15.34368991851807 19.40292549133301 14.6392822265625 20.12488555908203 14.33908176422119 C 20.84684753417969 14.0388822555542 21.6784725189209 14.20161819458008 22.23402404785156 14.75181007385254 C 22.59596252441406 15.11750793457031 22.79928779602051 15.61105251312256 22.79997825622559 16.12557411193848 L 22.79997634887695 17.95887565612793 L 22.65485954284668 18.06045722961426 L 18.93021202087402 18.06045722961426 Z M 2.967434406280518 11.14809226989746 L 2.967434406280518 9.242233276367188 L 15.54416751861572 5.981956958770752 L 28.12090110778809 9.242233276367188 L 28.12090110778809 11.14809226989746 L 15.66509914398193 7.916839122772217 C 15.58563899993896 7.897496700286865 15.50269603729248 7.897496700286865 15.42323684692383 7.916839122772217 L 2.967434406280518 11.14809226989746 Z M 15.06044960021973 28.70230865478516 L 12.641845703125 28.70230865478516 L 12.641845703125 21.93022346496582 L 15.06044960021973 21.93022346496582 L 15.06044960021973 28.70230865478516 Z M 18.44649124145508 28.70230865478516 L 16.02788734436035 28.70230865478516 L 16.02788734436035 21.93022346496582 L 18.44649124145508 21.93022346496582 L 18.44649124145508 28.70230865478516 Z M 19.41393280029297 28.70230865478516 L 19.41393280029297 21.44650268554688 C 19.41393280029297 21.17935180664062 19.19736099243164 20.96278190612793 18.93021202087402 20.96278190612793 L 12.15812492370605 20.96278190612793 C 11.89097309112549 20.96278190612793 11.67440414428711 21.17935180664062 11.67440414428711 21.44650268554688 L 11.67440414428711 28.70230865478516 L 5.38603687286377 28.70230865478516 L 5.38603687286377 11.52055740356445 L 15.54416751861572 8.884280204772949 L 25.70229721069336 11.52055740356445 L 25.70229721069336 17.09301567077637 C 25.04015731811523 17.09489822387695 24.38410758972168 17.21954917907715 23.76741790771484 17.46064376831055 L 23.76741790771484 16.12557792663574 C 23.76741790771484 14.52266693115234 22.46800422668457 13.22325325012207 20.8650951385498 13.22325420379639 C 19.26218414306641 13.22325420379639 17.96277046203613 14.52266788482666 17.96277046203613 16.12557983398438 L 17.96277046203613 18.06045722961426 L 17.47904968261719 18.06045722961426 L 17.47904968261719 19.02789878845215 L 21.60034942626953 19.02789878845215 C 20.81157875061035 19.97988700866699 20.38038635253906 21.17764282226562 20.38137245178223 22.4139404296875 C 20.38137435913086 24.11663818359375 22.11792945861816 26.79645156860352 23.53523254394531 28.70230865478516 L 19.41393280029297 28.70230865478516 Z M 25.70229721069336 31.6046314239502 C 23.84481239318848 31.6046314239502 22.8580207824707 31.07254219055176 22.79997634887695 30.88872528076172 C 22.8435115814209 30.73877334594727 23.46267127990723 30.35663604736328 24.71550941467285 30.21151733398438 C 25.05895042419434 30.63719177246094 25.29597473144531 30.9080753326416 25.33950805664062 30.95644569396973 C 25.43133354187012 31.06056976318359 25.5634708404541 31.12021827697754 25.70229721069336 31.12021827697754 C 25.84112739562988 31.12021827697754 25.97326469421387 31.06056976318359 26.06509017944336 30.95644569396973 C 26.10862350463867 30.90807723999023 26.34564781188965 30.63719177246094 26.6890869140625 30.21151733398438 C 27.94192504882812 30.35663414001465 28.56108665466309 30.73877334594727 28.60462188720703 30.86937713623047 C 28.54657745361328 31.07254028320312 27.55978584289551 31.6046314239502 25.70229721069336 31.6046314239502 Z" fill="#2f2e41" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ]),
                      // Adobe XD layer: 'Food' (text)
                      Text(
                        'Address',
                        style: TextStyle(
                          fontFamily: 'Bell MT',
                          fontSize: 12,
                          color: const Color(0x99f1f3f6),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(alignment: Alignment.center, children: [
                        SvgPicture.string(
                          '<svg viewBox="4536.0 4128.0 53.0 53.0" ><path transform="translate(4536.0, 4128.0)" d="M 26.5 0 C 41.13554382324219 0 53 11.8644552230835 53 26.5 C 53 41.13554382324219 41.13554382324219 53 26.5 53 C 11.8644552230835 53 0 41.13554382324219 0 26.5 C 0 11.8644552230835 11.8644552230835 0 26.5 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                        SvgPicture.string(
                          '<svg viewBox="0.0 0.0 24.4 15.6" ><path  d="M 22.05764198303223 0 L 2.29767107963562 0 C 1.03073525428772 0 0 1.03073525428772 0 2.29767107963562 L 0 13.32649230957031 C 0 14.37514972686768 0.7086017727851868 15.29054164886475 1.72325325012207 15.55155658721924 C 1.761854410171509 15.56120681762695 1.79999566078186 15.56626319885254 1.838136792182922 15.56626319885254 C 2.042629718780518 15.56626319885254 2.229660272598267 15.42886161804199 2.282966136932373 15.22161197662354 C 2.346381664276123 14.97576236724854 2.198411703109741 14.72531414031982 1.952560901641846 14.66189861297607 C 1.34413754940033 14.50473785400391 0.9190683960914612 13.9560546875 0.9190683960914612 13.32649230957031 L 0.9190683960914612 4.59534215927124 L 20.21950531005859 4.59534215927124 C 20.4736270904541 4.59534215927124 20.67904090881348 4.389471054077148 20.67904090881348 4.135807991027832 C 20.67904090881348 3.882144689559937 20.4736270904541 3.676273584365845 20.21950531005859 3.676273584365845 L 0.9190683960914612 3.676273584365845 L 0.9190683960914612 2.29767107963562 C 0.9190683960914612 1.537601590156555 1.537601590156555 0.9190683960914612 2.29767107963562 0.9190683960914612 L 22.05764198303223 0.9190683960914612 C 22.81771278381348 0.9190683960914612 23.43624687194824 1.537601590156555 23.43624687194824 2.29767107963562 L 23.43624687194824 6.433479309082031 L 4.135807991027832 6.433479309082031 C 3.882144689559937 6.433479309082031 3.676273584365845 6.639350414276123 3.676273584365845 6.893013000488281 C 3.676273584365845 7.146676540374756 3.882144689559937 7.352547168731689 4.135807991027832 7.352547168731689 L 23.43624687194824 7.352547168731689 L 23.43624687194824 10.56928730010986 C 23.43624687194824 10.82295036315918 23.64165496826172 11.02882099151611 23.89577865600586 11.02882099151611 C 24.14990234375 11.02882099151611 24.35531425476074 10.82295036315918 24.35531425476074 10.56928730010986 L 24.35531425476074 2.29767107963562 C 24.35531425476074 1.03073525428772 23.32457733154297 0 22.05764198303223 0 Z" fill="#2f2e41" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        )
                        // Adobe XD layer: 'ic_update_24px' (shape)
                        ,
                      ]),
                      // Adobe XD layer: 'Food' (text)
                      // Adobe XD layer: 'Travel' (text)
                      Text(
                        'Payments',
                        style: TextStyle(
                          fontFamily: 'Bell MT',
                          fontSize: 12,
                          color: const Color(0xa8f1f3f6),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(children: [
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.string(
                    '<svg viewBox="32.0 262.8 353.0 215.7" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="10"/></filter><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff683e77"  /><stop offset="1.0" stop-color="#ff1b1b2a"  /></linearGradient></defs><path transform="translate(32.0, 262.75)" d="M 28.81632614135742 0 L 324.1836853027344 0 C 340.0985107421875 0 353 11.21790504455566 353 25.0558967590332 L 353 190.603759765625 C 353 204.4417724609375 340.0985107421875 215.6596527099609 324.1836853027344 215.6596527099609 L 28.81632614135742 215.6596527099609 C 12.90150833129883 215.6596527099609 0 204.4417724609375 0 190.603759765625 L 0 25.0558967590332 C 0 11.21790504455566 12.90150833129883 0 28.81632614135742 0 Z" fill="url(#gradient)" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>',
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Basic Plan',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 16,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          height: 1.625,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 77.0,
                            height: 19.0,
                            child: Text(
                              'You Saving',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                                height: 1.6428571428571428,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            '30 %',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffffffff),
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 35.0,
                            height: 19.0,
                            child: Text(
                              'Price',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                                height: 1.6428571428571428,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            '500',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffff0e27),
                              decoration: TextDecoration.lineThrough,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 85.0,
                            height: 19.0,
                            child: Text(
                              'for you only',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                                height: 1.6428571428571428,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            '349',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffffffff),
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 137.0,
                              height: 19.0,
                              child: Text(
                                ' 1 Month Subscription     ',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),

                            // Adobe XD layer: 'Radio Button' (group)
                            SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(0.0, 0.0, 24.0, 24.0),
                                    size: Size(24.0, 24.0),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Dot 2' (shape)
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(9999.0, 9999.0)),
                                        color: const Color(0x0fFF0E27),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(5.0, 5.0, 14.0, 14.0),
                                    size: Size(24.0, 24.0),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Dot 2' (shape)
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(9999.0, 9999.0)),
                                        color: const Color(0xffFF0E27),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 137.0,
                            height: 19.0,
                            child: Text(
                              'Monthly Charges',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            'RS 349',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            // Adobe XD layer: 'Primary Button - Sm…' (group)
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(children: [
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.string(
                    '<svg viewBox="32.0 262.8 353.0 215.7" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="10"/></filter><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff683e77"  /><stop offset="1.0" stop-color="#ff1b1b2a"  /></linearGradient></defs><path transform="translate(32.0, 262.75)" d="M 28.81632614135742 0 L 324.1836853027344 0 C 340.0985107421875 0 353 11.21790504455566 353 25.0558967590332 L 353 190.603759765625 C 353 204.4417724609375 340.0985107421875 215.6596527099609 324.1836853027344 215.6596527099609 L 28.81632614135742 215.6596527099609 C 12.90150833129883 215.6596527099609 0 204.4417724609375 0 190.603759765625 L 0 25.0558967590332 C 0 11.21790504455566 12.90150833129883 0 28.81632614135742 0 Z" fill="url(#gradient)" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>',
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Standard Plan',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 16,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          height: 1.625,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 77.0,
                            height: 19.0,
                            child: Text(
                              'You Saving',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                                height: 1.6428571428571428,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            '40 %',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffffffff),
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 35.0,
                            height: 19.0,
                            child: Text(
                              'Price',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                                height: 1.6428571428571428,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            '1500',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffff0e27),
                              decoration: TextDecoration.lineThrough,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 85.0,
                            height: 19.0,
                            child: Text(
                              'for you only',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                                height: 1.6428571428571428,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            '899',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffffffff),
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 137.0,
                              height: 19.0,
                              child: Text(
                                ' 3 Month Subscription     ',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),

                            // Adobe XD layer: 'Radio Button' (group)
                            SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(0.0, 0.0, 24.0, 24.0),
                                    size: Size(24.0, 24.0),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Dot 2' (shape)
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(9999.0, 9999.0)),
                                        color: const Color(0x0fFF0E27),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(5.0, 5.0, 14.0, 14.0),
                                    size: Size(24.0, 24.0),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Dot 2' (shape)
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(9999.0, 9999.0)),
                                        color: const Color(0xffFF0E27),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 137.0,
                            height: 19.0,
                            child: Text(
                              'Monthly Charges',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            'RS 300',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(children: [
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.string(
                    '<svg viewBox="32.0 262.8 353.0 215.7" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="10"/></filter><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff683e77"  /><stop offset="1.0" stop-color="#ff1b1b2a"  /></linearGradient></defs><path transform="translate(32.0, 262.75)" d="M 28.81632614135742 0 L 324.1836853027344 0 C 340.0985107421875 0 353 11.21790504455566 353 25.0558967590332 L 353 190.603759765625 C 353 204.4417724609375 340.0985107421875 215.6596527099609 324.1836853027344 215.6596527099609 L 28.81632614135742 215.6596527099609 C 12.90150833129883 215.6596527099609 0 204.4417724609375 0 190.603759765625 L 0 25.0558967590332 C 0 11.21790504455566 12.90150833129883 0 28.81632614135742 0 Z" fill="url(#gradient)" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>',
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Premium Plan',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 16,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          height: 1.625,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 77.0,
                            height: 19.0,
                            child: Text(
                              'You Saving',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                                height: 1.6428571428571428,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            '50 %',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffffffff),
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 35.0,
                            height: 19.0,
                            child: Text(
                              'Price',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                                height: 1.6428571428571428,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            '3000',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffff0e27),
                              decoration: TextDecoration.lineThrough,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 85.0,
                            height: 19.0,
                            child: Text(
                              'for you only',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                                height: 1.6428571428571428,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            '1499',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffffffff),
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 137.0,
                              height: 19.0,
                              child: Text(
                                ' 12 Month Subscription    ',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),

                            // Adobe XD layer: 'Radio Button' (group)
                            SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(0.0, 0.0, 24.0, 24.0),
                                    size: Size(24.0, 24.0),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Dot 2' (shape)
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(9999.0, 9999.0)),
                                        color: const Color(0x0fFF0E27),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(5.0, 5.0, 14.0, 14.0),
                                    size: Size(24.0, 24.0),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Dot 2' (shape)
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(9999.0, 9999.0)),
                                        color: const Color(0xffFF0E27),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 137.0,
                            height: 19.0,
                            child: Text(
                              'Monthly Charges',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            'RS 250',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(children: [
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.string(
                    '<svg viewBox="32.0 262.8 353.0 215.7" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="10"/></filter><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff683e77"  /><stop offset="1.0" stop-color="#ff1b1b2a"  /></linearGradient></defs><path transform="translate(32.0, 262.75)" d="M 28.81632614135742 0 L 324.1836853027344 0 C 340.0985107421875 0 353 11.21790504455566 353 25.0558967590332 L 353 190.603759765625 C 353 204.4417724609375 340.0985107421875 215.6596527099609 324.1836853027344 215.6596527099609 L 28.81632614135742 215.6596527099609 C 12.90150833129883 215.6596527099609 0 204.4417724609375 0 190.603759765625 L 0 25.0558967590332 C 0 11.21790504455566 12.90150833129883 0 28.81632614135742 0 Z" fill="url(#gradient)" stroke="none" stroke-width="0.6000000238418579" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>',
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Premium Plus Plan',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 16,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          height: 1.625,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 77.0,
                            height: 19.0,
                            child: Text(
                              'You Saving',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                                height: 1.6428571428571428,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            '70 %',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffffffff),
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 35.0,
                            height: 19.0,
                            child: Text(
                              'Price',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                                height: 1.6428571428571428,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            '6000',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffff0e27),
                              decoration: TextDecoration.lineThrough,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 85.0,
                            height: 19.0,
                            child: Text(
                              'for you only',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                                height: 1.6428571428571428,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            '1799',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffffffff),
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 137.0,
                              height: 19.0,
                              child: Text(
                                ' 12 Month Subscription    ',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  color: const Color(0xa8ffffff),
                                  height: 1.6428571428571428,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),

                            // Adobe XD layer: 'Radio Button' (group)
                            SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(0.0, 0.0, 24.0, 24.0),
                                    size: Size(24.0, 24.0),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Dot 2' (shape)
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(9999.0, 9999.0)),
                                        color: const Color(0x0fFF0E27),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(5.0, 5.0, 14.0, 14.0),
                                    size: Size(24.0, 24.0),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Dot 2' (shape)
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(9999.0, 9999.0)),
                                        color: const Color(0xffFF0E27),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 137.0,
                            height: 19.0,
                            child: Text(
                              'Monthly Charges',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: const Color(0xa8ffffff),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            'RS 150',
                            style: TextStyle(
                              fontFamily: 'Acumin Pro',
                              fontSize: 20,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
