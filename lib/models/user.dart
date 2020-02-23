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
  String profilePic = "";
  bool isUpdate = false;
   
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

  Future<void> addUserDetails(String jsonData) async {
    print("Adding User details");
    String resourceUrl = "accounts";
    http.Response data = await server.postData(resourceUrl, jsonData);
    print(data.body);
    return;
  }

  Future<void> getUserDetails() async {
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