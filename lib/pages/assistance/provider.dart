import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class provider {
  String user_id;
  String name;
  String location;
  String designation;
  List<String> languages;
  String about_me;
  List<String> specialities;

  provider(this.user_id,
      this.name,
      this.location,
      this.designation,
      this.languages,
      this.about_me,
      this.specialities);



}