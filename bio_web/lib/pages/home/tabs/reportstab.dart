import 'package:app/models/user.dart';
import 'package:app/services/firebasedb.dart';
import 'package:flutter/material.dart';

class reportsTab extends StatefulWidget {
  User user;
  DatabaseService db;
  reportsTab(this.user, this.db);
  @override
  _reportsTabState createState() => _reportsTabState();
}

/*
Widget listReports() {
  return ListView(
    padding: EdgeInsets.all(10),
    children: <Widget>[

    ]
  );
}
*/

class _reportsTabState extends State<reportsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              child: Center(child: Text('All cases shared by Helix member will appear here.')),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Center(child: Text('You can examine, cases and add comments to cases which interests you.')),
            ),
          ),
        ],
      ),
    );
  }
}