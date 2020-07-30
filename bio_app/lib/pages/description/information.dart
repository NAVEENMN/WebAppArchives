import 'dart:ui';

import 'package:flutter/material.dart';

class Information extends StatelessWidget {

  final String page_name;
  final String long_description;

  Information(this.page_name, this.long_description);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(page_name),
        backgroundColor: Color(0xffe85358),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,), onPressed: () {
            Navigator.pop(context);
        },
          color: Colors.black,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(
            'assets/images/problems/depression/depression.png',
            fit: BoxFit.fitWidth,
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              this.long_description,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
          ),
          Center(
           child: FlatButton.icon(
             color: Color(0xffff9e91),
             label: Text(
               'Find a practioner',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   color: Colors.black
               ),
             ),
             onPressed: () {
               print('Find');
             },
             icon: Icon(Icons.search),
           ),
          )
        ],

      ),
    );
  }
}