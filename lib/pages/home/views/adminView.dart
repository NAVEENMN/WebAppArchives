import 'package:app/models/fontstyling.dart';
import 'package:app/models/logging.dart';
import 'package:app/pages/home/tabs/accounttab.dart';
import 'package:app/pages/home/tabs/metricstab.dart';
import 'package:flutter/material.dart';

class adminView extends StatefulWidget {

  final String user_uid;
  final TabController control;

  adminView(this.user_uid, this.control);

  @override
  _adminViewState createState() => _adminViewState();
}

class _adminViewState extends State<adminView> {

  adminlogging lg = adminlogging();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text(
        'Admin Dashboard',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat'
        ),
      ),
      centerTitle: true,
      bottom: TabBar(
        controller: widget.control,
        tabs: <Widget>[
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.assessment),
                SizedBox(width: 2,),
                fontText('Metrics', 'Montserrat', false, Colors.white, 1.5),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.people),
                SizedBox(width: 2,),
                fontText('Accounts', 'Montserrat', false, Colors.white, 1.5),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.assignment),
                SizedBox(width: 2,),
                fontText('Research', 'Montserrat', false, Colors.white, 1.5),
              ],
            ),
          ),
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
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Flexible(
          flex: 2, 
          child: Container(
            padding: EdgeInsets.all(10),
            child: TabBarView(
            controller: widget.control,
            children: <Widget>[
              metricsTab(lg),
              accounttab(lg),
              Center(
                child: Text('To be implemented'),
                )
              ],
              ),
            )
          ),
          Flexible(
            flex: 1,
            child: ValueListenableBuilder(
              valueListenable: lg.counter,
              builder: (BuildContext context, int value, Widget child) {
                return Container(
              padding: EdgeInsets.all(10),
              constraints: BoxConstraints.expand(),
              color: Colors.black,
              child: ListView.builder(
                itemCount: lg.logList.length,
                itemBuilder: (context, index) {
                  return lg.logLines[index];
                },
              ),
              );
              },
            ),
          )
      ],
    )
  );
  }
}