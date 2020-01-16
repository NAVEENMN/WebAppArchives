import 'package:bio/pages/wrapper.dart';
import 'package:flutter/material.dart';


void main() => runApp(RootApp());

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
    );
  }
}

/*

import 'package:bio/pages/loading.dart';
import 'package:bio/pages/login.dart';
import 'package:bio/pages/dashboard.dart';
import 'package:bio/pages/index.dart';
import 'package:bio/pages/call.dart';

void main() => runApp(MaterialApp(
  home: Home(),
  initialRoute: '/Login',
  routes: {
    '/Loading' : (context) => Loading(),
    '/Home' : (context) => Home(),
    '/Login' : (context) => Login(),
    '/Dashboard' : (context) => Dashboard(),
    '/Index' : (context) => IndexPage(),
    '/Call' : (context) => CallPage(),
  },
));

class Home1 extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState1();
}

class Api
{
  BuildContext context;
  Api({this.context});
}

class _HomeState1 extends State<Home1> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Api api = Api(context: context);
    //Navigator.pushNamed(context, '/Login');
    return Scaffold(
      body: SafeArea(child: Text('Home')),
    );
  }
}
*/