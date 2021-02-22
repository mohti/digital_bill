import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../home.dart';

class HomePageIcon extends StatelessWidget {
  final List<Widgetfunction> l;
  final List<String> s;
  final int i;
  HomePageIcon(this.l, this.s, this.i);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: l[i].f,
          child: Stack(alignment: Alignment.center, children: [
            SvgPicture.string(
              '<svg viewBox="36.0 575.0 55.0 55.0" ><defs><filter id="shadow"><feDropShadow dx="3" dy="6" stdDeviation="16"/></filter></defs><path transform="translate(36.0, 575.0)" d="M 15 0 L 40 0 C 48.28427124023438 0 55 6.715728759765625 55 15 L 55 40 C 55 48.28427124023438 48.28427124023438 55 40 55 L 15 55 C 6.715728759765625 55 0 48.28427124023438 0 40 L 0 15 C 0 6.715728759765625 6.715728759765625 0 15 0 Z" fill="#2f2e41" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>',
              allowDrawingOutsideViewBox: true,
            ),
            l[i].w
          ]),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          s[i],
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 10,
            color: const Color(0xff02020a),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
