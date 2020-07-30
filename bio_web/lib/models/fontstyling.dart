import 'package:flutter/material.dart';

Widget fontText(String text, String family, bool bold, Color color, double sizefactor) {
  
  double baseSize = 10.0;

  return Text(
    text,
    style: TextStyle(
      fontSize: baseSize * sizefactor,
      fontFamily: family,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: color
    ),
  );
}