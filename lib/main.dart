import 'package:flutter/material.dart';
import 'package:bio/pages/loading.dart';
import 'package:bio/pages/login.dart';
import 'package:bio/pages/dashboard.dart';

void main() => runApp(MaterialApp(
  home: Home(),
  initialRoute: '/Login',
  routes: {
    '/Loading' : (context) => Loading(),
    '/Home' : (context) => Home(),
    '/Login' : (context) => Login(),
    '/Dashboard' : (context) => Dashboard(),
  },
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class Api
{
  BuildContext context;
  Api({this.context});
}

class _HomeState extends State<Home> {

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
