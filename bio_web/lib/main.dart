import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:app/models/user.dart';
import 'package:app/services/auth.dart';
import 'package:app/pages/wrapper.dart';

void main() => runApp(RootApp());

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: OverlaySupport(
        child:MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    ));
  }
}