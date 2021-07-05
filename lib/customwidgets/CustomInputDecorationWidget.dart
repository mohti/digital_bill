import 'package:flutter/material.dart';

class CoustumInputDecorationWidget extends InputDecoration {
  String _labeltxt = '';
  CoustumInputDecorationWidget(this._labeltxt);
  InputDecoration decoration() {
    return InputDecoration(
        contentPadding: const EdgeInsets.only(left: 8.0, bottom: 1.0, top: 1.0),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(2))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(2))),
        labelStyle: TextStyle(
          fontFamily: 'Bell MT',
          fontSize: 15,
          color: const Color(0x992f2e41),
          fontWeight: FontWeight.w700,
        ),
        labelText: _labeltxt);
  }
}
