import 'package:app/models/user.dart';
import 'package:app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  final String user_uid;
  
  Home(this.user_uid);

  @override
  _HomeState createState() => _HomeState(user_uid);
}

class _HomeState extends State<Home> {
  
  String uid;
  _HomeState(this.uid);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (this.uid == "RbbXreHWQ4gmsEQzEVOeez2KyIE2") {
      return Scaffold(
        appBar: AppBar(
          title: Text("Admin Dashboard"),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
      );
    }
  }
}