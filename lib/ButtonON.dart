import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonON extends StatelessWidget {
  ButtonON({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 40.0, 18.0),
          size: Size(40.0, 18.0),
          pinRight: true,
          fixedWidth: true,
          fixedHeight: true,
          child: Transform.rotate(
            angle: 3.1416,
            child:
                // Adobe XD layer: 'Slide Copy' (group)
                Stack(
              children: <Widget>[
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(0.0, 0.0, 40.0, 18.0),
                  size: Size(40.0, 18.0),
                  pinLeft: true,
                  pinRight: true,
                  pinTop: true,
                  pinBottom: true,
                  child:
                      // Adobe XD layer: 'Shape' (shape)
                      SvgPicture.string(
                    _svg_k8i3ls,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(23.0, 2.0, 14.0, 14.0),
                  size: Size(40.0, 18.0),
                  pinLeft: true,
                  pinTop: true,
                  pinBottom: true,
                  fixedWidth: true,
                  child: Transform.rotate(
                    angle: 3.1416,
                    child:
                        // Adobe XD layer: 'Oval' (shape)
                        Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 0.5, color: const Color(0xffe5e5e5)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x65000000),
                            offset: Offset(0, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

const String _svg_k8i3ls =
    '<svg viewBox="8.0 -18.0 40.0 18.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 48.0, 0.0)" d="M 8 0 L 32 0 C 36.41827774047852 0 40 4.029437065124512 40 9 C 40 13.97056293487549 36.41827774047852 18 32 18 L 8 18 C 3.581721782684326 18 0 13.97056293487549 0 9 C 0 4.029437065124512 3.581721782684326 0 8 0 Z" fill="#707070" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
