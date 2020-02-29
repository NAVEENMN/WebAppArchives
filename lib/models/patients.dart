import 'package:app/models/user.dart';
import 'package:app/services/firebasedb.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;

class Patient {
  final String patientId;
  final String patientName;
  Patient({this.patientId, this.patientName});
}

class Patients {
  final User user;
  List<Patient> patientDetails = new List<Patient>();

  Patients(this.user);

  final fs.Firestore firestore = fb.firestore();

  Future<void> getPatientDetails() async {
    print("Getting Patient details");
    print(user.patientIds);
    for(var i=0; i<user.patientIds.length; i++) {
      String patientId = user.patientIds[i];
      await firestore.collection('PatientDetails').doc(patientId).get().then((snapshot) {
        if(snapshot.exists) {
          Map<String, dynamic> data = snapshot.data();
          print(data);
          Patient _patient = Patient(patientId: patientId, patientName: data['name']);
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