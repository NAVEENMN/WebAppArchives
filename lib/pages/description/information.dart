import 'package:flutter/material.dart';

class Information extends StatelessWidget {

  final String page_name;

  Information(this.page_name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(page_name),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), onPressed: () {
            Navigator.pop(context);
        },
          color: Colors.black,
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          Center(
            child: Text('Hello'),
          ),
        ],
      ),
    );
  }
}

