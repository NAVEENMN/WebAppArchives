import 'package:app/models/fontstyling.dart';
import 'package:app/models/user.dart';
import 'package:app/pages/home/views/adminView.dart';
import 'package:app/pages/home/views/userView.dart';
import 'package:app/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

var client = http.Client();

class Home extends StatefulWidget {
  final User user;
  final Utils utils;

  Home(this.user, this.utils);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  
  TabController control;
  bool loadingScreen = true;
  User usr;
  
  void getUserDetails() async {
    print("Get user details");
    await widget.user.getUserDetails();
    setState(() {
      loadingScreen = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    control = new TabController(vsync: this, length: 3);
    getUserDetails();
  }

  @override
  void dispose() {
    control.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.user.uid == "RbbXreHWQ4gmsEQzEVOeez2KyIE2") {
      return adminView(widget.user.uid, control);
    } else {
      // check if user info is valid if not take them to register page
      if (loadingScreen) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Dash board'),
          ),
          body: Center(
            child: Text('Loading..'),
          ),
        );
      } else {
        return userView(usr: widget.user, control: control, utils: widget.utils);
    }
  }
  }
}