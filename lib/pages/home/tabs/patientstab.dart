import 'package:app/models/pallet.dart';
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


Widget listPatients(Patients patients, setPatientDetails) {
  Pallet pallet = Pallet();
  return ListView(
    padding: EdgeInsets.all(10),
    children: <Widget>[
      Container(
        height: 500,
        color: pallet.shadePolite4,
        child: FutureBuilder(
          future: _getpatients(patients),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.data == null) {
              return Container(
                child: Text('Loading..'),
              );
            } else {
              // for initial setup
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  print(snapshot.data[index]);
                  String heading = snapshot.data[index].id +": "+snapshot.data[index].name;
                  String desp = "Age: "+snapshot.data[index].age+" Gender: "+snapshot.data[index].gender;
                  return ListTile(
                    title: Text(heading),
                    subtitle: Text(desp),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      print("clicked $index");
                      patients.currentPatient = patients.patientDetails[index];
                      setPatientDetails(index); 
                    },
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


class _patientDetails extends StatefulWidget {
  int patientID;
  Patients patientInfos;
  _patientDetails(this.patientID, this.patientInfos);
  @override
  __patientDetailsState createState() => __patientDetailsState();
}

class __patientDetailsState extends State<_patientDetails> {

  @override
  Widget build(BuildContext context) {
    print("budd");
    if (widget.patientInfos.patientDetails.length == 0) {
      return Scaffold(
      body: Center(
        child: Text("No patients"),
      ),
    );
    } else {
      print("name");
      print(widget.patientInfos.currentPatient.name);
      return Scaffold(
      body: Center(
        child: Text(widget.patientID.toString()),
      ),
    );
    }
  }
}

class _patientsTabState extends State<patientsTab> {

  int patientIndex = 0;

  @override
  Widget build(BuildContext context) {
    print("building patients tab");

    void setPatientDetails(int index){
      setState(() {
        patientIndex = index;
      });
    }

    return Container(
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              child: listPatients(widget.patients, setPatientDetails),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: _patientDetails(patientIndex, widget.patients),
            ),
          ),
        ],
      ),
    );
  }
}