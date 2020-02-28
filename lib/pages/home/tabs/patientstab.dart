import 'package:app/models/patients.dart';
import 'package:flutter/material.dart';

class patientsTab extends StatefulWidget {
  @override
  _patientsTabState createState() => _patientsTabState();
}


Future<List<Patients>> _getpatients() async {
  List<Patients> patientsCards = [];



  return patientsCards;
}

Widget listPatients() {
  return FutureBuilder(
    future: _getpatients(),
    builder: (BuildContext context, AsyncSnapshot snapshot){
      if (snapshot.data == null) {
        return Container(
          child: Center(
            child: Text('Loading..'),
          ),
        );
      } else {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) { 
            return ListTile(
              title: Text("hello"),
              subtitle: Text("28 M, 5.5"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                print("clicked $index");
              }
            );
          }
        );
      }
    },
  );
}


class _patientsTabState extends State<patientsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text('Patient'),
          Text('Patient'),
        ],
      ),
    );
  }
}