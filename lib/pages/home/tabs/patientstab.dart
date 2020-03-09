import 'dart:convert';

import 'package:app/models/fontstyling.dart';
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
                  print("---");
                  Map<String, dynamic> info = snapshot.data[index].infoJson;
                  print(info['info']);
                  print(info['info']['name']);
                  print("---");
                  String heading = info['info']['name'] +": "+info['info']['id'];
                  String desp = "Age: "+info['info']['age']+" Gender: "+info['info']['gender'];
                  String prf = 'RC1AymdClNV791lk5Ls78zVlSzq1';
                  String profileImageUrl = "https://vivly.s3-us-west-2.amazonaws.com/profileImages/${prf}.jpg";
                  return ListTile(
                    title: Text(heading),
                    subtitle: Text(desp),
                    trailing: Icon(Icons.arrow_forward_ios),
                    leading: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: NetworkImage(profileImageUrl),
                          fit: BoxFit.fill,
                        )
                      )
                    ),
                    onTap: () {
                      print("clicked $index");
                      patients.currentPatient = patients.patientDetails[index];
                      patients.setFlag = true;
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
  bool patientSet;
  Patient patientInfo;
  _patientDetails(this.patientSet, this.patientInfo);
  @override
  __patientDetailsState createState() => __patientDetailsState();
}

  Widget _nameCard(Map<String, dynamic> info) {
    String prf = 'RC1AymdClNV791lk5Ls78zVlSzq1';
    String profileImageUrl = "https://vivly.s3-us-west-2.amazonaws.com/profileImages/${prf}.jpg";
    String line1 = info['name']+" ("+info['id']+")";
    String line2 = "age: "+info['age']+" gender: "+info['gender']+" racial backgroung: "+info['race'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: 100,
          height: 100,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: NetworkImage(profileImageUrl),
              fit: BoxFit.fill,
            )
          )
        ),
        SizedBox(width: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            fontText(line1, 'Esteban', true, Colors.black, 2),
            fontText(line2, 'Esteban', true, Colors.black26, 1.5),
          ],
        )
      ],
    );
  }

Widget _bioCard(String label, List<Widget> details){
  return Card(
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: fontText(label, 'Esteban', true, Colors.black, 2),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: details,
          ),
        ),
      ],
    ),
  );
}

Widget _lableValue(String label, String value){
  return Row(
    children: <Widget>[
      Flexible(
        flex: 1,
        child: Container(
          height: 20,
          width: 10,
          color: Colors.green,
        ),
      ),
      SizedBox(width: 10,),
      Flexible(
        flex: 2,
        child: fontText(label, 'Esteban', false, Colors.black, 1.8),
      ),
      SizedBox(width: 10,),
      Flexible(
        flex: 2,
        child: fontText(value, 'Esteban', false, Colors.black, 1.8),
      )
    ],
  );
}

class __patientDetailsState extends State<_patientDetails> {

  @override
  Widget build(BuildContext context) {
    print(widget.patientInfo);
    if (!widget.patientSet) {
      return Scaffold(
      body: Center(
        child: Text("Select a patient"),
      ),
    );
    } else {
      Map<String, dynamic> info = widget.patientInfo.infoJson['info'];
      List<Widget> bioCards = new List();

      for (var key in widget.patientInfo.infoJson.keys) {
        if( key == "info" ){
          continue;
        }
        List<Widget> bioDetailsCards = new List();
        print("--- "+ key+" ---");
        Map<String, dynamic> payloadvalue = widget.patientInfo.infoJson[key];
        for (var label in payloadvalue.keys) {
          Map<String, dynamic> secDetails = payloadvalue[label];
          for (var marker in secDetails.keys) {
            print(marker+": "+secDetails[marker]);
            bioDetailsCards.add(
              Card(
                child: _lableValue(marker, secDetails[marker]),
              )
            );
          }
        }
        bioCards.add(_bioCard(key, bioDetailsCards));
        print("------");
      }

      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: _nameCard(info),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Scaffold(
                  body: GridView.count(
                    crossAxisCount: 2,
                    children: bioCards,
                  ),
                ),
              ),
            ),
          ],
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
    
    void setPatientDetails(int index) {
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
              child: _patientDetails(widget.patients.setFlag, widget.patients.currentPatient),
            ),
          ),
        ],
      ),
    );
  }
}