import 'package:bio/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Widget _getCard(context, main_text, sub_text) {
  return Center(
    child: Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print(main_text);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                main_text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                sub_text,
                style: TextStyle(
                  color: Colors.blueGrey
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildCard(context, option, text) {
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
      if (option == 'opt_2') {
        Navigator.pushNamed(context, '/Index ');
      } else if (option == 'opt_1') {
        print("you clicked my");
      } else {
        print("you clicked my");
      }
    },
  );
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21BFBD),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF21BFBD),
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back), onPressed: () {},
            color: Colors.black,
          ),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('log out'),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            Text(
              'I need help with..',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              height: MediaQuery.of(context).size.height-100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                padding: EdgeInsets.only(top: 30.0),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _getCard(context, 'Genral Health', 'Colf, Flu, Sore throat, cough, fever, headache ...'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _getCard(context, 'Depression', 'Always Feeling sad, feeling hopeless, lonely...'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _getCard(context, 'Nutrition', 'Genral food and health questions'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _getCard(context, 'Child care', 'Genral questions to pediatrician'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _getCard(context, 'Ayrveda', 'Traditional Indian medicinal practice'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _getCard(context, 'TCM', 'Traditional Chinese medicinal practice'),
                  )
                ],
              ),
            )
          ],
        )

    );
  }
}
