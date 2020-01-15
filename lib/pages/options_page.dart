import 'package:flutter/material.dart';

Widget _buildCard(text) {
  return Padding(
    padding: EdgeInsets.only(top: 15.0, left: 5.0, bottom: 5.0, right: 5.0),
    child: InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 3.0,
                  blurRadius: 5.0
              )
            ],
            color: Colors.white
        ),
      ),
    ),
  );
}

class OptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.lightGreen,
    body: ListView(
      children: <Widget>[
        SizedBox(height: 15.0,),
        Container(
          padding: EdgeInsets.only(right: 15.0),
          width: MediaQuery.of(context).size.width - 30.0,
          height: MediaQuery.of(context).size.height - 50.0,
          child: GridView.count(
            crossAxisCount: 2,
            primary: false,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 15.0,
            childAspectRatio: 0.8,
            children: <Widget>[
              _buildCard('Research'),
              _buildCard('Get Doctor'),
              _buildCard('Bio Marker'),
            ],
          ),
        )
      ],
    ),
    );
  }
}
