import 'package:app/models/user.dart';
import 'package:app/pages/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  User user;
  Authenticate(this.user);
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return SignIn(widget.user);
  }
}