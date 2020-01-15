import 'package:bio/pages/options_page.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}


// Image.asset('assets/images/options/option_1.png', fit: BoxFit.cover)
Widget _buildCard(text) {
  return GestureDetector(
      child: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Varela',
                color: Colors.white,
                fontWeight:FontWeight.bold
            ),
          ),
          margin: EdgeInsets.all(10),
          width:150,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  image:AssetImage("assets/images/options/option_1.png"),
                  fit:BoxFit.cover
              ),
          )
      ),
      onTap:(){
        print("you clicked my");
      },
  );
}


class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Report',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), onPressed: () {},
          color: Colors.black,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          SizedBox(height: 15.0),
          Text(
            'Welcome',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 40,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 15.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              _buildCard('Research'),
              _buildCard('Get a Doctor'),
              _buildCard('Bio Markers'),
              _buildCard('Order tests')
            ],
          )
        ],
      )

    );
  }
}
