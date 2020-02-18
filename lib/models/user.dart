import 'package:app/models/contact.dart';
import 'package:app/models/education.dart';
import 'package:app/models/location.dart';
import 'package:app/models/name.dart';
import 'package:app/models/profession.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class User {
  // User id
  final String uid;
  bool isUpdate;
  String gender;
  name name_ = name();
  location location_ = location();
  education education_ = education();
  profession profession_ = profession();
  List<dynamic> languages = new List<dynamic>();
  List<dynamic> areas = new List<dynamic>();
  String profilePic = "";
  contact contact_ = contact();
  String email; 

  User({this.uid, this.email});

  Future<void> getUserDetails() async {
    String url = "http://52.39.96.192/accounts?collection=Medteam&filter_by=id&id=${uid}";
    http.Response data = await http.get(
        Uri.encodeFull(url),
        headers: {"Accept": "application/json"}
    );
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
          this.name_ = name(
            title: data['name']['title'].toString(), 
            firstName: data['name']['firstName'].toString(),
            lastName: data['name']['lastName'].toString()
          );
          this.location_ = location(
            cityName: data['location']['cityName'].toString(),
            countryName: data['location']['countryName'].toString(),
            stateName: data['location']['stateName'].toString(),
            zipCode: data['location']['zipCode'].toString()
          );
          this.education_ = education(
            degreeName: data['education']['degreeName'].toString(),
            universityName: data['education']['universityName'].toString()
          );
          this.profession_ = profession(
            designation: data['profession']['designation'].toString(),
            specialities: data['profession']['specialities'],
            description: data['profession']['description']
          );
          this.contact_ = contact(
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
      print("Oops something went wrong, unable to reach server");
    }
  }

}