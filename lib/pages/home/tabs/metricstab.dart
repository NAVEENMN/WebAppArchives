import 'package:flutter/material.dart';

class metricsTab extends StatefulWidget {

  final Function update_log;
  metricsTab(this.update_log);

  @override
  _metricsTabState createState() => _metricsTabState();
}

Widget text_heading(String txt) {
  return Text(
    txt,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold
    ),
  );
}

Widget accountSummary(widget) {
  return Column(
    children: <Widget>[
      Row(
        children: <Widget>[
          text_heading('Account Metrics'),
          IconButton(icon: Icon(Icons.refresh), onPressed: () {
            widget.update_log('Running Account Summary');
          }
          ),
        ],
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

Widget researchSummary(widget) {
  return Column(
    children: <Widget>[
      Row(
        children: <Widget>[
          text_heading('Research Metrics'),
          IconButton(icon: Icon(Icons.refresh), onPressed: () { 
            widget.update_log('Running Research Summary');
          }
          ),
        ],
      ),
      Row(children: <Widget>[
        Text('Total pending posts :'),
        Text('0'),
      ],),
      Row(children: <Widget>[
        Text('Total published posts :'),
        Text('10'),
      ],),
    ],
  );
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
              child: researchSummary(widget),
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