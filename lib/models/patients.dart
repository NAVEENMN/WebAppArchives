import 'package:app/services/firebasedb.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;

class Patient {
  final String patientId;
  final String patientName;
  Patient({this.patientId, this.patientName});

}


class Patients {
  final String userId;
  
  List<Patient> patientDetails;

  Patients(this.userId);

  final fs.Firestore firestore = fb.firestore();

  Future<void> getPatientDetails() async {
    print("Getting Patient details");
    await firestore.collection('PatientDetails').doc(this.patientId).get().then((snapshot) {
      print(snapshot.data().keys);
    });

  }
}