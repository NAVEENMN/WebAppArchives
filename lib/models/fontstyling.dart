import 'package:flutter/material.dart';

Widget fontText(String text, String family, bool bold, Color color) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: family,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: color
    ),
  );
}