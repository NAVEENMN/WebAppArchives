import 'package:app/pages/home/adminView.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String user_uid;
  
  Home(this.user_uid);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  
  TabController control;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    control = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    control.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user_uid == "RbbXreHWQ4gmsEQzEVOeez2KyIE2") {
      return adminView(widget.user_uid, control);
    } else {
      return userView();
    }
  }
}

Widget userView() {
  return Scaffold(
    appBar: AppBar(
      title: Text('User Dashboard'),
    ),
  );
}

