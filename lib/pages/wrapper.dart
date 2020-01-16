import 'package:bio/pages/home/home.dart';
import 'package:flutter/material.dart';

// Return either home or authenticate page
// Depending on signed in or not
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
