import 'package:flutter/material.dart';

class metricsTab extends StatefulWidget {
  @override
  _metricsTabState createState() => _metricsTabState();
}

class _metricsTabState extends State<metricsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: accountSummary(),
          ),
          Center(
            child: Text('2'),
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

Widget accountSummary() {
  return Column(
    children: <Widget>[
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