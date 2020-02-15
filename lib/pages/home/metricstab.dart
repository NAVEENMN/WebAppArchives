import 'package:flutter/material.dart';

class metricsTab extends StatefulWidget {

  final Function update_log;
  metricsTab(this.update_log);

  @override
  _metricsTabState createState() => _metricsTabState();
}

class _metricsTabState extends State<metricsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 4,
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: accountSummary(widget),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: accountSummary(widget),
            ),
          ),
          Center(
            child: Text('3'),
          ),
          Center(
            child: Text('4'),
          ),
          Center(
            child: Text('5'),
          ),
          Center(
            child: Text('6'),
          ),
        ],
      ),
    );
  }
}

Widget accountSummary(widget) {
  return Column(
    children: <Widget>[
      IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () {
          widget.update_log('Hello');
        },
      ),
      Text(
        'Account Metrics',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        ),
      Row(children: <Widget>[
        Text('Total service provider accounts :'),
        Text('10'),
      ],),
      Row(children: <Widget>[
        Text('Total users(patient) accounts :'),
        Text('10'),
      ],),
    ],
  );
}