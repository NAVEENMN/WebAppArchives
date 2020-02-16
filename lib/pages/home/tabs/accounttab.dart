import 'package:app/models/user.dart';
import 'package:app/pages/home/pages/createAccountPage.dart';
import 'package:app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class accounttab extends StatefulWidget {

  final Function update_log;
  final FirebaseAuth _adminAuth = FirebaseAuth.instance;

  accounttab(this.update_log);

  @override
  _accounttabState createState() => _accounttabState();
}

Widget accountCreate(widget) {
  
  return Column(
    children: <Widget>[
      Text('Account Create',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      createAccountPage(widget._adminAuth, widget.update_log)
    ],
  );
}

class _accounttabState extends State<accounttab> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 4,
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: accountCreate(widget),
            ),
          ),
          Center(
            child: Text('2'),
          ),
          Center(
            child: Text('3'),
          ),
          Center(
            child: Text('4'),
          ),
          Center(
            child: Text('5'),
          ),
          Center(
            child: Text('6'),
          ),
        ],
      ),
    );
  }
}