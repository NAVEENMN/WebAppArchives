import 'package:bio/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Widget _getCard(context, main_text, sub_text, med_id) {
  return Center(
    child: Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print(main_text);
          Navigator.pushNamed(context, '/Providers', arguments: {
            'med_id': med_id,
          });
        },
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                child: Image.asset('assets/images/logo/logo.png'),
                height: 50,
                width: 50,
                padding: EdgeInsets.all(5),
              ),
              SizedBox(width: 5,),
              Column(
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
              icon: Icon(Icons.apps),
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
              height: MediaQuery.of(context).size.height-200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                padding: EdgeInsets.only(top: 30.0),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _getCard(context, 'Genral Health', 'Colf, Flu, Sore throat, cough, fever, headache ...', 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _getCard(context, 'Depression', 'Always Feeling sad, feeling hopeless, lonely...', 2),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _getCard(context, 'Nutrition', 'Genral food and health questions', 3),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _getCard(context, 'Child care', 'Genral questions to pediatrician', 4),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _getCard(context, 'Ayrveda', 'Traditional Indian medicinal practice', 5),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _getCard(context, 'TCM', 'Traditional Chinese medicinal practice', 6),
                  )
                ],
              ),
            )
          ],
        )

    );
  }
}
