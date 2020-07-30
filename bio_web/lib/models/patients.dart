import 'package:app/models/user.dart';
import 'package:app/services/firebasedb.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;

class Patient {
  final Map<String, dynamic> infoJson;
  Patient({this.infoJson});
}

class Patients {
  final User user;
  List<Patient> patientDetails = new List<Patient>();
  Patient currentPatient;
  bool setFlag = false;

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
          Patient _patient = Patient(infoJson: data);
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