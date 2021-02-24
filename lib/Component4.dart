import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Component4 extends StatelessWidget {
  Component4({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 412.0, 30.0),
          size: Size(412.0, 30.0),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          child: Stack(
            children: <Widget>[
              Pinned.fromSize(
                bounds: Rect.fromLTWH(0.0, 0.0, 412.0, 30.0),
                size: Size(412.0, 30.0),
                pinLeft: true,
                pinRight: true,
                pinTop: true,
                fixedHeight: true,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    border:
                        Border.all(width: 0.2, color: const Color(0xff000000)),
                  ),
                ),
              ),
            ],
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(14.0, 8.0, 167.0, 14.0),
          size: Size(412.0, 30.0),
          pinLeft: true,
          pinTop: true,
          fixedWidth: true,
          fixedHeight: true,
          child: Text(
            'How can I get sales summary ?',
            style: TextStyle(
              fontFamily: 'Arial',
              fontSize: 12,
              color: const Color(0xff2f2e41),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(370.0, 14.0, 16.0, 8.0),
          size: Size(412.0, 30.0),
          child: Stack(
            children: <Widget>[
              SvgPicture.string(
                _svg_qali3j,
                allowDrawingOutsideViewBox: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

const String _svg_qali3j =
    '<svg viewBox="0.0 0.0 16.0 8.0" ><path transform="translate(8.0, 0.0)" d="M 8 0 L 0 8" fill="none" stroke="#2f2e41" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /><path  d="M 0 0 L 8 8" fill="none" stroke="#2f2e41" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
