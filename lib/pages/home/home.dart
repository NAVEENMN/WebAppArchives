import 'package:bio/services/auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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
  int _current_index = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<IllnessCard>> _getillness() async {
    var data = await http.get("http://52.39.96.192/app/getproblems");
    var jsonData = json.decode(data.body);
    List<IllnessCard> illness_cards = [];
    if (jsonData['success']) {
      var _payload = jsonData['payload'];
      var problems = _payload[0]['problems'];
      for(int i =0; i<problems.length; i++) {
        var key = 'p_' + i.toString();
        var element = problems[i][key];
        illness_cards.add(
            IllnessCard(i, element['name'], element['description']));
      }
    }
    return illness_cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
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
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.white,
          backgroundColor: Colors.blue,
          buttonBackgroundColor: Colors.white,
          height: 50,
          index: _current_index,
          items: [
            Icon(Icons.description, color: Colors.black),
            Icon(Icons.home, color: Colors.black),
            Icon(Icons.people, color: Colors.black),
          ],
          animationDuration: Duration(milliseconds: 200),
          animationCurve: Curves.bounceInOut,
          onTap: (index) {
            setState(() {
              _current_index = index;
            });
          },
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
                color: Colors.blue,
              ),
              child: FutureBuilder(
                future: _getillness(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if (snapshot.data == null) {
                    return Container (
                      child: Center(
                        child: Text('Loading...'),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            snapshot.data[index].name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(snapshot.data[index].description),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            print("clicked $index");
                          },
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        )
    );
  }
}

class IllnessCard {
  final int index;
  final String name;
  final String description;
  IllnessCard(this.index, this.name, this.description);
}