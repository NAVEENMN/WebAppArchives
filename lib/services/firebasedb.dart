import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;


// collection reference for android app
// final CollectionReference ref = Firestore.instance.collection('medteam');
// https://github.com/happyharis/linktree_demo/blob/master/lib/settings.dart
class DatabaseService {

  final String uid;
  final fs.Firestore firestore = fb.firestore();

  DatabaseService(this.uid);
  
  Future updateData(String collectionName, String key, var data) async {    
    var response = await firestore.collection('medteam').doc(this.uid).set({key: data});
    print(response);
    return;
  }

  Future updateUserlogin(String collectionName, var data) async {    
    firestore.collection('medteam').doc(this.uid).set(data);
    return;
  } 

}