import 'package:app/pages/home/accounttab.dart';
import 'package:app/pages/home/metricstab.dart';
import 'package:flutter/material.dart';

class adminView extends StatefulWidget {

  final String user_uid;
  final TabController control;

  adminView(this.user_uid, this.control);

  @override
  _adminViewState createState() => _adminViewState();
}

class _adminViewState extends State<adminView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('Admin Dashboard'),
      bottom: TabBar(
        controller: widget.control,
        tabs: <Widget>[
          Tab(icon: Icon(Icons.directions_car)),
          Tab(icon: Icon(Icons.directions_transit)),
          Tab(icon: Icon(Icons.directions_bike)),
        ],
      ),
    ),
    drawer: Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Admin'),
            accountEmail: Text(widget.user_uid),
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
    body: TabBarView(
      controller: widget.control,
      children: <Widget>[
        metricsTab(),
        accounttab(),
        Center(
          child: Text('To be implemented'),
        )
      ],
    )
  );
  }
}