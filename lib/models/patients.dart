import 'package:app/models/user.dart';
import 'package:app/services/firebasedb.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;

class Patient {
  final String id;
  final String name;
  final String age;
  final String gender;
  Patient({this.id, 
    this.name,
    this.age,
    this.gender});
}

class Patients {
  final User user;
  List<Patient> patientDetails = new List<Patient>();
  Patient currentPatient;

  Patients(this.user);

  final fs.Firestore firestore = fb.firestore();

  Future<void> getPatientDetails() async {
    print("Getting Patient details");
    print(user.patientIds);
    // sanity clearing
    patientDetails.clear();
    for(var i=0; i<user.patientIds.length; i++) {
      String patientId = user.patientIds[i];
      await firestore.collection('PatientDetails').doc(patientId).get().then((snapshot) {
        if(snapshot.exists) {
          Map<String, dynamic> data = snapshot.data();
          print(data);
          Patient _patient = Patient(id: patientId, 
            name: data['name'],
            age: data['age'],
            gender: data['gender']);
          this.patientDetails.add(_patient);
        } else {
          print('Not such document or couldnt get data');
        }
      }).catchError(() {
          print('Exception');
        }
      );
    }
  }
}