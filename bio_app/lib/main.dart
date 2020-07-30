import 'package:bio/models/user.dart';
import 'package:bio/pages/assistance/providers.dart';
import 'package:bio/pages/dashboard.dart';
import 'package:bio/pages/wrapper.dart';
import 'package:bio/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(RootApp());

// Listen to changes in auth via stream
// and change app flow with
// Stream provider is listening to auth service and
// all desendent widgets can access value
class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: {
          '/Dashboard' : (context) => Dashboard(),
          '/Providers' : (context) => Providers()
        },
      ),
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