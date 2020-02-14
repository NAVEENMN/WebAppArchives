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
      return adminView();
    } else {
      return userView();
    }
  }
}

Widget adminView() {
  return Scaffold(
    appBar: AppBar(
      title: Text('Admin Dashboard'),
    ),
    drawer: Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Admin'),
            accountEmail: Text('admin@abc.com'),
            decoration: BoxDecoration(
              image:DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/background/background.png")
              )
            ),
          ),
          ListTile(
            title: Text("Config"),
            trailing: Icon(Icons.settings),
          ),
        ],
      ),
    ),
    body: Center(child: Text('Admin'),),
  );
}


Widget userView() {
  return Scaffold(
    appBar: AppBar(
      title: Text('User Dashboard'),
    ),
  );
}

