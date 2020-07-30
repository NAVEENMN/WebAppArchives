import 'package:app/services/firebasedb.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:app/models/server.dart';

class Name {

  String title;
  String firstName;
  String lastName;
  Name({this.title, this.firstName, this.lastName});

  static String toJson(Name n) {
    Map<String, dynamic> map() =>
    {
      'title': n.title,
      'firstName': n.firstName,
      'lastName': n.lastName
    };
    String result = jsonEncode(map());
    return result;
  }
  
  Map getMap() {
    return {
      'title': this.title,
      'firstName': this.firstName,
      'lastName': this.lastName
    };
  }

  void setMap(Map<String, dynamic> data) {
    this.title = data['title'];
    this.firstName = data['firstName'];
    this.lastName = data['lastName'];
  }

}

class Location {
  String cityName;
  String stateName;
  String countryName;
  String zipCode;
  Location({this.cityName, this.stateName, this.countryName, this.zipCode});

  static String toJson(Location l) {
    Map<String, dynamic> map() =>
    {
      'cityName': l.cityName,
      'stateName': l.stateName,
      'countryName': l.countryName,
      'zipCode': l.zipCode
    };
    String result = jsonEncode(map());
    return result;
  }

  Map getMap() {
    return {
      'cityName': this.cityName,
      'stateName': this.stateName,
      'countryName': this.countryName,
      'zipCode': this.zipCode
    };
  }

  void setMap(Map<String, dynamic> data) {
    this.cityName = data['cityName'];
    this.stateName = data['stateName'];
    this.countryName = data['countryName'];
    this.zipCode = data['zipCode'];
  }

}

class Profession {
  String designation;
  List<dynamic> specialities;
  String description;
  Profession({this.designation, this.specialities, this.description});

  static String toJson(Profession p) {
    Map<String, dynamic> map() =>
    {
      'designation': p.designation,
      'specialities': p.specialities,
      'description': p.description
    };
    String result = jsonEncode(map());
    return result;
  }

  Map getMap() {
    return {
      'designation': this.designation,
      'specialities': this.specialities,
      'description': this.description
    };
  }

  void setMap(Map<String, dynamic> data) {
    this.designation = data['designation'];
    this.specialities = data['specialities'];
    this.description = data['description'];
  }

}

class Education {
  String degreeName;
  String universityName;
  Education({this.degreeName, this.universityName});

  static String toJson(Education e) {
    Map<String, dynamic> map() =>
    {
      'degreeName': e.degreeName,
      'universityName': e.universityName
    };
    String result = jsonEncode(map());
    return result;
  }

  Map getMap() {
    return {
      'degreeName': this.degreeName,
      'universityName': this.universityName
    };
  }

  void setMap(Map<String, dynamic> data) {
    this.degreeName = data['degreeName'];
    this.universityName = data['universityName'];
  }
  

}

class Contact {
  String email;
  String phone;
  Contact({this.email, this.phone});

  static String toJson(Contact c) {
    Map<String, dynamic> map() =>
    {
      'email': c.email,
      'phone': c.phone
    };
    String result = jsonEncode(map());
    return result;
  }

  Map getMap() {
    return {
      'email': this.email,
      'phone': this.phone
    };
  }

  void setMap(Map<String, dynamic> data) {
    this.email = data['email'];
    this.phone = data['phone'];
  }

}

class User {
  // User id
  String uid;
  String email;

  String gender;
  Name name_ = Name();
  Location location_ = Location();
  Education education_ = Education();
  Profession profession_ = Profession();
  Contact contact_ = Contact();
  List<dynamic> languages = new List<dynamic>();
  List<dynamic> areas = new List<dynamic>();
  List<dynamic> patientIds = new List<dynamic>();
  List<dynamic> incomingPatientIds = new List<dynamic>();
  String profilePic = "";
  bool isUpdate = false;

  final fs.Firestore firestore = fb.firestore();
   
  User({this.uid, this.email});

  static String toJson(User user) {
    Map<String, dynamic> map() =>
    {
      'uid': user.uid,
      'email': user.email,
      'gender': user.gender,
      'name': Name.toJson(user.name_),
      'location': Location.toJson(user.location_),
      'education': Education.toJson(user.education_),
      'profession': Profession.toJson(user.profession_),
      'contact': Contact.toJson(user.contact_),
      'languages': user.languages,
      'areas': user.areas,
      'profilePicture': user.profilePic,
      'isUpdate': user.isUpdate
    };

    String result = jsonEncode(map());
    return result;
  }

  Server server = Server();
  
  Map getMap() {
    return {
      'uid': this.uid,
      'email': this.email,
      'gender': this.gender,
      'name': this.name_.getMap(),
      'location': this.location_.getMap(),
      'education': this.education_.getMap(),
      'profession': this.profession_.getMap(),
      'contact': this.contact_.getMap(),
      'languages': this.languages,
      'areas': this.areas,
      'profilePicture': this.profilePic,
      'isUpdate': this.isUpdate
    };
  }

  Future<void> updateUserDetails(DatabaseService ref) async {
    print("Adding User details");

    await firestore.collection('MedAccounts').doc(this.uid).set({'details': getMap()});

    // Legacy code
    /*
    String resourceUrl = "accounts";
    http.Response data = await server.postData(resourceUrl, jsonData);
    print(data.body);
    return;
    */
  }

  Future<void> getUserDetails() async {
    print("Getting User details");
    await firestore.collection('MedAccounts').doc(this.uid).get().then((snapshot) {
      if(snapshot.exists) {
        print("Found record");
        Map<String, dynamic> data = snapshot.data();
        this.name_.setMap(data['details']['name']);
        this.location_.setMap(data['details']['location']);
        this.education_.setMap(data['details']['education']);
        this.contact_.setMap(data['details']['contact']);
        this.profession_.setMap(data['details']['profession']);
        this.languages = data['details']['languages'];
        this.areas = data['details']['areas'];
        this.profilePic = data['details']['profilePicture'];
        // Patients
        print(data['patients']);
        this.patientIds = data['patients'];
        this.isUpdate = true;
      } else {
        print('Not such document or couldnt get data');
        this.isUpdate = false;
      }
      }).catchError(() {
        print('Exception');
        this.isUpdate = false;
      }
    );
  }

  Future<void> getUserDetails_() async {
    print("Getting User details");
    String resourceUrl = "accounts";
    String params = "collection=Medteam&filter_by=id&id=${uid}";
    http.Response data = await server.getData(resourceUrl, params);
    var jsonData = json.decode(data.body);
    if (jsonData['success']) {
      var payload = jsonData['payload'];
      print(payload);
      try {
        if(payload[0] == null) {
          this.isUpdate = false;
        } else {
          print("loading data to class");
          var data = payload[0];
          this.gender = data['gender'].toString();
            this.name_ = Name(
              title: data['name']['title'].toString(), 
              firstName: data['name']['firstName'].toString(),
              lastName: data['name']['lastName'].toString()
            );
            this.location_ = Location(
              cityName: data['location']['cityName'].toString(),
              countryName: data['location']['countryName'].toString(),
              stateName: data['location']['stateName'].toString(),
              zipCode: data['location']['zipCode'].toString()
            );
            this.education_ = Education(
              degreeName: data['education']['degreeName'].toString(),
              universityName: data['education']['universityName'].toString()
            );
            this.profession_ = Profession(
              designation: data['profession']['designation'].toString(),
              specialities: data['profession']['specialities'],
              description: data['profession']['description']
            );
            this.contact_ = Contact(
              email: data['contact']['email'],
              phone: data['contact']['phone']
            );
            //this.profilePic = data['profilePicture'].toString();
            this.languages = data['languages'];
            this.areas = data['areas'];
            this.isUpdate = data['isUpdate'];
            print("loaded data to class"); 
          }
      } on Exception catch (exception) {
        print("Decode error $exception");
      } catch (error) { 
        print("Decode error $error");
      }
    } else {
      print("getUserDetail: failed response");
    }
    print("getUserdata Response");
    return;
  }
}