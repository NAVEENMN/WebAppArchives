import 'dart:convert';

import 'package:app/models/fontstyling.dart';
import 'package:app/models/pallet.dart';
import 'package:app/models/patients.dart';
import 'package:app/models/user.dart';
import 'package:app/services/firebasedb.dart';
import 'package:flutter/material.dart';

class patientsTab extends StatefulWidget {
  User user;
  Patients patients;
  DatabaseService db;
  patientsTab(this.user, this.patients, this.db);
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
                  Map<String, dynamic> info = snapshot.data[index].infoJson;
                  String heading = info['info']['name'] +": "+info['info']['id'];
                  String desp = "Age: "+info['info']['age']+" Gender: "+info['info']['gender'];
                  String prf = info['info']['profileImage'];
                  String profileImageUrl = "https://vivly.s3-us-west-2.amazonaws.com/profileImages/${prf}";
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
  DatabaseService db;
  _patientDetails(this.patientSet, this.patientInfo, this.db);
  @override
  __patientDetailsState createState() => __patientDetailsState();
}

Widget _nameCard(Map<String, dynamic> _info) {
  Map<String, dynamic> info = _info['info'];
  print("name card");
  print(info);
  print("====");
  String prf = info['profileImage'];
  String profileImageUrl = "https://vivly.s3-us-west-2.amazonaws.com/profileImages/${prf}";
  String line1 = info['name']+" ("+info['id']+")";
  String line2 = "age: "+info['age']+" gender: "+info['gender'];
  String line3 = info['race'];
  bool isSwitched = false;

  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Flexible(
        flex: 2,
        child: Container(
          width: 100,
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: NetworkImage(profileImageUrl),
              fit: BoxFit.fill,
            )
          )
        ),
      ),
      Flexible(
        flex: 6,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: fontText(line1, 'Roboto', true, Colors.black, 2),
              ),
              Flexible(
                flex: 1,
                child: fontText(line2, 'Roboto', true, Colors.black26, 1.5),
              ),
              Flexible(
                flex: 1,
                child: fontText(line3, 'Roboto', true, Colors.black26, 1.5),
              ),
            ],
          ),
        ),
      ),      
    ],
  );
}

Widget _bioValues(String smarker, String value){
  print("===> secondary marker ${smarker}: ${value}");
  return Row(
    children: <Widget>[
      Flexible(
        flex: 1,
        child: Container(
          height: 40,
          width: 10,
          color: Colors.green,
        ),
      ),
      SizedBox(width: 10,),
      Flexible(
        flex: 2,
        child: fontText(smarker, 'Esteban', false, Colors.black, 1.8),
      ),
      SizedBox(width: 10,),
      Flexible(
        flex: 2,
        child: fontText(value, 'Esteban', false, Colors.black, 1.8),
      )
    ],
  );
}

Widget _bioCard(String cardLabel, Map<String, dynamic> reportsDetail) {
  Map<String, dynamic> reportsDetails = reportsDetail[cardLabel];
  List<Widget> secCardDetails = reportsDetails.keys.map((smarker) => _bioValues(smarker, reportsDetails[smarker])).toList();
  return Card(
    child: Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: fontText(cardLabel, 'Esteban', true, Colors.black, 2),
            ),
          ),
          Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: SizedBox(
                child: new ListView(children: secCardDetails),
              )
            ),
          ),
        ],
      ),
    )
  );
}

List<Widget> getbioCards(Map<String, dynamic> reportsDetails){
  List<Widget> bioCards = reportsDetails.keys.map((plable) => _bioCard(plable.toString(), reportsDetails)).toList();
  return bioCards;
}

Widget _reports(Map<String, dynamic> reportsDetails, bool isEdit, setReportView, int tabIndex) {
  List<String> tabLabel = reportsDetails.keys.map((lable) => lable.toString()).toList();
 
  return DefaultTabController(
    length: tabLabel.length,
    initialIndex: tabIndex,
    child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.delete),
          tooltip: 'Delete this patient record',
          onPressed: () {
            print("Delete this patient record");
          }
        ),
        bottom: TabBar(
          onTap: (int index) {
            tabIndex = index;
            setReportView(tabIndex);
          },
          tabs: tabLabel.map((label) => Tab(child: fontText(label, 'Montserrat', false, Colors.white, 1.3))).toList(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: getbioCards(reportsDetails[tabLabel[tabIndex]]),
        )
      )
    )
  );
  
}

Widget _investigateDetailsPage(String label, Map<String, dynamic> _info, TextEditingController controller, bool isEdit, setReportView, int tabIndex) {
  Map<String, dynamic> infocase = _info['case'];
  print(label);
  if (label == "Reports") {
    return _reports(infocase['Reports'], isEdit, setReportView, tabIndex);
  } else {
    String details = infocase[label].toString();
    print("case ${label} : ${details}");
    if (isEdit) {
      controller.text = details;
      return Container(
        padding: EdgeInsets.all(10.0),
        child: TextField(
          maxLines: 20,
          controller: controller,
        )
      );
    } else {
      return Container(
        padding: EdgeInsets.all(10.0),
        child: Text(details),
      );
    }
  }
}



Widget _patientInvestigation(Map<String, dynamic> _info, bool isEdit, setEditStatus, DatabaseService db, setReportView, int reportTabIndex) {

  String patientID = _info['info']['id'];
  
  List<String> tabLabel = ['Prognosis', 'Diagnosis', 'Treatment', 'Reports', 'Documents', 'Notes'];


  Icon editIcon;
  int tabIndex = 0;
  
  TextEditingController controller = TextEditingController();

  if(isEdit) {
    editIcon = Icon(Icons.save);
  } else {
    editIcon = Icon(Icons.edit);
  }
  
  return DefaultTabController(
    length: tabLabel.length,
    initialIndex: tabIndex,
    child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.delete),
          tooltip: 'Delete this patient record',
          onPressed: () {
            print("Delete this patient record");
          }
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            tooltip: 'Send this is patient record to someone',
            onPressed: () {
              print("Send this patient record to someone");
            }
          ),
          IconButton(
            icon: Icon(Icons.share),
            tooltip: 'Share this is patient record with Helix network',
            onPressed: () {
              print("Share this patient record with Helix network");
            }
          ),
          IconButton(
            icon: Icon(Icons.chat),
            tooltip: 'Send a message to patient',
            onPressed: () {
              print("make a chat");
            }
          ),
          IconButton(
            icon: Icon(Icons.call),
            tooltip: 'call patient',
            onPressed: () {
              print("make a call");
            }
          ),
          IconButton(
            icon: Icon(Icons.video_call),
            tooltip: 'video call patient',
            onPressed: () {
              print("make a video chat");
            }
          ),
        ],
        bottom: TabBar(
          onTap: (int index) {
            tabIndex = index;
          },
          tabs: tabLabel.map((label) => Tab(child: fontText(label, 'Montserrat', false, Colors.white, 1.3))).toList(),
          )
        ),
    body: Container(
      child: TabBarView(
        children: tabLabel.map((label) => _investigateDetailsPage(label, _info, controller, isEdit, setReportView, reportTabIndex)).toList(),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        print('edit');
        setEditStatus();
        print("save");
        print(controller.value.text);
        if(isEdit) {
          _info['case'][tabLabel[tabIndex]] = controller.value.text;
          db.updatePatientInvestigateData(patientID, _info);
        }
      },
      child: editIcon,
      backgroundColor: Colors.green,
      elevation: 0.0,
    ),
  )
  ,
  );
  
}

class __patientDetailsState extends State<_patientDetails> {

  bool isPublic = false;
  bool isEdit = false;
  String publicLabel = "Private";
  int tabIndex = 0;
  int reportIndex = 0;

  @override
  Widget build(BuildContext context) {

    void setPublicStatus(isPublic){
      print("setting status");
      setState(() {
        isPublic = !isPublic;
      });
    }

    void setEditStatus(){
      print("setting Edit status");
      setState(() {
        isEdit = !isEdit;
      });
    }

    void setReportView(int curIndex){
      print("report view");
      setState(() {
        reportIndex = curIndex;
      });
    }
    print("edit");
    print(isEdit);

    if (!widget.patientSet) {
      return Scaffold(
      body: Center(
        child: Text("Select a patient"),
      ),
    );

    } else {
      Map<String, dynamic> info = widget.patientInfo.infoJson;
      

      print("====");
      print(info);
      print("====");

      List<Widget> bioCards = new List();

      /*
      for (var key in widget.patientInfo.infoJson.keys) {
        if( key == "info" || key == "case" ){
          continue;
        }
        List<Widget> bioDetailsCards = new List();
        Map<String, dynamic> payloadvalue = widget.patientInfo.infoJson[key];
        for (var label in payloadvalue.keys) {
          Map<String, dynamic> secDetails = payloadvalue[label];
          for (var marker in secDetails.keys) {
            bioDetailsCards.add(
              Card(
                child: _lableValue(marker, secDetails[marker]),
              )
            );
          }
        }
        bioCards.add(_bioCard(key, bioDetailsCards));
      }
      */

      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: _nameCard(info),
              ),
            ),
            Flexible(
              flex: 8,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: _patientInvestigation(info, isEdit, setEditStatus, widget.db, setReportView, reportIndex),
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
              child: _patientDetails(widget.patients.setFlag, widget.patients.currentPatient, widget.db),
            ),
          ),
        ],
      ),
    );
  }
}