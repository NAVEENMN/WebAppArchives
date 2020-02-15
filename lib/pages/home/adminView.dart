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

  List<String> log_list = new List<String>();
  
  void update_log(String log_element) {
    setState(() {
        log_list.add(log_element);
      });
  }

  Text log_format(String txt) {
    var now = new DateTime.now();
    return Text(
      "${now} - ${txt}",
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.white
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('Admin Dashboard'),
      bottom: TabBar(
        controller: widget.control,
        tabs: <Widget>[
          Tab(
            child: Text('Metrics'),
            icon: Icon(Icons.assessment),
          ),
          Tab(
            child: Text('Accounts'),
            icon: Icon(Icons.people),
          ),
          Tab(
            child: Text('Research'),
            icon: Icon(Icons.directions_car),
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
            child: TabBarView(
            controller: widget.control,
            children: <Widget>[
              metricsTab(update_log),
              accounttab(),
              Center(
                child: Text('To be implemented'),
                )
              ],
              ),
            )
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              constraints: BoxConstraints.expand(),
              color: Colors.black,
              child: ListView.builder(
                itemCount: log_list.length,
                itemBuilder: (context, index) {
                  return log_format(log_list[index]);
                },
              ),
              )
          )
      ],
    )
  );
  }
}