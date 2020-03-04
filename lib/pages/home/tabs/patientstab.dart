import 'package:app/models/patients.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';

class patientsTab extends StatefulWidget {
  User user;
  Patients patients;
  patientsTab(this.user, this.patients);
  @override
  _patientsTabState createState() => _patientsTabState();
}


Future<List<Patient>> _getpatients(Patients patients) async {
  await patients.getPatientDetails();
  print("details");
  return patients.patientDetails;
}


Widget listPatients(Patients patients) {

  return ListView(
    padding: EdgeInsets.all(10),
    children: <Widget>[
      SizedBox(height: 10,),
      Text('Patients'),
      SizedBox(height: 15.0),
      Container(
        height: 500,
        child: FutureBuilder(
          future: _getpatients(patients),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.data == null) {
              return Container(
                child: Text('Loading..'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  print(snapshot.data[index]);
                  String heading = snapshot.data[index].id +": "+snapshot.data[index].name;
                  String desp = "Age: "+snapshot.data[index].age+" Gender: "+snapshot.data[index].gender;
                  return ListTile(
                    title: Text(heading),
                    subtitle: Text(desp),
                  );
                },
              );
            }
          }
        ),
      )
    ],
  );
  
}


class _patientsTabState extends State<patientsTab> {

  @override
  Widget build(BuildContext context) {
    print("building patients tab");

    return Container(
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              child: listPatients(widget.patients),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Text('Loading'),
            ),
          ),
        ],
      ),
    );
  }
}