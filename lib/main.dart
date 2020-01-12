import 'package:flutter/material.dart';
import 'package:bio/pages/loading.dart';
import 'package:bio/pages/login.dart';

void main() => runApp(MaterialApp(
  home: Home(),
  initialRoute: '/Login',
  routes: {
    '/Loading' : (context) => Loading(),
    '/Home' : (context) => Home(),
    '/Login' : (context) => Login(),
  },
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text('Home')),
    );
  }
}
